unit uGen;
{ ��������� ���� }

interface

uses
   uScan, uTable;

var
   PC : integer;

procedure InitGen;

procedure Gen(Cmd: integer);
procedure Fixup(A: integer);

procedure GenAbs;
procedure GenMin;
procedure GenOdd;
procedure GenConst(C: integer);
procedure GenComp(Op: tLex);
procedure GenAddr(X : tObj);
procedure AllocateVariables;

{=====================================================}

implementation

uses
   uOVM, uError, ufMain;

procedure InitGen;
begin
   PC := 0;
end;

procedure Gen(Cmd: integer);
begin
   if PC < MemSize then begin
      RAM[PC] := Cmd;
      PC := PC+1;
      end
   else
      Error('������������ ������ ��� ����');
end;

procedure Fixup(A: integer);
var
   temp: integer;
begin
   while A > 0 do begin
      temp := RAM[A-2];
      RAM[A-2] := PC;
      A := temp;
   end;
end;

procedure GenAbs;
begin
   Gen(cmDup);
   Gen(0);
   Gen(PC+3);
   Gen(cmIfGE);
   Gen(cmNeg);
end;

procedure GenMin;
begin
   Gen(MaxInt);
   Gen(cmNeg);
   Gen(1);
   Gen(cmSub);
end;

procedure GenOdd;
begin
   Gen(2);
   Gen(cmMod);
   Gen(1);
   Gen(0); { ����� �������� ������ }
   Gen(cmIfNE);
end;

procedure GenConst(C: integer);
begin
   Gen(abs(C));
   if C < 0 then
      Gen(cmNeg);
end;

procedure GenComp( Op : tLex );
begin
   Gen(0); { ������� ������ }
   case Op of
   lexEQ : Gen(cmIfNE);
   lexNE : Gen(cmIfEQ);
   lexLE : Gen(cmIfGT);
   lexLT : Gen(cmIfGE);
   lexGE : Gen(cmIfLT);
   lexGT : Gen(cmIfLE);
   end;
end;

procedure GenAddr(X: tObj);
begin
   Gen(X^.Val); {� ������� ������ ����� ���������� + 2}
   X^.Val := PC+1; {�����+2 = PC+1}
end;

procedure AllocateVariables;
var
   VRef: tObj; {������ �� ���������� � ������� ����}
begin
   FirstVar(VRef);         {����� ������ ����������}
   while VRef <> nil do begin
      if VRef^.Val = 0 then
         Warning('���������� ' + VRef^.Name +
                 ' �� ������������')
      else if PC < MemSize then begin
         Fixup(VRef^.Val); {�������� �������� ����������}
         PC := PC + 1;
         end
      else
         Error('������������ ������ ��� ����������');
      NextVar(VRef);       {����� ��������� ����������}
   end;
end;

end.
