unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  System.Actions, Vcl.ActnList, funcoes, mxWebUpdate, mxProtector, cxClasses,
  cxLocalization, Zip, ShellApi, UITypes;

type
  TfMain = class(TForm)
    pnBarra: TPanel;
    Panel2: TPanel;
    pnPag: TPanel;
    pnHead: TPanel;
    pnBarCad: TPanel;
    btInc: TSpeedButton;
    btAlt: TSpeedButton;
    btExc: TSpeedButton;
    btConf: TSpeedButton;
    ActionList1: TActionList;
    acInc: TAction;
    acAlt: TAction;
    acExc: TAction;
    acConf: TAction;
    mxUpdate: TmxWebUpdate;
    Edit1: TEdit;
    Button1: TButton;
    pnCad: TPanel;
    pnTitCad: TPanel;
    btCadInv: TSpeedButton;
    btCadCat: TSpeedButton;
    btCadLoc: TSpeedButton;
    btCadPes: TSpeedButton;
    btCadUsu: TSpeedButton;
    mxProtector1: TmxProtector;
    pnAtu: TPanel;
    cxLocalizer1: TcxLocalizer;
    edVersao: TEdit;
    Label1: TLabel;
    procedure btTabClick(Sender: TObject);
    procedure acModoExecute(Sender: TObject);
    procedure acConfExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure mxUpdateUpdateAvailable(Sender: TObject; ActualVersion,
      NewVersion: string; var CanUpdate: Boolean);
    procedure mxUpdateNoUpdateFound(Sender: TObject);
    procedure mxProtector1Expiration(Sender: TObject);
    procedure mxUpdateDownload(Sender: TObject; Total, Downloaded: Integer);
    procedure mxUpdateAfterDownload(Sender: TObject; FileName: string);
    procedure mxUpdateBeforeShowInfo(Sender: TObject; var ShowInfo,
      CheckForUpdate: Boolean);
  private
    { Private declarations }
    fChild: TForm;
    bChild: Boolean;
    lCaption: String;
    procedure WMACAO(var Msg: TMessage); message WM_ACAO;
    procedure AtuHead(St: String);
  public
    { Public declarations }
  end;

var
  fMain: TfMain;
//  fChild: TfUsuario;

implementation

{$R *.dfm}

uses cadUsuario, cadPessoal, cadLocal, cadInvent, cadCateg;

procedure TfMain.acConfExecute(Sender: TObject);
begin
//
  if(not Assigned(fChild)) then Exit;

  SendMessage(fChild.Handle, WM_ACAO, wpConfirma, 0); //Informa Ação Confirma
end;

procedure TfMain.acModoExecute(Sender: TObject);
begin
  //ShellExecute(
 if(not Assigned(fChild)) then Exit;

  wModo:= TComponent(Sender).Tag;
  if(wModo = 1) then btInc.Down:= true
  else if(wModo = 2) then btAlt.Down:= true
  else btExc.Down:= true;

  //fChild.Tag:= lModo;

  fChild.Caption:= lCaption + ' - Modo de ' + kModo[wModo];
  fMain.AtuHead(fChild.Caption);
  SendMessage(fChild.Handle, WM_ACAO, wpModo, wModo);  //Informa que o Modo foi Alterado (Inc, Alt, Exc)
end;

procedure TfMain.AtuHead(St: string);
begin
  pnHead.Caption:= St;
end;

procedure TfMain.btTabClick(Sender: TObject);
var
  tag: integer;
begin
tag:= TComponent(Sender).Tag;
bChild:= true;
pnHead.Hide;
pnBarCad.Hide;
if(Assigned(fChild)) then begin
  bChild:= false;
  if(not (fChild.Tag = tag)) then begin
    bChild:= true;
  end;
  fChild.Close;
  fChild.Free;
  fChild:= nil;
end;
if(bChild) then begin
  case tag of
    1: fChild:= TfInvent.Create(Application);
    2: fChild:= TfCateg.Create(Application);
    3: fChild:= TfLocal.Create(Application);
    4: fChild:= TfPessoal.Create(Application);
    5: fChild:= TfUsuario.Create(Application);
  end;

  //pnHead.Caption
  lCaption:= fChild.Caption;
  pnHead.Show;
  pnBarCad.Show;
  fChild.Tag:= tag;
  fChild.manualdock(pnPag);
  fChild.show;
  acInc.Execute;
end;

end;

procedure TfMain.Button1Click(Sender: TObject);
begin
pnAtu.Width:= Width -300;
pnAtu.Height:= Height div 2;
pnAtu.Left:= (Width - pnAtu.Width) div 2;
pnAtu.Top:= (Height - pnAtu.Height) div 2;
pnAtu.Show;
Refresh;
mxUpdate.CheckForAnUpdate;
pnAtu.Hide;
//killapp
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
cxLocalizer1.FileName:= '.\traducao.ini';
cxLocalizer1.Active:= true;
cxLocalizer1.Locale:= 1046;
Self.Caption:= Self.Caption + ' ' + edVersao.Text;
//getfileversion(
wUsuario:= 'ADMIN';
mxUpdate.TargetFolder:= ExtractFileDir(ParamStr(0)) + '\update';
edit1.Text:= mxUpdate.TargetFolder;
end;

procedure TfMain.mxProtector1Expiration(Sender: TObject);
begin
pnBarra.Enabled:= False;
end;

procedure TfMain.mxUpdateAfterDownload(Sender: TObject; FileName: string);
var
  arq: TZipFile;
begin
arq:= TZipFile.Create;
arq.Open(ExtractFileDir(ParamStr(0)) + '\update\update.zip', zmRead);
arq.ExtractAll(ExtractFileDir(ParamStr(0)) + '\update');
arq.Close;
arq.Free;
pnAtu.Caption:= 'Atualização Baixada!\nAguarde...';
If ShellExecute( Application.MainForm.Handle, PChar( 'open' ), PChar( '.\updatehmwin64.exe' ), PChar( 'crmg2022.exe update CRMG2022' ), PChar( '' ), SW_SHOWNORMAL ) <= 32 Then ShowMessage('erro');
application.Terminate;
//shellexecute(
end;

procedure TfMain.mxUpdateBeforeShowInfo(Sender: TObject; var ShowInfo,
  CheckForUpdate: Boolean);
begin
ShowInfo:= false;
end;

procedure TfMain.mxUpdateDownload(Sender: TObject; Total, Downloaded: Integer);
begin
  pnAtu.Caption:= 'Baixando: ' + IntToStr(Downloaded);
end;

procedure TfMain.mxUpdateNoUpdateFound(Sender: TObject);
begin
  MessageDlg( 'Não há atualização disponível!', mtError, [ mbOK ], 0 );

end;

procedure TfMain.mxUpdateUpdateAvailable(Sender: TObject; ActualVersion,
  NewVersion: string; var CanUpdate: Boolean);
begin
  CanUpdate := MessageDlg('Deseja mesmo baixar a atualização?', mtWarning, [ mbYes, mbNo ], 0 ) = mrYes;

end;

procedure TfMain.WMACAO(var Msg: TMessage);
begin
  if Msg.wParam = wpModo then begin
    if Msg.LParam = modoInc then btInc.Click;
    if Msg.LParam = modoAlt then btAlt.Click;
    if Msg.LParam = modoExc then btExc.Click;
  end;

end;

end.
