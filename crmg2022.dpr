program crmg2022;

uses
  Vcl.Forms,
  main in 'main.pas' {fMain},
  DtMod in 'DtMod.pas' {DM: TDataModule},
  funcoes in 'funcoes.pas',
  cadUsuario in 'cadUsuario.pas' {fUsuario},
  cadPessoal in 'cadPessoal.pas' {fPessoal},
  cadLocal in 'cadLocal.pas' {fLocal},
  cadInvent in 'cadInvent.pas' {fInvent},
  cadCateg in 'cadCateg.pas' {fCateg};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'CRMG 2022';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
