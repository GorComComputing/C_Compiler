unit ufMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.ExtCtrls,
  Vcl.Menus, Vcl.ComCtrls,
  System.Types, System.IOUtils, Vcl.Buttons,
  uOVM, uSimulator,
  uText, uScan, uGen, uPars;


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
    mEditor: TMemo;
    mConsole: TMemo;
    Panel1: TPanel;
    Splitter1: TSplitter;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure btnStepClick(Sender: TObject);
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
    procedure SpeedButton1Click(Sender: TObject);
    procedure OberonCompile1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Saveprogram1Click(Sender: TObject);


  private
    { Private declarations }
  public
    procedure ResetCPU();
    function IntToBin(Value: Longint; Digits: Integer): string;
  end;

var
  frmMain: TfrmMain;

  isRun: Boolean;
  ConsoleHeight: Integer;

  // Регистры симулятора
  IPsim: Integer;
  IRsim: Integer;
  SP: Integer;
  FLsim: Array[0..3] of Integer;       //CAEZ
  RegFile: Array[0..3] of Integer;     //0-AX, 1-BX, 2-CX, 3-DX

  //Память RAM
  RAM: Array[0..255] of ShortInt;//Integer;

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
  i, j, n: Integer;
  f: File;
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

  ConsoleHeight := mConsole.Height;

  if ParamCount > 0 then begin
    if (ParamStr(1)[Length(ParamStr(1)) ] = 'c') and (ParamStr(1)[Length(ParamStr(1)) - 1] = 'g') and (ParamStr(1)[Length(ParamStr(1)) - 2] = '.') then  begin
      frmMain.Caption := 'Виртуальный процессор 8-bit-AON - ' + ParamStr(1);
      mEditor.Lines.LoadFromFile(ParamStr(1));
      mEditor.Text := Utf8ToAnsi(mEditor.Text);
    end;

    if (ParamStr(1)[Length(ParamStr(1)) ] = 'o') and (ParamStr(1)[Length(ParamStr(1)) - 1] = 'c') and (ParamStr(1)[Length(ParamStr(1)) - 2] = 'g') and (ParamStr(1)[Length(ParamStr(1)) - 3] = '.') then  begin
      // Сброс процессора
      ResetCPU();

      // Заполняем память нулями
      for i := 0 to 255 do
        RAM[i] := 0;

      Label5.Caption := 'Memory: ' + ParamStr(1);
      AssignFile(f, ParamStr(1));
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

      cmbCPUType.ItemIndex := 2;
      cmbCPUTypeChange(cmbCPUType);
      frmMain.Caption := 'Виртуальный процессор 8-bit-AON - ' + ParamStr(1);
      aPanel1.Visible := False;
      mEditor.Visible := False;
      mConsole.Align := alClient;
      btnRun.Click;
    end;

  end;
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

procedure TfrmMain.OberonCompile1Click(Sender: TObject);
begin
   mConsole.Lines.add('Компилятор языка Оberon');

   ResetText;
   InitScan;
   {NextLex;
   frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + IntToStr(integer(Lex));
   while Ch <> chEOT do begin
    NextLex;
    frmMain.mConsole.lines.text := frmMain.mConsole.lines.text + IntToStr(integer(Lex));
   end;  }


   InitGen;

   Compile; {Компиляция}
   //Run;     {Выполнение}

end;

procedure TfrmMain.Openfile1Click(Sender: TObject);
//var
 // i, j, n: Integer;
 // f: File;
begin
  if OpenDialog1.Execute then
   begin
    frmMain.Caption := 'Виртуальный процессор 8-bit-AON - ' + OpenDialog1.FileName;
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


procedure TfrmMain.Save1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    begin
    mEditor.Lines.SaveToFile(SaveDialog1.FileName);
    frmMain.Caption := 'Виртуальный процессор 8-bit-AON - ' + SaveDialog1.FileName;
    end;
end;

procedure TfrmMain.Saveprogram1Click(Sender: TObject);
var
 // i, j, n: Integer;
  f: File;
begin
  if SaveDialog1.Execute then
    begin
    AssignFile(f, SaveDialog1.FileName);
    Rewrite(f, 1);
    blockwrite(f, RAM, 256);
    Label5.Caption := 'Memory: ' + SaveDialog1.FileName;
    end;

end;

procedure TfrmMain.SpeedButton1Click(Sender: TObject);
begin
  aPanel1.Visible := not aPanel1.Visible;
end;

procedure TfrmMain.SpeedButton2Click(Sender: TObject);
begin
    mEditor.Visible := not mEditor.Visible;
    if mEditor.Visible then begin
      mConsole.Height := ConsoleHeight;
      mConsole.Align := alBottom;
      Splitter1.Top := 471;
    end
    else begin
      ConsoleHeight := mConsole.Height;
      mConsole.Align := alClient;
    end;

end;

procedure TfrmMain.SpeedButton3Click(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to ParamCount do
    ShowMessage('Параметр '+IntToStr(i)+' = '+ParamStr(i));
end;

procedure TfrmMain.Step1Click(Sender: TObject);
begin
  btnStep.Click();
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
