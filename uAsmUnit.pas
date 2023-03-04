unit uAsmUnit;
{������ ���������� OVM}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.ExtCtrls,
  Vcl.Menus, Vcl.ComCtrls,
  System.Types, System.IOUtils, Vcl.Buttons;

procedure Assemble;

{=============================================================}

implementation

uses
	uText, uAsmScan, uAsmTable, uError, uOVM, ufMain;

type
	tLineProc = procedure;

var
	PC : integer;

procedure Gen( Cmd : integer );
begin
	if PC < MemSize then begin
		RAM[PC] := Cmd;
		PC := PC + 1;
		end
	else
		Error('������������ ������');
end;

{$F+}
(* ������  = [�����][�����|���|���] *)
procedure LineFirst;
begin
	if Lex = lexLabel then begin
		NewName( PC );
		NextLex;
	end;
	if Lex in [lexName, lexNum, LexOpCode] then begin
		PC := PC + 1;
		NextLex;
	end;
end;

procedure LineSecond;
var
	Addr : integer;
begin
	if Lex = lexLabel then
		NextLex;
	case Lex of
	lexName:
		begin
			Find(Addr);
			Gen(Addr);
			NextLex;
		end;
	lexNum:
		begin
			Gen(Num);
			NextLex;
		end;
	lexOpCode:
		begin
			Gen(OpCode);
			NextLex;
		end;
	end;
end;
{$F-}

(* ��������� = ������ { �������_������ ������ }  *)
procedure Pass(Line : tLineProc);
begin
	ResetText;
	NextLex;
	PC := 0;
	Line;
	while Lex = lexEOL do begin
		NextLex;
		Line;
	end;
	if Lex <> lexEOT then
		Error('������');
end;

procedure Assemble;
var
  i, j: Integer;
begin
	{������ ��������}
	Pass( LineFirst );
	{������ ��������}
	Pass( LineSecond );

  frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + #13#10;
  frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + '���������� ��������� �������' + #13#10;

  frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + '������ ���� ' + IntToStr(PC) + #13#10;
  frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + #13#10;

	// ��������� ������� Memory
  for i := 1 to frmMain.sgMemory.RowCount - 1 do
    for j := 1 to frmMain.sgMemory.ColCount - 1 do
      frmMain.sgMemory.Cells[j, i] := format('%.2x',[RAM[(i-1)*16 + (j-1)]]);

  // ����� ����������
  frmMain.ResetCPU();
end;

end.
