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
    Label3: TLabel;
    Label4: TLabel;
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
    qyRecdt_incor: TDateField;
    qyRectp_incor: TIntegerField;
    Label12: TLabel;
    edDTINCOR: TcxDateEdit;
    Label15: TLabel;
    cbTPINCOR: TComboBox;
    Panel1: TPanel;
    Label1: TLabel;
    edDESCR: TEdit;
    Label2: TLabel;
    edCod: TEdit;
    Label5: TLabel;
    edID: TEdit;
    DBGrid1: TDBGrid;
    dsMov: TDataSource;
    qyMov: TFDQuery;
    qyMovid: TFDAutoIncField;
    qyMovid_inv: TIntegerField;
    qyMovid_loc: TIntegerField;
    qyMovst_ini: TStringField;
    qyMovst_fim: TStringField;
    qyMovtp_reg: TStringField;
    qyMovnt_reg: TStringField;
    qyMovdata: TDateField;
    qyMovcd_mov: TIntegerField;
    qyMovobs: TWideStringField;
    qyMovvalor: TFloatField;
    qyMovdt_inc: TDateField;
    qyMovus_inc: TWideStringField;
    flDSREG: TStringField;
    qyMovds_loc: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure edENTER_KeyPress(Sender: TObject; var Key: Char);
    procedure gdRecDblClick(Sender: TObject);
    procedure qyRecCalcFields(DataSet: TDataSet);
    procedure qyMovCalcFields(DataSet: TDataSet);
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

  idLocOri: Integer;
  idLocDst: Integer;
//  dtManOri: TDate;
begin
  Result:= False;

  if(not ChkCampos) then Exit;
  //qyRec.DisableControls;
  bLocReg:= qyRec.Locate('cod', edCod.Text, []);
  bLocId:= false;
  if (wModo <> modoInc) then
      bLocId:= qyRec.Locate('id', edID.Text, []);

  if not (wModo = modoExc) then begin
    if(wModo = modoInc) then begin
      if(bLocReg) then begin
        MsgErro(Format(kJaCad, ['Inventário']));
        Exit;
      end;
      if(not msgPergunta(kMsgInc, kModo[wModo])) then exit;
    end else begin
      if(not bLocId) then begin
        MsgErro(Format(kNaoLoc, ['Inventário']));
        Exit;
      end;
      if(not msgPergunta(kMsgAlt, kModo[wModo])) then exit;
    end;//if
    idLocDst:= StrToInt(cbidloc.CodigoIndex);
    idLocOri:= -1;
    if(wModo = modoAlt) then
      idLocOri:= qyRec.FieldByName('id_local').AsInteger;

    if(idLocOri <> -1) and (idLocOri <> idLocDst) then begin
      if(not msgPergunta('Mudar o Local atual do item sleceionado?', 'Mudança de Local')) then Exit;
    end;


    DM.DBTRANS.StartTransaction;
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
      fieldbyname('dt_comp').AsVariant:= eddtcom.EditValue;
      fieldbyname('vl_comp').AsFloat:= edvlcom.Value;
      fieldbyname('vid_util').AsInteger:= edvidutil.Value;
      fieldbyname('situa').AsInteger:= cbsitua.ItemIndex;
      fieldbyname('dt_incor').AsVariant:= edDTINCOR.editvalue;
      fieldbyname('tp_incor').AsInteger:= cbTPINCOR.ItemIndex;
      Post;
    end;
    if(idLocOri <> idLocDst) then begin
      if(idLocOri = -1) then begin //Aquisição/Novo Item
        qyMov.Append;
        qyMov.fieldbyname('id_inv').AsInteger:= qyRec.fieldByname('id').AsInteger;
        qyMov.FieldByName('id_loc').AsInteger:= idLocDst;
        qyMov.FieldByName('st_ini').AsString:= cSTINI;
        qyMov.FieldByName('st_fim').AsString:= cSTFIM;
        qyMov.FieldByName('tp_reg').AsString:= cTPAQU;
        qyMov.FieldByName('nt_reg').AsString:= cNTCRE;
        qyMov.FieldByName('date').AsDateTime:= edDtIncor.Date;
        qyMov.FieldByName('dt_inc').AsDateTime:= date;
        qyMov.FieldByName('us_inc').AsString:= wUsuario;
        qyMov.Post;
      end else begin //Alteração de Local
        qyMov.Append;  //Local de Saída/Origem
        qyMov.fieldbyname('id_inv').AsInteger:= qyRec.fieldByname('id').AsInteger;
        qyMov.FieldByName('id_loc').AsInteger:= idLocOri;
        qyMov.FieldByName('st_ini').AsString:= cSTINI;
        qyMov.FieldByName('st_fim').AsString:= cSTFIM;
        qyMov.FieldByName('tp_reg').AsString:= cTPORI;
        qyMov.FieldByName('nt_reg').AsString:= cNTDEB;
        qyMov.FieldByName('data').AsDateTime:= edDtIncor.Date;
        qyMov.FieldByName('dt_inc').AsDateTime:= date;
        qyMov.FieldByName('us_inc').AsString:= wUsuario;
        qyMov.Post;

        qyMov.Append;  //Local de Entrada/Destinoo
        qyMov.fieldbyname('id_inv').AsInteger:= qyRec.fieldByname('id').AsInteger;
        qyMov.FieldByName('id_loc').AsInteger:= idLocDst;
        qyMov.FieldByName('st_ini').AsString:= cSTINI;
        qyMov.FieldByName('st_fim').AsString:= cSTFIM;
        qyMov.FieldByName('tp_reg').AsString:= cTPDST;
        qyMov.FieldByName('nt_reg').AsString:= cNTCRE;
        qyMov.FieldByName('data').AsDateTime:= edDtIncor.Date;
        qyMov.FieldByName('dt_inc').AsDateTime:= date;
        qyMov.FieldByName('us_inc').AsString:= wUsuario;
        qyMov.Post;

      end;
    end;
    DM.DBTRANS.Commit;
  end else begin
    if(not bLocId) then begin
      MsgErro(Format(kNaoLoc, ['Inventário']));
      Exit;
    end;

    if(qyMov.RecordCount > 0) then begin
      MsgErro('Há histórico para este Item. Ele não poder ser excluído!');
      Exit;
    end;
    if(not msgPergunta(kMsgExc, kModo[wModo])) then  exit;
    if(not msgPergunta(kMsgExcCtz, kModo[wModo])) then exit;

    qyREC.Delete;
  end;
  //qyRec.EnableControls;
  //qyRec.Refresh;

  //gdRec.Repaint;
  gdRec.Refresh;
  //Refresh;
//  if wModo = modoExc then gdRec.Repaint
//  else gdRec.Refresh;
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
    msgPreen('Descrição do Inventário (Bem)');
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
qyMov.Close;
qyRec.Close;
DM.qyCat.Close;
DM.qyLoc.Close;
end;

procedure TfInvent.FormCreate(Sender: TObject);
begin
DM.qyCat.Open();
DM.qyLoc.Open();
qyRec.Open();
qyMov.Open();
//qyMov.Filter:= 'id_inv = -1';
PreCbo;
pcInv.ActivePage:= tsCad;
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
  cbIdCat.ItemIndex:= -1;
  edDTCOM.EditValue:= null;
  edVLCOM.Value:=0;

  cbSitua.ItemIndex:= 0;
  edVidUtil.Value:= 0;
  edVLDEP.Text:= '';

  cbAtivo.ItemIndex:= 0;
  edDTMAN.EditValue:= null;
  cbIdLoc.ItemHeight:= -1;
  edDTINCOR.EditValue:= null;
  cbTPINCOR.ItemIndex:= 0;
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
    edDTINCOR.Date:= fieldbyname('dt_incor').AsDateTime;
    if edDTINCOR.EditValue = 0 then edDTINCOR.EditValue:= null;
    cbTPINCOR.ItemIndex:= FieldByName('tp_incor').AsInteger;
    if not (wModo = modoInc) then begin
      edID.Text:= FieldByName('id').AsString;
      qyMov.Filter:= ' id_inv = ' + edID.Text;
    end;
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

procedure TfInvent.qyMovCalcFields(DataSet: TDataSet);
begin
if(Dataset.FieldByName('tp_reg').AsString = cTPORI) then flDSREG.Value:= 'SAIU DE (ORIGEM)';
if(Dataset.FieldByName('tp_reg').AsString = cTPDST) then flDSREG.Value:= 'ENTROU EM (DESTINO)';
if(Dataset.FieldByName('tp_reg').AsString = cTPAQU) then flDSREG.Value:= 'ADQUIRIDO POR (EM USO)';
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
      qyMov.Filter:= ' id_inv = -1';
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
