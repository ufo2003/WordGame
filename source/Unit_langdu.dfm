object Form_langdu: TForm_langdu
  Left = 0
  Top = 0
  Caption = #26391#35835#19982#20998#20139
  ClientHeight = 540
  ClientWidth = 765
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
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
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 731
    Height = 57
    AutoSize = False
    Caption = 
      #35201#26391#35835#26576#19968#34892#65292#35831#40736#26631#21452#20987#36825#19968#34892#12290#25903#25345#36873#20013#37096#20998#21478#23384#20026'mp3'#21151#33021#65292#20855#20307#20808#40736#26631#25302#21160#36873#20013#25991#23383#20869#23481#65292#28982#21518#28857#20987#40736#26631#21491#38190#65292#36873#25321' '#21478#23384#20026'MP3'#25991 +
      #20214#12290#28982#21518#31245#24494#31561#24453#19968#20250#23601#20445#23384#22909#20102#12290#30334#24230#35821#38899#25903#25345#30007#22768#22899#22768#36873#25321#65292#28982#21518#25903#25345#38899#37327#35843#33410#12290#35831#25171#24320#28216#25103#35774#32622#30028#38754#20869#20462#25913#12290
    WordWrap = True
  end
  object Label3: TLabel
    Left = 8
    Top = 111
    Width = 731
    Height = 50
    AutoSize = False
    Caption = 
      #8220#20998#20139#8221#21151#33021#21487#20197#25226#20013#33521#25991#23545#29031#30340#38405#35835#26448#26009#19978#20256#21040#26381#21153#22120#65292#31867#20284#24744#22312#36855#23467#20869#30475#21040#30340#37027#20123#12290#28982#21518#20854#20182#29609#23478#22312#36827#20837#36855#23467#26102#20250#33258#21160#19979#36733#24744#25552#20132#30340#38405#35835#26448#26009 +
      #24182#38543#26426#26174#31034#20986#26469#12290#21487#20197#19968#27425#19978#20256#19968#27573#20013#33521#25991#23545#29031#30340#36164#26009#65292#25110#32773#19978#20256#22810#27573#25991#23383#35831#29992#22238#36710#38190#25171#31354#34892#38548#24320#12290
    WordWrap = True
  end
  object Label4: TLabel
    Left = 292
    Top = 459
    Width = 176
    Height = 16
    Caption = #19978#20256#36164#26009#22343#38656#23457#26680#21518#21487#35265
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 8
    Top = 178
    Width = 32
    Height = 16
    Caption = #23383#25968
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object Button1: TButton
    Left = 95
    Top = 456
    Width = 75
    Height = 25
    Caption = #26391#35835#20840#37096
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 176
    Top = 456
    Width = 75
    Height = 25
    Caption = #20572#27490#26391#35835
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
    Left = 14
    Top = 456
    Width = 75
    Height = 25
    Caption = #31896#36148
    TabOrder = 3
    OnClick = Button3Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 200
    Width = 749
    Height = 250
    Anchors = [akLeft, akTop, akRight, akBottom]
    PopupMenu = PopupMenu1
    ScrollBars = ssVertical
    TabOrder = 4
    OnChange = Memo1Change
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
  object Button4: TButton
    Left = 482
    Top = 456
    Width = 145
    Height = 25
    Caption = #19978#20256#20998#20139#32473#22823#23478
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 633
    Top = 456
    Width = 106
    Height = 25
    Hint = #26597#30475#19978#20256#25104#21151#19982#21542#30340#32479#35745#25968#25454
    Caption = #26597#30475#25105#19978#20256#30340
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = Button5Click
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
  object NetHTTPClient1: TNetHTTPClient
    Asynchronous = False
    ConnectionTimeout = 60000
    ResponseTimeout = 60000
    HandleRedirects = True
    AllowCookies = True
    UserAgent = 'Embarcadero URI Client/1.0'
    Left = 320
    Top = 152
  end
end
