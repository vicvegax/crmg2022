unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  System.Actions, Vcl.ActnList, funcoes, mxWebUpdate, mxProtector, cxClasses,
  cxLocalization;

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
    procedure btTabClick(Sender: TObject);
    procedure acModoExecute(Sender: TObject);
    procedure acConfExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure mxUpdateUpdateAvailable(Sender: TObject; ActualVersion,
      NewVersion: string; var CanUpdate: Boolean);
    procedure mxUpdateNoUpdateFound(Sender: TObject);
    procedure mxProtector1Expiration(Sender: TObject);
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

  SendMessage(fChild.Handle, WM_ACAO, wpConfirma, 0); //Informa A��o Confirma
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
//cxLocalizer1.FileName:= '.\traducao.ini';
//cxLocalizer1.Active:= true;
Self.Caption:= Self.Caption + ' v0.1';
//getfileversion(
wUsuario:= 'ADMIN';
mxUpdate.TargetFolder:= ExtractFileDir(ParamStr(0)) + '\update';
edit1.Text:= mxUpdate.TargetFolder;
end;

procedure TfMain.mxProtector1Expiration(Sender: TObject);
begin
pnBarra.Enabled:= False;
end;

procedure TfMain.mxUpdateNoUpdateFound(Sender: TObject);
begin
  MessageDlg( 'There is no update available!', mtError, [ mbOK ], 0 );

end;

procedure TfMain.mxUpdateUpdateAvailable(Sender: TObject; ActualVersion,
  NewVersion: string; var CanUpdate: Boolean);
begin
  CanUpdate := MessageDlg( Format( 'You are using version %s, but version %s is available to ' + #13 + #10 + 'download at the author''s website.' + #13 + #10 + 'Do you want to update your application now?', [ ActualVersion, NewVersion ] ), mtWarning, [ mbYes, mbNo ], 0 ) = mrYes;

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
