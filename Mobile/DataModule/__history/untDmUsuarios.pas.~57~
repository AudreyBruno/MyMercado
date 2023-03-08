unit untDmUsuarios;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  DataSet.Serialize.Config, RESTRequest4D, System.JSON, untConsts,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.FMXUI.Wait, System.IOUtils, FireDAC.DApt,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite;

type
  TDmUsuarios = class(TDataModule)
    TabUsuario: TFDMemTable;
    FDConnection: TFDConnection;
    FDQuery: TFDQuery;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    qryUsuario: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure FDConnectionBeforeConnect(Sender: TObject);
    procedure FDConnectionAfterConnect(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Login(email, senha: string);
    procedure CriarConta(nome, email, senha, endereco, bairro, cidade, uf, cep: string);
    procedure SalvarUsuarioLocal(id_usuario: integer; email, nome, endereco, bairro, cidade, uf, cep: String);
    procedure ListarUsuarioLocal;
    { Public declarations }
  end;

var
  DmUsuarios: TDmUsuarios;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDmUsuarios.DataModuleCreate(Sender: TObject);
begin
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  FDConnection.Connected := True;
end;

procedure TDmUsuarios.FDConnectionAfterConnect(Sender: TObject);
begin
  FDConnection.ExecSQL('CREATE TABLE IF NOT EXISTS TAB_USUARIO(' +
                       'ID_USUARIO INTEGER NOT NULL PRIMARY KEY, ' +
                       'EMAIL VARCHAR(100), ' +
                       'NOME VARCHAR(100), ' +
                       'ENDERECO VARCHAR(100), ' +
                       'BAIRRO VARCHAR(100), ' +
                       'CIDADE VARCHAR(100), ' +
                       'UF VARCHAR(100), ' +
                       'CEP VARCHAR(100))');

  FDConnection.ExecSQL('CREATE TABLE IF NOT EXISTS TAB_CARRINHO(' +
                       'ID_MERCADO INTEGER NOT NULL PRIMARY KEY, ' +
                       'NOME_MERCADO VARCHAR(100), ' +
                       'ENDERECO_MERCADO VARCHAR(100), ' +
                       'TAXA_ENTREGA DECIMAL(9,2))');

  FDConnection.ExecSQL('CREATE TABLE IF NOT EXISTS TAB_CARRINHO_ITEM(' +
                       'ID_PRODUTO INTEGER, ' +
                       'URL_FOTO VARCHAR(1000), ' +
                       'NOME VARCHAR(100), ' +
                       'UNIDADE VARCHAR(100), ' +
                       'QTD DECIMAL(9,2),' +
                       'VALOR_UNITARIO DECIMAL(9,2),' +
                       'VALOR_TOTAL DECIMAL(9,2))');
end;

procedure TDmUsuarios.FDConnectionBeforeConnect(Sender: TObject);
begin
  FDConnection.DriverName := 'SQLite';

  {$IFDEF MSWINDOWS}
    FDConnection.Params.Values['Database'] := System.SysUtils.GetCurrentDir + '\banco.db';
  {$ELSE}
    FDConnection.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'banco.db');
  {$ENDIF}
end;

procedure TDmUsuarios.Login(email, senha: string);
var
  resp: IResponse;
  json: TJSONObject;
begin
  try
      json := TJSONObject.Create;
      json.AddPair('email', email);
      json.AddPair('senha', senha);

      resp := TRequest.New.BaseURL(BASE_URL)
                          .Resource('usuarios/login')
                          .DataSetAdapter(TabUsuario)
                          .AddBody(json.ToJSON)
                          .Accept('application/json')
                          .BasicAuthentication(USER_NAME, PASSWORD)
                          .Post;

      if (resp.StatusCode = 401) then
        raise Exception.Create('E-mail ou senha inválida')
      else if (resp.StatusCode <> 200) then
        raise Exception.Create(resp.Content);
  finally
      json.DisposeOf;
  end;
end;

procedure TDmUsuarios.CriarConta(nome, email, senha, endereco, bairro, cidade, uf, cep: string);
var
  resp: IResponse;
  json: TJSONObject;
begin
  try
      json := TJSONObject.Create;
      json.AddPair('nome', nome);
      json.AddPair('email', email);
      json.AddPair('senha', senha);
      json.AddPair('endereco', endereco);
      json.AddPair('bairro', bairro);
      json.AddPair('cidade', cidade);
      json.AddPair('uf', uf);
      json.AddPair('cep', cep);

      resp := TRequest.New.BaseURL(BASE_URL)
                          .Resource('usuarios/cadastro')
                          .DataSetAdapter(TabUsuario)
                          .AddBody(json.ToJSON)
                          .Accept('application/json')
                          .BasicAuthentication(USER_NAME, PASSWORD)
                          .Post;

      if (resp.StatusCode = 401) then
        raise Exception.Create('Usuário não autorizado')
      else if (resp.StatusCode <> 201) then
        raise Exception.Create(resp.Content);
  finally
      json.DisposeOf;
  end;
end;

procedure TDmUsuarios.SalvarUsuarioLocal(id_usuario: integer; email, nome, endereco, bairro, cidade, uf, cep: String);
begin
  with qryUsuario do
    begin
      Active := False;
      SQL.Clear;

      SQL.Add('INSERT OR REPLACE INTO TAB_USUARIO(ID_USUARIO, EMAIL, NOME,');
      SQL.Add('ENDERECO, BAIRRO, CIDADE, UF, CEP)');
      SQL.Add('VALUES(:ID_USUARIO, :EMAIL, :NOME,');
      SQL.Add(':ENDERECO, :BAIRRO, :CIDADE, :UF, :CEP)');

      ParamByName('ID_USUARIO').Value := id_usuario;
      ParamByName('EMAIL').Value := email;
      ParamByName('NOME').Value := nome;
      ParamByName('ENDERECO').Value := endereco;
      ParamByName('BAIRRO').Value := bairro;
      ParamByName('CIDADE').Value := cidade;
      ParamByName('UF').Value := uf;
      ParamByName('CEP').Value := cep;

      ExecSQL;
    end;
end;



procedure TDmUsuarios.ListarUsuarioLocal;
begin
  with qryUsuario do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT * FROM TAB_USUARIO');
      Active := True;
    end;
end;

end.
