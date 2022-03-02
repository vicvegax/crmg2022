object DM: TDM
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 499
  Width = 698
  PixelsPerInch = 120
  object FDTransaction1: TFDTransaction
    Connection = DBCON
    Left = 96
    Top = 48
  end
  object DBCON: TFDConnection
    Params.Strings = (
      'Database=D:\Projetos\Delphi\crmg2022\compiled\dados.db'
      'LockingMode=Normal'
      'DriverID=SQLite')
    ConnectedStoredUsage = [auDesignTime]
    Connected = True
    LoginPrompt = False
    Transaction = FDTransaction1
    Left = 80
    Top = 152
  end
  object qyCat: TFDQuery
    Connection = DBCON
    SQL.Strings = (
      'select * from tbCateg')
    Left = 168
    Top = 264
  end
  object qyUsu: TFDQuery
    Connection = DBCON
    SQL.Strings = (
      'select * from tbUsuario')
    Left = 104
    Top = 264
  end
end
