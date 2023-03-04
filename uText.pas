unit uText;
{Драйвер исходного текста}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.ExtCtrls,
  Vcl.Menus, Vcl.ComCtrls,
  System.Types, System.IOUtils, Vcl.Buttons;


const
   chSpace = ' ';     {Пробел      }
   chTab   = chr(9);  {Табуляция   }
   chEOL   = chr(10); {Конец строки}
   chEOT   = chr(0);  {Конец текста}

var
   Ch    : char;    {Очередной символ      }
   Line  : integer; {Номер строки          }
   Pos   : integer; {Номер символа в строке}
   ChCount: integer; {Номер символа в файле}

procedure ResetText;
procedure NextCh;

{======================================================}

implementation

uses
   uError, ufMain;

const
   TabSize = 3; // размер табуляции


// инициализация переменных
procedure ResetText;
begin
  ChCount := 0;
  Pos := 0;
  Line := 1;
  NextCh;
end;


// функция чтения следующего символа (помещает в переменную Ch)
procedure NextCh;
begin
  ChCount := ChCount + 1; // увеличиваем позицию символа в файле
  // проверяем не дошли ли до конца файла
  if Length(frmMain.mEditor.lines.text) = ChCount then      //eof(f)
    Ch := chEOT // если конец файла пишем последний символ chEOT
  // проверяем на конец строки
  else if frmMain.mEditor.lines.text[ChCount] = #13 then
    begin    //eoln(f)
    ChCount := ChCount + 1;
    Line := Line + 1;
    Pos := 0; // обнуляем позицию в строке
    Ch := chEOL;  // пишем chEOL
    end
  else begin
    Ch := frmMain.mEditor.lines.text[ChCount];
    if Ch <> chTab then begin
      Pos := Pos + 1; // увеличиваем позицию символа в строке
      end
    else
      repeat // обработка табуляции
        //frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + ' ';
        Pos := Pos + 1;
      until Pos mod TabSize = 0;
   end;
end;

end.
