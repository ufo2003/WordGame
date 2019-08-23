object Form_goods: TForm_goods
  Left = 48
  Top = 78
  Caption = #35013#22791#12289#27494#22120#12289#29289#21697
  ClientHeight = 590
  ClientWidth = 927
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 385
    Height = 412
    Caption = #20154#29289#23646#24615
    TabOrder = 0
    object ListBox2: TListBox
      Left = 2
      Top = 15
      Width = 381
      Height = 395
      Style = lbOwnerDrawVariable
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
      OnDrawItem = ListBox2DrawItem
      OnMeasureItem = ListBox2MeasureItem
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 432
    Width = 385
    Height = 145
    Caption = #20154#29289#21015#34920
    TabOrder = 1
    object ListBox1: TListBox
      Left = 2
      Top = 15
      Width = 381
      Height = 128
      Style = lbOwnerDrawVariable
      Align = alClient
      DragMode = dmAutomatic
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 0
      OnClick = ListBox1Click
      OnDragDrop = ListBox1DragDrop
      OnDragOver = ListBox1DragOver
      OnDrawItem = ListBox1DrawItem
      OnMeasureItem = ListBox1MeasureItem
      OnMouseDown = ListBox1MouseDown
      OnMouseUp = ListBox1MouseUp
    end
  end
  object PageControl1: TPageControl
    Left = 384
    Top = 8
    Width = 545
    Height = 569
    ActivePage = TabSheet5
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = #27494#22120
      object Label1: TLabel
        Left = 8
        Top = 8
        Width = 172
        Height = 13
        Caption = #32534#21495'  '#21517#31216'  '#25968#37327'  '#35814#32454#20171#32461
      end
      object ListBox3: TListBox
        Left = 0
        Top = 24
        Width = 537
        Height = 441
        Style = lbOwnerDrawVariable
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = #40657#20307
        Font.Style = []
        ItemHeight = 16
        ParentFont = False
        TabOrder = 0
        OnDblClick = Button1Click
        OnDrawItem = ListBox3DrawItem
        OnMeasureItem = ListBox3MeasureItem
        OnMouseMove = ListBox3MouseMove
      end
      object Button1: TButton
        Left = 8
        Top = 480
        Width = 137
        Height = 25
        Caption = #35013#22791#25152#36873#27494#22120
        TabOrder = 1
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 160
        Top = 480
        Width = 129
        Height = 25
        Caption = #21368#36733#29616#25345#27494#22120
        TabOrder = 2
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 304
        Top = 480
        Width = 137
        Height = 25
        Caption = #25172#25481#25152#36873#27494#22120
        TabOrder = 3
        OnClick = Button3Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = #35013#22791
      ImageIndex = 1
      object Label2: TLabel
        Left = 8
        Top = 8
        Width = 172
        Height = 13
        Caption = #32534#21495'  '#21517#31216'  '#25968#37327'  '#35814#32454#20171#32461
      end
      object ListBox4: TListBox
        Left = 0
        Top = 32
        Width = 537
        Height = 441
        Style = lbOwnerDrawVariable
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = #40657#20307
        Font.Style = []
        ItemHeight = 16
        ParentFont = False
        TabOrder = 0
        OnDblClick = Button4Click
        OnDrawItem = ListBox3DrawItem
        OnMeasureItem = ListBox3MeasureItem
        OnMouseMove = ListBox3MouseMove
      end
      object Button4: TButton
        Left = 8
        Top = 480
        Width = 137
        Height = 25
        Caption = #31359#25140#25152#36873#35013#22791
        TabOrder = 1
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 160
        Top = 480
        Width = 129
        Height = 25
        Caption = #33073#31163#24050#31359#35013#22791
        TabOrder = 2
        OnClick = Button5Click
      end
      object Button6: TButton
        Left = 304
        Top = 480
        Width = 137
        Height = 25
        Caption = #25172#25481#25152#36873#35013#22791
        TabOrder = 3
        OnClick = Button6Click
      end
    end
    object TabSheet3: TTabSheet
      Caption = #21487#28040#32791#29289#21697
      ImageIndex = 2
      object Label3: TLabel
        Left = 8
        Top = 8
        Width = 172
        Height = 13
        Caption = #32534#21495'  '#21517#31216'  '#25968#37327'  '#35814#32454#20171#32461
      end
      object ListBox5: TListBox
        Left = 0
        Top = 32
        Width = 537
        Height = 441
        Style = lbOwnerDrawVariable
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = []
        ItemHeight = 16
        ParentFont = False
        TabOrder = 0
        OnDblClick = Button7Click
        OnDrawItem = ListBox3DrawItem
        OnMeasureItem = ListBox3MeasureItem
        OnMouseMove = ListBox3MouseMove
      end
      object Button7: TButton
        Left = 8
        Top = 480
        Width = 137
        Height = 25
        Caption = #20351#29992#25152#36873#29289#21697
        TabOrder = 1
        OnClick = Button7Click
      end
      object Button8: TButton
        Left = 160
        Top = 480
        Width = 129
        Height = 25
        Caption = #21368#36733#29616#25345#27494#22120
        TabOrder = 2
        Visible = False
      end
      object Button9: TButton
        Left = 304
        Top = 480
        Width = 137
        Height = 25
        Caption = #25172#25481#25152#36873#29289#21697
        TabOrder = 3
        OnClick = Button9Click
      end
    end
    object TabSheet4: TTabSheet
      Caption = #20918#28860#21407#26009
      ImageIndex = 3
      object Label4: TLabel
        Left = 8
        Top = 8
        Width = 172
        Height = 13
        Caption = #32534#21495'  '#21517#31216'  '#25968#37327'  '#35814#32454#20171#32461
      end
      object ListBox6: TListBox
        Left = 0
        Top = 32
        Width = 537
        Height = 441
        Style = lbOwnerDrawVariable
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = []
        ItemHeight = 16
        ParentFont = False
        TabOrder = 0
        OnDrawItem = ListBox3DrawItem
        OnMeasureItem = ListBox3MeasureItem
        OnMouseMove = ListBox3MouseMove
      end
      object Button10: TButton
        Left = 8
        Top = 480
        Width = 137
        Height = 25
        Caption = #35013#22791#25152#36873#27494#22120
        TabOrder = 1
        Visible = False
      end
      object Button11: TButton
        Left = 160
        Top = 480
        Width = 129
        Height = 25
        Caption = #21368#36733#29616#25345#27494#22120
        TabOrder = 2
        Visible = False
      end
      object Button12: TButton
        Left = 304
        Top = 480
        Width = 137
        Height = 25
        Caption = #25172#25481#25152#36873#21407#26009
        TabOrder = 3
        OnClick = Button12Click
      end
    end
    object TabSheet5: TTabSheet
      Caption = #29305#27530#29289#21697
      ImageIndex = 4
      object Label5: TLabel
        Left = 8
        Top = 8
        Width = 172
        Height = 13
        Caption = #32534#21495'  '#21517#31216'  '#25968#37327'  '#35814#32454#20171#32461
      end
      object ListBox7: TListBox
        Left = 0
        Top = 32
        Width = 537
        Height = 441
        Style = lbOwnerDrawVariable
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = #40657#20307
        Font.Style = []
        ItemHeight = 16
        ParentFont = False
        TabOrder = 0
        OnClick = ListBox7Click
        OnDblClick = ListBox7DblClick
        OnDrawItem = ListBox3DrawItem
        OnMeasureItem = ListBox3MeasureItem
        OnMouseMove = ListBox3MouseMove
      end
      object Button13: TButton
        Left = 8
        Top = 480
        Width = 137
        Height = 25
        Caption = #20351#29992#25152#36873#29289#21697
        TabOrder = 1
        OnClick = Button13Click
      end
      object Button14: TButton
        Left = 160
        Top = 480
        Width = 129
        Height = 25
        Caption = #23398#20064#35813#25216#33021
        TabOrder = 2
        OnClick = Button14Click
      end
      object Button15: TButton
        Left = 304
        Top = 480
        Width = 137
        Height = 25
        Caption = #25172#25481#25152#36873#29289#21697
        TabOrder = 3
        OnClick = Button15Click
      end
    end
    object TabSheet6: TTabSheet
      Caption = #25216#33021
      ImageIndex = 5
      object ListBox8: TListBox
        Left = 0
        Top = 16
        Width = 537
        Height = 441
        Style = lbOwnerDrawVariable
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = []
        ItemHeight = 16
        ParentFont = False
        TabOrder = 0
        OnDrawItem = ListBox3DrawItem
        OnMeasureItem = ListBox3MeasureItem
        OnMouseMove = ListBox3MouseMove
      end
    end
    object TabSheet7: TTabSheet
      Caption = #20185#26415
      ImageIndex = 6
      object ListBox9: TListBox
        Left = 0
        Top = 16
        Width = 537
        Height = 441
        Style = lbOwnerDrawVariable
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = []
        ItemHeight = 16
        ParentFont = False
        TabOrder = 0
        OnDrawItem = ListBox3DrawItem
        OnMeasureItem = ListBox3MeasureItem
        OnMouseMove = ListBox3MouseMove
      end
    end
    object TabSheet8: TTabSheet
      Caption = #32852#32593#20449#24687
      ImageIndex = 7
      OnShow = TabSheet8Show
    end
  end
  object CheckBox1: TCheckBox
    Left = 280
    Top = 416
    Width = 97
    Height = 17
    Hint = #36873#20013#27492#23646#24615#65292#37027#20040#35813#20154#29289#19981#20250#26174#31034#22312#25112#26007#30028#38754#20013#65292#24403#28982#20063#20998#19981#21040#32463#39564#20540#12290
    Caption = #25112#26007#26102#38544#34255
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = CheckBox1Click
  end
  object Button16: TButton
    Left = 200
    Top = 416
    Width = 75
    Height = 19
    Caption = #36716#31227#37329#38065
    TabOrder = 4
    OnClick = Button16Click
  end
  object Button17: TButton
    Left = 120
    Top = 416
    Width = 75
    Height = 19
    Caption = #26356#25913#22836#20687
    TabOrder = 5
    OnClick = Button17Click
  end
  object PopupMenu1: TPopupMenu
    Left = 168
    Top = 464
    object N1: TMenuItem
      Caption = #20174#22270#29255#25991#20214#33719#21462#22836#20687
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #20174#21098#36148#26495#33719#21462#22836#20687
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #20174#23631#24149#25335#36125
      OnClick = N3Click
    end
  end
end
