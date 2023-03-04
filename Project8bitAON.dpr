program Project8bitAON;

uses
  Vcl.Forms,
  ufMain in 'ufMain.pas' {frmMain},
  uText in 'uText.pas',
  uOVM in 'uOVM.pas',
  uError in 'uError.pas',
  uSimulator in 'uSimulator.pas',
  uScan in 'uScan.pas',
  uGen in 'uGen.pas',
  uTable in 'uTable.pas',
  uPars in 'uPars.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
