unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.ExtCtrls,
  Vcl.Menus, Vcl.ComCtrls,
  System.Types, System.IOUtils;

type
  TfrmMain = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    labelRegA: TLabel;
    labelRegB: TLabel;
    labelRegC: TLabel;
    labelRegD: TLabel;
    Label9: TLabel;
    labelRegIP: TLabel;
    Label11: TLabel;
    labelRegTMP: TLabel;
    Label13: TLabel;
    labelRegACC: TLabel;
    Label15: TLabel;
    labelRegMAR: TLabel;
    Label17: TLabel;
    labelRegFC: TLabel;
    Label19: TLabel;
    labelRegFA: TLabel;
    Label21: TLabel;
    labelRegFE: TLabel;
    Label23: TLabel;
    labelRegFZ: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    labelRegIR: TLabel;
    Label28: TLabel;
    labelRegST: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label33: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label67: TLabel;
    Image1: TImage;
    sgMemory: TStringGrid;
    mEditor: TMemo;
    mConsole: TMemo;
    MainMenu1: TMainMenu;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    File1: TMenuItem;
    Openfile1: TMenuItem;
    Assembly1: TMenuItem;
    OberonCompile1: TMenuItem;
    CCompile1: TMenuItem;
    VM1: TMenuItem;
    LoadProgram1: TMenuItem;
    Run1: TMenuItem;
    Step1: TMenuItem;
    Reset1: TMenuItem;
    N1: TMenuItem;
    Clearmemory1: TMenuItem;
    N2: TMenuItem;
    Save1: TMenuItem;
    Saveprogram1: TMenuItem;
    ComboBox1: TComboBox;
    btnRun: TButton;
    StatusBar1: TStatusBar;
    btnStep: TButton;
    btnReset: TButton;
    ComboBox2: TComboBox;
    Label68: TLabel;
    Label5: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    est1: TMenuItem;
    UpperCase1: TMenuItem;
    LowerCase1: TMenuItem;
    procedure btnStepClick(Sender: TObject);
    procedure mEditorChange(Sender: TObject);
    procedure UpperCase1Click(Sender: TObject);
    procedure LowerCase1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure LoadProgram1Click(Sender: TObject);


  private
    { Private declarations }
  public
    procedure StepSimulate();
    function IntToBin(Value: Longint; Digits: Integer): string;
  end;

var
  frmMain: TfrmMain;

  // Файл с программой
  ff: Text;

  // Регистры симулятора
  IPsim: integer;
  IRsim: integer;
  FLsim: Array[0..3] of Integer;       //CAEZ
  RegFile: Array[0..3] of Integer;     //0-AX, 1-BX, 2-CX, 3-DX

  //Память RAM
  RAM: Array[0..255] of Byte;

implementation

{$R *.dfm}

procedure TfrmMain.btnResetClick(Sender: TObject);
var
   i: Integer;
begin
  // Инициализация регистров симулятора
  IPsim := 0;
  IRsim := 0;
  for i := 0 to 3 do
    begin
    FLsim[i] := 0;       //CAEZ
    RegFile[i] := 0;    //0-AX, 1-BX, 2-CX, 3-DX
    end;

  labelRegMAR.Caption := format('%.2x',[0]);
  labelRegTMP.Caption := format('%.2x',[0]);
  labelRegACC.Caption := format('%.2x',[0]);
  labelRegST.Caption := format('%.7x',[0]);

  labelRegFC.Caption := format('%.1x',[FLsim[0]]);
  labelRegFA.Caption := format('%.1x',[FLsim[1]]);
  labelRegFE.Caption := format('%.1x',[FLsim[2]]);
  labelRegFZ.Caption := format('%.1x',[FLsim[3]]);

  labelRegA.Caption := format('%.2x',[RegFile[0]]);
  labelRegB.Caption := format('%.2x',[RegFile[1]]);
  labelRegC.Caption := format('%.2x',[RegFile[2]]);
  labelRegD.Caption := format('%.2x',[RegFile[3]]);

  labelRegIP.Caption := format('%.2x',[IPsim]);//inttostr(IPsim);
  labelRegIR.Caption := IntToBin(IRsim, 7);//format('%.8x',[IRsim]);//inttostr(IRsim);
end;

procedure TfrmMain.btnStepClick(Sender: TObject);
begin
   //IPsim := 8;
   //labelRegA.Caption := inttostr(IPsim);
   StepSimulate();
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
   i, j : Integer;
begin
  // Инициализация регистров симулятора
  IPsim := 0;
  IRsim := 0;
  for i := 0 to 3 do
    begin
    FLsim[i] := 0;       //CAEZ
    RegFile[i] := 0;    //0-AX, 1-BX, 2-CX, 3-DX
    end;

  for i := 0 to 255 do
    RAM[i] := i;

  labelRegMAR.Caption := format('%.2x',[0]);
  labelRegTMP.Caption := format('%.2x',[0]);
  labelRegACC.Caption := format('%.2x',[0]);
  labelRegST.Caption := format('%.7x',[0]);

  labelRegFC.Caption := format('%.1x',[FLsim[0]]);
  labelRegFA.Caption := format('%.1x',[FLsim[1]]);
  labelRegFE.Caption := format('%.1x',[FLsim[2]]);
  labelRegFZ.Caption := format('%.1x',[FLsim[3]]);

  labelRegA.Caption := format('%.2x',[RegFile[0]]);
  labelRegB.Caption := format('%.2x',[RegFile[1]]);
  labelRegC.Caption := format('%.2x',[RegFile[2]]);
  labelRegD.Caption := format('%.2x',[RegFile[3]]);

  labelRegIP.Caption := format('%.2x',[IPsim]);//inttostr(IPsim);
  labelRegIR.Caption := IntToBin(IRsim, 7);//format('%.8x',[IRsim]);//inttostr(IRsim);

  // Заполняем таблицу Memory
  for i := 1 to sgMemory.RowCount - 1 do
      sgMemory.Cells[0, i] := format('%.2x',[i-1]);
  for i := 1 to sgMemory.ColCount - 1 do
      sgMemory.Cells[i, 0] := format('%.2x',[i-1]);

  for i := 1 to sgMemory.RowCount - 1 do
    for j := 1 to sgMemory.ColCount - 1 do
      sgMemory.Cells[j, i] := format('%.2x',[RAM[(i-1)*16 + (j-1)]]);
end;

procedure TfrmMain.LoadProgram1Click(Sender: TObject);
var
  i, j: Integer;
  n: String;
  A: TArray<System.Byte>;
begin
  if OpenDialog1.Execute then
   begin
    Label5.Caption := 'Memory: ' + OpenDialog1.FileName;
    AssignFile(ff, OpenDialog1.FileName);



 A := TFile.ReadAllBytes(OpenDialog1.FileName);

    //Reset(ff);
    //i := 0;
    //while not eof(ff) do
    for i := 0 to 255 do
      begin
      //if eof(ff) then Break;
       //Read(ff, n);
       RAM[i] := A[i];
       //i := i + 1;
      end;
    CloseFile(ff);

    for i := 1 to sgMemory.RowCount - 1 do
      for j := 1 to sgMemory.ColCount - 1 do
        sgMemory.Cells[j, i] := format('%.2x',[RAM[(i-1)*16 + (j-1)]]);

    end
     else
      //exit;
end;

procedure TfrmMain.LowerCase1Click(Sender: TObject);
begin
   mEditor.Lines.Text := AnsiLowerCase(mEditor.Lines.Text);
end;

procedure TfrmMain.mEditorChange(Sender: TObject);
begin
  Label69.Caption := 'Editor: ' + IntToStr(Length(mEditor.Lines.Text));
end;

procedure TfrmMain.UpperCase1Click(Sender: TObject);
begin
  mEditor.Lines.Text := AnsiUpperCase(mEditor.Lines.Text);
end;


// Шаг осциллятора
procedure TfrmMain.StepSimulate();
var
  IPsimBefore, isALU, Operation, RegA, RegB, FC, FA, FE, FZ: Integer;
  i: Integer;
begin
  // Fetch Instruction
	IPsimBefore := IPsim;
	IRsim := RAM[IPsim];
	IPsim := IPsim + 1;

  // Вывод содержимого регистров
  labelRegIP.Caption := format('%.2x',[IPsim]);//inttostr(IPsim);
  labelRegIR.Caption := IntToBin(IRsim, 7);//format('%.8x',[IRsim]);//inttostr(IRsim);
  sgMemory.Selection := TGridRect(rect((IPsim MOD 16) + 1, (IPsim DIV 16) + 1, (IPsim MOD 16) + 1, (IPsim DIV 16) + 1));

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
  mConsole.Lines.add('Simulate: ' + IntToStr(IPsim));
  mConsole.Lines.add('IRsim: ' + IntToStr(IRsim));
  mConsole.Lines.add('isALU: ' + IntToStr(isALU));
  mConsole.Lines.add('Operation: ' + IntToStr(Operation));
  mConsole.Lines.add('RegA: ' + IntToStr(RegA));
  mConsole.Lines.add('RegB: ' + IntToStr(RegB));
  mConsole.Lines.add('FC: ' + IntToStr(FC));
  mConsole.Lines.add('FA: ' + IntToStr(FA));
  mConsole.Lines.add('FE: ' + IntToStr(FE));
  mConsole.Lines.add('FZ: ' + IntToStr(FZ));


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
			//document.querySelector("#mem-block"+RegFile[RegA]).textContent = paddy(dec2hex(RAM[RegFile[RegA]].charCodeAt(0)),2);
			//DrawASCII(RegFile[RegA]);
			end;
		2: begin // Data
			RegFile[RegB] := RAM[IPsim];//.charCodeAt(0);
			IPsim := IPsim + 1;
			end;
		3: begin // JMP to Reg
			IPsim := RegFile[RegB];
      mConsole.Lines.add('IPsim now: ' + IntToStr(IPsim));
			end;
		4: begin // JMP to Address
			IPsim := RAM[IPsim];//.charCodeAt(0);
      mConsole.Lines.add('IPsim now: ' + IntToStr(IPsim));
			end;
		5: begin // JMP IF to Address
			if(((FC AND FLsim[0]) <> 0) or ((FA AND FLsim[1]) <> 0) or ((FE AND FLsim[2]) <> 0) or ((FZ AND FLsim[3]) <> 0)) then begin
			IPsim := RAM[IPsim];//.charCodeAt(0);
      mConsole.Lines.add('IPsim now: ' + IntToStr(IPsim));
			end
			else IPsim := IPsim + 1;
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
  labelRegFC.Caption := format('%.1x',[FLsim[0]]);
  labelRegFA.Caption := format('%.1x',[FLsim[1]]);
  labelRegFE.Caption := format('%.1x',[FLsim[2]]);
  labelRegFZ.Caption := format('%.1x',[FLsim[3]]);

  labelRegA.Caption := format('%.2x',[RegFile[0]]);
  labelRegB.Caption := format('%.2x',[RegFile[1]]);
  labelRegC.Caption := format('%.2x',[RegFile[2]]);
  labelRegD.Caption := format('%.2x',[RegFile[3]]);

end;


// Integer to Binary
function TfrmMain.IntToBin(Value: Longint; Digits: Integer): string;
var
  i: Integer;
begin
  Result := '';
  for i := Digits downto 0 do
    if Value and (1 shl i) <> 0 then
      Result := Result + '1'
    else
     Result := Result + '0';
end;

end.
