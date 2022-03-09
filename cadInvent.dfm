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
    Top = 41
    Width = 782
    Height = 304
    ActivePage = tsCad
    Align = alTop
    TabOrder = 1
    object tsCad: TTabSheet
      Caption = 'Dados do Cadastro'
      object Label3: TLabel
        Left = 4
        Top = 152
        Width = 48
        Height = 15
        Caption = 'Situa'#231#227'o:'
      end
      object Label4: TLabel
        Left = 741
        Top = 128
        Width = 24
        Height = 15
        Caption = 'Obs.'
      end
      object Label6: TLabel
        Left = 4
        Top = 20
        Width = 54
        Height = 15
        Caption = 'Categoria:'
      end
      object Label7: TLabel
        Left = 4
        Top = 63
        Width = 80
        Height = 15
        Caption = 'Dt. da Compra:'
      end
      object Label8: TLabel
        Left = 234
        Top = 63
        Width = 91
        Height = 15
        Caption = 'Valor de Compra:'
      end
      object Label9: TLabel
        Left = 4
        Top = 106
        Width = 88
        Height = 15
        Caption = 'Vida '#218'till (Anos):'
      end
      object Label10: TLabel
        Left = 472
        Top = 63
        Width = 71
        Height = 15
        Caption = 'Conserva'#231#227'o:'
      end
      object Label11: TLabel
        Left = 188
        Top = 106
        Width = 135
        Height = 15
        Caption = 'Valor Depreciado (Linear):'
      end
      object Label13: TLabel
        Left = 234
        Top = 152
        Width = 91
        Height = 15
        Caption = #218'lt. Manuten'#231#227'o:'
      end
      object Label14: TLabel
        Left = 4
        Top = 199
        Width = 64
        Height = 15
        Caption = 'Localiza'#231#227'o:'
      end
      object Label12: TLabel
        Left = 4
        Top = 244
        Width = 88
        Height = 15
        Caption = 'Incorporado em:'
      end
      object Label15: TLabel
        Left = 244
        Top = 244
        Width = 41
        Height = 15
        Caption = 'Motivo:'
      end
      object cbAtivo: TComboBox
        Left = 74
        Top = 149
        Width = 145
        Height = 23
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 6
        Text = 'Ativo'
        Items.Strings = (
          'Ativo'
          'Em Manuten'#231#227'o'
          'Em Desuso'
          'Obsoleto'
          'Imprest'#225'vel')
      end
      object edOBS: TMemo
        Left = 472
        Top = 149
        Width = 295
        Height = 115
        TabOrder = 11
      end
      object cbIDCAT: TMyComboBox
        Left = 76
        Top = 17
        Width = 433
        Height = 23
        Style = csDropDownList
        TabOrder = 0
      end
      object edDTCOM: TcxDateEdit
        Left = 99
        Top = 60
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = 'dd/mm/yyyy'
        Properties.SaveTime = False
        Properties.ShowTime = False
        TabOrder = 1
        Width = 121
      end
      object edVLCOM: TcxCalcEdit
        Left = 331
        Top = 60
        EditValue = 0.000000000000000000
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0.00'
        Properties.ImmediatePost = True
        Properties.Nullstring = '0'
        TabOrder = 2
        Width = 121
      end
      object edVIDUTIL: TcxSpinEdit
        Left = 98
        Top = 103
        Properties.ImmediatePost = True
        TabOrder = 4
        Width = 75
      end
      object cbSITUA: TComboBox
        Left = 557
        Top = 60
        Width = 145
        Height = 23
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 3
        Text = 'Bom'
        Items.Strings = (
          'Bom'
          'Regular'
          'Ruim')
      end
      object edVLDEP: TEdit
        Left = 331
        Top = 103
        Width = 121
        Height = 23
        Alignment = taRightJustify
        TabOrder = 5
      end
      object edDTMAN: TcxDateEdit
        Left = 331
        Top = 149
        Properties.Alignment.Horz = taRightJustify
        Properties.ClearKey = 46
        Properties.DateButtons = [btnClear, btnToday]
        Properties.DateOnError = deNull
        Properties.DisplayFormat = 'dd/mm/yyyy'
        Properties.SaveTime = False
        Properties.ShowTime = False
        TabOrder = 7
        Width = 121
      end
      object cbIDLOC: TMyComboBox
        Left = 74
        Top = 196
        Width = 376
        Height = 23
        Style = csDropDownList
        TabOrder = 8
        OnKeyPress = edENTER_KeyPress
      end
      object edDTINCOR: TcxDateEdit
        Left = 101
        Top = 241
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = 'dd/mm/yyyy'
        Properties.ImmediatePost = True
        Properties.SaveTime = False
        Properties.ShowTime = False
        TabOrder = 9
        OnExit = edDTINCORExit
        OnKeyPress = edENTER_KeyPress
        Width = 121
      end
      object cbTPINCOR: TComboBox
        Left = 291
        Top = 241
        Width = 145
        Height = 23
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 10
        Text = 'CADASTRO'
        OnKeyPress = edENTER_KeyPress
        Items.Strings = (
          'CADASTRO'
          'AQUISI'#199#195'O'
          'PERMUTA'
          'TRANSFER'#202'NCIA')
      end
    end
    object tsHist: TTabSheet
      Caption = 'Hist'#243'rico'
      ImageIndex = 1
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 774
        Height = 274
        Align = alClient
        DataSource = dsMov
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'id'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'id_inv'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'tp_reg'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'data'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ds_reg'
            Width = 204
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ds_loc'
            Width = 265
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'id_loc'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'st_ini'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'st_fim'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'nt_reg'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cd_mov'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'valor'
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
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'us_inc'
            Visible = False
          end>
      end
    end
  end
  object gdRec: TDBGrid
    Left = 0
    Top = 345
    Width = 782
    Height = 208
    Align = alClient
    DataSource = dsRec
    ReadOnly = True
    TabOrder = 2
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
        FieldName = 'dt_incor'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'tp_incor'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ativo'
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 782
    Height = 41
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 54
      Height = 15
      Caption = 'Descri'#231#227'o:'
    end
    object Label2: TLabel
      Left = 431
      Top = 16
      Width = 39
      Height = 15
      Caption = 'C'#243'digo'
    end
    object Label5: TLabel
      Left = 665
      Top = 16
      Width = 33
      Height = 15
      Caption = 'Ident.:'
    end
    object edDESCR: TEdit
      Left = 80
      Top = 10
      Width = 305
      Height = 23
      TabOrder = 0
      TextHint = '(Descri'#231#227'o)'
    end
    object edCod: TEdit
      Left = 476
      Top = 10
      Width = 121
      Height = 23
      MaxLength = 8
      TabOrder = 1
      TextHint = '(C'#243'digo)'
      OnKeyPress = edENTER_KeyPress
    end
    object edID: TEdit
      Left = 704
      Top = 10
      Width = 65
      Height = 23
      TabStop = False
      Alignment = taRightJustify
      ReadOnly = True
      TabOrder = 2
    end
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
    Left = 170
    Top = 456
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
    object qyRecdt_incor: TDateField
      FieldName = 'dt_incor'
      Origin = 'dt_incor'
    end
    object qyRectp_incor: TIntegerField
      FieldName = 'tp_incor'
      Origin = 'tp_incor'
    end
  end
  object dsMov: TDataSource
    DataSet = qyMov
    Left = 116
    Top = 163
  end
  object qyMov: TFDQuery
    OnCalcFields = qyMovCalcFields
    Filtered = True
    Connection = DM.DBCON
    SQL.Strings = (
      'select * from plMovimento ORDER BY id_inv, data, tp_reg')
    Left = 212
    Top = 163
    object qyMovid: TFDAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object qyMovid_inv: TIntegerField
      FieldName = 'id_inv'
    end
    object flDSREG: TStringField
      FieldKind = fkCalculated
      FieldName = 'ds_reg'
      Size = 50
      Calculated = True
    end
    object qyMovds_loc: TStringField
      FieldKind = fkLookup
      FieldName = 'ds_loc'
      LookupDataSet = DM.qyLoc
      LookupKeyFields = 'id'
      LookupResultField = 'descr'
      KeyFields = 'id_loc'
      Size = 50
      Lookup = True
    end
    object qyMovid_loc: TIntegerField
      FieldName = 'id_loc'
    end
    object qyMovst_ini: TStringField
      FieldName = 'st_ini'
      FixedChar = True
      Size = 1
    end
    object qyMovst_fim: TStringField
      FieldName = 'st_fim'
      FixedChar = True
      Size = 1
    end
    object qyMovtp_reg: TStringField
      FieldName = 'tp_reg'
      FixedChar = True
      Size = 1
    end
    object qyMovnt_reg: TStringField
      FieldName = 'nt_reg'
      FixedChar = True
      Size = 1
    end
    object qyMovdata: TDateField
      FieldName = 'data'
    end
    object qyMovcd_mov: TIntegerField
      FieldName = 'cd_mov'
    end
    object qyMovobs: TWideStringField
      FieldName = 'obs'
      Size = 255
    end
    object qyMovvalor: TFloatField
      FieldName = 'valor'
    end
    object qyMovdt_inc: TDateField
      FieldName = 'dt_inc'
    end
    object qyMovus_inc: TWideStringField
      FieldName = 'us_inc'
      Size = 8
    end
  end
end
