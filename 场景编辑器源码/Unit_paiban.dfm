object Form_paiban: TForm_paiban
  Left = 221
  Top = 161
  Width = 502
  Height = 364
  Caption = #31446#24335#25490#29256
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
    Left = 8
    Top = 24
    Width = 39
    Height = 13
    Caption = #20869#23481#65306
  end
  object Button1: TButton
    Left = 64
    Top = 288
    Width = 97
    Height = 25
    Caption = #20445#23384#23450#20301#20449#24687
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 280
    Top = 288
    Width = 75
    Height = 25
    Caption = #20851#38381
    TabOrder = 1
    OnClick = Button2Click
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 56
    Width = 281
    Height = 209
    Caption = #26174#31034#20301#32622
    TabOrder = 2
    object Label2: TLabel
      Left = 160
      Top = 48
      Width = 26
      Height = 13
      Caption = #20687#32032
    end
    object Label3: TLabel
      Left = 160
      Top = 144
      Width = 65
      Height = 13
      Caption = #23383#23450#20301#19968#27425
    end
    object Label4: TLabel
      Left = 24
      Top = 48
      Width = 52
      Height = 13
      Caption = #24038#21491#36793#32536
    end
    object Label5: TLabel
      Left = 24
      Top = 72
      Width = 39
      Height = 13
      Caption = #36317#39030#37096
    end
    object Label6: TLabel
      Left = 160
      Top = 72
      Width = 26
      Height = 13
      Caption = #20687#32032
    end
    object Label7: TLabel
      Left = 24
      Top = 144
      Width = 26
      Height = 13
      Caption = #27599#38548
    end
    object Label8: TLabel
      Left = 24
      Top = 96
      Width = 52
      Height = 13
      Caption = #25991#23383#34892#36317
    end
    object Label9: TLabel
      Left = 160
      Top = 96
      Width = 26
      Height = 13
      Caption = #20687#32032
    end
    object Label10: TLabel
      Left = 24
      Top = 120
      Width = 52
      Height = 13
      Caption = #25991#23383#21015#36317
    end
    object Label11: TLabel
      Left = 160
      Top = 120
      Width = 26
      Height = 13
      Caption = #20687#32032
    end
    object Label12: TLabel
      Left = 24
      Top = 168
      Width = 52
      Height = 13
      Caption = #27599#21015#23383#25968
    end
    object RadioButton_left: TRadioButton
      Left = 24
      Top = 24
      Width = 105
      Height = 17
      Hint = #25991#23383#38752#24038#36793#31383#21475#26174#31034
      Caption = #23621#24038
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object RadioButton_right: TRadioButton
      Left = 144
      Top = 24
      Width = 113
      Height = 17
      Hint = #25991#23383#32771#21491#36793#31383#21475#26174#31034
      Caption = #23621#21491
      Checked = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      TabStop = True
    end
    object Edit1: TEdit
      Left = 80
      Top = 48
      Width = 73
      Height = 21
      Hint = #19982#31383#20307#36793#32536#30340#36317#31163
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Text = '30'
    end
    object Edit3: TEdit
      Left = 80
      Top = 72
      Width = 73
      Height = 21
      Hint = #39318#23383#36317#31163#31383#21475#39030#37096#30340#38388#36317
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Text = '25'
    end
    object Edit4: TEdit
      Left = 80
      Top = 144
      Width = 73
      Height = 21
      Hint = #35774#32622#27599#38548#20960#20010#23383#23450#20301#19968#27425
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      Text = '1'
    end
    object Edit5: TEdit
      Left = 80
      Top = 96
      Width = 73
      Height = 21
      Hint = #19978#19968#20010#23383#19982#19979#19968#20010#23383#20043#38388#30340#31354#30333#36317#31163
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      Text = '8'
    end
    object Edit6: TEdit
      Left = 80
      Top = 120
      Width = 73
      Height = 21
      Hint = #24038#36793#23383#19982#21491#36793#23383#20043#38388#30340#31354#30333#36317#31163#12290
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      Text = '25'
    end
    object Edit7: TEdit
      Left = 80
      Top = 168
      Width = 73
      Height = 21
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      Text = '7'
    end
  end
  object Edit2: TEdit
    Left = 48
    Top = 24
    Width = 377
    Height = 21
    TabOrder = 3
    OnChange = Edit2Change
  end
  object Button3: TButton
    Left = 176
    Top = 288
    Width = 89
    Height = 25
    Caption = #28165#38500#23450#20301#20449#24687
    TabOrder = 4
    OnClick = Button3Click
  end
end
