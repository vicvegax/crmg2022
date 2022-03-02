unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters, dxNavBarCollns,
  cxClasses, dxNavBarBase, dxNavBar, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  System.Actions, Vcl.ActnList, funcoes, mxWebUpdate;

type
  TfMain = class(TForm)
    Panel1: TPanel;
    dxNavBar1: TdxNavBar;
    dxNavBar1Group1: TdxNavBarGroup;
    btInv: TdxNavBarItem;
    btCat: TdxNavBarItem;
    btUni: TdxNavBarItem;
    btPes: TdxNavBarItem;
    btUsu: TdxNavBarItem;
    Panel2: TPanel;
    pnFoot: TPanel;
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
    procedure btTabClick(Sender: TObject);
    procedure acModoExecute(Sender: TObject);
    procedure acConfExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    fChild: TForm;
    bChild: Boolean;
    lCaption: String;
    procedure WMACAO(var Msg: TMessage); message WM_ACAO;
  public
    { Public declarations }
    procedure AtuHead(St: String);
  end;

var
  fMain: TfMain;
//  fChild: TfUsuario;

implementation

{$R *.dfm}

uses usuario, pessoal, local;

procedure TfMain.acConfExecute(Sender: TObject);
begin
//
  if(not Assigned(fChild)) then Exit;

  SendMessage(fChild.Handle, WM_ACAO, wpConfirma, 0); //Informa Ação Confirma
end;

procedure TfMain.acModoExecute(Sender: TObject);
begin
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
if(Assigned(fChild)) then begin
  bChild:= false;
  if(not (fChild.Tag = tag)) then begin
    fChild.Close;
    fChild.Free;
    bChild:= true;
  end;
end;
if(bChild) then begin
  case tag of
    3: fChild:= TfLocal.Create(Application);
    4: fChild:= TfPessoal.Create(Application);
    5: fChild:= TfUsuario.Create(Application);
  end;

  //pnHead.Caption
  lCaption:= fChild.Caption;
  pnBarCad.Show;
  fChild.Tag:= tag;
  fChild.manualdock(pnPag);
  fChild.show;
  acInc.Execute;
end;

end;

procedure TfMain.FormCreate(Sender: TObject);
begin
wUsuario:= 'ADMIN';
mxUpdate.TargetFolder:= ExtractFileDir(GetCurrentDir()) + '\update';
edit1.Text:= mxUpdate.TargetFolder;
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
