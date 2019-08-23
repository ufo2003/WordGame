object Form_tihuan: TForm_tihuan
  Left = 241
  Top = 239
  Width = 524
  Height = 382
  Caption = #25209#37327#26367#25442
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 32
    Width = 65
    Height = 13
    Caption = #24320#22987#22330#26223#65306
  end
  object Label2: TLabel
    Left = 248
    Top = 32
    Width = 65
    Height = 13
    Caption = #32467#26463#22330#26223#65306
  end
  object Label3: TLabel
    Left = 48
    Top = 80
    Width = 65
    Height = 13
    Caption = #26597#25214#20869#23481#65306
  end
  object Label4: TLabel
    Left = 48
    Top = 176
    Width = 52
    Height = 13
    Caption = #26367#25442#20026#65306
  end
  object Label5: TLabel
    Left = 184
    Top = 288
    Width = 42
    Height = 13
    Caption = 'Label5'
  end
  object Edit1: TEdit
    Left = 112
    Top = 24
    Width = 81
    Height = 21
    TabOrder = 0
    Text = '10000'
  end
  object Edit2: TEdit
    Left = 320
    Top = 24
    Width = 81
    Height = 21
    TabOrder = 1
    Text = '15000'
  end
  object CheckBox1: TCheckBox
    Left = 48
    Top = 288
    Width = 113
    Height = 17
    Caption = #26367#25442#21069#20808#30830#35748
    Checked = True
    State = cbChecked
    TabOrder = 2
  end
  object Memo1: TMemo
    Left = 128
    Top = 80
    Width = 297
    Height = 89
    TabOrder = 3
  end
  object Memo2: TMemo
    Left = 128
    Top = 176
    Width = 297
    Height = 89
    TabOrder = 4
  end
  object Button1: TButton
    Left = 312
    Top = 280
    Width = 75
    Height = 25
    Caption = #24320#22987#26367#25442
    TabOrder = 5
    OnClick = Button1Click
  end
  object Button3: TButton
    Left = 312
    Top = 304
    Width = 75
    Height = 25
    Caption = #20572#27490
    TabOrder = 6
    OnClick = Button3Click
  end
  object Button2: TButton
    Left = 216
    Top = 304
    Width = 75
    Height = 25
    Caption = #32487#32493
    Enabled = False
    TabOrder = 7
    OnClick = Button2Click
  end
  object Button4: TButton
    Left = 128
    Top = 304
    Width = 75
    Height = 25
    Caption = #25552#21462#23383#31526#20018
    TabOrder = 8
    OnClick = Button4Click
  end
  object CheckBox2: TCheckBox
    Left = 48
    Top = 312
    Width = 73
    Height = 17
    Caption = #33258#21160#25552#21462
    TabOrder = 9
  end
  object Button5: TButton
    Left = 216
    Top = 48
    Width = 185
    Height = 25
    Hint = #36941#21382#20840#37096#22330#26223#25991#20214#65292#37325#26032#20570#22330#26223#21517#31216#21644#32534#21495#30340#23545#24212#34920#65292#29992#20110#23548#33322
    Caption = #37325#20570#22330#26223#21517#31216#21644#32534#21495#23545#24212#34920
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    OnClick = Button5Click
  end
end
