object Form_password: TForm_password
  Left = 254
  Top = 238
  Width = 415
  Height = 341
  Caption = #21152#23494#21644#39640#32423#36873#39033
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 385
    Height = 113
    Caption = #20445#23384#25991#20214#26102
    TabOrder = 0
    object Label1: TLabel
      Left = 168
      Top = 24
      Width = 26
      Height = 13
      Caption = #23494#30721
    end
    object Label2: TLabel
      Left = 168
      Top = 56
      Width = 65
      Height = 13
      Caption = #30830#35748#23494#30721#65306
    end
    object RadioButton1: TRadioButton
      Left = 16
      Top = 32
      Width = 113
      Height = 17
      Caption = #33258#21160#21152#23494#25991#26723
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object RadioButton2: TRadioButton
      Left = 16
      Top = 56
      Width = 129
      Height = 17
      Caption = #24635#26159#35810#38382#26159#21542#21152#23494
      TabOrder = 1
    end
    object Edit1: TEdit
      Left = 240
      Top = 24
      Width = 121
      Height = 21
      PasswordChar = '*'
      TabOrder = 2
    end
    object Edit2: TEdit
      Left = 240
      Top = 56
      Width = 121
      Height = 21
      PasswordChar = '*'
      TabOrder = 3
    end
    object RadioButton5: TRadioButton
      Left = 16
      Top = 80
      Width = 113
      Height = 17
      Caption = #19981#21152#23494
      TabOrder = 4
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 128
    Width = 385
    Height = 81
    Caption = #25171#24320#25991#20214#26102
    TabOrder = 1
    object Label3: TLabel
      Left = 168
      Top = 24
      Width = 39
      Height = 13
      Caption = #23494#30721#65306
    end
    object RadioButton3: TRadioButton
      Left = 24
      Top = 24
      Width = 113
      Height = 17
      Caption = #33258#21160#35299#23494
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object RadioButton4: TRadioButton
      Left = 24
      Top = 48
      Width = 113
      Height = 17
      Caption = #25163#24037#36755#20837#23494#30721
      TabOrder = 1
    end
    object Edit3: TEdit
      Left = 240
      Top = 24
      Width = 121
      Height = 21
      PasswordChar = '*'
      TabOrder = 2
    end
  end
  object Button1: TButton
    Left = 208
    Top = 264
    Width = 75
    Height = 25
    Caption = #30830#23450
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 312
    Top = 264
    Width = 75
    Height = 25
    Caption = #21462#28040
    TabOrder = 3
    OnClick = Button2Click
  end
  object CheckBox1: TCheckBox
    Left = 32
    Top = 216
    Width = 145
    Height = 17
    Caption = #21551#21160#26102#26174#31034#31354#30333#39029#38754
    TabOrder = 4
  end
  object Button3: TButton
    Left = 296
    Top = 232
    Width = 97
    Height = 25
    Hint = #29992#20110#21152#23494#28216#25103#26102#65292#22312#28216#25103#30340'dat'#25991#20214#22841#19979#30340'set'#25991#20214#20869#65292#21542#21017#65292#36733#20837#28216#25103#20250#26174#31034'crc'#38169#35823
    Caption = #33719#21462'game_id'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = Button3Click
  end
  object Edit4: TEdit
    Left = 16
    Top = 240
    Width = 273
    Height = 21
    TabOrder = 6
  end
end
