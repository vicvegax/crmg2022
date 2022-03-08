unit cadLocal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Mask, Vcl.Buttons, funcoes;

type
  TfLocal = class(TForm)
    dsRec: TDataSource;
    qyRec: TFDQuery;
    gdRec: TDBGrid;
    Label1: TLabel;
    edDESCR: TEdit;
    qyRecid: TFDAutoIncField;
    qyReccod: TWideStringField;
    qyRecdescr: TWideStringField;
    qyReclocal: TWideStringField;
    qyRecobs: TWideStringField;
    qyRecativo: TIntegerField;
    qyRecdt_inc: TDateField;
    qyRecus_inc: TWideStringField;
    qyRecdt_alt: TDateField;
    qyRecus_alt: TWideStringField;
    qyRecrg_alt: TWideStringField;
    Label5: TLabel;
    Label2: TLabel;
    edID: TEdit;
    edCod: TEdit;
    Label3: TLabel;
    cbAtivo: TComboBox;
    Label4: TLabel;
    edObs: TMemo;
    Label6: TLabel;
    edLocal: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure edENTER_KeyPress(Sender: TObject; var Key: Char);
    procedure gdRecDblClick(Sender: TObject);
  private
    { Private declarations }
    function ExeAcao: Boolean;
    function ChkCampos: Boolean;
    procedure preCampos;
    procedure WMACAO(var Msg: TMessage); message WM_ACAO;
    procedure LimpaCampos;
    var
      qtModoInc: Integer;
  public
    { Public declarations }
  end;

var
  fLocal: TfLocal;

implementation

{$R *.dfm}

uses DtMod;

function TfLocal.ExeAcao: Boolean;
var
  bLocId, bLocReg: Boolean;
begin
  Result:= False;

  if(not ChkCampos) then Exit;
  //qyRec.DisableControls;
  bLocReg:= qyRec.Locate('cod', edCOD.Text, []);
  bLocId:= false;
  if (wModo <> modoInc) then
      bLocId:= qyRec.Locate('id', edID.Text, []);

  if not (wModo = modoExc) then begin
    if(wModo = modoInc) then begin
      if(bLocReg) then begin
        MsgErro(Format(kJaCad, ['Texto']));
        Exit;
      end;
      if(not msgPergunta(kMsgInc, kModo[wModo])) then exit;
    end else begin
      if(not bLocId) then begin
        MsgErro(Format(kNaoLoc, ['Texto']));
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
      FieldByName('cod').AsString:= edCod.Text;
      FieldByName('local').AsString:= edLocal.Text;
      FieldByName('obs').AsString:= edObs.Lines.Text;
      FieldByName('ativo').AsInteger:= cbAtivo.ItemIndex;
      Post;
    end;
  end else begin
    if(not bLocId) then begin
      MsgErro(Format(kNaoLoc, ['Texto']));
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

function TfLocal.ChkCampos: Boolean;
begin
  Result:= False;
  if(length(edDescr.Text) = 0) then begin
    msgPreen('Nome da Unidade');
    edDescr.SetFocus;
    Exit;
  end;
  if(length(edCod.Text) = 0) then begin
    msgPreen('Código');
    edCod.SetFocus;
    Exit;
  end;
  Result:= True;
end;

procedure TfLocal.edENTER_KeyPress(Sender: TObject; var Key: Char);
begin
if(key = kENTER) then begin
  key:= #0;
  ExeAcao;
end;
end;

procedure TfLocal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
qyRec.Close;
end;

procedure TfLocal.FormCreate(Sender: TObject);
begin
qyRec.Open();
end;

procedure TfLocal.FormShow(Sender: TObject);
begin
//edDESCR.SetFocus;
LimpaCampos;
end;

procedure TfLocal.gdRecDblClick(Sender: TObject);
begin
if qyRec.RecordCount>0 then
  PreCampos;
end;

procedure TfLocal.LimpaCampos;
begin
  edDescr.Text:= '';
  edID.Text:= kNovoId;
  edCod.Text:= '';
  edObs.Lines.Clear;
  cbAtivo.ItemIndex:= 0;
  edLocal.Text:= '';
  qtModoInc:= 0;
end;

procedure TfLocal.preCampos;
begin
  with qyRec do begin
    edDESCR.Text:= FieldByName('DESCR').AsString;
    edCod.Text:= FieldByName('cod').AsString;
    edlocal.Text:= FieldByName('local').AsString;
    cbativo.ItemIndex:= fieldbyname('ativo').AsInteger;
    edobs.lines.Text:= fieldbyname('obs').AsString;

    if not (wModo = modoInc) then edID.Text:= FieldByName('id').AsString;
  end;
end;

procedure TfLocal.WMACAO(var Msg: TMessage);
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
