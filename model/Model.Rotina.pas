unit Model.Rotina;

interface

Uses
  TypeAgil.ComplexTypes,
  ClasseAgil.BaseObject,
  System.Classes, System.SysUtils, System.StrUtils;

Type
  TRotina = class(TBaseObject)
  private
    aID : TGUID;
    aCodigo,
    aNome  ,
    aDescricao : String;
    aIndice : Integer;
    aTipo   : ct_TipoRotina;
    aParent : TRotina;
    procedure SetParent(Value : TRotina);
    procedure SetCodigo(Value : String);
    procedure SetNome(Value : String);
    procedure SetDescricao(Value : String);
    procedure SetIndice(Value : Integer);
  protected
    constructor Create;
  public
    constructor CriarRotina(pNome, pDescricao : String);

    property ID : TGUID read aID write aID;
    property Codigo : String read aCodigo write SetCodigo;
    property Nome : String read aNome write SetNome;
    property Descricao : String read aDescricao write SetDescricao;
    property Indice : Integer read aIndice write SetIndice;
    property Tipo   : ct_TipoRotina read aTipo write aTipo;
    property Parent : TRotina read aParent write SetParent;
//
//    procedure Salvar; virtual; abstract;
//    function Buscar(Codigo: String): TRotina; virtual; abstract;
  end;

implementation

{ TRotina }

constructor TRotina.CriarRotina(pNome, pDescricao: String);
begin
  Self.Create;
  CreateGUID(aID);
  aNome      := Trim(pNome);
  aDescricao := Trim(pDescricao);
  aTipo      := tr_Menu;
  aIndice    := 0;
end;

procedure TRotina.SetCodigo(Value: String);
begin
  aCodigo := Trim(Value);
end;

procedure TRotina.SetDescricao(Value: String);
begin
  aDescricao := Trim(Value);
end;

procedure TRotina.SetIndice(Value: Integer);
begin
  aIndice := Value;
  Notify;
end;

procedure TRotina.SetNome(Value: String);
begin
  aNome := Trim(Value);
end;

procedure TRotina.SetParent(Value: TRotina);
begin
  aParent := Value;
end;

constructor TRotina.Create;
begin
  inherited Create;
  aCodigo := EmptyStr;
  aTipo   := tr_Menu;
  aParent := nil;
end;

end.
