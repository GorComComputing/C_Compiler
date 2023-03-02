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
    Save1: TMenuItem;
    Saveprogram1: TMenuItem;
    cmbHz: TComboBox;
    btnRun: TButton;
    StatusBar1: TStatusBar;
    btnStep: TButton;
    btnReset: TButton;
    cmbCPUType: TComboBox;
    Label68: TLabel;
    Label5: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    est1: TMenuItem;
    UpperCase1: TMenuItem;
    LowerCase1: TMenuItem;
    Timer1: TTimer;
    Label6: TLabel;
    labelRegSP: TLabel;
    LoadOVM1: TMenuItem;
    Compile1: TMenuItem;
    N2: TMenuItem;
    Settings1: TMenuItem;
    Font1: TMenuItem;
    Color1: TMenuItem;
    FontDialog1: TFontDialog;
    ColorDialog1: TColorDialog;
    aPanel1: TPanel;
    mPanel1: TPanel;
    procedure btnStepClick(Sender: TObject);
    procedure mEditorChange(Sender: TObject);
    procedure UpperCase1Click(Sender: TObject);
    procedure LowerCase1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure LoadProgram1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnRunClick(Sender: TObject);
    procedure Openfile1Click(Sender: TObject);
    procedure Assembly1Click(Sender: TObject);
    procedure cmbCPUTypeChange(Sender: TObject);
    procedure Clearmemory1Click(Sender: TObject);
    procedure cmbHzChange(Sender: TObject);
    procedure LoadOVM1Click(Sender: TObject);
    procedure Run1Click(Sender: TObject);
    procedure Step1Click(Sender: TObject);
    procedure Reset1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Font1Click(Sender: TObject);
    procedure Color1Click(Sender: TObject);


  private
    { Private declarations }
  public
    procedure StepSimulate();
    procedure StepAON();
    procedure StepOVM();
    procedure ResetCPU();
    function IntToBin(Value: Longint; Digits: Integer): string;
  end;

var
  frmMain: TfrmMain;

  isRun: Boolean;

  // Регистры симулятора
  IPsim: Integer;
  IRsim: Integer;
  SP: Integer;
  FLsim: Array[0..3] of Integer;       //CAEZ
  RegFile: Array[0..3] of Integer;     //0-AX, 1-BX, 2-CX, 3-DX

  //Память RAM
  RAM: Array[0..255] of Integer;

implementation

{$R *.dfm}

procedure TfrmMain.Assembly1Click(Sender: TObject);
var
  s: String;
begin
  s := mEditor.Text[2];
  mConsole.Text := s;
end;

procedure TfrmMain.btnResetClick(Sender: TObject);
begin
  // Сброс процессора
  ResetCPU();
end;

procedure TfrmMain.btnRunClick(Sender: TObject);
begin
  if isRun = False then
  begin
    btnRun.Caption := 'Stop';
    isRun := True;
    Timer1.Enabled := True
  end
  else
    begin
    btnRun.Caption := 'Run';
    isRun := False;
    Timer1.Enabled := False;
    end;
end;

procedure TfrmMain.btnStepClick(Sender: TObject);
begin
  Case cmbCPUType.ItemIndex of
		0: StepSimulate();
    1: StepAON();
    2: StepOVM();
  End;
end;

procedure TfrmMain.Clearmemory1Click(Sender: TObject);
var
  i, j: Integer;
begin
  // Заполняем память нулями
  for i := 0 to 255 do
    RAM[i] := 0;

  // Заполняем таблицу Memory
  for i := 1 to sgMemory.RowCount - 1 do
    for j := 1 to sgMemory.ColCount - 1 do
      sgMemory.Cells[j, i] := format('%.2x',[RAM[(i-1)*16 + (j-1)]]);

  sgMemory.Selection := TGridRect(rect(1, 1, 1, 1));
end;

procedure TfrmMain.cmbCPUTypeChange(Sender: TObject);
begin
   Case cmbCPUType.ItemIndex of
   0: begin
    Label1.Visible := True;
    Label2.Visible := True;
    Label3.Visible := True;
    Label4.Visible := True;
    Label9.Visible := True;

    Label17.Visible := True;
    Label19.Visible := True;
    Label21.Visible := True;
    Label23.Visible := True;
    Label25.Visible := True;

    labelRegA.Visible := True;
    labelRegB.Visible := True;
    labelRegC.Visible := True;
    labelRegD.Visible := True;
    labelRegIP.Visible := True;
    labelRegFC.Visible := True;
    labelRegFA.Visible := True;
    labelRegFE.Visible := True;
    labelRegFZ.Visible := True;


    Label6.Visible := False;
    labelRegSP.Visible := False;
    labelRegMAR.Visible := False;
    labelRegACC.Visible := False;
    labelRegTMP.Visible := False;
    labelRegIR.Visible := False;
    labelRegST.Visible := False;
    Label26.Visible := False;
    Label28.Visible := False;
    Label11.Visible := False;
    Label13.Visible := False;
    Label15.Visible := False;

    Label30.Visible := False;
    Label31.Visible := False;
    Label32.Visible := False;
    Label33.Visible := False;
    Label34.Visible := False;
    Label35.Visible := False;
    Label36.Visible := False;
    Label37.Visible := False;
    Label38.Visible := False;
    Label39.Visible := False;
    Label40.Visible := False;
    Label41.Visible := False;
    Label42.Visible := False;
    Label43.Visible := False;
    Label44.Visible := False;
    Label45.Visible := False;
    Label46.Visible := False;
    Label47.Visible := False;
    Label48.Visible := False;
    Label49.Visible := False;
    Label50.Visible := False;
    Label51.Visible := False;
    Label52.Visible := False;
    Label53.Visible := False;
    Label54.Visible := False;
    Label55.Visible := False;
    Label56.Visible := False;
    Label57.Visible := False;
    Label58.Visible := False;
    Label59.Visible := False;
    Label60.Visible := False;
    Label61.Visible := False;
    Label62.Visible := False;
    Label63.Visible := False;
    Label64.Visible := False;
    Label65.Visible := False;
    Label66.Visible := False;
    Label67.Visible := False;

   end;
   1: begin
    Label1.Visible := True;
    Label2.Visible := True;
    Label3.Visible := True;
    Label4.Visible := True;
    Label9.Visible := True;
    Label11.Visible := True;
    Label13.Visible := True;
    Label15.Visible := True;
    Label17.Visible := True;
    Label19.Visible := True;
    Label21.Visible := True;
    Label23.Visible := True;
    Label25.Visible := True;
    Label26.Visible := True;
    Label28.Visible := True;
    labelRegA.Visible := True;
    labelRegB.Visible := True;
    labelRegC.Visible := True;
    labelRegD.Visible := True;
    labelRegIP.Visible := True;
    labelRegFC.Visible := True;
    labelRegFA.Visible := True;
    labelRegFE.Visible := True;
    labelRegFZ.Visible := True;
    labelRegMAR.Visible := True;
    labelRegACC.Visible := True;
    labelRegTMP.Visible := True;
    labelRegIR.Visible := True;
    labelRegST.Visible := True;

    Label6.Visible := False;
    labelRegSP.Visible := False;

    Label30.Visible := True;
    Label31.Visible := True;
    Label32.Visible := True;
    Label33.Visible := True;
    Label34.Visible := True;
    Label35.Visible := True;
    Label36.Visible := True;
    Label37.Visible := True;
    Label38.Visible := True;
    Label39.Visible := True;
    Label40.Visible := True;
    Label41.Visible := True;
    Label42.Visible := True;
    Label43.Visible := True;
    Label44.Visible := True;
    Label45.Visible := True;
    Label46.Visible := True;
    Label47.Visible := True;
    Label48.Visible := True;
    Label49.Visible := True;
    Label50.Visible := True;
    Label51.Visible := True;
    Label52.Visible := True;
    Label53.Visible := True;
    Label54.Visible := True;
    Label55.Visible := True;
    Label56.Visible := True;
    Label57.Visible := True;
    Label58.Visible := True;
    Label59.Visible := True;
    Label60.Visible := True;
    Label61.Visible := True;
    Label62.Visible := True;
    Label63.Visible := True;
    Label64.Visible := True;
    Label65.Visible := True;
    Label66.Visible := True;
    Label67.Visible := True;
   end;
   2: begin
    Label1.Visible := False;
    Label2.Visible := False;
    Label3.Visible := False;
    Label4.Visible := False;
    Label9.Visible := False;
    Label11.Visible := False;
    Label13.Visible := False;
    Label15.Visible := False;
    Label17.Visible := False;
    Label19.Visible := False;
    Label21.Visible := False;
    Label23.Visible := False;
    Label25.Visible := False;
    Label26.Visible := False;
    Label28.Visible := False;
    labelRegA.Visible := False;
    labelRegB.Visible := False;
    labelRegC.Visible := False;
    labelRegD.Visible := False;
    labelRegIP.Visible := False;
    labelRegFC.Visible := False;
    labelRegFA.Visible := False;
    labelRegFE.Visible := False;
    labelRegFZ.Visible := False;
    labelRegMAR.Visible := False;
    labelRegACC.Visible := False;
    labelRegTMP.Visible := False;
    labelRegIR.Visible := False;
    labelRegST.Visible := False;

    Label6.Visible := True;
    labelRegSP.Visible := True;
    labelRegIP.Visible := True;
    Label9.Visible := True;

    Label30.Visible := False;
    Label31.Visible := False;
    Label32.Visible := False;
    Label33.Visible := False;
    Label34.Visible := False;
    Label35.Visible := False;
    Label36.Visible := False;
    Label37.Visible := False;
    Label38.Visible := False;
    Label39.Visible := False;
    Label40.Visible := False;
    Label41.Visible := False;
    Label42.Visible := False;
    Label43.Visible := False;
    Label44.Visible := False;
    Label45.Visible := False;
    Label46.Visible := False;
    Label47.Visible := False;
    Label48.Visible := False;
    Label49.Visible := False;
    Label50.Visible := False;
    Label51.Visible := False;
    Label52.Visible := False;
    Label53.Visible := False;
    Label54.Visible := False;
    Label55.Visible := False;
    Label56.Visible := False;
    Label57.Visible := False;
    Label58.Visible := False;
    Label59.Visible := False;
    Label60.Visible := False;
    Label61.Visible := False;
    Label62.Visible := False;
    Label63.Visible := False;
    Label64.Visible := False;
    Label65.Visible := False;
    Label66.Visible := False;
    Label67.Visible := False;
   end;


   End;

end;

procedure TfrmMain.cmbHzChange(Sender: TObject);
begin
Case cmbHz.ItemIndex of
   0: Timer1.Interval := 1000;
   1: Timer1.Interval := 100;
   2: Timer1.Interval := 10;
   3: Timer1.Interval := 1;
End;
end;

procedure TfrmMain.Color1Click(Sender: TObject);
begin
  if ColorDialog1.Execute then
    mEditor.Color := ColorDialog1.Color;
end;

procedure TfrmMain.Font1Click(Sender: TObject);
begin
  if FontDialog1.Execute then
    mEditor.Font := FontDialog1.Font;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
   i, j : Integer;
begin
  // Инициализация регистров симулятора
  IPsim := 0;
  IRsim := 0;
  SP := $E0;
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
  labelRegSP.Caption := format('%.2x',[SP]);


  // Заполняем память нулями
  for i := 0 to 255 do
    RAM[i] := 0;

  // Заполняем таблицу Memory
  for i := 1 to sgMemory.RowCount - 1 do
      sgMemory.Cells[0, i] := format('%.2x',[i-1]);
  for i := 1 to sgMemory.ColCount - 1 do
      sgMemory.Cells[i, 0] := format('%.2x',[i-1]);

  for i := 1 to sgMemory.RowCount - 1 do
    for j := 1 to sgMemory.ColCount - 1 do
      sgMemory.Cells[j, i] := format('%.2x',[RAM[(i-1)*16 + (j-1)]]);

  sgMemory.Selection := TGridRect(rect(1, 1, 1, 1));
end;

procedure TfrmMain.LoadOVM1Click(Sender: TObject);
var
  i, j: Integer;
begin

    // Сброс процессора
    ResetCPU();

    // Заполняем память нулями
    for i := 0 to 255 do
      RAM[i] := 0;

    Label5.Caption := 'Memory: OVM test program Prime';

  {
  RAM[0] := 100;
  RAM[1] := -21;
  RAM[2] := -9;
  RAM[3] := 101;
  RAM[4] := 2;
  RAM[5] := -9;
  RAM[6] := 100;
  RAM[7] := -8;
  RAM[8] := 101;
  RAM[9] := -8;
  RAM[10] := -6;
  RAM[11] := 0;
  RAM[12] := 22;
  RAM[13] := -19;
  RAM[14] := 101;
  RAM[15] := 101;
  RAM[16] := -8;
  RAM[17] := 1;
  RAM[18] := -2;
  RAM[19] := -9;
  RAM[20] := 6;
  RAM[21] := -14;
  RAM[22] := 101;
  RAM[23] := -8;
  RAM[24] := 100;
  RAM[25] := -8;
  RAM[26] := 34;
  RAM[27] := -20;
  RAM[28] := 100;
  RAM[29] := -8;
  RAM[30] := 0;
  RAM[31] := -22;
  RAM[32] := 37;
  RAM[33] := -14;
  RAM[34] := 0;
  RAM[35] := 0;
  RAM[36] := -22;
  RAM[37] := -23;
  RAM[38] := -1;    }


  RAM[0] := -21;
  RAM[1] := 2;
  RAM[2] := -13;
  RAM[3] := -13;
  RAM[4] := -6;
  RAM[5] := 0;
  RAM[6] := 12;
  RAM[7] := -15;
  RAM[8] := 1;
  RAM[9] := -2;
  RAM[10] := 2;
  RAM[11] := -14;
  RAM[12] := -13;
  RAM[13] := 17;
  RAM[14] := -15;
  RAM[15] := -11;
  RAM[16] := 0;
  RAM[17] := 0;
  RAM[18] := -22;
  RAM[19] := -23;
  RAM[20] := -1;

  {  IN,
    2,
    OVER,
    OVER,
    MOD,
    0,
    12,
    IFEQ,
    1,
    ADD,
    2,
    GOTO,
    OVER,
    17,
    IFEQ,
    DROP,
    0,
    0,
    OUT,
    LN,
    STOP       }

  for i := 1 to sgMemory.RowCount - 1 do
    for j := 1 to sgMemory.ColCount - 1 do
      sgMemory.Cells[j, i] := format('%.2x',[RAM[(i-1)*16 + (j-1)]]);

  sgMemory.Selection := TGridRect(rect(1, 1, 1, 1));

end;

procedure TfrmMain.LoadProgram1Click(Sender: TObject);
var
  i, j, n: Integer;
  f: File;
begin
  if OpenDialog1.Execute then
   begin
    // Сброс процессора
    ResetCPU();

    // Заполняем память нулями
    for i := 0 to 255 do
      RAM[i] := 0;

    Label5.Caption := 'Memory: ' + OpenDialog1.FileName;
    AssignFile(f, OpenDialog1.FileName);
    Reset(f,1);
    i := 0;
    while not eof(f) do
    begin
      BlockRead(f,RAM[i],1);
      i := i + 1;
    end;
    CloseFile(f);


    for i := 1 to sgMemory.RowCount - 1 do
      for j := 1 to sgMemory.ColCount - 1 do
        sgMemory.Cells[j, i] := format('%.2x',[RAM[(i-1)*16 + (j-1)]]);
    sgMemory.Selection := TGridRect(rect(1, 1, 1, 1));

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
  //Label69.Caption := 'Editor: ' + IntToStr(Length(mEditor.Lines.Text));
end;

procedure TfrmMain.Openfile1Click(Sender: TObject);
var
  i, j, n: Integer;
  f: File;
begin
  if OpenDialog1.Execute then
   begin
    Label69.Caption := 'Editor: ' + OpenDialog1.FileName;
    mEditor.Lines.LoadFromFile(OpenDialog1.FileName);
    mEditor.Text := Utf8ToAnsi(mEditor.Text);
    end
     else
      //exit;
end;

procedure TfrmMain.UpperCase1Click(Sender: TObject);
begin
  mEditor.Lines.Text := AnsiUpperCase(mEditor.Lines.Text);
end;


// Сброс процессора
procedure TfrmMain.Reset1Click(Sender: TObject);
begin
  btnReset.Click();
end;

procedure TfrmMain.ResetCPU();
var
   i: Integer;
begin
  //Остонавливаем процессор
  isRun := False;
  btnRun.Caption := 'Run';
  Timer1.Enabled := False;

  // Инициализация регистров симулятора
  IPsim := 0;
  IRsim := 0;
  SP := $E0;
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
  labelRegSP.Caption := format('%.2x',[SP]);

  sgMemory.Selection := TGridRect(rect(1, 1, 1, 1));
end;


procedure TfrmMain.Run1Click(Sender: TObject);
begin
  btnRun.Click();
end;

// Шаг осциллятора Simulator
procedure TfrmMain.StepSimulate();
var
  IPsimBefore, isALU, Operation, RegA, RegB, FC, FA, FE, FZ: Integer;
  i, j: Integer;
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

      for i := 1 to sgMemory.RowCount - 1 do
        for j := 1 to sgMemory.ColCount - 1 do
          sgMemory.Cells[j, i] := format('%.2x',[RAM[(i-1)*16 + (j-1)]]);
			//DrawASCII(RegFile[RegA]);
			end;
		2: begin // Data
			RegFile[RegB] := RAM[IPsim];//.charCodeAt(0);
			IPsim := IPsim + 1;
			end;
		3: begin // JMP to Reg
			IPsim := RegFile[RegB];
      mConsole.Lines.add('IPsim now: ' + IntToStr(IPsim));
      sgMemory.Selection := TGridRect(rect((IPsim MOD 16) + 1, (IPsim DIV 16) + 1, (IPsim MOD 16) + 1, (IPsim DIV 16) + 1));
      labelRegIP.Caption := format('%.2x',[IPsim]);
			end;
		4: begin // JMP to Address
			IPsim := RAM[IPsim];//.charCodeAt(0);
      mConsole.Lines.add('IPsim now: ' + IntToStr(IPsim));
      sgMemory.Selection := TGridRect(rect((IPsim MOD 16) + 1, (IPsim DIV 16) + 1, (IPsim MOD 16) + 1, (IPsim DIV 16) + 1));
      labelRegIP.Caption := format('%.2x',[IPsim]);
			end;
		5: begin // JMP IF to Address
			if(((FC AND FLsim[0]) <> 0) or ((FA AND FLsim[1]) <> 0) or ((FE AND FLsim[2]) <> 0) or ((FZ AND FLsim[3]) <> 0)) then
      begin
			IPsim := RAM[IPsim];//.charCodeAt(0);
      mConsole.Lines.add('IPsim now: ' + IntToStr(IPsim));
      sgMemory.Selection := TGridRect(rect((IPsim MOD 16) + 1, (IPsim DIV 16) + 1, (IPsim MOD 16) + 1, (IPsim DIV 16) + 1));
      labelRegIP.Caption := format('%.2x',[IPsim]);
			end
			else
      begin
      IPsim := IPsim + 1;
      sgMemory.Selection := TGridRect(rect((IPsim MOD 16) + 1, (IPsim DIV 16) + 1, (IPsim MOD 16) + 1, (IPsim DIV 16) + 1));
      labelRegIP.Caption := format('%.2x',[IPsim]);
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
  labelRegIP.Caption := format('%.2x',[IPsim]);//inttostr(IPsim);
  labelRegIR.Caption := IntToBin(IRsim, 7);//format('%.8x',[IRsim]);//inttostr(IRsim);
  sgMemory.Selection := TGridRect(rect((IPsim MOD 16) + 1, (IPsim DIV 16) + 1, (IPsim MOD 16) + 1, (IPsim DIV 16) + 1));

  labelRegFC.Caption := format('%.1x',[FLsim[0]]);
  labelRegFA.Caption := format('%.1x',[FLsim[1]]);
  labelRegFE.Caption := format('%.1x',[FLsim[2]]);
  labelRegFZ.Caption := format('%.1x',[FLsim[3]]);

  labelRegA.Caption := format('%.2x',[RegFile[0]]);
  labelRegB.Caption := format('%.2x',[RegFile[1]]);
  labelRegC.Caption := format('%.2x',[RegFile[2]]);
  labelRegD.Caption := format('%.2x',[RegFile[3]]);

end;


// Шаг осциллятора AON
procedure TfrmMain.Save1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    begin
    mEditor.Lines.SaveToFile(SaveDialog1.FileName);
    Label69.Caption := 'Editor: ' + SaveDialog1.FileName;
    end;
end;

procedure TfrmMain.Step1Click(Sender: TObject);
begin
  btnStep.Click();
end;

procedure TfrmMain.StepAON();

begin
  //
end;


// Шаг осциллятора OVM
procedure TfrmMain.StepOVM();
const
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
var
   i, j, Buf: Integer;
begin
  IRsim := RAM[IPsim];
  IPsim := IPsim + 1;
  // Вывод содержимого регистров
  labelRegIP.Caption := format('%.2x',[IPsim]);
  labelRegIR.Caption := IntToBin(IRsim, 7);
  labelRegSP.Caption := IntToBin(SP, 7);
  sgMemory.Selection := TGridRect(rect((IPsim MOD 16) + 1, (IPsim DIV 16) + 1, (IPsim MOD 16) + 1, (IPsim DIV 16) + 1));

      if IRsim >= 0 then begin
         SP := SP - 1;
         RAM[SP] := IRsim;
         end
      else
         case IRsim of
         cmStop:
            begin
               btnRun.Caption := 'Run';
               isRun := False;
               Timer1.Enabled := False;
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


               //btnRun.Caption := 'Run';
               //isRun := False;
               Timer1.Enabled := False;
               //Write('?');
               mConsole.Lines.add('?');
               RAM[SP] := StrToInt(InputBox('OVM', 'Введите число', ''));
               mConsole.Lines.add(IntToStr(RAM[SP]));

               if isRun then begin
                Timer1.Enabled := True;
               end;

              //btnRun.Caption := 'Stop';
              //isRun := True;


               //Readln( RAM[SP] );
            end;
         cmOut:
            begin
               //Write(RAM[SP+1]:RAM[SP]);
               mConsole.Lines.add(IntToStr(RAM[SP+1]));
               SP := SP + 2;
            end;
         cmOutLn:
            //WriteLn;
            mConsole.Lines.add('');
         else begin
            //WriteLn('Недопустимый код операции');
            mConsole.Lines.add('Недопустимый код операции');
            RAM[IPsim] := cmStop;
         end;
         end;
      IRsim := RAM[IPsim];

  // Вывод содержимого регистров
  labelRegIP.Caption := format('%.2x',[IPsim]);
  labelRegIR.Caption := IntToBin(IRsim, 7);
  labelRegSP.Caption := format('%.2x',[SP]);
  for i := 1 to sgMemory.RowCount - 1 do
    for j := 1 to sgMemory.ColCount - 1 do
      sgMemory.Cells[j, i] := format('%.2x',[RAM[(i-1)*16 + (j-1)]]);
  sgMemory.Selection := TGridRect(rect((IPsim MOD 16) + 1, (IPsim DIV 16) + 1, (IPsim MOD 16) + 1, (IPsim DIV 16) + 1));
end;


procedure TfrmMain.Timer1Timer(Sender: TObject);
begin
  Case cmbCPUType.ItemIndex of
		0: StepSimulate();
    1: StepAON();
    2: StepOVM();
  End;
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
