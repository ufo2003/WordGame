object Form_chinese: TForm_chinese
  Left = 74
  Top = 428
  Caption = #19981#30693#19981#35273#32972#21333#35789
  ClientHeight = 101
  ClientWidth = 454
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 84
    Height = 24
    Caption = 'English'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 38
    Height = 19
    Caption = #20013#25991
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 24
    Top = 72
    Width = 240
    Height = 16
    Cursor = crHandPoint
    Hint = #28857#27492#20813#36153#19979#36733#24494#36719#20013#25991#26391#35835#24341#25806#12290
    Caption = #20013#25991#26391#35835#24341#25806#19981#21487#29992#65292#31435#21363#19979#36733#65281
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    Visible = False
    OnClick = Label3Click
  end
  object Label4: TLabel
    Left = 264
    Top = 72
    Width = 64
    Height = 16
    Caption = #20851#38381#25552#31034
    Visible = False
    OnClick = Label4Click
  end
  object Button1: TButton
    Left = 392
    Top = 64
    Width = 57
    Height = 25
    Caption = #33756#21333
    TabOrder = 0
    OnClick = Button1Click
  end
  object PopupMenu1: TPopupMenu
    Left = 224
    Top = 48
    object N1: TMenuItem
      Caption = #26174#31034#28216#25103#31383#21475
      OnClick = N1Click
    end
    object N3: TMenuItem
      Caption = #38544#34255#31383#21475'('#32487#32493#26391#35835')'
      OnClick = N3Click
    end
    object N9: TMenuItem
      Caption = #20851#38381#26412#31383#21475
      OnClick = N9Click
    end
    object N11: TMenuItem
      Caption = #33521#25991#26391#35835#24341#25806#35774#32622
      OnClick = N11Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object N4: TMenuItem
      Caption = #26391#35835#23383#27597
      OnClick = N4Click
    end
    object N5: TMenuItem
      Caption = #26391#35835#21333#35789
      OnClick = N4Click
    end
    object N6: TMenuItem
      Caption = #26391#35835#20013#25991
      OnClick = N4Click
    end
    object N10: TMenuItem
      Caption = #20013#25991#25972#21477#26391#35835
      OnClick = N4Click
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object N8: TMenuItem
      Caption = #26242#20572
      OnClick = N8Click
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 168
    Top = 16
  end
end
