unit ViewUI.FormSplashUI;

interface

uses
  InterfaceAgil.Observer,
  Controller.VersaoAplicacao,
  Controller.Licenca,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ViewUI.FormDefaultUI, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TFormSplashUI = class(TFormDefaultUI, IObservador) // Este splash ser� o observador da licen�a
    lblCompanyName: TLabel;
    lblLegalCopyright: TLabel;
    lblSplashName: TLabel;
    lblSplashDescription: TLabel;
    lblProductVersion: TLabel;
    ImgBackgroud: TImage;
    lblRegistradoPara: TLabel;
    lblCarregando: TLabel;
    imgAppIcon: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    aVersao  : TVersaoAplicacaoController;
    aLicenca : TLicencaController;
    procedure CarregarInformacao;
  public
    { Public declarations }
    procedure Update(Observable: IObservable);
  end;

var
  FormSplashUI: TFormSplashUI;

implementation

{$R *.dfm}

{ TFormSplashUI }

procedure TFormSplashUI.CarregarInformacao;
begin
  aVersao  := TVersaoAplicacaoController.GetInstance();
  with aVersao do
  begin
    lblSplashName.Caption        := SplashName;
    lblSplashDescription.Caption := SplashDescription;
    lblProductVersion.Caption    := 'Vers�o do Produto: ' + ProductVersion + ' (Build ' + FileVersion + ')';

    lblCompanyName.Caption       := CompanyName;
    lblLegalCopyright.Caption    := LegalCopyright;
  end;
  lblCarregando.Caption := EmptyStr;
  Self.Update(nil);
end;

procedure TFormSplashUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  aLicenca.Model.removeObserver(Self);
  inherited;
end;

procedure TFormSplashUI.FormCreate(Sender: TObject);
begin
  inherited;
  aLicenca := TLicencaController.GetInstance;

  aLicenca.Model.addObserver(Self);
end;

procedure TFormSplashUI.FormShow(Sender: TObject);
begin
  CarregarInformacao;
end;

procedure TFormSplashUI.Update(Observable: IObservable);
begin
  with aLicenca, Model do
    if Carregada then
      lblRegistradoPara.Caption := 'Propriedade intelectual de ' + aVersao.Owner +
        ', com licen�a de uso para ' + RazaoSocial + ', com CPF/CNPJ ' + Cnpj +
        '. Atualizada em ' + aVersao.ReleaseDate + ', tendo como compet�ncia limite ' +
        IntToStr(CompetenciaLimite) + ' (' + FormatDateTime('dd/mm/yyyy', DataBloqueio) + ').'
    else
      lblRegistradoPara.Caption := EmptyStr;

  lblRegistradoPara.Caption := Trim(lblRegistradoPara.Caption);
  lblCarregando.Caption     := Trim(aLicenca.Model.NotificacaoSplash);
  lblCarregando.Update;
end;

end.
