unit cadInvent;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Mask, Vcl.Buttons, funcoes, Vcl.ComCtrls,
  MyComboBox2022, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxCore,
  cxDateUtils, cxCalc, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxSpinEdit;

type
  TfInvent = class(TForm)
    dsRec: TDataSource;
    qyRec: TFDQuery;
    qyRecid: TFDAutoIncField;
    qyReccod: TWideStringField;
    qyRecdescr: TWideStringField;
    qyRecid_cat: TIntegerField;
    qyRecid_local: TIntegerField;
    qyRecdt_comp: TDateField;
    qyRecvl_comp: TFloatField;
    qyRecvid_util: TIntegerField;
    qyRecobs: TWideStringField;
    qyRecsitua: TIntegerField;
    qyRecdt_man: TDateField;
    qyRecid_man: TIntegerField;
    qyRecativo: TIntegerField;
    qyRecdt_inc: TDateField;
    qyRecus_inc: TWideStringField;
    qyRecdt_alt: TDateField;
    qyRecus_alt: TWideStringField;
    qyRecrg_alt: TWideStringField;
    pcInv: TPageControl;
    tsCad: TTabSheet;
    Label1: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edDESCR: TEdit;
    edID: TEdit;
    edCod: TEdit;
    cbAtivo: TComboBox;
    edOBS: TMemo;
    tsHist: TTabSheet;
    gdRec: TDBGrid;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    cbIDCAT: TMyComboBox;
    qyReccateg: TStringField;
    edDTCOM: TcxDateEdit;
    edVLCOM: TcxCalcEdit;
    Label9: TLabel;
    edVIDUTIL: TcxSpinEdit;
    Label10: TLabel;
    cbSITUA: TComboBox;
    Label11: TLabel;
    edVLDEP: TEdit;
    Label13: TLabel;
    edDTMAN: TcxDateEdit;
    Label14: TLabel;
    cbIDLOC: TMyComboBox;
    qyReclocal: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure edENTER_KeyPress(Sender: TObject; var Key: Char);
    procedure gdRecDblClick(Sender: TObject);
    procedure qyRecCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    function ExeAcao: Boolean;
    function ChkCampos: Boolean;
    procedure preCampos;
    procedure WMACAO(var Msg: TMessage); message WM_ACAO;
    procedure LimpaCampos;
    procedure PreCbo;
    var
      qtModoInc: Integer;
  public
    { Public declarations }
  end;

var
  fInvent: TfInvent;

implementation

{$R *.dfm}

uses DtMod;

function TfInvent.ExeAcao: Boolean;
var
  bLocId, bLocReg: Boolean;
begin
  Result:= False;

  if(not ChkCampos) then Exit;
  qyRec.DisableControls;
  bLocReg:= qyRec.Locate('cod', edCod.Text, []);
  bLocId:= false;
  if (wModo <> modoInc) then
      bLocId:= qyRec.Locate('id', edID.Text, []);

  if not (wModo = modoExc) then begin
    if(wModo = modoInc) then begin
      if(bLocReg) then begin
        MsgErro(Format(kJaCad, ['Pessoal']));
        Exit;
      end;
      if(not msgPergunta(kMsgInc, kModo[wModo])) then exit;
    end else begin
      if(not bLocId) then begin
        MsgErro(Format(kNaoLoc, ['Pessoal']));
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
      FieldByName('ativo').AsInteger:= cbAtivo.ItemIndex;
      FieldByName('obs').AsString:= edObs.Lines.Text;
      FieldByName('ativo').AsInteger:= cbAtivo.ItemIndex;
      FieldBYName('id_local').AsString:= cbidloc.CodigoIndex;
      fieldbyname('id_cat').AsString:= cbidcat.CodigoIndex;
      fieldbyname('dt_man').AsVariant:= edDTMAN.EditValue;
      fieldbyname('dt_comp').AsDateTime:= eddtcom.Date;
      fieldbyname('vl_comp').AsFloat:= edvlcom.Value;
      fieldbyname('vid_util').AsInteger:= edvidutil.Value;
      fieldbyname('situa').AsInteger:= cbsitua.ItemIndex;
      Post;
    end;
  end else begin
    if(not bLocId) then begin
      MsgErro(Format(kNaoLoc, ['Pessoal']));
      Exit;
    end;
    if(msgPergunta(kMsgExc, kModo[wModo])) then
      if(msgPergunta(kMsgExc, kModo[wModo])) then begin
        qyREC.Delete;
      end;
  end;
  qyRec.EnableControls;
  qyRec.Refresh;
  if wModo = modoExc then gdRec.Repaint
  else gdRec.Refresh;
  LimpaCampos;
  MudaModo(modoInc);
  Result:= true;
end;

function TfInvent.ChkCampos: Boolean;
begin
  Result:= False;
  if(length(edCod.Text) = 0) then begin
    msgPreen('Código');
    edCod.SetFocus;
    Exit;
  end;
  if(length(edDescr.Text) = 0) then begin
    msgPreen('Nome Completo');
    edDescr.SetFocus;
    Exit;
  end;
  Result:= True;
end;

procedure TfInvent.edENTER_KeyPress(Sender: TObject; var Key: Char);
begin
if(key = kENTER) then begin
  key:= #0;
  ExeAcao;
end;
end;

procedure TfInvent.FormClose(Sender: TObject; var Action: TCloseAction);
begin
qyRec.Close;
DM.qyCat.Close;
DM.qyLoc.Close;
end;

procedure TfInvent.FormCreate(Sender: TObject);
begin
DM.qyCat.Open();
DM.qyLoc.Open();
qyRec.Open();
PreCbo;
end;

procedure TfInvent.FormShow(Sender: TObject);
begin
//edDESCR.SetFocus;
LimpaCampos;
end;

procedure TfInvent.gdRecDblClick(Sender: TObject);
begin
if qyRec.RecordCount>0 then
  PreCampos;
end;

procedure TfInvent.LimpaCampos;
begin
  edDescr.Text:= '';
  edCod.Text:= '';
  cbAtivo.ItemIndex:= 0;
  edObs.Lines.Clear;
  edID.Text:= kNovoId;
  qtModoInc:= 0;
end;

procedure TfInvent.preCampos;
begin
  with qyRec do begin
    edDESCR.Text:= FieldByName('DESCR').AsString;
    edCod.Text:= FieldByName('Cod').AsString;
    cbAtivo.ItemIndex:= FieldByName('ativo').AsInteger;
    edObs.Lines.Text:= FieldByName('obs').AsString;
    cbIDCAT.CodigoIndex:= FieldByName('id_cat').AsString;
    edDTCOM.EditValue:= null;
    edDTCOM.Date:= FieldByName('dt_comp').AsDateTime;
    if edDTCOM.EditValue = 0 then edDTCOM.EditValue:= null;
    edVLCOM.Value:= FieldByName('vl_comp').AsFloat;
    edDTMAN.Date:= fieldbyname('dt_man').AsDateTime;
    if edDTMAN.EditValue = 0 then edDTMAN.EditValue:= null;
    edVidutil.Value:= FieldByName('vid_util').AsInteger;
    cbidloc.CodigoIndex:= fieldByname('id_local').AsString;
    if not (wModo = modoInc) then edID.Text:= FieldByName('id').AsString;
  end;
end;

procedure TfInvent.PreCbo;
begin
with DM.qyCat do begin
  First;
  while not Eof do begin
    cbIDCAT.AppendItem(FieldByName('descr').AsString, FieldBYName('id').AsString);
    Next;
  end;
end;
with DM.qyLoc do begin
  First;
  while not Eof do begin
    cbIDLOC.AppendItem(FieldByName('descr').AsString, FieldBYName('id').AsString);
    Next;
  end;
end;
end;

procedure TfInvent.qyRecCalcFields(DataSet: TDataSet);
begin
//with DM.qyCat do begin
//DataSet.FieldByName('categ').AsString:=
end;

procedure TfInvent.WMACAO(var Msg: TMessage);
begin
  if Msg.wParam = wpModo then begin
    if Msg.LParam <> modoInc then begin
      if(qyRec.RecordCount > 0) then PreCampos
      else MudaModo(modoInc);
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
