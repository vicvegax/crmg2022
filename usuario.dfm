object fUsuario: TfUsuario
  Left = 0
  Top = 0
  Align = alClient
  Caption = 'Cadastro de Usu'#225'rios'
  ClientHeight = 522
  ClientWidth = 853
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 16
    Top = 24
    Width = 92
    Height = 15
    Caption = 'Nome Completo:'
  end
  object Label2: TLabel
    Left = 65
    Top = 67
    Width = 43
    Height = 15
    Caption = 'Usu'#225'rio:'
  end
  object Label3: TLabel
    Left = 73
    Top = 112
    Width = 35
    Height = 15
    Caption = 'Senha:'
  end
  object Label5: TLabel
    Left = 457
    Top = 24
    Width = 33
    Height = 15
    Caption = 'Ident.:'
  end
  object gdRec: TDBGrid
    Left = 0
    Top = 152
    Width = 853
    Height = 370
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dsRec
    ReadOnly = True
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDblClick = gdRecDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'id'
        Title.Caption = 'Ident.'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descr'
        Title.Caption = 'Nome Completo'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cd_usu'
        Title.Caption = 'Usu'#225'rio'
        Width = 73
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'pass'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'dt_inc'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'us_inc'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'dt_alt'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'us_alt'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'rg_alt'
        Visible = True
      end>
  end
  object edDESCR: TEdit
    Left = 120
    Top = 21
    Width = 305
    Height = 23
    TabOrder = 0
    TextHint = '(Nome do Usu'#225'rio)'
    OnKeyPress = edENTERKeyPress
  end
  object edCDUSU: TEdit
    Left = 120
    Top = 64
    Width = 121
    Height = 23
    CharCase = ecUpperCase
    MaxLength = 8
    TabOrder = 2
    TextHint = '(Login)'
  end
  object edPASS: TEdit
    Left = 120
    Top = 109
    Width = 121
    Height = 23
    Hint = '(Login)'
    MaxLength = 8
    TabOrder = 3
    OnKeyPress = edPASSKeyPress
  end
  object edID: TEdit
    Left = 496
    Top = 21
    Width = 65
    Height = 23
    TabStop = False
    Alignment = taRightJustify
    ReadOnly = True
    TabOrder = 1
  end
  object dsRec: TDataSource
    DataSet = qyRec
    Left = 494
    Top = 70
  end
  object qyRec: TFDQuery
    AfterScroll = qyRecAfterScroll
    Connection = DM.DBCON
    SQL.Strings = (
      'select * from tbUsuario')
    Left = 319
    Top = 72
    object qyRecid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qyRecdescr: TWideStringField
      FieldName = 'descr'
      Origin = 'descr'
      Size = 50
    end
    object qyReccd_usu: TWideStringField
      FieldName = 'cd_usu'
      Origin = 'cd_usu'
      Size = 8
    end
    object qyRecpass: TWideStringField
      FieldName = 'pass'
      Origin = 'pass'
      Size = 16
    end
    object qyRecativo: TIntegerField
      FieldName = 'ativo'
      Origin = 'ativo'
    end
    object qyRecdt_inc: TDateField
      FieldName = 'dt_inc'
      Origin = 'dt_inc'
    end
    object qyRecus_inc: TWideStringField
      FieldName = 'us_inc'
      Origin = 'us_inc'
      Size = 8
    end
    object qyRecdt_alt: TDateField
      FieldName = 'dt_alt'
      Origin = 'dt_alt'
    end
    object qyRecus_alt: TWideStringField
      FieldName = 'us_alt'
      Origin = 'us_alt'
      Size = 8
    end
    object qyRecrg_alt: TWideStringField
      FieldName = 'rg_alt'
      Origin = 'rg_alt'
      Size = 200
    end
  end
end
