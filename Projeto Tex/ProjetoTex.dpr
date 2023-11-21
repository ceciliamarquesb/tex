program ProjetoTex;

uses
  Vcl.Forms,
  ufrmLogin in 'ufrmLogin.pas' {frmLogin},
  ufrmPrincipal in 'ufrmPrincipal.pas' {frmPrincipal},
  udmProjeto in 'udmProjeto.pas' {dmProjeto: TDataModule},
  uControllers in 'uControllers.pas',
  uModels in 'uModels.pas',
  uAPI in 'uAPI.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmProjeto, dmProjeto);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
