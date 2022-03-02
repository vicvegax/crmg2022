program crmg2022;

uses
  Vcl.Forms,
  main in 'main.pas' {fMain},
  DtMod in 'DtMod.pas' {DM: TDataModule},
  funcoes in 'funcoes.pas',
  usuario in 'usuario.pas' {fUsuario},
  pessoal in 'pessoal.pas' {fPessoal},
  local in 'local.pas' {fLocal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'CRM';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
