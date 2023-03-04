unit uError;
{Сообщения об ошибках}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.ExtCtrls,
  Vcl.Menus, Vcl.ComCtrls,
  System.Types, System.IOUtils, Vcl.Buttons;

procedure Error(Msg : string);
procedure Expected(Msg : string);
procedure Warning(Msg : string);

{=======================================================}

implementation

uses
   uText, ufMain, uScan;


// Основная функция сообщения об ошибке
procedure Error(Msg : string);
var
   ELine, i : integer;
begin
   ELine := Line;
   while (Ch <> chEOL) and (Ch <> chEOT) do
    begin
    NextCh;
    frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + Ch;
    end;

   if Ch = chEOT then frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + Ch;

   i := 0;
   while i < LexPos do begin
    frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + ' ';
    i := i + 1;
   end;
   frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + '^' + #13#10;
   //WriteLn('^': LexPos);

   frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + '(Строка ' + IntToStr(ELine) + ') Ошибка: ' + Msg + #13#10;
   //Writeln('(Строка ', ELine, ') Ошибка: ', Msg);

   frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + #13#10;
   //Readln;
   //Halt(1);
end;


// сообщаем о синтаксической ошибке
procedure Expected(Msg: string);
begin
   Error('Ожидается ' + Msg);  // нужно добавить указание на начало лексемы
end;


// предупреждение
procedure Warning(Msg : string);
begin
   frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + #13#10;
   frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + 'Предупреждение: ' + Msg + #13#10;
   //frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + #13#10;
end;

end.
