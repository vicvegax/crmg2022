unit cadPessoal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Mask, Vcl.Buttons, funcoes;

type
  TfPessoal = class(TForm)
    dsRec: TDataSource;
    qyRec: TFDQuery;
    gdRec: TDBGrid;
    Label1: TLabel;
    edDESCR: TEdit;
    Label5: TLabel;
    edID: TEdit;
    qyRecid: TFDAutoIncField;
    qyReccod: TWideStringField;
    qyRecdescr: TWideStringField;
    qyRecobs: TWideStringField;
    qyRecid_loc: TIntegerField;
    qyRecdt_inc: TDateField;
    qyRecus_inc: TWideStringField;
    qyRecdt_alt: TDateField;
    qyRecus_alt: TWideStringField;
    qyRecrg_alt: TWideStringField;
    edCod: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    cbAtivo: TComboBox;
    Label4: TLabel;
    edObs: TMemo;
    qyRecativo: TIntegerField;
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
  fPessoal: TfPessoal;

implementation

{$R *.dfm}

uses DtMod;

function TfPessoal.ExeAcao: Boolean;
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

function TfPessoal.ChkCampos: Boolean;
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

procedure TfPessoal.edENTER_KeyPress(Sender: TObject; var Key: Char);
begin
if(key = kENTER) then begin
  key:= #0;
  ExeAcao;
end;
end;

procedure TfPessoal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
qyRec.Close;
end;

procedure TfPessoal.FormCreate(Sender: TObject);
begin
qyRec.Open();
end;

procedure TfPessoal.FormShow(Sender: TObject);
begin
//edDESCR.SetFocus;
LimpaCampos;
end;

procedure TfPessoal.gdRecDblClick(Sender: TObject);
begin
if qyRec.RecordCount>0 then
  PreCampos;
end;

procedure TfPessoal.LimpaCampos;
begin
  edDescr.Text:= '';
  edCod.Text:= '';
  cbAtivo.ItemIndex:= 0;
  edObs.Lines.Clear;
  edID.Text:= kNovoId;
  qtModoInc:= 0;
end;

procedure TfPessoal.preCampos;
begin
  with qyRec do begin
    edDESCR.Text:= FieldByName('DESCR').AsString;
    edCod.Text:= FieldByName('Cod').AsString;
    cbAtivo.ItemIndex:= FieldByName('ativo').AsInteger;
    edObs.Lines.Text:= FieldByName('obs').AsString;
    if not (wModo = modoInc) then edID.Text:= FieldByName('id').AsString;
  end;
end;

procedure TfPessoal.WMACAO(var Msg: TMessage);
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
