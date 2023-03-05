unit uAsmScan;
{Сканер для ассемблера}

interface

const
	NameLen = 31;

type
	tName = string[NameLen];
	tLex = (lexLabel, lexOpCode, lexNum, lexName,  lexEOL, lexEOT);

var
	Lex      : tLex;      {Текущая лексема            }
	Num      : integer;   {Значение числовых литералов}
	OpCode   : integer;
	Name     : tName;     {Строковое значение имени   }

	LexPos   : integer;

procedure InitScan;
procedure NextLex;

{=========================================================================}

implementation

uses
	uText, uError, uOVM;

const
	CmdNum = 31;    // количество команд

type
	tMnemo = string[5];

var
	cmd   : integer;
	Code  : array [1..CmdNum] of integer;
	Mnemo : array [1..CmdNum] of tMnemo;


// Добавляет мнемонику в таблицу (для инициализации таблицы)
procedure EnterCode( Op : integer; Mn : tMnemo );
begin
	cmd := cmd + 1;
	Code[cmd] := Op;
	Mnemo[cmd] := Mn;
end;


// Проверка наличия имени в словаре мнемоники
procedure TestOpCode;
var
	i : integer;
begin
	i := CmdNum;
	while (i>0) and (Mnemo[i] <> Name) do
		i := i-1;
	if i=0 then
		Lex := lexName
	else begin
		Lex := lexOpCode;
		OpCode := Code[i];
	end;
end;


// Собирает имя идентификатора в одну строку
procedure Ident;
var
	i : integer;
begin
	i := 0;
	Name := '';
	repeat
		if i < NameLen then begin
			i := i + 1;
			Name[i] := AnsiChar(Ch);
		end;
		NextCh;
	until not ( Ch in ['A'..'Z', 'a'..'z', '0'..'9'] );
	Name[0] := AnsiChar(chr(i));
	if Ch = ':' then begin
		Lex := lexLabel;
		NextCh;
		end
	else
		TestOpCode;
end;


// собираем число
procedure Number;
var
	d : integer;
begin
	Lex := lexNum;
	Num := 0;
	repeat
		d := ord(Ch)-ord('0');
		if ( Maxint - d ) div 10 >= Num then
			Num := 10*Num + d
		else
			Error('Слишком большое число');
		NextCh;
	until not ( Ch in ['0'..'9'] );
end;


// функция выбора следующей лексемы (это и есть сам сканер)
procedure NextLex;
begin
	while Ch in [' ', chTab] do NextCh;
	LexPos := Pos;
	case Ch of
	'A'..'Z','a'..'z':
		Ident;
	'0'..'9':
		Number;
	';':
		begin
			while ( Ch <> ChEOL ) and ( Ch <> chEOT ) do
				NextCh;
			NextLex;
		end;
	chEOL:
		begin
			Lex := lexEOL;
			NextCh;
		end;
	chEOT:
		Lex := lexEOT;
	else
		Error('Недопустимый символ');
	end;
end;


// Заполняем таблицу соответствия мнемоники машинным командам при инициализации
procedure InitScan;
begin
	cmd := 0;
	EnterCode(cmStop, 'STOP' );
	EnterCode(cmOut, 'OUT' );
	EnterCode(cmOutLn, 'OUTLN' );
	EnterCode(cmIn, 'IN' );
	EnterCode(cmAdd, 'ADD' );
	EnterCode(cmSub, 'SUB' );
	EnterCode(cmMult, 'MULT' );
	EnterCode(cmDIV, 'DIV' );
	EnterCode(cmMOD, 'MOD' );
	EnterCode(cmNeg, 'NEG' );
	EnterCode(cmDup, 'DUP' );
	EnterCode(cmDrop, 'DROP' );
	EnterCode(cmSwap, 'SWAP' );
	EnterCode(cmOver, 'OVER' );
	EnterCode(cmLoad, 'LOAD' );
	EnterCode(cmSave, 'SAVE' );
	EnterCode(cmGoto, 'GOTO' );
	EnterCode(cmIfEQ, 'IFEQ' );
	EnterCode(cmIfNE, 'IFNE' );
	EnterCode(cmIfLE, 'IFLE' );
	EnterCode(cmIfLT, 'IFLT' );
	EnterCode(cmIfGE, 'IFGE' );
	EnterCode(cmIfGT, 'IFGT' );

{
	EnterCode(cmEnter, 'ENTER' );
	EnterCode(cmCall, 'CALL' );
	EnterCode(cmRet, 'RET' );
	EnterCode(cmSetBP, 'SETBP' );
	EnterCode(cmGetBP, 'GETBP' );
	EnterCode(cmLLoad, 'LLOAD' );
	EnterCode(cmLStore, 'LSTORE' );
	EnterCode(cmSP, 'SP' );
}
end;

end.
