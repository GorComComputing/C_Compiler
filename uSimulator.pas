unit uSimulator;
{Симулятор процессора 8-bit-AON}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.ExtCtrls,
  Vcl.Menus, Vcl.ComCtrls,
  System.Types, System.IOUtils, Vcl.Buttons;


  procedure StepSimulate();
  procedure StepAON();

implementation

uses
  ufMain;


// Шаг осциллятора Simulator
procedure StepSimulate();
var
  IPsimBefore, isALU, Operation, RegA, RegB, FC, FA, FE, FZ: Integer;
  i, j: Integer;
begin
  // Fetch Instruction
	IPsimBefore := IPsim;
	IRsim := RAM[IPsim];
	IPsim := IPsim + 1;

  // Вывод содержимого регистров
  frmMain.labelRegIP.Caption := format('%.2x',[IPsim]);//inttostr(IPsim);
  frmMain.labelRegIR.Caption := frmMain.IntToBin(IRsim, 7);//format('%.8x',[IRsim]);//inttostr(IRsim);
  frmMain.sgMemory.Selection := TGridRect(rect((IPsim MOD 16) + 1, (IPsim DIV 16) + 1, (IPsim MOD 16) + 1, (IPsim DIV 16) + 1));

  // Decode Instruction
	isALU := IRsim SHR 7;
	Operation := IRsim SHR 4 AND 7;
	RegA := IRsim SHR 2 AND 3;
	RegB := IRsim AND 3;
	FC := (IRsim AND 8) SHR 7;
	FA := (IRsim AND 4) SHR 3;
	FE := (IRsim AND 2) SHR 1;
	FZ := IRsim AND 1;

  // Console Log
  frmMain.mConsole.Lines.add('Simulate: ' + IntToStr(IPsim));
  frmMain.mConsole.Lines.add('IRsim: ' + IntToStr(IRsim));
  frmMain.mConsole.Lines.add('isALU: ' + IntToStr(isALU));
  frmMain.mConsole.Lines.add('Operation: ' + IntToStr(Operation));
  frmMain.mConsole.Lines.add('RegA: ' + IntToStr(RegA));
  frmMain.mConsole.Lines.add('RegB: ' + IntToStr(RegB));
  frmMain.mConsole.Lines.add('FC: ' + IntToStr(FC));
  frmMain.mConsole.Lines.add('FA: ' + IntToStr(FA));
  frmMain.mConsole.Lines.add('FE: ' + IntToStr(FE));
  frmMain.mConsole.Lines.add('FZ: ' + IntToStr(FZ));


  // Execute Instruction
	if isALU <> 0 then begin // ALU Operations
		Case Operation of
		0: begin // ADD
			RegFile[RegB] := RegFile[RegA] + RegFile[RegB];
			if (RegFile[RegB] > 65535) then begin RegFile[RegB] := 65535; FLsim[0] := 1; end
			else FLsim[0] := 0;
			if (RegFile[RegB] = 0) then FLsim[3] := 1
			else FLsim[3] := 0;
			end;
    1: begin // SHL
			RegFile[RegB] := RegFile[RegA] SHL 1;
			FLsim[0] := RegFile[RegA] AND 15;
			if (RegFile[RegB] = 0) then FLsim[3] := 1
			else FLsim[3] := 0;
			end;
		2: begin // SHR
			RegFile[RegB] := RegFile[RegA] SHR 1;
			FLsim[0] := RegFile[RegA] AND 1;
			if (RegFile[RegB] = 0) then FLsim[3] := 1
			else FLsim[3] := 0;
			end;
		3: begin // NOT
			RegFile[RegB] := NOT RegFile[RegA];
			if (RegFile[RegB] = 0) then FLsim[3] := 1
			else FLsim[3] := 0;
			end;
		4: begin // AND
			RegFile[RegB] := RegFile[RegA] AND RegFile[RegB];
			if (RegFile[RegB] = 0) then FLsim[3] := 1
			else FLsim[3] := 0;
			end;
		5: begin // OR
			RegFile[RegB] := RegFile[RegA] OR RegFile[RegB];
			if (RegFile[RegB] = 0) then FLsim[3] := 1
			else FLsim[3] := 0;
			end;
		6: begin // XOR
			RegFile[RegB] := RegFile[RegA] XOR RegFile[RegB];
			if (RegFile[RegB] = 0) then FLsim[3] := 1
			else FLsim[3] := 0;
			end;
		7: begin // CMP
			if ((RegFile[RegB] - RegFile[RegA]) = 0) then FLsim[2] := 1
			else FLsim[2] := 0;
			if ((RegFile[RegB] - RegFile[RegA]) > 0) then FLsim[1] := 1
			else FLsim[1] := 0;
			FLsim[0] := 0;
			FLsim[3] := 0;
			end;
		end;
	end
	else begin  // Other Operations
		Case Operation of
		0: begin // Load
			RegFile[RegB] := RAM[RegFile[RegA]];//.charCodeAt(0);
			end;
		1: begin // Store
			RAM[RegFile[RegA]] := RegFile[RegB];//String.fromCharCode(RegFile[RegB]);

      for i := 1 to frmMain.sgMemory.RowCount - 1 do
        for j := 1 to frmMain.sgMemory.ColCount - 1 do
          frmMain.sgMemory.Cells[j, i] := format('%.2x',[RAM[(i-1)*16 + (j-1)]]);
			//DrawASCII(RegFile[RegA]);
			end;
		2: begin // Data
			RegFile[RegB] := RAM[IPsim];//.charCodeAt(0);
			IPsim := IPsim + 1;
			end;
		3: begin // JMP to Reg
			IPsim := RegFile[RegB];
      frmMain.mConsole.Lines.add('IPsim now: ' + IntToStr(IPsim));
      frmMain.sgMemory.Selection := TGridRect(rect((IPsim MOD 16) + 1, (IPsim DIV 16) + 1, (IPsim MOD 16) + 1, (IPsim DIV 16) + 1));
      frmMain.labelRegIP.Caption := format('%.2x',[IPsim]);
			end;
		4: begin // JMP to Address
			IPsim := RAM[IPsim];//.charCodeAt(0);
      frmMain.mConsole.Lines.add('IPsim now: ' + IntToStr(IPsim));
      frmMain.sgMemory.Selection := TGridRect(rect((IPsim MOD 16) + 1, (IPsim DIV 16) + 1, (IPsim MOD 16) + 1, (IPsim DIV 16) + 1));
      frmMain.labelRegIP.Caption := format('%.2x',[IPsim]);
			end;
		5: begin // JMP IF to Address
			if(((FC AND FLsim[0]) <> 0) or ((FA AND FLsim[1]) <> 0) or ((FE AND FLsim[2]) <> 0) or ((FZ AND FLsim[3]) <> 0)) then
      begin
			IPsim := RAM[IPsim];//.charCodeAt(0);
      frmMain.mConsole.Lines.add('IPsim now: ' + IntToStr(IPsim));
      frmMain.sgMemory.Selection := TGridRect(rect((IPsim MOD 16) + 1, (IPsim DIV 16) + 1, (IPsim MOD 16) + 1, (IPsim DIV 16) + 1));
      frmMain.labelRegIP.Caption := format('%.2x',[IPsim]);
			end
			else
      begin
      IPsim := IPsim + 1;
      frmMain.sgMemory.Selection := TGridRect(rect((IPsim MOD 16) + 1, (IPsim DIV 16) + 1, (IPsim MOD 16) + 1, (IPsim DIV 16) + 1));
      frmMain.labelRegIP.Caption := format('%.2x',[IPsim]);
      end;
			end;
		6: begin // Clear Flags
      for i := 0 to 3 do
        FLsim[i] := 0;
			end;
		7: begin // IO

			end;
		end;
	end;



  // Вывод содержимого регистров
  frmMain.labelRegIP.Caption := format('%.2x',[IPsim]);//inttostr(IPsim);
  frmMain.labelRegIR.Caption := frmMain.IntToBin(IRsim, 7);//format('%.8x',[IRsim]);//inttostr(IRsim);
  frmMain.sgMemory.Selection := TGridRect(rect((IPsim MOD 16) + 1, (IPsim DIV 16) + 1, (IPsim MOD 16) + 1, (IPsim DIV 16) + 1));

  frmMain.labelRegFC.Caption := format('%.1x',[FLsim[0]]);
  frmMain.labelRegFA.Caption := format('%.1x',[FLsim[1]]);
  frmMain.labelRegFE.Caption := format('%.1x',[FLsim[2]]);
  frmMain.labelRegFZ.Caption := format('%.1x',[FLsim[3]]);

  frmMain.labelRegA.Caption := format('%.2x',[RegFile[0]]);
  frmMain.labelRegB.Caption := format('%.2x',[RegFile[1]]);
  frmMain.labelRegC.Caption := format('%.2x',[RegFile[2]]);
  frmMain.labelRegD.Caption := format('%.2x',[RegFile[3]]);

end;


// Шаг осциллятора AON
procedure StepAON();

begin
  //
end;

end.
