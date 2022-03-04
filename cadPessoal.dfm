object fPessoal: TfPessoal
  Left = 0
  Top = 0
  Align = alClient
  Caption = 'Cadastro de Pessoal'
  ClientHeight = 552
  ClientWidth = 782
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
  object Label5: TLabel
    Left = 665
    Top = 24
    Width = 33
    Height = 15
    Caption = 'Ident.:'
  end
  object Label2: TLabel
    Left = 449
    Top = 24
    Width = 39
    Height = 15
    Caption = 'C'#243'digo'
  end
  object Label3: TLabel
    Left = 37
    Top = 64
    Width = 71
    Height = 15
    Caption = 'Em atividade:'
  end
  object Label4: TLabel
    Left = 354
    Top = 64
    Width = 70
    Height = 15
    Caption = 'Observa'#231#245'es:'
  end
  object gdRec: TDBGrid
    Left = 0
    Top = 152
    Width = 782
    Height = 400
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dsRec
    ReadOnly = True
    TabOrder = 5
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
        FieldName = 'cod'
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descr'
        Title.Caption = 'Nome Completo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ativo'
        Title.Caption = 'Ativo'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'id_loc'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'obs'
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
    TextHint = '(Nome Completo)'
  end
  object edID: TEdit
    Left = 704
    Top = 21
    Width = 65
    Height = 23
    TabStop = False
    Alignment = taRightJustify
    ReadOnly = True
    TabOrder = 2
  end
  object edCod: TEdit
    Left = 504
    Top = 21
    Width = 121
    Height = 23
    MaxLength = 8
    TabOrder = 1
    TextHint = '(C'#243'digo)'
    OnKeyPress = edENTER_KeyPress
  end
  object cbAtivo: TComboBox
    Left = 120
    Top = 61
    Width = 145
    Height = 23
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 3
    Text = 'Sim'
    Items.Strings = (
      'Sim'
      'N'#227'o'
      'Suspenso'
      'Afastado'
      'Atestado')
  end
  object edObs: TMemo
    Left = 440
    Top = 57
    Width = 329
    Height = 89
    TabOrder = 4
  end
  object dsRec: TDataSource
    DataSet = qyRec
    Left = 115
    Top = 206
  end
  object qyRec: TFDQuery
    Connection = DM.DBCON
    SQL.Strings = (
      'select * from tbPessoal')
    Left = 203
    Top = 231
    object qyRecid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qyReccod: TWideStringField
      FieldName = 'cod'
      Origin = 'cod'
    end
    object qyRecdescr: TWideStringField
      FieldName = 'descr'
      Origin = 'descr'
      Size = 50
    end
    object qyRecobs: TWideStringField
      FieldName = 'obs'
      Origin = 'obs'
      Size = 255
    end
    object qyRecid_loc: TIntegerField
      FieldName = 'id_loc'
      Origin = 'id_loc'
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
      Size = 500
    end
  end
end
