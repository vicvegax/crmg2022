unit funcoes;

interface


uses SysUtils, Messages, Forms, Controls, Windows;

const
  WM_ACAO = WM_USER + 10;  //Message
  wpModo = 1;           //wParam
  wpConfirma = 2;          //wParam

  kModo: array[1..3] of string = ('Inclusão', 'Alteração', 'Exclusão');
  modoInc = 1;
  modoAlt = 2;
  modoExc = 3;


  kNovoId = '(AUTOM)';
  kENTER = #13;

  kMsgInc = 'Confirmar Inclusão deste Registro?';
  kMsgAlt = 'Confirmar Alteração deste Registro?';
  kMsgExc = 'Confirmar EXCLUSÃO deste Registro?';
  kMsgExcCtz = 'Tem CERTEZA que dejesa EXCLUIR este Registro?';
  kJaCad = 'Este(a) "%s" já está cadastrado.';
  kNaoLoc = 'Este(a) "%s" não foi localizado.';
  kCadas = 'Este(a) "%s" não existe. Deseja cadastrá-lo(a)?';
  kPreen = 'Você deve preencher o campo "%s" corretamente.';

  cNTCRE = 'C';
  cNTDEB = 'D';
  cNTNEU = 'N';

  cSTINI = 'N';
  cSTFIM = 'N';

  cTPAQU = '1';  //Operação de Aquisição
  cTPSAI = '2';  //Operação de Transferência - Origem
  cTPORI = '2';  //Operação de Transferência - Origem
  cTPENT = '3';  //Operação de Transferência - Destino
  cTPDST = '3';  //Operação de Transferência - Origem
  cTPMAN = '8';  //Manutenção

var
  wUsuario: string;
  wModo: Integer;

function Codifica(const Str1: string): String;
function CodificaH(const St: String; const Tp: Byte): String;

function MsgBox(sMen, sCap: String; iFlag: Integer = 0): Integer;
procedure MsgErro(const sMen: String);
procedure MsgPreen(const sCampo: String);
function MsgPergunta(const sMen, sCap: String): Boolean;
procedure MudaModo(novoModo: Integer);

implementation

procedure MudaModo(novoModo: integer);
begin
  SendMessage(Application.MainForm.Handle, WM_ACAO, wpModo, novoModo);
end;

function Codifica(const Str1: string): String;
{Encripta uma string}
const
  Mascara = '#$%$'#13#12;
var
	Str2: String;
	PonM, PonS: Byte;
begin
Str2:= '';
PonM:= 1;
for PonS:=1 to Length(Str1) do begin
 Str2:= Str2 + Chr(Ord(Str1[PonS]) Xor Ord(Mascara[PonM]));
 Inc(PonM);
 if PonM > Length(Mascara) then PonM:= 1;
 Result:= Str2;
end;{for}
end;

function CodificaH(const St: String; const Tp: Byte): String;
var
	St2, sHx: String;
  i, q: Integer;
begin
Result:= '';
if St = '' then Exit;
if Tp = 0 then begin //Encripta
	St2:= Codifica(St);
  sHx:= '';
  for i:=1 to Length(St2) do
    sHx:= IntToHex(Ord(St2[i]), 2) + sHx;
  St2:= sHx;
end else begin       //Decripta
	q:= Length(St);
	if (q mod 2) > 0 then begin
  	Result:= '***LGT' + IntToStr(q) + '***';
    Exit;
  end;{if}
	St2:= '';
  for i:= 1 to (q div 2) do
  	St2:= Chr(StrToInt('$' + Copy(St, (i * 2 - 1), 2))) + St2;
  St2:= Codifica(St2);
end;{if}
Result:= St2;
end;



///////////////// Mensagens
function MsgBox(sMen, sCap: String; iFlag: Integer = 0): Integer;
begin
	Screen.Cursor:= crDefault;
	Result:= Application.MessageBox(PWideChar(sMen), PWideChar(sCap), iFlag);
end;{MsgBox}

procedure MsgErro(const sMen: String);
begin
  MsgBox(sMen, 'Atenção', MB_OK + MB_ICONWARNING);
end;{MsgErro}

procedure msgPreen(const sCampo: String);
begin
  MsgErro(Format(kPREEN, [sCampo]));;
end;{MsgErro}

function msgPergunta(const sMen, sCap: String): Boolean;
begin
  result:= MsgBox(sMen, sCap, MB_YESNO + MB_ICONQUESTION) = ID_YES;
end;{MsgErro}
///////////////// Fim Mensagens




end.
