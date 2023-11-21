unit ufrmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Stan.Intf,
  FireDAC.Comp.UI;

type
  TfrmLogin = class(TForm)
    lblUsuario: TLabel;
    lblSenha: TLabel;
    btnLogin: TButton;
    btnSair: TButton;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    pnlMarca: TPanel;
    Image1: TImage;
    Label1: TLabel;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure btnSairClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    function fncVerificaCampos: Boolean;
    function fncConsultaUsuario: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
   ufrmPrincipal, udmProjeto;

{$R *.dfm}

procedure TfrmLogin.btnLoginClick(Sender: TObject);
begin
if not fncVerificaCampos then
   Exit;

if fncConsultaUsuario then
   frmPrincipal.Show
else
   Exit;
//frmLogin.Close;
end;

function TfrmLogin.fncConsultaUsuario: Boolean;
begin
dmProjeto.FDConsulta.Close;
dmProjeto.FDConsulta.SQL.Clear;
dmProjeto.FDConsulta.SQL.Add('SELECT USUARIO, SENHA FROM LOGIN ');
dmProjeto.FDConsulta.SQL.Add('WHERE USUARIO = :USUARIO AND SENHA = :SENHA');
dmProjeto.FDConsulta.Params.ParamByName('USUARIO').AsString := edtUsuario.Text;
dmProjeto.FDConsulta.Params.ParamByName('SENHA').AsString := edtSenha.Text;
dmProjeto.FDConsulta.Open();

if dmProjeto.FDConsulta.IsEmpty then
   begin
   ShowMessage('Usuário ou senha inválidos. Verifique!');
   edtUsuario.SetFocus;
   Result := False;
   end
else
   Result := True;

end;

function TfrmLogin.fncVerificaCampos: Boolean;
begin
Result := True;
if Trim(edtUsuario.Text) = '' then
   begin
   ShowMessage('Campo "Usuário" é obrigatório!');
   Result := False;
   edtUsuario.SetFocus;
   Exit
   end;
if Trim(edtSenha.Text) = '' then
   begin
   ShowMessage('Campo "Senha" é obrigatório!');
   Result := False;
   edtSenha.SetFocus;
   Exit
   end;
end;

procedure TfrmLogin.FormKeyPress(Sender: TObject; var Key: Char);
begin
if (Key = #13) then
   begin
   Key := ' ';
   Perform(Wm_NextDlgCtl,0,0);
   end;
end;

procedure TfrmLogin.btnSairClick(Sender: TObject);
begin
Application.Terminate;
end;

end.
