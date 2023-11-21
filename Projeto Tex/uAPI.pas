unit uAPI;

interface

uses
  idHTTP, System.JSON, FireDAC.Comp.Client, System.SysUtils, System.Classes,
  System.Net.HttpClient, IdURI, IdException,
  IdMultipartFormData, REST.Client, REST.Authenticator.OAuth,
  Data.Cloud.CloudAPI, System.Net.URLClient, IdGlobal,
  Vcl.Graphics, Vcl.Dialogs, Vcl.Imaging.jpeg, REST.HttpClient, Winapi.WinInet,
  Winapi.Windows, uModels;


const
   URL_Base = 'viacep.com.br/ws/';
type
 TAPI = class(TObject)
 private

 public
    constructor Create;
    function BuscarCEP(psCEP: string; poCliente: TCliente): Boolean;
 end;

implementation


{ TAPI }

function TAPI.BuscarCEP(psCEP: string; poCliente: TCliente): Boolean;
var
  JSONResposta: TJSONObject;
  RESTClient1: TRESTClient;
  RESTRequest1: TRESTRequest;
  RESTResponse1: TRESTResponse;
begin
  RESTClient1 := TRESTClient.Create(nil);
  RESTRequest1 := TRESTRequest.Create(nil);
  RESTResponse1 := TRESTResponse.Create(nil);
  RESTRequest1.Client := RESTClient1;
  RESTRequest1.Response := RESTResponse1;
  RESTClient1.BaseURL := URL_Base + psCEP + '/json';
  RESTRequest1.Execute;
  JSONResposta := RESTResponse1.JSONValue as TJSONObject;
  try
    if Assigned(JSONResposta) then
       begin
       poCliente.Logradrouro := JSONResposta.Values['logradouro'].Value;
       poCliente.Bairro := JSONResposta.Values['bairro'].Value;
       poCliente.UF := JSONResposta.Values['uf'].Value;
       poCliente.Cidade := JSONResposta.Values['localidade'].Value;
       poCliente.Complemento :=  JSONResposta.Values['complemento'].Value;
       Result := True;
       end
    else
       begin
       ShowMessage('Endereço não encontrado!');
       Result := False;
       end;
  finally
    FreeAndNil(JSONResposta);
  end;
end;

constructor TAPI.Create;
begin

end;

end.
