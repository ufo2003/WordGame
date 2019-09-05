object Form_reg: TForm_reg
  Left = 192
  Top = 107
  Caption = #27880#20876#29992#25143
  ClientHeight = 571
  ClientWidth = 506
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 489
    Height = 153
    Caption = #22522#26412#20449#24687
    TabOrder = 0
    object Label1: TLabel
      Left = 88
      Top = 16
      Width = 72
      Height = 16
      Caption = '*'#29992#25143'ID'#65306
    end
    object Label2: TLabel
      Left = 88
      Top = 72
      Width = 56
      Height = 16
      Caption = '*'#23494#30721#65306
    end
    object Label3: TLabel
      Left = 88
      Top = 48
      Width = 56
      Height = 16
      Caption = '*'#26165#31216#65306
    end
    object Label4: TLabel
      Left = 88
      Top = 97
      Width = 88
      Height = 16
      Caption = '*'#37325#22797#23494#30721#65306
    end
    object Label5: TLabel
      Left = 88
      Top = 121
      Width = 56
      Height = 16
      Caption = '*'#24615#21035#65306
    end
    object Edit1: TEdit
      Left = 184
      Top = 16
      Width = 137
      Height = 24
      Hint = #30331#24405#28216#25103#30340'id'#65292#19968#26086#27880#20876#65292#19981#21487#26356#25913#65292#21482#33021#29992#23383#27597#25968#23383#32452#25104#65292#27604#22914#21487#29992#30005#23376#37038#20214#22320#22336
      MaxLength = 32
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnChange = Edit1Change
      OnKeyPress = Edit1KeyPress
    end
    object Button3: TButton
      Left = 336
      Top = 16
      Width = 105
      Height = 25
      Caption = #26816#27979#29992#25143'ID'
      TabOrder = 1
      OnClick = Button3Click
    end
    object Edit2: TEdit
      Left = 184
      Top = 40
      Width = 137
      Height = 24
      Hint = #38543#24847#65292#19988#21487#38543#26102#26356#25913
      MaxLength = 48
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnKeyPress = Edit1KeyPress
    end
    object Edit3: TEdit
      Left = 184
      Top = 64
      Width = 137
      Height = 24
      MaxLength = 32
      PasswordChar = '*'
      TabOrder = 3
    end
    object Edit4: TEdit
      Left = 184
      Top = 88
      Width = 137
      Height = 24
      MaxLength = 32
      PasswordChar = '*'
      TabOrder = 4
    end
    object ComboBox1: TComboBox
      Left = 184
      Top = 120
      Width = 137
      Height = 24
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 5
      Text = #30007
      Items.Strings = (
        #30007
        #22899)
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 168
    Width = 489
    Height = 329
    Caption = #36873#22635#20449#24687#65288#21487#19981#22635#65289
    TabOrder = 1
    object Label6: TLabel
      Left = 56
      Top = 32
      Width = 80
      Height = 16
      Caption = #23494#30721#38382#39064#65306
    end
    object Label7: TLabel
      Left = 56
      Top = 56
      Width = 80
      Height = 16
      Caption = #23494#30721#31572#26696#65306
    end
    object Label8: TLabel
      Left = 56
      Top = 88
      Width = 80
      Height = 16
      Caption = #30495#23454#22995#21517#65306
    end
    object Label9: TLabel
      Left = 304
      Top = 88
      Width = 48
      Height = 16
      Caption = #24180#40836#65306
    end
    object Label10: TLabel
      Left = 56
      Top = 120
      Width = 48
      Height = 16
      Caption = #25163#26426#65306
    end
    object Label11: TLabel
      Left = 56
      Top = 168
      Width = 32
      Height = 16
      Caption = 'QQ'#65306
    end
    object Label12: TLabel
      Left = 56
      Top = 192
      Width = 40
      Height = 16
      Caption = 'MSN'#65306
    end
    object Label13: TLabel
      Left = 56
      Top = 216
      Width = 64
      Height = 16
      Caption = 'E-mail'#65306
    end
    object Label14: TLabel
      Left = 56
      Top = 144
      Width = 48
      Height = 16
      Caption = #30005#35805#65306
    end
    object Label15: TLabel
      Left = 56
      Top = 240
      Width = 48
      Height = 16
      Caption = 'Blog'#65306
    end
    object Label16: TLabel
      Left = 56
      Top = 264
      Width = 80
      Height = 16
      Caption = #36890#35759#22320#22336#65306
    end
    object Label17: TLabel
      Left = 56
      Top = 288
      Width = 80
      Height = 16
      Caption = #33258#25105#20171#32461#65306
    end
    object Edit5: TEdit
      Left = 160
      Top = 32
      Width = 265
      Height = 24
      Hint = #24403#23494#30721#24536#35760#26102#65292#20250#26174#31034#27492#38382#39064#65292#27604#22914#21487#20197#20889#65292#25105#23478#23567#29399#21483#20160#20040#21517#23383#65311
      MaxLength = 32
      TabOrder = 0
      OnKeyPress = Edit1KeyPress
    end
    object Edit6: TEdit
      Left = 160
      Top = 56
      Width = 265
      Height = 24
      Hint = #22635#20889#33258#23450#30340#31572#26696#65292#22914#26524#31572#26696#27491#30830#65292#37027#20040#21487#20197#37325#32622#23494#30721
      MaxLength = 32
      TabOrder = 1
      OnKeyPress = Edit1KeyPress
    end
    object Edit7: TEdit
      Left = 160
      Top = 88
      Width = 137
      Height = 24
      MaxLength = 16
      TabOrder = 2
      OnKeyPress = Edit1KeyPress
    end
    object Edit8: TEdit
      Left = 360
      Top = 88
      Width = 65
      Height = 24
      MaxLength = 3
      TabOrder = 3
    end
    object Edit9: TEdit
      Left = 160
      Top = 112
      Width = 137
      Height = 24
      MaxLength = 20
      TabOrder = 4
      OnKeyPress = Edit1KeyPress
    end
    object Edit10: TEdit
      Left = 160
      Top = 136
      Width = 137
      Height = 24
      MaxLength = 20
      TabOrder = 5
      OnKeyPress = Edit1KeyPress
    end
    object Edit11: TEdit
      Left = 160
      Top = 160
      Width = 137
      Height = 24
      MaxLength = 20
      TabOrder = 6
      OnKeyPress = Edit1KeyPress
    end
    object Edit12: TEdit
      Left = 160
      Top = 184
      Width = 265
      Height = 24
      MaxLength = 50
      TabOrder = 7
      OnKeyPress = Edit1KeyPress
    end
    object Edit13: TEdit
      Left = 160
      Top = 208
      Width = 265
      Height = 24
      MaxLength = 50
      TabOrder = 8
      OnKeyPress = Edit1KeyPress
    end
    object Edit14: TEdit
      Left = 160
      Top = 232
      Width = 265
      Height = 24
      MaxLength = 50
      TabOrder = 9
      OnKeyPress = Edit1KeyPress
    end
    object Edit15: TEdit
      Left = 160
      Top = 256
      Width = 265
      Height = 24
      MaxLength = 100
      TabOrder = 10
      OnKeyPress = Edit1KeyPress
    end
    object Edit16: TEdit
      Left = 160
      Top = 280
      Width = 265
      Height = 24
      MaxLength = 255
      TabOrder = 11
      OnKeyPress = Edit1KeyPress
    end
  end
  object Button1: TButton
    Left = 152
    Top = 504
    Width = 75
    Height = 25
    Caption = #27880#20876
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 288
    Top = 504
    Width = 75
    Height = 25
    Caption = #21462#28040
    TabOrder = 3
    OnClick = Button2Click
  end
end
