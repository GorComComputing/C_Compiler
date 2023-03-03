unit uError;
{Обработка ошибок}

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

procedure Error(Msg : string);
var
   ELine : integer;
begin
   ELine := Line;
   while (Ch <> chEOL) and (Ch <> chEOT) do NextCh;
   if Ch = chEOT then frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + Ch;
   frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + '^' + #13#10;
   //WriteLn('^': LexPos);
   frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + '(Строка ' + IntToStr(ELine) + ') Ошибка: ' + Msg + #13#10;
   //Writeln('(Строка ', ELine, ') Ошибка: ', Msg);
   frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + #13#10;
   //WriteLn;
   frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + 'Нажмите ВВОД' + #13#10;
   //WriteLn('Нажмите ВВОД');
   //Readln;
   //Halt(1);
end;

procedure Expected(Msg: string);
begin
   Error('Ожидается ' + Msg);
end;

procedure Warning(Msg : string);
begin
   frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + #13#10;
   //WriteLn;
   frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + 'Предупреждение: ' + Msg + #13#10;
   //Writeln('Предупреждение: ', Msg);
   frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + #13#10;
   //WriteLn;
end;

end.
