unit udmProjeto;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, Vcl.Forms, Vcl.Dialogs, System.IniFiles,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TdmProjeto = class(TDataModule)
    FDConnection: TFDConnection;
    Link: TFDPhysFBDriverLink;
    FDConsulta: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmProjeto: TdmProjeto;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmProjeto.DataModuleCreate(Sender: TObject);
var
   sCaminhoINI: String;
   oIni: TIniFile;
begin
sCaminhoINI := ExtractFilePath(Application.ExeName)+'DBCONNECTION.INI';
if not FileExists(sCaminhoINI) then
   begin
   ShowMessage('O arquivo de conexão ao banco de dados não foi encontrado! Verifique se o arquivo "'+sCaminhoINI+'" '+
               'está configurado corretamente!');
   Application.Terminate;
   end
Else
   begin
   oIni := TIniFile.Create(sCaminhoINI);
   try
       try
       FDConnection.Close;
       FDConnection.Params.Database := oIni.ReadString('PARAMS', 'DATABASE','');
       FDConnection.Params.UserName := oIni.ReadString('PARAMS', 'USER','');
       FDConnection.Params.Password := oIni.ReadString('PARAMS', 'PASS','');;
       Link.VendorLib := ExtractFilePath(Application.ExeName)+'fbclient.dll';
       FDConnection.Connected := True;

       Except
          ShowMessage('Não foi possível conectar com o banco de dados!');
          Application.Terminate;
          End;
   finally
     FreeAndNil(oIni);
     end;
    end;
end;

end.
