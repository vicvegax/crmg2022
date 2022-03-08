unit cadUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Mask, Vcl.Buttons, funcoes, MyComboBox2022;

type
  TfUsuario = class(TForm)
    dsRec: TDataSource;
    qyRec: TFDQuery;
    qyRecid: TFDAutoIncField;
    qyRecdescr: TWideStringField;
    qyReccd_usu: TWideStringField;
    qyRecpass: TWideStringField;
    qyRecdt_inc: TDateField;
    qyRecus_inc: TWideStringField;
    qyRecdt_alt: TDateField;
    qyRecus_alt: TWideStringField;
    qyRecrg_alt: TWideStringField;
    gdRec: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    edDESCR: TEdit;
    Label3: TLabel;
    edCDUSU: TEdit;
    edPASS: TEdit;
    Label5: TLabel;
    edID: TEdit;
    qyRecativo: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure edPASSKeyPress(Sender: TObject; var Key: Char);
    procedure qyRecAfterScroll(DataSet: TDataSet);
    procedure gdRecDblClick(Sender: TObject);
    procedure edENTERKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    function ExeAcao: Boolean;
    function ChkCampos: Boolean;
    procedure preCampos;
    procedure WMACAO(var Msg: TMessage); message WM_ACAO;
    procedure LimpaCampos;
    var
      qtModoInc: Integer;
    //var
  public
    { Public declarations }
    //lModo: Integer;
  end;

var
  fUsuario: TfUsuario;

implementation

{$R *.dfm}

uses DtMod;

function TfUsuario.ExeAcao: Boolean;
var
  bLocId, bLocReg: Boolean;
begin
  Result:= False;

  if(not ChkCampos) then Exit;
  //qyRec.DisableControls;
  bLocReg:= qyRec.Locate('cd_usu', edCDUSU.Text, []);
  bLocId:= false;
  if (wModo <> modoInc) then
    //if strtoint(edID.Text)>0 then
      bLocId:= qyRec.Locate('id', edID.Text, []);

  if not (wModo = modoExc) then begin
    if(wModo = modoInc) then begin
      if(bLocReg) then begin
        MsgErro(Format(kJaCad, ['Usuário']));
        Exit;
      end;
      if(not msgPergunta(kMsgInc, kModo[wModo])) then exit;
    end else begin
      if(not bLocId) then begin
        MsgErro(Format(kNaoLoc, ['Usuário']));
        Exit;
      end;
      if(not msgPergunta(kMsgAlt, kModo[wModo])) then exit;
    end;//if
    with qyRec do begin
      if(wModo = modoInc) then begin
        Append;
        FieldByName('US_INC').AsString:= wUsuario;
        FieldByName('DT_INC').AsDateTime:= Date;
      end else begin
        Edit;
        FieldByName('US_ALT').AsString:= wUsuario;
        FieldByName('DT_ALT').AsDateTime:= Date;
      end;
      FieldByName('DESCR').AsString:= edDESCR.Text;
      FieldByName('CD_USU').AsString:= edCDUSU.Text;
      FieldByName('PASS').AsString:= CodificaH(edPASS.Text, 0);
      Post;
    end;
  end else begin
    if(not bLocId) then begin
      MsgErro(Format(kNaoLoc, ['Usuário']));
      Exit;
    end;
    if(not msgPergunta(kMsgExc, kModo[wModo])) then  exit;
    if(not msgPergunta(kMsgExcCtz, kModo[wModo])) then exit;

    qyREC.Delete;
  end;
  //qyRec.EnableControls;
  //qyRec.Refresh;
  //if wModo = modoExc then gdRec.Repaint
  //else
  gdRec.Refresh;
  LimpaCampos;
  MudaModo(modoInc);
  Result:= true;
end;

function TfUsuario.ChkCampos: Boolean;
begin
  Result:= False;
  if(wModo <>modoExc) and (length(edPASS.Text) < 4) then begin
    msgErro('Senha precisa ter 4 dígitos ou mais.');
    edPASS.SetFocus;
    Exit;
  end;
  if(length(edDescr.Text) = 0) then begin
    msgPreen('Nome');
    edDescr.SetFocus;
  end;
  Result:= True;
end;

procedure TfUsuario.edENTERKeyPress(Sender: TObject; var Key: Char);
begin
//if(key = #13) then begin
  //key := #0;
  //ProxFocus(Self);
  //Self.Perform(CM_DIALOGKEY, VK_TAB, 0);
//end;
end;

procedure TfUsuario.edPASSKeyPress(Sender: TObject; var Key: Char);
begin
if(key = kENTER) then begin
  key:= #0;
  ExeAcao;
end;
end;

procedure TfUsuario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
qyRec.Close;
end;

procedure TfUsuario.FormCreate(Sender: TObject);
begin
qyRec.Open();
//btInc.Click;
//qtMovoInc:= 0;
end;

procedure TfUsuario.FormShow(Sender: TObject);
begin
edDESCR.SetFocus;
LimpaCampos;
end;

procedure TfUsuario.gdRecDblClick(Sender: TObject);
begin
//if(wModo = modoInc) then
if qyRec.RecordCount>0 then
  PreCampos;
end;

procedure TfUsuario.LimpaCampos;
begin
  edDescr.Text:= '';
  edCDUSU.Text:= '';
  edPASS.Text:= '';
  edID.Text:= kNovoId;
  qtModoInc:= 0;
end;

procedure TfUsuario.preCampos;
begin
  with qyRec do begin
    edDESCR.Text:= FieldByName('DESCR').AsString;
    if not (wModo = modoInc) then edID.Text:= FieldByName('id').AsString;
    edCDUSU.Text:= FieldByName('cd_usu').AsString;
    edPASS.Text:= '';
  end;
end;

procedure TfUsuario.qyRecAfterScroll(DataSet: TDataSet);
begin
//if not (wModo = modoInc) then PreCampos;
end;

procedure TfUsuario.WMACAO(var Msg: TMessage);
begin
  if Msg.wParam = wpModo then begin
    if Msg.LParam <> modoInc then begin
      if(qyRec.RecordCount > 0) then PreCampos
      else MudaModo(modoInc);
      qtModoInc:= 0;
    end else begin
      edID.Text:= kNovoID;
      inc(qtModoInc);
      if(qtModoInc > 1) then begin
        LimpaCampos;
        qtModoInc:= 0;
      end;
    end;
    edDescr.SetFocus;
  end;
  if Msg.WParam = wpConfirma then begin
    ExeAcao;
  end;

end;

end.
