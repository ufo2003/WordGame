object Form1: TForm1
  Left = 194
  Top = 112
  Cursor = crHourGlass
  Caption = #32972#21333#35789#28216#25103#27494#20384#29256' 2019'
  ClientHeight = 547
  ClientWidth = 982
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox5: TGroupBox
    Left = 0
    Top = 49
    Width = 982
    Height = 498
    Align = alClient
    Caption = #22330#26223
    TabOrder = 0
    object Edit1: TEdit
      Left = 576
      Top = 27
      Width = 137
      Height = 29
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = #21097#20313#65306'600'#31186
      Visible = False
    end
  end
  object GroupBox6: TGroupBox
    Left = 0
    Top = 0
    Width = 982
    Height = 49
    Align = alTop
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    object SpeedButton1: TSpeedButton
      Left = 16
      Top = 0
      Width = 50
      Height = 48
      Hint = #26597#30475#20010#20154#20449#24687
      Enabled = False
      Flat = True
      ParentShowHint = False
      ShowHint = True
      Spacing = 0
      OnClick = SpeedButton1Click
    end
    object Button1: TButton
      Left = 353
      Top = 8
      Width = 89
      Height = 25
      Hint = #20154#29289#23646#24615#26597#30475#20462#25913#21644#29289#21697#20351#29992
      Caption = #20154#29289#21644#29289#21697
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 448
      Top = 8
      Width = 89
      Height = 25
      Hint = #21046#36896#27494#22120#65292#26263#22120#21644#33647#21697#65292#35013#22791
      Caption = #38136#21073#21644#28860#33647
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 616
      Top = 8
      Width = 81
      Height = 25
      Hint = #20445#23384#25110#28165#38500#24403#21069#30340#28216#25103#36827#24230
      Caption = #23384#21462#36827#24230
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 784
      Top = 8
      Width = 129
      Height = 25
      Hint = #21435#28216#25103#20027#39029#30475#30475#65292#26377#27809#26377#26032#30340#28216#25103#29256#26412#21644#20854#20182#21487#29992#36164#26009#12290
      Caption = #19978#35770#22363#35752#35770
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = Button4Click
    end
    object Button13: TButton
      Left = 912
      Top = 8
      Width = 105
      Height = 25
      Hint = #38543#24847#20889#28857#30041#35328
      Caption = #21457#34920#30041#35328#35780#35770
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = Button13Click
    end
    object ComboBox2: TComboBox
      Left = 3
      Top = 8
      Width = 129
      Height = 32
      Hint = #36873#25321#19968#20010#20249#20276#65292#21487#20197#19982#22905#65288#20182#65289#32842#22825#12290
      Style = csOwnerDrawFixed
      DropDownCount = 6
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ItemHeight = 26
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      Visible = False
      OnDrawItem = ComboBox2DrawItem
      OnKeyPress = ComboBox2KeyPress
      OnMeasureItem = ComboBox2MeasureItem
      OnSelect = ComboBox2Select
    end
    object Button5: TButton
      Left = 536
      Top = 8
      Width = 75
      Height = 25
      Caption = #20219#21153#21644#28040#24687
      TabOrder = 6
      OnClick = Button5Click
    end
    object Button6: TButton
      Left = 133
      Top = 8
      Width = 49
      Height = 25
      Hint = #32972#21333#35789#65292#36386#20154
      Caption = #21160#20316#8230
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnClick = Button6Click
    end
    object Button7: TButton
      Left = 704
      Top = 8
      Width = 75
      Height = 25
      Hint = #35821#38899#24341#25806#65292#28216#25103#35774#32622
      Caption = #28216#25103#35774#32622
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      OnClick = Button7Click
    end
    object Button8: TButton
      Left = 167
      Top = 33
      Width = 75
      Height = 25
      Hint = #28857#27492#25353#38062#21487#20851#38381#36855#23467#20869#30340#24191#21578#26174#31034
      Caption = #20851#38381#24191#21578
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      Visible = False
      OnClick = Button8Click
    end
    object CheckBox1: TCheckBox
      Left = 248
      Top = 26
      Width = 97
      Height = 17
      Hint = #35843#35797#26102#25171#38057#65292#33258#21160#36339#36807#32972#21333#35789#21644#25112#26007
      Caption = #35843#35797#30053#36807
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
      Visible = False
      OnClick = CheckBox1Click
    end
    object Button9: TButton
      Left = 268
      Top = 8
      Width = 67
      Height = 25
      Caption = #23383#20307#22823#23567
      TabOrder = 11
      OnClick = Button9Click
    end
    object Button10: TButton
      Left = 188
      Top = 8
      Width = 66
      Height = 25
      Hint = #24744#21487#20197#28155#21152#26032#30340#20013#33521#25991#23545#29031#38405#35835#26448#26009#20849#20139#32473#22823#23478
      Caption = #38405#35835#28155#21152
      ParentShowHint = False
      ShowHint = True
      TabOrder = 12
      OnClick = Button10Click
    end
  end
  object ApplicationEvents1: TApplicationEvents
    OnException = ApplicationEvents1Exception
    OnMessage = ApplicationEvents1Message
    OnMinimize = ApplicationEvents1Minimize
    Left = 24
    Top = 296
  end
  object PopupMenu3: TPopupMenu
    Images = Data2.ImageList1
    OnPopup = PopupMenu3Popup
    Left = 24
    Top = 336
    object N24: TMenuItem
      Caption = #26174#31034#28216#25103
      Visible = False
      OnClick = N24Click
    end
    object N17: TMenuItem
      Caption = #32972#21333#35789
      Hint = #21644#26576#20010#21516#20276#19968#36215#32972#21333#35789#65292#36830#32493#32972#28385'20'#20010#21333#35789#65292#23601#26377#26426#20250#22686#38271#21644#22905#30340#29233#24773#20540
      ImageIndex = 0
      OnClick = N17Click
    end
    object N6: TMenuItem
      Caption = #25171#22352
      Hint = #35813#25805#20316#21487#20197#24674#22797#28789#21147
      ImageIndex = 2
      OnClick = N6Click
    end
    object N7: TMenuItem
      Caption = #23567#28216#25103
      object N9: TMenuItem
        Caption = #27873#27873#40857
        object N10: TMenuItem
          Tag = 60
          Caption = #21021#32423
          OnClick = N10Click
        end
        object N11: TMenuItem
          Tag = 120
          Caption = #20013#32423
          OnClick = N10Click
        end
        object N12: TMenuItem
          Tag = 200
          Caption = #39640#32423
          OnClick = N10Click
        end
      end
      object N13: TMenuItem
        Caption = #20116#23376#26827#32972#21333#35789
        object N23: TMenuItem
          Caption = #24320#22987#28216#25103
          OnClick = N14Click
        end
      end
    end
    object N18: TMenuItem
      Caption = '-'
    end
    object N8: TMenuItem
      Caption = #39134#34892#22320#22270
      ImageIndex = 8
      OnClick = N8Click
    end
    object N21: TMenuItem
      Caption = '-'
    end
    object N1: TMenuItem
      Caption = #20154#29289#23646#24615
      OnClick = Button1Click
    end
    object N2: TMenuItem
      Caption = #20219#21153#21015#34920
      OnClick = Button5Click
    end
    object N3: TMenuItem
      Caption = #38136#36896
      OnClick = Button2Click
    end
    object N4: TMenuItem
      Caption = #23384#21462#36827#24230
      ImageIndex = 7
      OnClick = Button3Click
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object N19: TMenuItem
      Caption = #23545#35805
      Hint = #21644#26576#20010#21516#20276#32842#22825#65292#24403#28982#65292#38656#35201#22330#26223#20869#26377#30456#24212#30340#23545#35805#12290
      ImageIndex = 3
      OnClick = N19Click
    end
    object N20: TMenuItem
      Caption = #36386#20986#38431#21592
      Hint = #25226#26576#20010#21516#20276#20174#38431#20237#20869#36386#20986#12290
      ImageIndex = 1
      OnClick = N20Click
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 24
    Top = 208
  end
  object Timer_exe: TTimer
    Enabled = False
    OnTimer = Timer_exeTimer
    Left = 24
    Top = 256
  end
  object Timer_duihua: TTimer
    Enabled = False
    OnTimer = Timer_duihuaTimer
    Left = 32
    Top = 384
  end
end
