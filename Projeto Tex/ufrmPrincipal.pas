unit ufrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, Vcl.Mask, uModels, Vcl.Buttons;

type
  TfrmPrincipal = class(TForm)
    pnlMarca: TPanel;
    ImgTex: TImage;
    Panel1: TPanel;
    pnlCliente: TPanel;
    edtNomePesquisa: TEdit;
    grpDados: TGroupBox;
    edtNome: TEdit;
    lblNome: TLabel;
    lblCEP: TLabel;
    edtCEP: TMaskEdit;
    lblLogradouro: TLabel;
    edtLogradouro: TEdit;
    lblNumero: TLabel;
    edtNumero: TEdit;
    lblBairro: TLabel;
    edtBairro: TEdit;
    lblCidade: TLabel;
    edtCidade: TEdit;
    lblUF: TLabel;
    cbxUF: TComboBox;
    lblTelFIxo: TLabel;
    edtTelFixo: TMaskEdit;
    lblTelCelular: TLabel;
    edtTelCelular: TMaskEdit;
    lblEmail: TLabel;
    edtEmail: TEdit;
    lblRG: TLabel;
    edtRG: TEdit;
    edtCPF: TMaskEdit;
    lblCPF: TLabel;
    btnCEP: TBitBtn;
    btnLocalizar: TBitBtn;
    lblComplemento: TLabel;
    edtComplemento: TEdit;
    grpBotoes: TGroupBox;
    btnNovo: TBitBtn;
    btnGravar: TBitBtn;
    btnExcluir: TBitBtn;
    btnSair: TBitBtn;
    procedure edtNomePesquisaClick(Sender: TObject);
    procedure edtNomePesquisaExit(Sender: TObject);
    procedure btnLocalizarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnCEPClick(Sender: TObject);
    procedure edtCEPExit(Sender: TObject);
    procedure edtNomePesquisaChange(Sender: TObject);
  private
    vgoCliente: TCliente;
    procedure pcdBuscaCliente;
    procedure pcdLimparCampos;
    procedure pcdPreencheCampos(poCliente: TCliente);
    procedure pcdBotoes(pbNovo: Boolean);
    procedure pcdCapturaClasse;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
   uControllers, uAPI;

{$R *.dfm}

procedure TfrmPrincipal.btnCEPClick(Sender: TObject);
var
  vsCEP: String;
  voAPI: TAPI;
begin
vsCEP := StringReplace(edtCEP.Text , '-', '', [rfReplaceAll]);
if (edtCEP.Text = '_____-___') or
   (Length(vsCEP) < 8) then
   begin
   ShowMessage('Preencha o CEP corretamente!');
   edtCEP.SetFocus;
   Exit;
   end;

voAPI := TAPI.Create;
try
   if voAPI.BuscarCEP(vsCEP, vgoCliente) then
      begin
      edtLogradouro.Text := vgoCliente.Logradrouro;
      edtBairro.Text := vgoCliente.Bairro;
      edtCidade.Text := vgoCliente.Cidade;
      cbxUF.ItemIndex := cbxUF.Items.IndexOf(vgoCliente.UF);
      edtNumero.SetFocus;
      end;
finally
   FreeAndNil(voAPI);
   end;
end;

procedure TfrmPrincipal.btnExcluirClick(Sender: TObject);
var
   voAppDAO: TAppDAO;
begin
if Application.MessageBox('Tem certeza que deseja exlcuir o cliente?','TEX',mb_yesno + mb_iconquestion) = id_yes then
   begin
   voAppDAO := TAppDAO.Create;
   try
      if voAppDAO.fncExcluirCliente(vgoCliente) then
         begin
         ShowMessage('Cliente excluído com sucesso!');
         pcdLimparCampos;
         pcdBotoes(True);
         end;
   finally
      FreeAndNil(voAppDAO);
      end;
   end
else
   begin
   Exit;
   end;
end;

procedure TfrmPrincipal.btnGravarClick(Sender: TObject);
var
   voAppDAO: TAppDAO;
begin
voAppDAO := TAppDAO.Create;
try
   pcdCapturaClasse;
   if vgoCliente.Codigo <= 0 then
      begin
      if voAppDAO.fncInsertCliente(vgoCliente) then
         ShowMessage('Cliente cadastrado com sucesso!');
      end
   else
      begin
      if voAppDAO.fncUpdateCliente(vgoCliente) then
         ShowMessage('Cliente atualizado com sucesso!');
      end;
   pcdBotoes(True);
   pcdLimparCampos;
finally
   FreeAndNil(voAppDAO);
   end;
end;

procedure TfrmPrincipal.pcdBotoes(pbNovo: Boolean);
begin
btnNovo.Enabled := pbNovo;
btnGravar.Enabled := not pbNovo;
btnExcluir.Enabled := not pbNovo;
grpDados.Enabled := not pbNovo;
end;

procedure TfrmPrincipal.btnLocalizarClick(Sender: TObject);
begin
if edtNomePesquisa.Font.Color = 10789024 then
   begin
   ShowMessage('Digite o nome do cliente para efetuar a pesquisa!');
   edtNomePesquisa.SetFocus;
   Exit;
   end;

pcdBuscaCliente;
end;

procedure TfrmPrincipal.pcdBuscaCliente;
var
   voAppDAO: TAppDAO;
begin
voAppDAO := TAppDAO.Create;
try
   vgoCliente := voAppDAO.fncConsultaCliente(edtNomePesquisa.Text);
   if vgoCliente.Codigo > 0 then
      begin
      pcdPreencheCampos(vgoCliente);
      pcdBotoes(False);
      end
   else
      begin
      ShowMessage('Cliente não encontrado!');
      end;
finally
   FreeAndNil(voAppDAO);
   end;
end;

procedure TfrmPrincipal.pcdCapturaClasse;
begin
vgoCliente.Nome := edtNome.Text;
vgoCliente.CEP := edtCEP.Text;
vgoCliente.Logradrouro := edtLogradouro.Text;
vgoCliente.Numero := edtNumero.Text;
vgoCliente.Bairro := edtBairro.Text;
vgoCliente.Cidade := edtCidade.Text;
vgoCliente.UF := cbxUF.Text;
vgoCliente.TelFixo := edtTelFixo.Text;
vgoCliente.TelCelular := edtTelCelular.Text;
vgoCliente.Email := edtEmail.Text;
vgoCliente.RG := edtRG.Text;
vgoCliente.CPF := edtCPF.Text;
vgoCliente.Complemento := edtComplemento.Text;
end;

procedure TfrmPrincipal.pcdPreencheCampos(poCliente: TCliente);
begin
edtNome.Text := poCliente.Nome;
edtCEP.Text := poCliente.CEP;
edtLogradouro.Text := poCliente.Logradrouro;
edtNumero.Text := poCliente.Numero;
edtBairro.Text := poCliente.Bairro;
edtCidade.Text := poCliente.Cidade;
cbxUF.ItemIndex := cbxUF.Items.IndexOf(poCliente.UF);
edtTelFixo.Text := poCliente.TelFixo;
edtTelCelular.Text := poCliente.TelCelular;
edtEmail.Text := poCliente.Email;
edtRG.Text := poCliente.RG;
edtCPF.Text := poCliente.CPF;
edtComplemento.Text := poCliente.Complemento;
end;


procedure TfrmPrincipal.btnNovoClick(Sender: TObject);
begin
vgoCliente.pcdLimparDados;
pcdLimparCampos;
pcdBotoes(False);
edtNome.SetFocus;
end;

procedure TfrmPrincipal.pcdLimparCampos;
begin
edtNomePesquisa.Font.Color := clWindow;
edtNomePesquisa.Text := 'DIGITE O NOME DO CLIENTE';
edtNome.Text := '';
edtCEP.Text := '_____-___';
edtLogradouro.Text := '';
edtNumero.Text := '';
edtBairro.Text := '';
edtCidade.Text := '';
cbxUF.ItemIndex := -1;
edtTelFixo.Text := '(__)____-____';
edtTelCelular.Text := '(__)_____-____';
edtRG.Text := '';
edtCPF.Text := '___.___.___-__';
edtComplemento.Text := '';
end;

procedure TfrmPrincipal.btnSairClick(Sender: TObject);
begin
Application.Terminate;
end;

procedure TfrmPrincipal.edtCEPExit(Sender: TObject);
begin
btnCEP.OnClick(btnCEP);
end;

procedure TfrmPrincipal.edtNomePesquisaChange(Sender: TObject);
begin
if edtNomePesquisa.Font.Color = 10789024 then
   edtNomePesquisa.Font.Color := clWindowText;
end;

procedure TfrmPrincipal.edtNomePesquisaClick(Sender: TObject);
begin
edtNomePesquisa.Text := '';
edtNomePesquisa.Font.Color := clWindowText;
end;

procedure TfrmPrincipal.edtNomePesquisaExit(Sender: TObject);
begin
if Trim(edtNomePesquisa.Text) = '' then
   begin
   edtNomePesquisa.Font.Color := clWindow;
   edtNomePesquisa.Text := 'DIGITE O NOME DO CLIENTE';
   end;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FreeAndNil(vgoCliente);
end;

procedure TfrmPrincipal.FormKeyPress(Sender: TObject; var Key: Char);
begin
if (Key = #13) then
   begin
   Key := ' ';
   Perform(Wm_NextDlgCtl,0,0);
   end;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
vgoCliente := TCliente.Create;
pcdBotoes(True);
end;

end.
