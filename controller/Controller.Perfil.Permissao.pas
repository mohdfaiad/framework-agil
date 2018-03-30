unit Controller.Perfil.Permissao;

interface

Uses
  TypeAgil.Constants,
  TypeAgil.ComplexTypes,
  InterfaceAgil.Controller,
  ClasseAgil.BaseObject,
  Model.Perfil.Permissao,
  Controller.Mensagem,

  System.Classes, System.SysUtils, System.StrUtils,

  FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  Data.DB, Datasnap.DBClient;

  Type
    TPermissaoPerfilController = class(TInterfacedObject, IController)
    private
      class var aInstance : TPermissaoPerfilController;
      aMsg   : TMensagemController;
      aModel : TPermissaoPerfil;
      procedure SetModel(Value : TPermissaoPerfil);
      function GetModel : TPermissaoPerfil;
    protected
//      constructor Create;
      procedure CarregarDados(const aDataSet : TDataSet);
      procedure FreeFieldsReadOnly(const aDataSet: TDataSet);
    public
      class function GetInstance: TPermissaoPerfilController;
      constructor Create;
      destructor Destroy; override;

      procedure New(const aDataSet: TDataSet); overload;
      procedure Load(const aDataSet: TDataSet);
      procedure Refresh(const aDataSet: TDataSet);
      procedure RefreshRecord(const aDataSet: TDataSet);
      procedure RemoverPermissoes(const aDataSet: TFDQuery);

      function Edit(const aDataSet: TDataSet) : Boolean;
      function Delete(const aDataSet: TDataSet) : Boolean;
      function Save(const aDataSet: TDataSet) : Boolean;
      function Cancel(const aDataSet: TDataSet) : Boolean;
      function Find(ID: String; const aDataSet: TDataSet): TBaseObject;
      function New: TBaseObject; overload;
      function ExecuteQuery(const aPerfil : Boolean; const aDataSet: TDataSet; aPesquisa : String) : Boolean;
    published
      property Model : TPermissaoPerfil read GetModel write SetModel;
    end;

implementation

{ TPermissaoPerfilController }

function TPermissaoPerfilController.Cancel(const aDataSet: TDataSet): Boolean;
begin
  ;
end;

procedure TPermissaoPerfilController.CarregarDados(const aDataSet: TDataSet);
begin
  ;
end;

constructor TPermissaoPerfilController.Create;
begin
  inherited Create;
  aMsg   := TMensagemController.GetInstance;
  aModel := TPermissaoPerfil.Create;
end;

function TPermissaoPerfilController.Delete(const aDataSet: TDataSet): Boolean;
begin
  ;
end;

destructor TPermissaoPerfilController.Destroy;
begin
  aModel.Free;
  inherited Destroy;
end;

function TPermissaoPerfilController.Edit(const aDataSet: TDataSet): Boolean;
var
  aRetorno : Boolean;
begin
  aRetorno := False;
  try
    if Assigned(aDataSet) then
      if (aDataSet.Active and (not aDataSet.IsEmpty)) then
        begin
          TFDQuery(aDataSet).Edit;
          aRetorno := True;
        end;
  finally
    Result := aRetorno;
  end;
end;

function TPermissaoPerfilController.ExecuteQuery(const aPerfil : Boolean;
  const aDataSet: TDataSet; aPesquisa: String): Boolean;
var
  aRetorno : Boolean;
begin
  aRetorno := False;
  try
    if Assigned(aDataSet) then
      with TFDQuery(aDataSet) do
      begin
        if aDataSet.Active then
          aDataSet.Close;

        if (Params.FindParam('perfil') <> nil) then
          ParamByName('perfil').Clear;
        if (Params.FindParam('perfil') <> nil) then
          ParamByName('perfil').AsString  := aPesquisa;

        aDataSet.Open;

        aRetorno := not aDataSet.IsEmpty;
      end;
  finally
    Result := aRetorno;
  end;
end;

function TPermissaoPerfilController.Find(ID: String;
  const aDataSet: TDataSet): TBaseObject;
begin
  ;
end;

procedure TPermissaoPerfilController.FreeFieldsReadOnly(
  const aDataSet: TDataSet);
begin
  ;
end;

class function TPermissaoPerfilController.GetInstance: TPermissaoPerfilController;
begin
  if not Assigned(aInstance) then
    aInstance := TPermissaoPerfilController.Create;
  Result := aInstance;
end;

function TPermissaoPerfilController.GetModel: TPermissaoPerfil;
begin
  Result := aModel;
end;

procedure TPermissaoPerfilController.Load(const aDataSet: TDataSet);
begin
  ;
end;

function TPermissaoPerfilController.New: TBaseObject;
begin
  if Assigned(aModel) then
    aModel.Free;

  aModel := TPermissaoPerfil.Create;
  Result := aModel;
end;

procedure TPermissaoPerfilController.New(const aDataSet: TDataSet);
begin
  ;
end;

procedure TPermissaoPerfilController.Refresh(const aDataSet: TDataSet);
begin
  if Assigned(aDataSet) then
    if aDataSet.Active then
      TFDQuery(aDataSet).Refresh;
end;

procedure TPermissaoPerfilController.RefreshRecord(const aDataSet: TDataSet);
begin
  if Assigned(aDataSet) then
    if aDataSet.Active then
      with TFDQuery(aDataSet) do
      begin
        if RefreshRecord then
        begin
//          aModel.ID         := StringToGUID(FieldByName('id_perfil').AsString);
//          aModel.Codigo     := FieldByName('cd_perfil').AsInteger;
//          aModel.Descricao  := FieldByName('ds_perfil').AsString;
//          aModel.Ativo      := (FieldByName('sn_ativo').AsInteger = FLAG_SIM);
//          aModel.UsoSistema := (FieldByName('sn_sistema').AsInteger = FLAG_SIM);
//          aModel.Saved      := True;
        end;
      end;
end;

procedure TPermissaoPerfilController.RemoverPermissoes(
  const aDataSet: TFDQuery);
var
  aQry : TFDQuery;
begin
  if aMsg.ShowConfirmation('Remover Permissões', 'Deseja remover todas as permissões do perfil ' + QuotedStr(aModel.Perfil.Descricao) + '?') then
  try
    aQry := TFDQuery.Create(nil);
    with aDataSet do
    begin
      aQry.Connection  := aDataSet.Connection;
      aQry.Transaction := aDataSet.Transaction;

      DisableControls;
      First;

      while not Eof do
      begin
        Edit;
        if FieldByName('parent').IsNull then
          FieldByName('tp_permissao').AsInteger := -1
        else
          case ct_TipoRotina(FieldByName('tp_rotina').AsInteger) of
            tr_Menu          : FieldByName('tp_permissao').AsInteger := Ord(tp_Visualizar);
            tr_Formulario    ,
            tr_Processo      ,
            tr_Impressao     : FieldByName('tp_permissao').AsInteger := Ord(tp_SemAcesso);
            tr_CampoCadastro : FieldByName('tp_permissao').AsInteger := Ord(tp_Alterar);
          end;

        Post;
        Next;
      end;

      First;
      while not Eof do
      begin
        if not FieldByName('parent').IsNull then
        begin
          aQry.SQL.BeginUpdate;
          aQry.SQL.Clear;
          aQry.SQL.Add('Update USR_PERFIL_PERMISSAO p Set');
          aQry.SQL.Add('  p.tp_permissao = ' + FieldByName('tp_permissao').AsString);
          aQry.SQL.Add('where (p.id_acesso = :id_acesso)');
          aQry.SQL.Add('  and (p.id_perfil = :id_perfil)');
          aQry.SQL.EndUpdate;

          aQry.ParamByName('id_acesso').AsString  := FieldByName('id_acesso').AsString;
          aQry.ParamByName('id_perfil').AsString  := GUIDToString(aModel.Perfil.ID);
          aQry.ExecSQL;
        end;

        Next;
      end;

      aQry.Connection.CommitRetaining;
    end;
  finally
    aQry.Free;
    aDataSet.First;
    aDataSet.EnableControls;
  end;
end;

function TPermissaoPerfilController.Save(const aDataSet: TDataSet): Boolean;
begin
  ;
end;

procedure TPermissaoPerfilController.SetModel(Value: TPermissaoPerfil);
begin
  aModel := Value;
end;

end.
