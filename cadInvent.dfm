object fInvent: TfInvent
  Left = 0
  Top = 0
  Align = alClient
  Caption = 'Cadastro de Bens e Materiais'
  ClientHeight = 553
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
  object pcInv: TPageControl
    Left = 0
    Top = 0
    Width = 782
    Height = 337
    ActivePage = tsCad
    Align = alTop
    TabOrder = 0
    object tsCad: TTabSheet
      Caption = 'Dados do Cadastro'
      object Label1: TLabel
        Left = 8
        Top = 16
        Width = 54
        Height = 15
        Caption = 'Descri'#231#227'o:'
      end
      object Label5: TLabel
        Left = 665
        Top = 16
        Width = 33
        Height = 15
        Caption = 'Ident.:'
      end
      object Label2: TLabel
        Left = 431
        Top = 16
        Width = 39
        Height = 15
        Caption = 'C'#243'digo'
      end
      object Label3: TLabel
        Left = 8
        Top = 60
        Width = 60
        Height = 15
        Caption = 'Ativo ('#218'til):'
      end
      object Label4: TLabel
        Left = 400
        Top = 192
        Width = 70
        Height = 15
        Caption = 'Observa'#231#245'es:'
      end
      object Label6: TLabel
        Left = 256
        Top = 60
        Width = 54
        Height = 15
        Caption = 'Categoria:'
      end
      object Label7: TLabel
        Left = 8
        Top = 103
        Width = 80
        Height = 15
        Caption = 'Dt. da Compra:'
      end
      object Label8: TLabel
        Left = 238
        Top = 103
        Width = 91
        Height = 15
        Caption = 'Valor de Compra:'
      end
      object Label9: TLabel
        Left = 8
        Top = 146
        Width = 88
        Height = 15
        Caption = 'Vida '#218'till (Anos):'
      end
      object Label10: TLabel
        Left = 476
        Top = 103
        Width = 71
        Height = 15
        Caption = 'Conserva'#231#227'o:'
      end
      object Label11: TLabel
        Left = 192
        Top = 146
        Width = 135
        Height = 15
        Caption = 'Valor Depreciado (Linear):'
      end
      object Label13: TLabel
        Left = 8
        Top = 192
        Width = 91
        Height = 15
        Caption = #218'lt. Manuten'#231#227'o:'
      end
      object Label14: TLabel
        Left = 8
        Top = 236
        Width = 64
        Height = 15
        Caption = 'Localiza'#231#227'o:'
      end
      object edDESCR: TEdit
        Left = 80
        Top = 13
        Width = 305
        Height = 23
        TabOrder = 0
        TextHint = '(Descri'#231#227'o)'
      end
      object edID: TEdit
        Left = 704
        Top = 13
        Width = 65
        Height = 23
        TabStop = False
        Alignment = taRightJustify
        ReadOnly = True
        TabOrder = 2
      end
      object edCod: TEdit
        Left = 476
        Top = 13
        Width = 121
        Height = 23
        MaxLength = 8
        TabOrder = 1
        TextHint = '(C'#243'digo)'
        OnKeyPress = edENTER_KeyPress
      end
      object cbAtivo: TComboBox
        Left = 80
        Top = 57
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
      object edOBS: TMemo
        Left = 476
        Top = 189
        Width = 295
        Height = 115
        TabOrder = 12
      end
      object cbIDCAT: TMyComboBox
        Left = 328
        Top = 57
        Width = 433
        Height = 23
        Style = csDropDownList
        TabOrder = 4
      end
      object edDTCOM: TcxDateEdit
        Left = 103
        Top = 100
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = 'dd/mm/yyyy'
        Properties.SaveTime = False
        Properties.ShowTime = False
        TabOrder = 5
        Width = 121
      end
      object edVLCOM: TcxCalcEdit
        Left = 335
        Top = 100
        EditValue = 0.000000000000000000
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0.00'
        Properties.Nullstring = '0'
        TabOrder = 6
        Width = 121
      end
      object edVIDUTIL: TcxSpinEdit
        Left = 102
        Top = 143
        TabOrder = 8
        Width = 75
      end
      object cbSITUA: TComboBox
        Left = 553
        Top = 100
        Width = 145
        Height = 23
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 7
        Text = 'Bom'
        Items.Strings = (
          'Bom'
          'Regular'
          'Ruim')
      end
      object edVLDEP: TEdit
        Left = 335
        Top = 143
        Width = 121
        Height = 23
        TabOrder = 9
      end
      object edDTMAN: TcxDateEdit
        Left = 105
        Top = 189
        Properties.Alignment.Horz = taRightJustify
        Properties.ClearKey = 46
        Properties.DateButtons = [btnClear, btnToday]
        Properties.DateOnError = deNull
        Properties.DisplayFormat = 'dd/mm/yyyy'
        Properties.SaveTime = False
        Properties.ShowTime = False
        TabOrder = 10
        Width = 121
      end
      object cbIDLOC: TMyComboBox
        Left = 80
        Top = 233
        Width = 376
        Height = 23
        Style = csDropDownList
        TabOrder = 11
        OnKeyPress = edENTER_KeyPress
      end
    end
    object tsHist: TTabSheet
      Caption = 'Hist'#243'rico'
      ImageIndex = 1
    end
  end
  object gdRec: TDBGrid
    Left = 0
    Top = 337
    Width = 782
    Height = 216
    Align = alClient
    DataSource = dsRec
    ReadOnly = True
    TabOrder = 1
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
        Width = 36
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cod'
        Width = 83
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descr'
        Width = 245
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'id_cat'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'categ'
        Width = 210
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'id_local'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'local'
        Width = 210
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'dt_comp'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'vl_comp'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'vid_util'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'obs'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'situa'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'dt_man'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'id_man'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ativo'
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
  object dsRec: TDataSource
    DataSet = qyRec
    Left = 78
    Top = 346
  end
  object qyRec: TFDQuery
    OnCalcFields = qyRecCalcFields
    Connection = DM.DBCON
    SQL.Strings = (
      'select * from tbInvent')
    Left = 171
    Top = 396
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
    object qyRecid_cat: TIntegerField
      FieldName = 'id_cat'
      Origin = 'id_cat'
    end
    object qyRecid_local: TIntegerField
      FieldName = 'id_local'
      Origin = 'id_local'
    end
    object qyRecdt_comp: TDateField
      FieldName = 'dt_comp'
      Origin = 'dt_comp'
    end
    object qyRecvl_comp: TFloatField
      FieldName = 'vl_comp'
      Origin = 'vl_comp'
    end
    object qyRecvid_util: TIntegerField
      FieldName = 'vid_util'
      Origin = 'vid_util'
    end
    object qyRecobs: TWideStringField
      FieldName = 'obs'
      Origin = 'obs'
      Size = 255
    end
    object qyRecsitua: TIntegerField
      FieldName = 'situa'
      Origin = 'situa'
    end
    object qyRecdt_man: TDateField
      FieldName = 'dt_man'
      Origin = 'dt_man'
    end
    object qyRecid_man: TIntegerField
      FieldName = 'id_man'
      Origin = 'id_man'
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
      Size = 1000
    end
    object qyReccateg: TStringField
      FieldKind = fkLookup
      FieldName = 'categ'
      LookupDataSet = DM.qyCat
      LookupKeyFields = 'id'
      LookupResultField = 'descr'
      KeyFields = 'id_cat'
      Size = 50
      Lookup = True
    end
    object qyReclocal: TStringField
      FieldKind = fkLookup
      FieldName = 'local'
      LookupDataSet = DM.qyLoc
      LookupKeyFields = 'id'
      LookupResultField = 'descr'
      KeyFields = 'id_local'
      Size = 50
      Lookup = True
    end
  end
end
