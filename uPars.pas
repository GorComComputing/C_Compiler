unit uPars;
{Синтаксический анализатор}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.ExtCtrls,
  Vcl.Menus, Vcl.ComCtrls,
  System.Types, System.IOUtils, Vcl.Buttons;

procedure Compile;

{======================================================}

implementation

uses
   uScan, uError, uTable, uGen, uOVM, ufMain;

const
   spABS    = 1;
   spMAX    = 2;
   spMIN    = 3;
   spDEC    = 4;
   spODD    = 5;
   spHALT   = 6;
   spINC    = 7;
   spInOpen = 8;
   spInInt  = 9;
   spOutInt = 10;
   spOutLn  = 11;

procedure StatSeq; forward;
procedure Expression(var t: tType); forward;


// проверяет следующую лексему
procedure Check(L: tLex; M: string);
begin
   if Lex <> L then    // (НЕ читает следующую)
      Expected(M)
   else                // (Читает следующую)
      NextLex;
end;


// ["+" | "-"] (Число | Имя).
procedure ConstExpr(var V: integer);
var
   X  : tObj;
   Op : tLex;
begin
   Op := lexPlus;
   if Lex in [lexPlus, lexMinus] then begin
      Op := Lex;
      NextLex;
   end;
   if Lex = lexNum then begin
      V := Num;
      NextLex;
      end
   else if Lex = lexName then begin
      Find(Name, X);
      if X^.Cat = catGuard then
         Error('Нельзя определять константу через себя')
      else if X^.Cat <> catConst then
         Expected( 'имя константы' )
      else
         V := X^.Val;
      NextLex;
      end
   else
      Expected( 'константное выражение' );
   if Op = lexMinus then
      V := -V;
end;


// Имя "=" КонстВыраж.
procedure ConstDecl;
var
   ConstRef: tObj; {Ссылка на имя в таблице}
begin
   NewName(Name, catGuard, ConstRef);
   NextLex;
   Check(lexEQ, '"="');
   ConstExpr(ConstRef^.Val);
   ConstRef^.Typ := typInt; {Констант других типов нет}
   ConstRef^.Cat := catConst;
end;


//  Тип = Имя.
procedure ParseType;
var
   TypeRef : tObj;
begin
   if Lex <> lexName then
      Expected('имя')
   else begin
      Find(Name, TypeRef);
      if TypeRef^.Cat <> catType then
         Expected('имя типа')
      else if TypeRef^.Typ <> typInt then
         Expected('целый тип');
      NextLex;
   end;
end;


// Имя {"," Имя} ":" Тип.
procedure VarDecl;
var
   NameRef : tObj;
begin
   if Lex <> lexName then
      Expected('имя')
   else begin
      NewName(Name, catVar, NameRef);
      NameRef^.Typ := typInt;
      NextLex;
   end;
   while Lex = lexComma do begin
      NextLex;
      if Lex <> lexName then
         Expected('имя')
      else begin
         NewName(Name, catVar, NameRef);
         NameRef^.Typ := typInt;
         NextLex;
      end;
   end;
   Check(lexColon, '":"');
   ParseType;
end;


//   {CONST
//      {ОбъявлКонст ";"}
//   |VAR
//      {ОбъявлПерем ";"} }.
procedure DeclSeq;
begin
   while Lex in [lexCONST, lexVAR] do begin
      if Lex = lexCONST then begin
         NextLex;
         while Lex = lexName do begin
            ConstDecl; {Объявление константы}
            Check( lexSemi, '";"' );
         end;
         end
      else begin
         NextLex; { VAR }
         while Lex = lexName do begin
            VarDecl;   {Объявление переменных}
            Check( lexSemi, '";"' );
         end;
      end;
   end;
end;

procedure IntExpression;
var
   T : tType;
begin
   Expression(T);
   if T <> typInt then
      Expected('выражение целого типа');
end;

procedure StFunc(F: integer; var T: tType);
begin
   case F of
   spABS:
      begin
         IntExpression;
         GenAbs;
         T := typInt;
      end;
   spMAX:
      begin
         ParseType;
         Gen(MaxInt);
         T := typInt;
      end;
   spMIN:
      begin
         ParseType;
         GenMin;
         T := typInt;
      end;
   spODD:
      begin
         IntExpression;
         GenOdd;
         T := typBool;
      end;
   end;
end;


// Множитель =
//   Имя ["(" Выраж | Тип ")"]
//   | Число
//   | "(" Выраж ")".
procedure Factor(var T : tType);
var
   X : tObj;
begin
   if Lex = lexName then begin
      Find(Name, X);
      if X^.Cat = catVar then begin
         GenAddr(X);    {Адрес переменной}
         Gen( cmLoad );
         T := X^.Typ;
         NextLex;
         end
      else if X^.Cat = catConst then begin
         GenConst(X^.Val);
         T := X^.Typ;
         NextLex;
         end
      else if (X^.Cat=catStProc) and (X^.Typ<>typNone)
      then begin
         NextLex;
         Check(lexLPar, '"("');
         StFunc(X^.Val, T);
         Check(lexRPar, '")"');
         end
      else
         Expected(
         'переменная, константа или процедура-функции'
         );
      end
   else if Lex = lexNum then begin
      T := typInt;
      GenConst(Num);
      NextLex
      end
   else if Lex = lexLPar then begin
      NextLex;
      Expression(T);
      Check(lexRPar, '")"');
      end
   else
      Expected('имя, число или "("');
end;


//  Слагаемое = Множитель {ОперУмн Множитель}.
procedure Term(var T: tType);
var
   Op : tLex;
begin
   Factor(T);     // множитель
   if Lex in [lexMult, lexDIV, lexMOD] then begin
      if T <> typInt then
         Error('Несоответствие операции типу операнда');
      repeat
         Op := Lex;
         NextLex;
         Factor(T);      //множитель
         if T <> typInt then
            Expected('выражение целого типа');                 case Op of
         lexMult: Gen(cmMult);
         lexDIV:  Gen(cmDIV);
         lexMOD:  Gen(cmMOD);
         end;
      until not(Lex in [lexMult, lexDIV, lexMOD]);
   end;
end;


// ПростоеВыраж = ["+"|"-"] Слагаемое {ОперСлож Слагаемое}.
procedure SimpleExpr(var T : tType);
var
   Op : tLex;
begin
   if Lex in [lexPlus, lexMinus] then begin
      Op := Lex;
      NextLex;
      Term(T);  // слагаемое
      if T <> typInt then
         Expected('выражение целого типа');
      if Op = lexMinus then
         Gen(cmNeg);
      end
   else
      Term(T);   // слагаемое
   if Lex in [lexPlus, lexMinus] then begin
      if T <> typInt then
         Error('Несоответствие операции типу операнда');
      repeat
         Op := Lex;
         NextLex;
         Term(T);
         if T <> typInt then
            Expected('выражение целого типа');
         case Op of
         lexPlus:  Gen(cmAdd);
         lexMinus: Gen(cmSub);
         end;
      until not( Lex in [lexPlus, lexMinus] );
   end;
end;


// Выраж = ПростоеВыраж [Отношение ПростоеВыраж].
procedure Expression(var T : tType);
var
   Op : tLex;
begin
   SimpleExpr(T);
   if Lex in [lexEQ, lexNE, lexGT, lexGE, lexLT, lexLE]
   then begin
      Op := Lex;
      if T <> typInt then
         Error('Несоответствие операции типу операнда');
      NextLex;
      SimpleExpr(T); {Правый операнд отношения}
      if T <> typInt then
         Expected('выражение целого типа');
      GenComp(Op);   {Генерация условного перехода}
      T := typBool;
   end; {иначе тип равен типу первого простого выражения}
end;


// проверка переменной
procedure Variable;
var
   X : tObj;
begin
   if Lex <> lexName then
      Expected('имя')
   else begin
      Find(Name, X);
      if X^.Cat <> catVar then
         Expected('имя переменной');
     GenAddr(X);
     NextLex;
   end;
end;

procedure StProc(sp: integer);
var
   c : integer;
begin
   case sp of
   spDEC:
      begin
         Variable;
         Gen(cmDup);
         Gen(cmLoad);
         if Lex = lexComma then begin
            NextLex;
            IntExpression;
            end
         else
            Gen(1);
         Gen(cmSub);
         Gen(cmSave);
      end;
   spINC:
      begin
         Variable;
         Gen(cmDup);
         Gen(cmLoad);
         if Lex = lexComma then begin
            NextLex;
            IntExpression;
            end
         else
            Gen(1);
         Gen(cmAdd);
         Gen(cmSave);
      end;
   spInOpen:
      { Пусто };
   spInInt:
      begin
         Variable;
         Gen(cmIn);
         Gen(cmSave);
      end;
   spOutInt:
      begin
         IntExpression;
         Check(lexComma , '","');
         IntExpression;
         Gen(cmOut);
      end;
   spOutLn:
      Gen(cmOutLn);
   spHalt:
      begin
         ConstExpr(c);
         GenConst(c);
         Gen(cmStop);
      end;
   end;
end;


//
procedure BoolExpression;
var
   T : tType;
begin
   Expression(T);
   if T <> typBool then     // TestBool(T)
      Expected('логическое выражение');
end;


//   Переменная ":=" Выраж
procedure AssStatement;
begin
   Variable;
   if Lex = lexAss then begin
      NextLex;
      IntExpression;
      Gen(cmSave);
      end
   else
      Expected('":="')
end;


//   |[Имя "."] Имя ["(" [Параметр {"," Параметр}] ")"]
procedure CallStatement(sp : integer);
begin
   Check(lexName, 'имя процедуры');
   if Lex = lexLPar then begin
      NextLex;
      StProc(sp);
      Check( lexRPar, '")"' );
      end
   else if sp in [spOutLn, spInOpen] then
      StProc(sp)
   else
      Expected('"("');
end;


//   IF Выраж THEN
//      ПослОператоров
//   {ELSIF Выраж THEN
//      ПослОператоров}
//   [ELSE
//      ПослОператоров]
//    END
procedure IfStatement;
var
   CondPC   : integer;
   LastGOTO : integer;
begin
   Check(lexIF, 'IF');
   LastGOTO := 0;     {Предыдущего перехода нет        }
   BoolExpression;
   CondPC := PC;      {Запомн. положение усл. перехода }
   Check(lexTHEN, 'THEN');
   StatSeq;
   while Lex = lexELSIF do begin
      Gen(LastGOTO);  {Фиктивный адрес, указывающий    }
      Gen(cmGOTO);    {на место предыдущего перехода.  }
      LastGOTO := PC; {Запомнить место GOTO            }
      NextLex;
      Fixup(CondPC);  {Зафикс. адрес условного перехода}
      BoolExpression;
      CondPC := PC;   {Запомн. положение усл. перехода }
      Check(lexTHEN, 'THEN');
      StatSeq;
   end;
   if Lex = lexELSE then begin
      Gen(LastGOTO);  {Фиктивный адрес, указывающий    }
      Gen(cmGOTO);    {на место предыдущего перехода   }
      LastGOTO := PC; {Запомнить место последнего GOTO }
      NextLex;
      Fixup(CondPC);  {Зафикс. адрес условного перехода}
      StatSeq;
      end
   else
      Fixup(CondPC); {Если ELSE отсутствует          }
   Check( lexEND, 'END' );
   Fixup(LastGOTO);     {Направить сюда все GOTO        }
end;


//    WHILE Выраж DO
//      ПослОператоров
//    END
procedure WhileStatement;
var
   WhilePC  : integer;
   CondPC   : integer;
begin
   WhilePC := PC;
   Check(lexWHILE, 'WHILE');
   BoolExpression;
   CondPC := PC;
   Check(lexDO, 'DO');
   StatSeq;
   Check(lexEND, 'END');
   Gen(WhilePC);
   Gen(cmGOTO);
   Fixup(CondPC);     // адресная привязка
end;


//[
//   Переменная ":=" Выраж
//   |[Имя "."] Имя ["(" [Параметр {"," Параметр}] ")"]
//   |IF Выраж THEN
//      ПослОператоров
//   {ELSIF Выраж THEN
//      ПослОператоров}
//   [ELSE
//      ПослОператоров]
//    END
//   |WHILE Выраж DO
//      ПослОператоров
//    END
//].
procedure Statement;
var
   X : tObj;
begin
   if Lex = lexName then begin     // AssOrCall()
      Find(Name, X);
      if X^.Cat = catModule then begin
         NextLex;
         Check(lexDot, '"."');
         if    (Lex = lexName) and
            (Length(X^.Name)+Length(Name) < NameLen)
         then
            Find(X^.Name+'.'+Name, X)
         else
            Expected('имя из модуля '+ X^.Name);
      end;
      if X^.Cat = catVar then
         AssStatement          {Присваивание}
      else if (X^.Cat=catStProc) and (X^.Typ=typNone) then
         CallStatement(X^.Val) {Вызов процедуры}
      else
         Expected(
            'обозначение переменной или процедуры'
         );
      end
   else if Lex = lexIF then       // IfStatement()
      IfStatement
   else if Lex = lexWHILE then    //WhileStatement()
      WhileStatement
end;


//   Оператор {";" Оператор }.
procedure StatSeq;
begin
   Statement;    {Оператор}
   while Lex = lexSemi do begin
      NextLex;
      Statement; {Оператор}
   end;
end;


//
procedure ImportModule;
var
   ImpRef: tObj;
begin
   if Lex = lexName then begin
      NewName(Name, catModule, ImpRef);
      if Name = 'In' then begin
         Enter( 'In.Open', catStProc, typNone, spInOpen );
         Enter( 'In.Int', catStProc, typNone, spInInt );
         end
      else if Name = 'Out' then begin
         Enter( 'Out.Int', catStProc, typNone, spOutInt );
         Enter( 'Out.Ln', catStProc, typNone, spOutLn );
         end
      else
         Error('Неизвестный модуль');
      NextLex;
      end
   else
      Expected('имя импортируемого модуля');
end;


//   IMPORT Имя {"," Имя} ";".
procedure Import;
begin
   Check(lexIMPORT, 'IMPORT');
   ImportModule;    {Обработка имени импортируемого модуля}
   while Lex = lexComma do begin
      NextLex;
      ImportModule; {Обработка имени импортируемого модуля}
   end;
   Check(lexSemi, '";"');
end;


//   MODULE Имя ";"
//   [Импорт]
//   ПослОбъявл
//   [BEGIN
//      ПослОператоров]
//   END Имя ".".
procedure Module;
var
   ModRef: tObj; {Ссылка на имя модуля в таблице}
begin
   Check(lexMODULE, 'MODULE');
   if Lex <> lexName then
      Expected('имя модуля')
   else {Имя модуля - в таблицу имен}
      NewName(Name, catModule, ModRef);
   NextLex;
   Check(lexSemi, '";"');
   if Lex = lexIMPORT then
      Import;
   DeclSeq;
   if Lex = lexBEGIN then begin
      NextLex;
      StatSeq;
   end;
   Check(lexEND, 'END');

   {Сравнение имени модуля и имени после END}
      if Lex <> lexName then
         Expected('имя модуля')
      else if Name <> ModRef^.Name then
         Expected('имя модуля "'+ModRef^.Name+'"')
      else
         NextLex;
   if Lex <> lexDot then
      Expected('"."');
   Gen(0);            {Код возврата}
   Gen(cmStop);       {Команда останова}
   AllocateVariables; {Размещение переменных}
end;


// основная функция компилятора
procedure Compile;
var
  i, j: Integer;
begin
   // Заполняем память нулями
  for i := 0 to 255 do
    RAM[i] := 0;

   InitNameTable;
   OpenScope; {Блок стандартных имен}
   Enter( 'ABS', catStProc, typInt, spABS );
   Enter( 'MAX', catStProc, typInt, spMAX );
   Enter( 'MIN', catStProc, typInt, spMIN );
   Enter( 'DEC', catStProc, typNone, spDEC );
   Enter( 'ODD', catStProc, typBool, spODD );
   Enter( 'HALT', catStProc, typNone, spHALT );
   Enter( 'INC', catStProc, typNone, spINC );
   Enter( 'INTEGER', catType, typInt, 0 );
   OpenScope;  {Блок модуля}
   Module;
   CloseScope; {Блок модуля}
   CloseScope; {Блок стандартных имен}

   frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + #13#10;
   frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + 'Компиляция завершена успешно' + #13#10;

  // Заполняем таблицу Memory
  for i := 1 to frmMain.sgMemory.RowCount - 1 do
    for j := 1 to frmMain.sgMemory.ColCount - 1 do
      frmMain.sgMemory.Cells[j, i] := format('%.2x',[RAM[(i-1)*16 + (j-1)]]);

  // Сброс процессора
  frmMain.ResetCPU();
end;

end.
