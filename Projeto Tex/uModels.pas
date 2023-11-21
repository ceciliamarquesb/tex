unit uModels;

interface

type
   TCliente = class(TObject)
   private
      FCodigo: integer;
      FNome: String;
      FCEP: String;
      FLogradrouro: String;
      FNumero: String;
      FBairro: String;
      FCidade: String;
      FUF: String;
      FTelFixo: String;
      FTelCelular: String;
      FEmail: String;
      FRG: String;
      FCPF: String;
      FComplemento: String;
    procedure SetBairro(const Value: String);
    procedure SetCEP(const Value: String);
    procedure SetCidade(const Value: String);
    procedure SetCodigo(const Value: integer);
    procedure SetLogradrouro(const Value: String);
    procedure SetNome(const Value: String);
    procedure SetNumero(const Value: String);
    procedure SetTelCelular(const Value: String);
    procedure SetTelFixo(const Value: String);
    procedure SetUF(const Value: String);
    procedure SetEmail(const Value: String);
    procedure SetCPF(const Value: String);
    procedure SetRG(const Value: String);
    procedure SetComplemento(const Value: String);

   public
      property Codigo: integer read FCodigo write SetCodigo;
      property Nome: String read FNome write SetNome;
      property CEP: String read FCEP write SetCEP;
      property Logradrouro: String read FLogradrouro write SetLogradrouro;
      property Numero: String read FNumero write SetNumero;
      property Bairro: String read FBairro write SetBairro;
      property Cidade: String read FCidade write SetCidade;
      property UF: String read FUF write SetUF;
      property TelFixo: String read FTelFixo write SetTelFixo;
      property TelCelular: String read FTelCelular write SetTelCelular;
      property Email: String read FEmail write SetEmail;
      property RG: String read FRG write SetRG;
      property CPF: String read FCPF write SetCPF;
      property Complemento: String read FComplemento write SetComplemento;
      constructor Create;
      destructor Destroy; override;
      procedure pcdLimparDados;
   end;


implementation

{ TClientes }

constructor TCliente.Create;
begin
Codigo := 0;
Nome := '';
CEP := '';
Logradrouro := '';
Numero := '';
Bairro := '';
Cidade := '';
UF := '';
TelFixo := '';
TelCelular := '';
Email := '';
RG := '';
CPF := '';
end;

destructor TCliente.Destroy;
begin

  inherited;
end;

procedure TCliente.pcdLimparDados;
begin
Codigo := 0;
Nome := '';
CEP := '';
Logradrouro := '';
Numero := '';
Bairro := '';
Cidade := '';
UF := '';
TelFixo := '';
TelCelular := '';
Email := '';
RG := '';
CPF := '';
end;

procedure TCliente.SetBairro(const Value: String);
begin
  FBairro := Value;
end;

procedure TCliente.SetCEP(const Value: String);
begin
  FCEP := Value;
end;

procedure TCliente.SetCidade(const Value: String);
begin
  FCidade := Value;
end;

procedure TCliente.SetCodigo(const Value: integer);
begin
  FCodigo := Value;
end;


procedure TCliente.SetComplemento(const Value: String);
begin
  FComplemento := Value;
end;

procedure TCliente.SetCPF(const Value: String);
begin
  FCPF := Value;
end;

procedure TCliente.SetEmail(const Value: String);
begin
  FEmail := Value;
end;

procedure TCliente.SetLogradrouro(const Value: String);
begin
  FLogradrouro := Value;
end;

procedure TCliente.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TCliente.SetNumero(const Value: String);
begin
  FNumero := Value;
end;

procedure TCliente.SetRG(const Value: String);
begin
  FRG := Value;
end;

procedure TCliente.SetTelCelular(const Value: String);
begin
  FTelCelular := Value;
end;

procedure TCliente.SetTelFixo(const Value: String);
begin
  FTelFixo := Value;
end;

procedure TCliente.SetUF(const Value: String);
begin
  FUF := Value;
end;

end.
