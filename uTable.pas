unit uTable;
{������� ����}

interface

uses uScan;

type
   {��������� ���}
      tCat = (catConst, catVar, catType,
              catStProc, catModule, catGuard);

   {����}
      tType = (typNone, typInt, typBool);

   tObj = ^tObjRec;     {��� ��������� �� ������ �������}

   tObjRec = record     {��� ������ ������� ����}
      Name  : tName;    {���� ������            }
      Cat   : tCat;     {��������� �����        }
      Typ   : tType;    {���                    }
      Val   : integer;  {��������               }
      Prev  : tObj;     {��������� �� ����. ��� }
   end;

{������������� �������}
   procedure InitNameTable;
{���������� ��������}
   procedure Enter(N: tName; C: tCat; T: tType; V: integer);
{��������� ������ �����}
   procedure NewName(Name:tName; Cat:tCat; var Obj:tObj);
{����� �����}
   procedure Find(Name: tName; var Obj: tObj);
{�������� ������� ��������� (�����)}
   procedure OpenScope;
{�������� ������� ��������� (�����)}
   procedure CloseScope;
{����� ������ ����������}
   procedure FirstVar(var VRef : tObj);
{����� ��������� ����������}
   procedure NextVar(var VRef : tObj);
{=======================================================}

implementation

uses
   uError;

var
   Top    : tObj;  {��������� �� ������� ������    }
   Bottom : tObj;  {��������� �� ����� (���) ������}
   CurrObj: tObj;


{������������� ������� ����}
procedure InitNameTable;
begin
   Top := nil;
end;


{���������� ��������}
procedure Enter(N: tName; C: tCat; T: tType; V: integer);
var
  P : tObj;
begin
   New(P);
   P^.Name := N;
   P^.Cat := C;
   P^.Typ := T;
   P^.Val := V;
   P^.Prev := Top;
   Top := P;
end;


{�������� ������� ��������� (�����)}
procedure OpenScope;
begin
   Enter( '', catGuard, typNone, 0 );
   if Top^.Prev = nil then
      Bottom := Top;
end;


{�������� ������� ��������� (�����)}
procedure CloseScope;
var
   P : tObj;
begin
   while Top^.Cat <> catGuard do begin
      P := Top;
      Top := Top^.Prev;
      Dispose(P);
   end;
   P := Top;
   Top := Top^.Prev;
   Dispose(P);
end;


{��������� ������ �����}
procedure NewName(Name: tName; Cat: tCat; var Obj: tObj);
begin
   Obj := Top;
   while (Obj^.Cat<>catGuard) and (Obj^.Name<>Name) do
      Obj := Obj^.Prev;
   if Obj^.Cat = catGuard then begin
      New(Obj);
      Obj^.Name := Name;
      Obj^.Cat := Cat;
      Obj^.Val := 0;
      Obj^.Prev := Top;
      Top := Obj;
      end
   else
      Error('��������� ���������� �����');
end;


{����� �����}
procedure Find(Name: tName; var Obj: tObj);
begin
   Bottom^.Name := Name;
   Obj := Top;
   while Obj^.Name <> Name do
      Obj := Obj^.Prev;
   if Obj=Bottom then
      Error('������������� ���');
end;


{����� ������ ����������}
procedure FirstVar(var VRef : tObj);
begin
   CurrObj := Top;
   NextVar(VRef);
end;


{����� ��������� ����������}
procedure NextVar(var VRef : tObj);
begin
   while (CurrObj<>Bottom) and (CurrObj^.Cat<>catVar) do
      CurrObj := CurrObj^.Prev;
   if CurrObj = Bottom then
      VRef := nil
   else begin
      VRef := CurrObj;
      CurrObj := CurrObj^.Prev;
   end
end;

end.
