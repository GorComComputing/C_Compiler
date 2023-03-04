unit uAsmTable;
{Таблица имен ассемблера OVM}

interface

uses
	uAsmScan;

type

	tObj = ^tObjRec;

	tObjRec = record
		Name        : tName;
		Addr        : integer;
		Prev        : tObj;
	end;

procedure InitNameTable;
procedure NewName( Addr : integer );
procedure Find( var Addr : integer );

{=========================================================================}

implementation

uses
	uError;

var
	Top   : tObj;

procedure InitNameTable;
begin
	Top := nil;
end;

procedure NewName(Addr : integer);
var
	Obj : tObj;
begin
	Obj := Top;
	while ( Obj <> nil) and ( Obj^.Name <> Name ) do
		Obj := Obj^.Prev;
	if Obj = nil then begin
		New(Obj);
		Obj^.Name := Name;
		Obj^.Addr := Addr;
		Obj^.Prev := Top;
		Top := Obj;
		end
	else
		Error('Повторное объявление имени');
end;

procedure Find(var Addr : integer);
var
	Obj : tObj;
begin
	Obj := Top;
	while ( Obj <> nil ) and ( Obj^.Name <> Name ) do
		Obj := Obj^.Prev;
	if Obj=nil then
		Error('Необъявленное имя')
	else
		Addr := Obj^.Addr;
end;

end.
