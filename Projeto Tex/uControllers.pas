unit uControllers;

interface

uses
 System.SysUtils, System.Types, System.UITypes, System.Classes,
 System.Variants, FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics,
 FMX.Dialogs, FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls,
 FMX.Objects, Data.FireDACJSONReflect, FireDAC.Comp.Client, FireDAC.Stan.Param,
 Data.DB, FMX.ListBox, FireDAC.Stan.Option, System.Math, udmProjeto,
 uModels;

type
 TAppDAO = class(TObject)
 private
 public
    constructor Create;
    function fncConsultaCliente(psNome: String): TCliente;
    function fncInsertCliente(poCliente: TCliente): Boolean;
    function fncUpdateCliente(poCliente: TCliente): Boolean;
    function fncExcluirCliente(poCliente: TCliente): Boolean;

 end;

implementation


constructor TAppDAO.Create;
begin
 inherited;
 if not Assigned(dmProjeto) then
  dmProjeto := TdmProjeto.Create(Application);
end;

function TAppDAO.fncConsultaCliente(psNome: String): TCliente;
begin
Result := TCliente.Create;

dmProjeto.FDConsulta.Close;
dmProjeto.FDConsulta.SQL.Clear;
dmProjeto.FDConsulta.SQL.Add('SELECT CLI_CODIGO, CLI_NOME, CLI_CEP, CLI_LOGRADOURO, ');
dmProjeto.FDConsulta.SQL.Add('CLI_NUMERO, CLI_BAIRRO, CLI_CIDADE, CLI_UF, CLI_TELFIXO, ');
dmProjeto.FDConsulta.SQL.Add('CLI_TELCELULAR, CLI_EMAIL, CLI_RG, CLI_CPF ');
dmProjeto.FDConsulta.SQL.Add('FROM CLIENTE ');
dmProjeto.FDConsulta.SQL.Add('WHERE CLI_NOME LIKE :CLI_NOME' );
dmProjeto.FDConsulta.Params.ParamByName('CLI_NOME').AsString := '%'+Trim(psNome)+'%';
dmProjeto.FDConsulta.Open();

if not dmProjeto.FDConsulta.IsEmpty then
   begin
   Result.Codigo := dmProjeto.FDConsulta.FieldByName('CLI_CODIGO').AsInteger;
   Result.Nome := dmProjeto.FDConsulta.FieldByName('CLI_NOME').AsString;
   Result.CEP := dmProjeto.FDConsulta.FieldByName('CLI_CEP').AsString;
   Result.Logradrouro := dmProjeto.FDConsulta.FieldByName('CLI_LOGRADOURO').AsString;
   Result.Numero := dmProjeto.FDConsulta.FieldByName('CLI_NUMERO').AsString;
   Result.Bairro := dmProjeto.FDConsulta.FieldByName('CLI_BAIRRO').AsString;
   Result.Cidade := dmProjeto.FDConsulta.FieldByName('CLI_CIDADE').AsString;
   Result.UF := dmProjeto.FDConsulta.FieldByName('CLI_UF').AsString;
   Result.TelFixo := dmProjeto.FDConsulta.FieldByName('CLI_TELFIXO').AsString;
   Result.TelCelular := dmProjeto.FDConsulta.FieldByName('CLI_TELCELULAR').AsString;
   Result.Email := dmProjeto.FDConsulta.FieldByName('CLI_EMAIL').AsString;
   Result.RG := dmProjeto.FDConsulta.FieldByName('CLI_RG').AsString;
   Result.CPF := dmProjeto.FDConsulta.FieldByName('CLI_CPF').AsString;
   end
else
   Result.Codigo := 0;
end;

function TAppDAO.fncInsertCliente(poCliente: TCliente): Boolean;
begin
try
   dmProjeto.FDConsulta.Close;
   dmProjeto.FDConsulta.SQL.Clear;
   dmProjeto.FDConsulta.SQL.Add('INSERT INTO CLIENTE (CLI_NOME, CLI_CEP, CLI_LOGRADOURO, ');
   dmProjeto.FDConsulta.SQL.Add('CLI_NUMERO, CLI_BAIRRO, CLI_CIDADE, CLI_UF, CLI_TELFIXO, ');
   dmProjeto.FDConsulta.SQL.Add('CLI_TELCELULAR, CLI_EMAIL, CLI_RG, CLI_CPF) ');
   dmProjeto.FDConsulta.SQL.Add('VALUES (:CLI_NOME, :CLI_CEP, :CLI_LOGRADOURO, ');
   dmProjeto.FDConsulta.SQL.Add(':CLI_NUMERO, :CLI_BAIRRO, :CLI_CIDADE, :CLI_UF, :CLI_TELFIXO, ');
   dmProjeto.FDConsulta.SQL.Add(':CLI_TELCELULAR, :CLI_EMAIL, :CLI_RG, :CLI_CPF) ');
   dmProjeto.FDConsulta.Params.ParamByName('CLI_NOME').AsString := poCliente.Nome;
   dmProjeto.FDConsulta.Params.ParamByName('CLI_CEP').AsString := poCliente.CEP;
   dmProjeto.FDConsulta.Params.ParamByName('CLI_LOGRADOURO').AsString := poCliente.Logradrouro;
   dmProjeto.FDConsulta.Params.ParamByName('CLI_NUMERO').AsString := poCliente.Numero;
   dmProjeto.FDConsulta.Params.ParamByName('CLI_BAIRRO').AsString := poCliente.Bairro;
   dmProjeto.FDConsulta.Params.ParamByName('CLI_CIDADE').AsString := poCliente.Cidade;
   dmProjeto.FDConsulta.Params.ParamByName('CLI_UF').AsString := poCliente.UF;
   dmProjeto.FDConsulta.Params.ParamByName('CLI_TELFIXO').AsString := poCliente.TelFixo;
   dmProjeto.FDConsulta.Params.ParamByName('CLI_TELCELULAR').AsString := poCliente.TelCelular;
   dmProjeto.FDConsulta.Params.ParamByName('CLI_EMAIL').AsString := poCliente.Email;
   dmProjeto.FDConsulta.Params.ParamByName('CLI_RG').AsString := poCliente.RG;
   dmProjeto.FDConsulta.Params.ParamByName('CLI_CPF').AsString := poCliente.CPF;
   dmProjeto.FDConsulta.ExecSQL();
   Result := True;
except
  ShowMessage('Erro ao inserir o cliente!');
  Result := False;
  end;
end;

function TAppDAO.fncUpdateCliente(poCliente: TCliente): Boolean;
begin
try
   dmProjeto.FDConsulta.Close;
   dmProjeto.FDConsulta.SQL.Clear;
   dmProjeto.FDConsulta.SQL.Add('UPDATE CLIENTE SET CLI_NOME = :CLI_NOME, CLI_CEP = :CLI_CEP, ');
   dmProjeto.FDConsulta.SQL.Add('CLI_LOGRADOURO = :CLI_LOGRADOURO, CLI_NUMERO = :CLI_NUMERO, ');
   dmProjeto.FDConsulta.SQL.Add('CLI_BAIRRO = :CLI_BAIRRO, CLI_CIDADE = :CLI_CIDADE, CLI_UF = :CLI_UF, ');
   dmProjeto.FDConsulta.SQL.Add('CLI_TELFIXO = :CLI_TELFIXO, CLI_TELCELULAR = :CLI_TELCELULAR, ');
   dmProjeto.FDConsulta.SQL.Add('CLI_EMAIL = :CLI_EMAIL, CLI_RG = :CLI_RG, CLI_CPF = :CLI_CPF ');
   dmProjeto.FDConsulta.SQL.Add('WHERE CLI_CODIGO = :CLI_CODIGO ');
   dmProjeto.FDConsulta.Params.ParamByName('CLI_CODIGO').AsInteger := poCliente.Codigo;
   dmProjeto.FDConsulta.Params.ParamByName('CLI_NOME').AsString := poCliente.Nome;
   dmProjeto.FDConsulta.Params.ParamByName('CLI_CEP').AsString := poCliente.CEP;
   dmProjeto.FDConsulta.Params.ParamByName('CLI_LOGRADOURO').AsString := poCliente.Logradrouro;
   dmProjeto.FDConsulta.Params.ParamByName('CLI_NUMERO').AsString := poCliente.Numero;
   dmProjeto.FDConsulta.Params.ParamByName('CLI_BAIRRO').AsString := poCliente.Bairro;
   dmProjeto.FDConsulta.Params.ParamByName('CLI_CIDADE').AsString := poCliente.Cidade;
   dmProjeto.FDConsulta.Params.ParamByName('CLI_UF').AsString := poCliente.UF;
   dmProjeto.FDConsulta.Params.ParamByName('CLI_TELFIXO').AsString := poCliente.TelFixo;
   dmProjeto.FDConsulta.Params.ParamByName('CLI_TELCELULAR').AsString := poCliente.TelCelular;
   dmProjeto.FDConsulta.Params.ParamByName('CLI_EMAIL').AsString := poCliente.Email;
   dmProjeto.FDConsulta.Params.ParamByName('CLI_RG').AsString := poCliente.RG;
   dmProjeto.FDConsulta.Params.ParamByName('CLI_CPF').AsString := poCliente.CPF;
   dmProjeto.FDConsulta.ExecSQL();
   Result := True;
except
  ShowMessage('Erro ao atualizar o cliente!');
  Result := False;
  end;
end;


function TAppDAO.fncExcluirCliente(poCliente: TCliente): Boolean;
begin
try
   dmProjeto.FDConsulta.Close;
   dmProjeto.FDConsulta.SQL.Clear;
   dmProjeto.FDConsulta.SQL.Add('DELETE FROM CLIENTE WHERE CLI_CODIGO = :CLI_CODIGO ');
   dmProjeto.FDConsulta.Params.ParamByName('CLI_CODIGO').AsInteger := poCliente.Codigo;
   dmProjeto.FDConsulta.ExecSQL();
   Result := True;
except
  ShowMessage('Erro ao excluir o cliente!');
  Result := False;
  end;
end;

end.
