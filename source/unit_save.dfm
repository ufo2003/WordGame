object Form_save: TForm_save
  Left = 304
  Top = 159
  Caption = #23384#21462#36827#24230
  ClientHeight = 487
  ClientWidth = 386
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 168
    Top = 424
    Width = 80
    Height = 16
    Caption = #36755#20837#23494#30721#65306
  end
  object Label2: TLabel
    Left = 168
    Top = 456
    Width = 80
    Height = 16
    Caption = #37325#22797#23494#30721#65306
  end
  object ListBox1: TListBox
    Left = 8
    Top = 0
    Width = 361
    Height = 321
    Style = lbOwnerDrawVariable
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = #23435#20307
    Font.Style = []
    ItemHeight = 19
    ParentFont = False
    TabOrder = 0
    OnDblClick = ListBox1DblClick
    OnDrawItem = ListBox1DrawItem
    OnMeasureItem = ListBox1MeasureItem
  end
  object Button1: TButton
    Left = 8
    Top = 328
    Width = 97
    Height = 25
    Hint = #28216#25103#23384#30424
    Caption = #20445#23384#36827#24230
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 112
    Top = 328
    Width = 97
    Height = 25
    Caption = #35835#21462#36827#24230
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button4: TButton
    Left = 8
    Top = 360
    Width = 153
    Height = 25
    Hint = #27880#24847#65292#26159#28216#25103#20869#22312#26434#36135#24215#36141#20080#30340#23384#20648#21345#65292#21487#22312#36855#23467#23384#30424#65292#19981#26159#25554#21040#30005#33041#19978#30340'U'#30424'SD'#21345#20043#31867#30340#19996#19996#12290
    Caption = #29992#23384#20648#21345#20445#23384#36827#24230
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 8
    Top = 392
    Width = 49
    Height = 25
    Hint = #21024#38500#24403#21069#23384#26723
    Caption = #21024#38500
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = Button5Click
  end
  object Button3: TButton
    Left = 56
    Top = 392
    Width = 49
    Height = 25
    Caption = #20851#38381
    TabOrder = 3
    OnClick = Button3Click
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 423
    Width = 89
    Height = 17
    Caption = #21152#23494#23384#26723
    TabOrder = 6
    OnClick = CheckBox1Click
  end
  object Edit1: TEdit
    Left = 248
    Top = 416
    Width = 121
    Height = 24
    Enabled = False
    PasswordChar = '*'
    TabOrder = 7
  end
  object Edit2: TEdit
    Left = 248
    Top = 448
    Width = 121
    Height = 24
    Enabled = False
    PasswordChar = '*'
    TabOrder = 8
  end
  object Button6: TButton
    Left = 8
    Top = 446
    Width = 97
    Height = 25
    Hint = #25171#24320#28216#25103#30340#23384#26723#25991#20214#22841
    Caption = #25171#24320#23384#26723#25991#20214#22841
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 248
    Top = 327
    Width = 113
    Height = 25
    Caption = #23548#20837#23384#26723
    TabOrder = 10
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 248
    Top = 360
    Width = 113
    Height = 25
    Caption = #23548#20986#23384#26723
    TabOrder = 11
    OnClick = Button8Click
  end
  object OpenDialog1: TOpenDialog
    Filter = #23384#26723#25991#20214'|*.gsf'
    Left = 128
    Top = 232
  end
  object SaveDialog1: TSaveDialog
    Filter = #23384#26723#25991#20214'|*.gsf'
    Left = 176
    Top = 240
  end
end
