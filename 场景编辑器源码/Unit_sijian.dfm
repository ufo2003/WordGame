object Form_shijian: TForm_shijian
  Left = 192
  Top = 107
  Width = 452
  Height = 520
  Caption = #20107#20214#21015#34920
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 417
    Height = 25
    AutoSize = False
    Caption = #20107#20214#21015#34920#65306#24314#35758#29992#22235#20301#25968#23383#32534#21495#65292#20174'1001'#24320#22987#12290#27492#20107#20214#21015#34920#65292#20165#20165#26159#20026#20102#26041#20415#22312#28216#25103#24320#21457#20013#30340#35760#20107#12290#20363#22914#65306'1001='#36175#38065#24050#39046#21462#12290
    WordWrap = True
  end
  object Memo1: TMemo
    Left = 8
    Top = 40
    Width = 417
    Height = 401
    ScrollBars = ssVertical
    TabOrder = 0
    OnChange = Memo1Change
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 448
    Width = 73
    Height = 17
    Caption = #33258#21160#20445#23384
    Checked = True
    Enabled = False
    State = cbChecked
    TabOrder = 1
  end
  object Button1: TButton
    Left = 216
    Top = 448
    Width = 97
    Height = 25
    Caption = #25171#24320#20107#20214#21015#34920
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 328
    Top = 448
    Width = 97
    Height = 25
    Caption = #20445#23384#20107#20214#21015#34920
    Enabled = False
    TabOrder = 3
    OnClick = Button2Click
  end
  object CheckBox2: TCheckBox
    Left = 96
    Top = 448
    Width = 97
    Height = 17
    Hint = #24403#20854#20182#31243#24207#20462#25913#20102#21516#19968#25991#20214#26102#65292#33258#21160#37325#26032#21152#36733#12290
    Caption = #33258#21160#26356#26032
    Checked = True
    Enabled = False
    State = cbChecked
    TabOrder = 4
  end
  object OpenDialog1: TOpenDialog
    Filter = #25991#26412#25991#20214' .txt|*.txt'
    Left = 168
    Top = 80
  end
end
