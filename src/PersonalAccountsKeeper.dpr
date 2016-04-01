program PersonalAccountsKeeper;

uses
  Forms,
  PAK_MainForm in 'PAK_MainForm.pas' {PAKMainFrm},
  PAK_Language in 'PAK_Language.pas',
  PAK_AcCardFrm in 'PAK_AcCardFrm.pas' {AccountFrm},
  PAK_DBEngine in 'PAK_DBEngine.pas' {$R *.res},
  aboutboxfrm in 'aboutboxfrm.pas' {frmAbout},
  PAK_DonateForm in 'PAK_DonateForm.pas' {FormDonate};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TPAKMainFrm, PAKMainFrm);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.Run;
end.