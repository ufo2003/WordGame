object Form_scene_option: TForm_scene_option
  Left = 242
  Top = 275
  Width = 559
  Height = 376
  Caption = #22330#26223#23646#24615
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 448
    Top = 224
    Width = 57
    Height = 17
    Cursor = crHandPoint
    AutoSize = False
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentColor = False
    ParentFont = False
    OnClick = Label1Click
  end
  object Label2: TLabel
    Left = 248
    Top = 224
    Width = 57
    Height = 17
    Cursor = crHandPoint
    AutoSize = False
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentColor = False
    ParentFont = False
    OnClick = Label1Click
  end
  object Label3: TLabel
    Left = 248
    Top = 256
    Width = 57
    Height = 17
    Cursor = crHandPoint
    AutoSize = False
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentColor = False
    ParentFont = False
    OnClick = Label1Click
  end
  object Label4: TLabel
    Left = 248
    Top = 280
    Width = 57
    Height = 17
    Cursor = crHandPoint
    AutoSize = False
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentColor = False
    ParentFont = False
    OnClick = Label1Click
  end
  object Label5: TLabel
    Left = 448
    Top = 256
    Width = 57
    Height = 17
    Cursor = crHandPoint
    AutoSize = False
    Color = clWindowText
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentColor = False
    ParentFont = False
    OnClick = Label1Click
  end
  object Button1: TButton
    Left = 336
    Top = 296
    Width = 75
    Height = 25
    Caption = #20445#23384
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 440
    Top = 296
    Width = 75
    Height = 25
    Caption = #21462#28040
    TabOrder = 1
    OnClick = Button2Click
  end
  object CheckBox_mi: TCheckBox
    Left = 152
    Top = 8
    Width = 57
    Height = 17
    Hint = #36873#20013#27492#23646#24615#65292#34920#31034#36827#20837#20102#36855#23467#65292#19968#20123#21151#33021#23558#34987#38480#21046#65292#27604#22914#19981#33021#38543#24847#23384#30424#12290
    Caption = #36855#23467
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
  end
  object CheckBox_temp: TCheckBox
    Left = 16
    Top = 8
    Width = 97
    Height = 17
    Hint = #40664#35748#36733#20837#22330#26223#26102#37117#20250#28165#38500#20020#26102#34920#65292#22914#26524#36873#20013#27492#23646#24615#65292#37027#20040#35813#22330#26223#36733#20837#26102#23558#20445#30041#21069#19968#22330#26223#30340#20020#26102#34920#20869#23481
    Caption = #19981#28165#38500#20020#26102#34920
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
  end
  object CheckBox_notstop: TCheckBox
    Left = 240
    Top = 8
    Width = 113
    Height = 17
    Hint = #36873#20013#27492#23646#24615#65292#34920#31034#27492#22330#26223#37324#30340#23545#35805#24517#39035#35828#23436#65292#19981#33021#20013#36884#34987#25171#26029#12290
    Caption = #19981#20801#35768#32467#26463#23545#35805
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
  end
  object CheckBox_after: TCheckBox
    Left = 16
    Top = 80
    Width = 97
    Height = 17
    Hint = #36825#20123#22312#22330#26223#36733#20837#21518#25191#34892#12290
    Caption = #36733#20837#21518#21160#20316
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = CheckBox_afterClick
  end
  object CheckBox_before: TCheckBox
    Left = 16
    Top = 56
    Width = 97
    Height = 17
    Hint = #36873#20013#27492#23646#24615#65292#21487#22312#22330#26223#36733#20837#21069#25191#34892#19968#20123#20989#25968#12290
    Caption = #36733#20837#21069#21160#20316
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = CheckBox_beforeClick
  end
  object Edit1: TEdit
    Left = 120
    Top = 56
    Width = 385
    Height = 21
    Enabled = False
    TabOrder = 7
  end
  object Edit2: TEdit
    Left = 120
    Top = 80
    Width = 385
    Height = 21
    Enabled = False
    TabOrder = 8
  end
  object CheckBox_b_pic: TCheckBox
    Left = 16
    Top = 136
    Width = 97
    Height = 17
    Hint = #21487#20197#20026#22330#26223#28155#21152#32972#26223#22270
    Caption = #32972#26223#22270#20687
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = CheckBox_b_picClick
  end
  object CheckBox_b_sound: TCheckBox
    Left = 16
    Top = 184
    Width = 97
    Height = 17
    Hint = #22330#26223#30340#32972#26223#38899#20048
    Caption = #32972#26223#38899#20048
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    OnClick = CheckBox_b_soundClick
  end
  object Edit3: TEdit
    Left = 120
    Top = 136
    Width = 305
    Height = 21
    Enabled = False
    TabOrder = 11
  end
  object Edit4: TEdit
    Left = 120
    Top = 184
    Width = 249
    Height = 21
    Enabled = False
    TabOrder = 12
    OnChange = Edit4Change
  end
  object Button3: TButton
    Left = 432
    Top = 136
    Width = 75
    Height = 25
    Caption = #27983#35272#8230#8230
    Enabled = False
    TabOrder = 13
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 432
    Top = 184
    Width = 75
    Height = 25
    Caption = #27983#35272#8230#8230
    Enabled = False
    TabOrder = 14
    OnClick = Button4Click
  end
  object CheckBox_color: TCheckBox
    Left = 336
    Top = 224
    Width = 97
    Height = 17
    Hint = #22330#26223#30340#32972#26223#39068#33394
    Caption = #32972#26223#39068#33394
    ParentShowHint = False
    ShowHint = True
    TabOrder = 15
  end
  object CheckBox_link: TCheckBox
    Left = 120
    Top = 224
    Width = 97
    Height = 17
    Hint = #22914#27442#35774#32622#22330#26223#20869#30340#36229#38142#25509#39068#33394#65292#35831#36873#20013#27492#22788#12290
    Caption = #36229#38142#25509#39068#33394
    ParentShowHint = False
    ShowHint = True
    TabOrder = 16
  end
  object CheckBox_alink: TCheckBox
    Left = 120
    Top = 256
    Width = 121
    Height = 17
    Hint = #24403#40736#26631#31227#21160#21040#36229#38142#25509#19978#26102#20505#26174#31034#30340#25991#23383#39068#33394#12290
    Caption = #40736#26631#28608#27963#26102#39068#33394
    ParentShowHint = False
    ShowHint = True
    TabOrder = 17
  end
  object CheckBox_vlink: TCheckBox
    Left = 120
    Top = 280
    Width = 97
    Height = 17
    Hint = #24050#32463#28857#20987#36807#30340#36229#38142#25509#39068#33394
    Caption = #38142#25509#24050#28857#20987#39068#33394
    ParentShowHint = False
    ShowHint = True
    TabOrder = 18
  end
  object Button5: TButton
    Left = 376
    Top = 184
    Width = 49
    Height = 25
    Caption = #35797#21548
    Enabled = False
    TabOrder = 19
    OnClick = Button5Click
  end
  object CheckBox_home: TCheckBox
    Left = 392
    Top = 8
    Width = 97
    Height = 17
    Caption = #35774#20026#22238#22478#28857
    TabOrder = 20
  end
  object RadioButton_PP: TRadioButton
    Tag = 1
    Left = 160
    Top = 160
    Width = 113
    Height = 17
    Hint = #32972#26223#22270#26174#31034#23646#24615
    Caption = #24179#38138
    ParentShowHint = False
    ShowHint = True
    TabOrder = 21
  end
  object RadioButton_LS: TRadioButton
    Tag = 1
    Left = 32
    Top = 160
    Width = 113
    Height = 17
    Hint = #32972#26223#22270#26174#31034#23646#24615
    Caption = #25289#20280
    ParentShowHint = False
    ShowHint = True
    TabOrder = 22
  end
  object RadioButton_GD: TRadioButton
    Tag = 1
    Left = 288
    Top = 160
    Width = 113
    Height = 17
    Hint = #32972#26223#22270#26174#31034#23646#24615
    Caption = #22266#23450
    Checked = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 23
    TabStop = True
  end
  object CheckBox_tuichu: TCheckBox
    Left = 16
    Top = 112
    Width = 97
    Height = 17
    Hint = #36825#26159#22312#22330#26223#39029#38754#36864#20986#65288#20999#25442#65289#26102#25191#34892#30340#21160#20316
    Caption = #36864#20986#26102#21160#20316
    TabOrder = 24
    OnClick = CheckBox_tuichuClick
  end
  object Edit5: TEdit
    Left = 120
    Top = 104
    Width = 385
    Height = 21
    Enabled = False
    TabOrder = 25
  end
  object CheckBox_not_down_img: TCheckBox
    Left = 152
    Top = 32
    Width = 97
    Height = 17
    Hint = #19981#22312#24403#21069#39029#38754#26174#31034#26681#25454#20851#38190#23383#19979#36733#30340#22270#29255
    Caption = #19981#26174#31034#19979#36733#22270
    ParentShowHint = False
    ShowHint = True
    TabOrder = 26
  end
  object CheckBox_text: TCheckBox
    Left = 336
    Top = 256
    Width = 97
    Height = 17
    Caption = #25991#26412#39068#33394
    TabOrder = 27
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 
      #20840#37096#22270#29255#31867#22411'|*.*|png|*.png|Icons (*.ico)|*.ico|GIF Image (*.gif)|*.gif' +
      '|JPEG Image File (*.jpg)|*.jpg|JPEG Image File (*.jpeg)|*.jpeg|B' +
      'itmaps (*.bmp)|*.bmp'
    Left = 16
    Top = 224
  end
  object OpenDialog1: TOpenDialog
    Filter = 'midi'#25991#20214'|*.mid|wav'#25991#20214'|*.wav|mp3'#25991#20214'|*.mp3|'#20840#37096#25991#20214'|*.*'
    Left = 64
    Top = 224
  end
  object ColorDialog1: TColorDialog
    Ctl3D = True
    Left = 24
    Top = 256
  end
end
