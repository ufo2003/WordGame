object Form_gpic: TForm_gpic
  Left = 207
  Top = 106
  Width = 617
  Height = 525
  Caption = #20869#32852#22270#29255#32534#36753
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 409
    Height = 65
    AutoSize = False
    Caption = 
      #35828#26126#65306#20869#32852#22270#29255#26159#19968#31181#25226#25991#23383#30452#25509#36716#25442#20026'jpg'#22270#29255#65292#20351#20854#21487#20197#29992#26469#20570#32972#26223#22270#65292#25110#32773#22312#22330#26223#20869#24341#29992#12290#36825#20123#22270#29255#22312#20869#23384#21512#25104#65292#28982#21518#36890#36807#8220'gpic'#8221 +
      #33258#23450#20041#21327#35758#34987#27983#35272#22120#30452#25509#36733#20837#65292#19981#20250#22312#30828#30424#19978#20135#29983#20020#26102#25991#20214#12290
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label2: TLabel
    Left = 144
    Top = 184
    Width = 38
    Height = 19
    Cursor = crHandPoint
    Hint = #28857#20987#20462#25913#36755#20986#25991#23383#30340#23383#20307
    Caption = #23383#20307
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = Label2Click
  end
  object Label3: TLabel
    Left = 8
    Top = 184
    Width = 57
    Height = 19
    Cursor = crHandPoint
    Hint = #28857#20987#20462#25913#36755#20986#25991#23383#30340#32972#26223#33394
    Caption = #32972#26223#33394
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = Label3Click
  end
  object Label4: TLabel
    Left = 8
    Top = 80
    Width = 39
    Height = 13
    Caption = #25991#23383#65306
  end
  object Label5: TLabel
    Left = 8
    Top = 112
    Width = 26
    Height = 13
    Caption = #23485#65306
  end
  object Label6: TLabel
    Left = 144
    Top = 112
    Width = 26
    Height = 13
    Caption = #39640#65306
  end
  object Label7: TLabel
    Left = 264
    Top = 112
    Width = 52
    Height = 13
    Caption = #36879#26126#24230#65306
  end
  object Label8: TLabel
    Left = 8
    Top = 152
    Width = 65
    Height = 13
    Caption = #26174#31034#25928#26524#65306
  end
  object Label9: TLabel
    Left = 368
    Top = 112
    Width = 7
    Height = 13
    Caption = '%'
  end
  object Label10: TLabel
    Left = 8
    Top = 280
    Width = 91
    Height = 13
    Caption = #36873#25321#37197#32622#27169#26495#65306
  end
  object Edit1: TEdit
    Left = 48
    Top = 80
    Width = 465
    Height = 21
    Hint = #38656#35201#20197#29305#25928#22270#29255#26174#31034#30340#25991#23383#20869#23481#65292#22914#26524#35201#37197#21512#24341#29992#22270#29255#65292#35831#22312#26368#21069#38754#21152#20837#22270#29255#21517#65292#22270#29255#21482#33021#22312'img'#25991#20214#22841#19979#12290
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnChange = Edit1Change
  end
  object Edit2: TEdit
    Left = 40
    Top = 112
    Width = 81
    Height = 21
    Hint = '0'#34920#31034#25353#32593#39029#23485#24230#65292#21542#21017#35831#35774#32622#20687#32032#20540#65292#27604#22914'300'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    Text = '0'
  end
  object Edit3: TEdit
    Left = 168
    Top = 112
    Width = 81
    Height = 21
    Hint = '0'#34920#31034#25353#32593#39029#39640#24230#65292#21542#21017#35831#35774#32622#20687#32032#20540#65292#27604#22914'200'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Text = '0'
  end
  object Edit4: TEdit
    Left = 320
    Top = 112
    Width = 41
    Height = 21
    Hint = '100'#34920#31034#23436#20840#36879#26126#65292'0'#34920#31034#19981#36879#26126
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    Text = '80'
  end
  object ComboBox1: TComboBox
    Left = 88
    Top = 152
    Width = 145
    Height = 21
    Hint = #38468#21152#22312#25991#23383#19978#30340#26174#31034#29305#25928#65292#22312#28216#25103#36816#34892#20013#26174#31034#12290
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    Text = #26080#25928#26524
    Items.Strings = (
      #26080#25928#26524
      #24102#28176#21464#36718#24275
      #22122#28857
      #27169#31946
      #28176#21464
      #21322#36879#26126
      #21521#21491#19978#20542#26012
      #21521#21491#19979#20542#26012
      #38452#24433
      #36731#24494#21943#28293
      #20013#31561#21943#28293
      #24378#28872#21943#28293
      #26080#28176#21464#36718#24275)
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 248
    Width = 121
    Height = 17
    Hint = #19981#33258#21160#21152#20837'<img '#26631#35760
    Caption = #20165#36755#20986'gpic'#22320#22336
    Checked = True
    ParentShowHint = False
    ShowHint = True
    State = cbChecked
    TabOrder = 5
  end
  object Button1: TButton
    Left = 24
    Top = 384
    Width = 75
    Height = 25
    Caption = #30830#23450
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 24
    Top = 424
    Width = 75
    Height = 25
    Caption = #21462#28040
    TabOrder = 7
    OnClick = Button2Click
  end
  object CheckBox2: TCheckBox
    Left = 8
    Top = 216
    Width = 97
    Height = 17
    Caption = #28014#38613#25928#26524
    TabOrder = 8
  end
  object Button3: TButton
    Left = 520
    Top = 80
    Width = 41
    Height = 25
    Hint = #21487#20197#23558#25991#23383#25490#20026#31446#24335#26174#31034
    Caption = #25490#29256
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = Button3Click
  end
  object ComboBox2: TComboBox
    Left = 8
    Top = 296
    Width = 121
    Height = 21
    Hint = #20197#21069#20445#23384#19979#26469#30340#37197#32622#27169#26495#65292#21253#25324#23383#20307#65292#32972#26223#33394#31561#12290
    Style = csDropDownList
    ItemHeight = 13
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    OnSelect = ComboBox2Select
  end
  object Button4: TButton
    Left = 24
    Top = 320
    Width = 75
    Height = 25
    Hint = #21487#20197#25226#24403#21069#37197#32622#20445#23384#20026#27169#26495#65292#36825#26679#19979#27425#36935#21040#30456#21516#37197#32622#26102#21487#30452#25509#35843#20986#20351#29992#12290
    Caption = #20445#23384#20026#27169#26495
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 560
    Top = 80
    Width = 41
    Height = 25
    Hint = #28155#21152#25991#23383#30340#32972#26223#22270#65292#25110#32773#20165#20351#29992#22270#29255
    Caption = #22270#29255
    ParentShowHint = False
    ShowHint = True
    TabOrder = 12
    OnClick = Button5Click
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MinFontSize = 0
    MaxFontSize = 0
    Left = 96
    Top = 128
  end
  object ColorDialog1: TColorDialog
    Ctl3D = True
    Left = 336
    Top = 168
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 'jpg'#22270#29255' *.jpg|*.jpg|'#25152#26377#25991#20214'|*.*'
    Left = 280
    Top = 168
  end
end
