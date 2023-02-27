unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.ExtCtrls,
  Vcl.Menus, Vcl.ComCtrls;

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
    Openprogram1: TMenuItem;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

// Регистры симулятора
IPsim: integer;
IRsim: integer;
FLsim: Array[0..3] of Integer;       //CAEZ
RegFile: Array[0..3] of Integer;     //0-AX, 1-BX, 2-CX, 3-DX

implementation

{$R *.dfm}

procedure TfrmMain.btnResetClick(Sender: TObject);
begin
  // Инициализация регистров симулятора
  IPsim := 0;
  IRsim := 0;
  //FLsim: Array[0..3] of Integer;       //CAEZ
  //RegFile: Array[0..3] of Integer;     //0-AX, 1-BX, 2-CX, 3-DX

  labelRegIP.Caption := format('%.2u',[IPsim]);//inttostr(IPsim);
  labelRegIR.Caption := format('%.8u',[IRsim]);//inttostr(IRsim);
end;

procedure TfrmMain.btnStepClick(Sender: TObject);
begin
   IPsim := 8;
   labelRegA.Caption := inttostr(IPsim);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
   i, j : Integer;
begin
  // Инициализация регистров симулятора
  IPsim := 0;
  IRsim := 0;
  //FLsim: Array[0..3] of Integer;       //CAEZ
  //RegFile: Array[0..3] of Integer;     //0-AX, 1-BX, 2-CX, 3-DX

  labelRegIP.Caption := format('%.2u',[IPsim]);//inttostr(IPsim);
  labelRegIR.Caption := format('%.8u',[IRsim]);//inttostr(IRsim);

  // Заполняем таблицу Memory
  for i := 1 to sgMemory.RowCount - 1 do
      sgMemory.Cells[0, i] := format('%.2x',[i-1]);
  for i := 1 to sgMemory.ColCount - 1 do
      sgMemory.Cells[i, 0] := format('%.2x',[i-1]);

  for i := 1 to sgMemory.RowCount - 1 do
    for j := 1 to sgMemory.ColCount - 1 do
      sgMemory.Cells[j, i] := format('%.2x',[0]);
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

end.
