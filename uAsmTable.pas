unit uAsmTable;
{Таблица имен ассемблера OVM}

interface

uses
	uAsmScan;

type

	tObj = ^tObjRec;          {Тип указателя на запись таблицы}

	tObjRec = record          {Тип записи таблицы имен}
		Name        : tName;    {Ключ поиска            }
		Addr        : integer;
		Prev        : tObj;     {Указатель на пред. имя }
	end;

procedure InitNameTable;
procedure NewName( Addr : integer );
procedure Find( var Addr : integer );

{=========================================================================}

implementation

uses
	uError;

var
	Top   : tObj;             {Указатель на вершину списка    }


// Инициализация таблицы имен
procedure InitNameTable;
begin
	Top := nil;
end;


// Занесение нового имени
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


// Поиск имени
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
