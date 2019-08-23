object Form_langdu: TForm_langdu
  Left = 0
  Top = 0
  Caption = #26391#35835#25991#26412
  ClientHeight = 540
  ClientWidth = 765
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    765
    540)
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 279
    Top = 8
    Width = 240
    Height = 16
    Caption = #21333#21477#26391#35835#65292#40736#26631#21452#20987#26391#35835#24403#21069#34892#12290
  end
  object Button1: TButton
    Left = 591
    Top = 8
    Width = 75
    Height = 25
    Caption = #26391#35835#20840#37096
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 672
    Top = 8
    Width = 75
    Height = 25
    Caption = #20572#27490
    TabOrder = 1
    OnClick = Button2Click
  end
  object CheckBox1: TCheckBox
    Left = 9
    Top = 8
    Width = 264
    Height = 17
    Hint = #30334#24230#22312#32447#21512#25104#35821#38899#21487#20197#26391#35835#20013#25991#65292#33521#25991
    Caption = #21246#36873#30334#24230#35821#38899#65292#25903#25345#20013#25991#33521#25991#26391#35835
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = CheckBox1Click
  end
  object Button3: TButton
    Left = 510
    Top = 8
    Width = 75
    Height = 25
    Caption = #31896#36148
    TabOrder = 3
    OnClick = Button3Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 48
    Width = 749
    Height = 484
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      #35201#26391#35835#26576#19968#34892#65292#35831#40736#26631#21452#20987#36825#19968#34892#12290
      #25903#25345#36873#20013#37096#20998#21478#23384#20026'mp3'#21151#33021#65292#20855#20307#20808#40736#26631#25302#21160#36873#20013#25991#23383#20869#23481#65292#28982#21518#28857#20987#40736#26631#21491#38190#65292#36873#25321' '#21478#23384#20026'MP3'#25991
      #20214
      #28982#21518#31245#24494#31561#24453#19968#20250#23601#20445#23384#22909#20102#12290
      #30334#24230#35821#38899#25903#25345#30007#22768#22899#22768#36873#25321#65292#28982#21518#25903#25345#38899#37327#35843#33410#12290#35831#25171#24320#28216#25103#35774#32622#30028#38754#20869#20462#25913#12290)
    PopupMenu = PopupMenu1
    ScrollBars = ssVertical
    TabOrder = 4
    OnDblClick = Memo1DblClick
  end
  object CheckBox2: TCheckBox
    Left = 8
    Top = 25
    Width = 129
    Height = 17
    Caption = #20165#26391#35835#33521#25991
    TabOrder = 5
  end
  object PopupMenu1: TPopupMenu
    Left = 352
    Top = 232
    object N1: TMenuItem
      Caption = #31896#36148
      OnClick = Button3Click
    end
    object N2: TMenuItem
      Caption = #26391#35835#20840#37096
      OnClick = Button1Click
    end
    object MP31: TMenuItem
      Caption = #21478#23384#20026'MP3'#25991#20214
      OnClick = MP31Click
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 568
    Top = 152
  end
  object SaveDialog1: TSaveDialog
    Filter = 'MP3'#25991#20214'|*.MP3'
    Left = 464
    Top = 248
  end
end
