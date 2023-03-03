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
   TabSize = 3;

//var
  // f : text;


procedure ResetText;
begin
  ChCount := 0;
  Pos := 0;
  Line := 1;
  NextCh;
  {frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + Ch;
  if Ch = chEOL then begin
    frmMain.mConsole.SelStart := Length(frmMain.mConsole.Lines.Text) ;
    frmMain.mConsole.SelLength := 0;
  end;  }
  {while Ch <> chEOT do begin
    NextCh;
    frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + Ch;
    if Ch = chEOL then begin
      frmMain.mConsole.SelStart := Length(frmMain.mConsole.Lines.Text) ;
      frmMain.mConsole.SelLength := 0;
    end;
  end;  }
end;


procedure NextCh;
begin
  ChCount := ChCount + 1;
  //frmMain.mEditor.Lines.Text := 'A';
  //memo1.lines.text:= IntToStr(Length(memo1.lines.text))
   if Length(frmMain.mEditor.lines.text) = ChCount then      //eof(f)
      //frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + 'END'
      Ch := chEOT
   else if frmMain.mEditor.lines.text[ChCount] = #13 then begin    //eoln(f)
      ChCount := ChCount + 1;
      //ReadLn(f);
        //frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + Ch;
      //frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + #13 + #10;
      //frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + 'ENTER';
      //WriteLn;
      Line := Line + 1;
      Pos := 0;
      Ch := chEOL;
      end
   else begin
      Ch := frmMain.mEditor.lines.text[ChCount];
      if Ch <> chTab then begin
          //frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + Ch;
         Pos := Pos + 1;
         end
      else
         repeat
            frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + ' ';
            Pos := Pos + 1;
         until Pos mod TabSize = 0;
   end;
end;

end.
