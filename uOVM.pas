unit uOVM;
{Виртуальная машина OVM}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.ExtCtrls,
  Vcl.Menus, Vcl.ComCtrls,
  System.Types, System.IOUtils, Vcl.Buttons;


const
   MemSize = 256; // 8*1024;  // 8 килослов

   // Команды виртуальной машины
   cmStop   = -1;

   cmAdd    = -2;
   cmSub    = -3;
   cmMult   = -4;
   cmDiv    = -5;
   cmMod    = -6;
   cmNeg    = -7;

   cmLoad   = -8;
   cmSave  = -9;

   cmDup    = -10;
   cmDrop   = -11;
   cmSwap   = -12;
   cmOver   = -13;

   cmGOTO   = -14;
   cmIfEQ   = -15;
   cmIfNE   = -16;
   cmIfLE   = -17;
   cmIfLT   = -18;
   cmIfGE   = -19;
   cmIfGT   = -20;

   cmIn     = -21;
   cmOut    = -22;
   cmOutLn  = -23;


  procedure StepOVM();


implementation

uses
  ufMain;


// Шаг осциллятора OVM
procedure StepOVM();
var
   i, j, Buf: Integer;
begin
  IRsim := RAM[IPsim];
  IPsim := IPsim + 1;
  // Вывод содержимого регистров
  frmMain.labelRegIP.Caption := format('%.2x',[IPsim]);
  frmMain.labelRegIR.Caption := frmMain.IntToBin(IRsim, 7);
  frmMain.labelRegSP.Caption := frmMain.IntToBin(SP, 7);
  frmMain.sgMemory.Selection := TGridRect(rect((IPsim MOD 16) + 1, (IPsim DIV 16) + 1, (IPsim MOD 16) + 1, (IPsim DIV 16) + 1));

      if IRsim >= 0 then begin
         SP := SP - 1;
         RAM[SP] := IRsim;
         end
      else
         case IRsim of
         cmStop:
            begin
               frmMain.btnRun.Caption := 'Run';
               isRun := False;
               frmMain.Timer1.Enabled := False;
            end;
         cmAdd:
            begin
               SP := SP + 1;
               RAM[SP] := RAM[SP] + RAM[SP-1];
            end;
         cmSub:
            begin
               SP := SP + 1;
               RAM[SP] := RAM[SP] - RAM[SP-1];
            end;
         cmMult:
            begin
               SP := SP + 1;
               RAM[SP] := RAM[SP]*RAM[SP-1];
            end;
         cmDiv:
            begin
               SP := SP + 1;
               RAM[SP] := RAM[SP] div RAM[SP-1];
            end;
         cmMod:
            begin
               SP := SP + 1;
               RAM[SP] := RAM[SP] mod RAM[SP-1];
            end;
         cmNeg:
            RAM[SP] := -RAM[SP];
         cmLoad:
            RAM[SP] := RAM[RAM[SP]];
         cmSave:
            begin
               RAM[RAM[SP+1]] := RAM[SP];
               SP := SP + 2;
            end;
         cmDup:
            begin
               SP := SP - 1;
               RAM[SP] := RAM[SP+1];
            end;
         cmDrop:
            begin
               SP := SP + 1;
            end;
         cmSwap:
            begin
               Buf := RAM[SP];
               RAM[SP] := RAM[SP+1];
               RAM[SP+1] := Buf;
            end;
         cmOver:
            begin
               SP := SP - 1;
               RAM[SP] := RAM[SP+2];
            end;
         cmGOTO:
            begin
               IPsim := RAM[SP];
               SP := SP + 1;
            end;
         cmIfEQ:
            begin
               if RAM[SP+2] = RAM[SP+1] then
                  IPsim := RAM[SP];
               SP := SP + 3;
            end;
         cmIfNE:
            begin
               if RAM[SP+2] <> RAM[SP+1] then
                  IPsim := RAM[SP];
               SP := SP + 3;
            end;
         cmIfLE:
            begin
               if RAM[SP+2] <= RAM[SP+1] then
                  IPsim := RAM[SP];
               SP := SP + 3;
            end;
         cmIfLT:
            begin
               if RAM[SP+2] < RAM[SP+1] then
                  IPsim := RAM[SP];
               SP := SP + 3;
            end;
         cmIfGE:
            begin
               if RAM[SP+2] >= RAM[SP+1] then
                  IPsim := RAM[SP];
               SP := SP + 3;
            end;
         cmIfGT:
            begin
               if RAM[SP+2] > RAM[SP+1] then
                  IPsim := RAM[SP];
               SP := SP + 3;
            end;
         cmIn:
            begin
               SP := SP - 1;
               frmMain.Timer1.Enabled := False;
               frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + '?';
               RAM[SP] := StrToInt(InputBox('OVM', 'Введите число', ''));
               frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + IntToStr(RAM[SP]) + #13#10;

               if isRun then begin
                frmMain.Timer1.Enabled := True;
               end;
            end;
         cmOut:
            begin
               frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + IntToStr(RAM[SP+1]);
               SP := SP + 2;
            end;
         cmOutLn:
            frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + #13#10;
         else begin
            frmMain.mConsole.Lines.add('Недопустимый код операции');
            RAM[IPsim] := cmStop;
         end;
         end;
      IRsim := RAM[IPsim];

  // Вывод содержимого регистров
  frmMain.labelRegIP.Caption := format('%.2x',[IPsim]);
  frmMain.labelRegIR.Caption := frmMain.IntToBin(IRsim, 7);
  frmMain.labelRegSP.Caption := format('%.2x',[SP]);
  for i := 1 to frmMain.sgMemory.RowCount - 1 do
    for j := 1 to frmMain.sgMemory.ColCount - 1 do
      frmMain.sgMemory.Cells[j, i] := format('%.2x',[RAM[(i-1)*16 + (j-1)]]);
  frmMain.sgMemory.Selection := TGridRect(rect((IPsim MOD 16) + 1, (IPsim DIV 16) + 1, (IPsim MOD 16) + 1, (IPsim DIV 16) + 1));
end;


// Печатает сгенерированный код
procedure printCode(PC: Integer);
begin
      //for pc in range(0, PC):
      //  print(pc, ') ', M[pc] if M[pc] >= 0 else _mnemo[-M[pc]])
end;

end.
