unit uPars;
{�������������� ����������}

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


// ��������� ��������� �������
procedure Check(L: tLex; M: string);
begin
   if Lex <> L then    // (�� ������ ���������)
      Expected(M)
   else                // (������ ���������)
      NextLex;
end;


// ["+" | "-"] (����� | ���).
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
         Error('������ ���������� ��������� ����� ����')
      else if X^.Cat <> catConst then
         Expected( '��� ���������' )
      else
         V := X^.Val;
      NextLex;
      end
   else
      Expected( '����������� ���������' );
   if Op = lexMinus then
      V := -V;
end;


// ��� "=" ����������.
procedure ConstDecl;
var
   ConstRef: tObj; {������ �� ��� � �������}
begin
   NewName(Name, catGuard, ConstRef);
   NextLex;
   Check(lexEQ, '"="');
   ConstExpr(ConstRef^.Val);
   ConstRef^.Typ := typInt; {�������� ������ ����� ���}
   ConstRef^.Cat := catConst;
end;


//  ��� = ���.
procedure ParseType;
var
   TypeRef : tObj;
begin
   if Lex <> lexName then
      Expected('���')
   else begin
      Find(Name, TypeRef);
      if TypeRef^.Cat <> catType then
         Expected('��� ����')
      else if TypeRef^.Typ <> typInt then
         Expected('����� ���');
      NextLex;
   end;
end;


// ��� {"," ���} ":" ���.
procedure VarDecl;
var
   NameRef : tObj;
begin
   if Lex <> lexName then
      Expected('���')
   else begin
      NewName(Name, catVar, NameRef);
      NameRef^.Typ := typInt;
      NextLex;
   end;
   while Lex = lexComma do begin
      NextLex;
      if Lex <> lexName then
         Expected('���')
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
//      {����������� ";"}
//   |VAR
//      {����������� ";"} }.
procedure DeclSeq;
begin
   while Lex in [lexCONST, lexVAR] do begin
      if Lex = lexCONST then begin
         NextLex;
         while Lex = lexName do begin
            ConstDecl; {���������� ���������}
            Check( lexSemi, '";"' );
         end;
         end
      else begin
         NextLex; { VAR }
         while Lex = lexName do begin
            VarDecl;   {���������� ����������}
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
      Expected('��������� ������ ����');
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


// ��������� =
//   ��� ["(" ����� | ��� ")"]
//   | �����
//   | "(" ����� ")".
procedure Factor(var T : tType);
var
   X : tObj;
begin
   if Lex = lexName then begin
      Find(Name, X);
      if X^.Cat = catVar then begin
         GenAddr(X);    {����� ����������}
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
         '����������, ��������� ��� ���������-�������'
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
      Expected('���, ����� ��� "("');
end;


//  ��������� = ��������� {������� ���������}.
procedure Term(var T: tType);
var
   Op : tLex;
begin
   Factor(T);     // ���������
   if Lex in [lexMult, lexDIV, lexMOD] then begin
      if T <> typInt then
         Error('�������������� �������� ���� ��������');
      repeat
         Op := Lex;
         NextLex;
         Factor(T);      //���������
         if T <> typInt then
            Expected('��������� ������ ����');                 case Op of
         lexMult: Gen(cmMult);
         lexDIV:  Gen(cmDIV);
         lexMOD:  Gen(cmMOD);
         end;
      until not(Lex in [lexMult, lexDIV, lexMOD]);
   end;
end;


// ������������ = ["+"|"-"] ��������� {�������� ���������}.
procedure SimpleExpr(var T : tType);
var
   Op : tLex;
begin
   if Lex in [lexPlus, lexMinus] then begin
      Op := Lex;
      NextLex;
      Term(T);  // ���������
      if T <> typInt then
         Expected('��������� ������ ����');
      if Op = lexMinus then
         Gen(cmNeg);
      end
   else
      Term(T);   // ���������
   if Lex in [lexPlus, lexMinus] then begin
      if T <> typInt then
         Error('�������������� �������� ���� ��������');
      repeat
         Op := Lex;
         NextLex;
         Term(T);
         if T <> typInt then
            Expected('��������� ������ ����');
         case Op of
         lexPlus:  Gen(cmAdd);
         lexMinus: Gen(cmSub);
         end;
      until not( Lex in [lexPlus, lexMinus] );
   end;
end;


// ����� = ������������ [��������� ������������].
procedure Expression(var T : tType);
var
   Op : tLex;
begin
   SimpleExpr(T);
   if Lex in [lexEQ, lexNE, lexGT, lexGE, lexLT, lexLE]
   then begin
      Op := Lex;
      if T <> typInt then
         Error('�������������� �������� ���� ��������');
      NextLex;
      SimpleExpr(T); {������ ������� ���������}
      if T <> typInt then
         Expected('��������� ������ ����');
      GenComp(Op);   {��������� ��������� ��������}
      T := typBool;
   end; {����� ��� ����� ���� ������� �������� ���������}
end;


// �������� ����������
procedure Variable;
var
   X : tObj;
begin
   if Lex <> lexName then
      Expected('���')
   else begin
      Find(Name, X);
      if X^.Cat <> catVar then
         Expected('��� ����������');
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
      { ����� };
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
      Expected('���������� ���������');
end;


//   ���������� ":=" �����
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


//   |[��� "."] ��� ["(" [�������� {"," ��������}] ")"]
procedure CallStatement(sp : integer);
begin
   Check(lexName, '��� ���������');
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


//   IF ����� THEN
//      ��������������
//   {ELSIF ����� THEN
//      ��������������}
//   [ELSE
//      ��������������]
//    END
procedure IfStatement;
var
   CondPC   : integer;
   LastGOTO : integer;
begin
   Check(lexIF, 'IF');
   LastGOTO := 0;     {����������� �������� ���        }
   BoolExpression;
   CondPC := PC;      {������. ��������� ���. �������� }
   Check(lexTHEN, 'THEN');
   StatSeq;
   while Lex = lexELSIF do begin
      Gen(LastGOTO);  {��������� �����, �����������    }
      Gen(cmGOTO);    {�� ����� ����������� ��������.  }
      LastGOTO := PC; {��������� ����� GOTO            }
      NextLex;
      Fixup(CondPC);  {������. ����� ��������� ��������}
      BoolExpression;
      CondPC := PC;   {������. ��������� ���. �������� }
      Check(lexTHEN, 'THEN');
      StatSeq;
   end;
   if Lex = lexELSE then begin
      Gen(LastGOTO);  {��������� �����, �����������    }
      Gen(cmGOTO);    {�� ����� ����������� ��������   }
      LastGOTO := PC; {��������� ����� ���������� GOTO }
      NextLex;
      Fixup(CondPC);  {������. ����� ��������� ��������}
      StatSeq;
      end
   else
      Fixup(CondPC); {���� ELSE �����������          }
   Check( lexEND, 'END' );
   Fixup(LastGOTO);     {��������� ���� ��� GOTO        }
end;


//    WHILE ����� DO
//      ��������������
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
   Fixup(CondPC);     // �������� ��������
end;


//[
//   ���������� ":=" �����
//   |[��� "."] ��� ["(" [�������� {"," ��������}] ")"]
//   |IF ����� THEN
//      ��������������
//   {ELSIF ����� THEN
//      ��������������}
//   [ELSE
//      ��������������]
//    END
//   |WHILE ����� DO
//      ��������������
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
            Expected('��� �� ������ '+ X^.Name);
      end;
      if X^.Cat = catVar then
         AssStatement          {������������}
      else if (X^.Cat=catStProc) and (X^.Typ=typNone) then
         CallStatement(X^.Val) {����� ���������}
      else
         Expected(
            '����������� ���������� ��� ���������'
         );
      end
   else if Lex = lexIF then       // IfStatement()
      IfStatement
   else if Lex = lexWHILE then    //WhileStatement()
      WhileStatement
end;


//   �������� {";" �������� }.
procedure StatSeq;
begin
   Statement;    {��������}
   while Lex = lexSemi do begin
      NextLex;
      Statement; {��������}
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
         Error('����������� ������');
      NextLex;
      end
   else
      Expected('��� �������������� ������');
end;


//   IMPORT ��� {"," ���} ";".
procedure Import;
begin
   Check(lexIMPORT, 'IMPORT');
   ImportModule;    {��������� ����� �������������� ������}
   while Lex = lexComma do begin
      NextLex;
      ImportModule; {��������� ����� �������������� ������}
   end;
   Check(lexSemi, '";"');
end;


//   MODULE ��� ";"
//   [������]
//   ����������
//   [BEGIN
//      ��������������]
//   END ��� ".".
procedure Module;
var
   ModRef: tObj; {������ �� ��� ������ � �������}
begin
   Check(lexMODULE, 'MODULE');
   if Lex <> lexName then
      Expected('��� ������')
   else {��� ������ - � ������� ����}
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

   {��������� ����� ������ � ����� ����� END}
      if Lex <> lexName then
         Expected('��� ������')
      else if Name <> ModRef^.Name then
         Expected('��� ������ "'+ModRef^.Name+'"')
      else
         NextLex;
   if Lex <> lexDot then
      Expected('"."');
   Gen(0);            {��� ��������}
   Gen(cmStop);       {������� ��������}
   AllocateVariables; {���������� ����������}
end;


// �������� ������� �����������
procedure Compile;
var
  i, j: Integer;
begin
   // ��������� ������ ������
  for i := 0 to 255 do
    RAM[i] := 0;

   InitNameTable;
   OpenScope; {���� ����������� ����}
   Enter( 'ABS', catStProc, typInt, spABS );
   Enter( 'MAX', catStProc, typInt, spMAX );
   Enter( 'MIN', catStProc, typInt, spMIN );
   Enter( 'DEC', catStProc, typNone, spDEC );
   Enter( 'ODD', catStProc, typBool, spODD );
   Enter( 'HALT', catStProc, typNone, spHALT );
   Enter( 'INC', catStProc, typNone, spINC );
   Enter( 'INTEGER', catType, typInt, 0 );
   OpenScope;  {���� ������}
   Module;
   CloseScope; {���� ������}
   CloseScope; {���� ����������� ����}

   frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + #13#10;
   frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + '���������� ��������� �������' + #13#10;

  // ��������� ������� Memory
  for i := 1 to frmMain.sgMemory.RowCount - 1 do
    for j := 1 to frmMain.sgMemory.ColCount - 1 do
      frmMain.sgMemory.Cells[j, i] := format('%.2x',[RAM[(i-1)*16 + (j-1)]]);

  // ����� ����������
  frmMain.ResetCPU();
end;

end.
