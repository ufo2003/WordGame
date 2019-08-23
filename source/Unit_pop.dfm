object Form_pop: TForm_pop
  Left = 157
  Top = 90
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Form_pop'
  ClientHeight = 563
  ClientWidth = 697
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 448
    Top = 0
    Width = 65
    Height = 13
    Caption = #24403#21069#35789#24211#65306
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 507
    Width = 64
    Height = 16
    AutoSize = False
    Caption = #21517#23383#19968#20010
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
  end
  object Label3: TLabel
    Left = 72
    Top = 507
    Width = 64
    Height = 16
    AutoSize = False
    Caption = #21517#23383#19968#20010
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 136
    Top = 507
    Width = 64
    Height = 16
    AutoSize = False
    Caption = #21517#23383#19968#20010
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label5: TLabel
    Left = 200
    Top = 507
    Width = 64
    Height = 16
    AutoSize = False
    Caption = #21517#23383#19968#20010
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 264
    Top = 507
    Width = 64
    Height = 16
    AutoSize = False
    Caption = #21517#23383#19968#20010
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label7: TLabel
    Left = 328
    Top = 507
    Width = 64
    Height = 16
    AutoSize = False
    Caption = #21517#23383#19968#20010
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 392
    Top = 507
    Width = 64
    Height = 16
    AutoSize = False
    Caption = #21517#23383#19968#20010
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label9: TLabel
    Left = 456
    Top = 507
    Width = 64
    Height = 16
    AutoSize = False
    Caption = #21517#23383#19968#20010
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object Label10: TLabel
    Left = 520
    Top = 507
    Width = 64
    Height = 16
    Hint = #19979#19968#20010
    AutoSize = False
    Caption = #21517#23383#19968#20010
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = []
    ParentColor = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object Label11: TLabel
    Left = 584
    Top = 507
    Width = 64
    Height = 16
    Hint = #24403#21069
    AutoSize = False
    Caption = #21517#23383#19968#20010
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object CheckBox2: TCheckBox
    Left = 8
    Top = 0
    Width = 43
    Height = 17
    Hint = #26391#35835#33521#25991#21333#35789#25110#32773#21477#23376#12290#37325#22797#26391#35835#24555#25463#38190' R'
    Caption = #26391#35835
    Checked = True
    ParentShowHint = False
    ShowHint = True
    State = cbChecked
    TabOrder = 1
  end
  object CheckBox3: TCheckBox
    Left = 64
    Top = 0
    Width = 73
    Height = 17
    Hint = #26174#31034#20013#25991#65292#36873#25321#27491#30830#30340#33521#25991#35299#37322#12290
    Caption = #21453#21521#23398#20064
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = CheckBox3Click
  end
  object ComboBox1: TComboBox
    Left = 512
    Top = 1
    Width = 137
    Height = 21
    Hint = #36873#25321#35789#24211
    Style = csDropDownList
    ItemHeight = 13
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnChange = ComboBox1Change
    OnEnter = ComboBox1Enter
  end
  object CheckBox8: TCheckBox
    Left = 144
    Top = 0
    Width = 129
    Height = 17
    Hint = #22914#38656#31435#21363#26174#31034#21333#35789#35299#37322#65292#35831#22312#28216#25103#20869#30340#26434#36135#38138#36141#20080#26102#38388#21152#36895#20024#24182#21462#28040#36825#37324#30340#25171#38057#12290
    Caption = #21333#35789#35299#37322#24310#36831#26174#31034
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnMouseUp = CheckBox8MouseUp
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 544
    Width = 697
    Height = 19
    AutoHint = True
    Panels = <
      item
        Width = 520
      end
      item
        Width = 50
      end>
  end
  object Panel1: TPanel
    Left = 8
    Top = 24
    Width = 640
    Height = 480
    Caption = #38656#35201'DirectX 9.0'#21450#20197#19978#29256#26412#25903#25345#65292#25110#32773#37325#26032#21551#21160#30005#33041#35797#35797
    TabOrder = 6
    OnMouseDown = Panel1MouseDown
    OnMouseMove = Panel1MouseMove
    object GroupBox1: TGroupBox
      Left = 168
      Top = 184
      Width = 337
      Height = 169
      Caption = #21333#35789
      TabOrder = 0
      Visible = False
      object Label12: TLabel
        Left = 8
        Top = 32
        Width = 39
        Height = 13
        Caption = #21333#35789#65306
      end
      object Label13: TLabel
        Left = 8
        Top = 72
        Width = 39
        Height = 13
        Caption = #35299#37322#65306
      end
      object Edit2: TEdit
        Left = 48
        Top = 32
        Width = 169
        Height = 21
        TabOrder = 0
      end
      object Edit3: TEdit
        Left = 48
        Top = 72
        Width = 273
        Height = 21
        TabOrder = 1
      end
      object Button12: TButton
        Left = 48
        Top = 120
        Width = 75
        Height = 25
        Caption = #30830#23450
        TabOrder = 2
        OnClick = Button12Click
      end
      object Button13: TButton
        Left = 168
        Top = 120
        Width = 75
        Height = 25
        Caption = #21462#28040
        TabOrder = 3
        OnClick = Button13Click
      end
    end
  end
  object GroupBox3: TGroupBox
    Left = 224
    Top = 200
    Width = 425
    Height = 225
    TabOrder = 0
    Visible = False
    object Button1: TButton
      Left = 8
      Top = 16
      Width = 41
      Height = 33
      Caption = #25915
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 8
      Top = 56
      Width = 41
      Height = 33
      Caption = #38450
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 8
      Top = 96
      Width = 41
      Height = 33
      Caption = #26415
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 8
      Top = 136
      Width = 41
      Height = 33
      Caption = #29289
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 8
      Top = 176
      Width = 41
      Height = 33
      Caption = #36867
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = Button5Click
    end
    object ListBox1: TListBox
      Left = 64
      Top = 8
      Width = 345
      Height = 177
      Style = lbOwnerDrawVariable
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      Visible = False
      OnDragOver = ListBox1DragOver
      OnDrawItem = ListBox1DrawItem
      OnKeyPress = ListBox1KeyPress
      OnMeasureItem = ListBox1MeasureItem
      OnMouseDown = ListBox1MouseDown
      OnMouseMove = ListBox1MouseMove
      OnMouseUp = ListBox1MouseUp
    end
    object Button6: TButton
      Left = 48
      Top = 192
      Width = 75
      Height = 25
      Caption = #24555#25463'-'#26080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnClick = Button6Click
      OnDragDrop = Button6DragDrop
      OnDragOver = Button6DragOver
    end
    object Button7: TButton
      Left = 122
      Top = 192
      Width = 75
      Height = 25
      Caption = #24555#25463'-'#26080
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnClick = Button6Click
      OnDragDrop = Button6DragDrop
      OnDragOver = Button6DragOver
    end
    object Button8: TButton
      Left = 196
      Top = 192
      Width = 75
      Height = 25
      Caption = #24555#25463'-'#26080
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      OnClick = Button6Click
      OnDragDrop = Button6DragDrop
      OnDragOver = Button6DragOver
    end
    object Button9: TButton
      Left = 270
      Top = 192
      Width = 75
      Height = 25
      Caption = #24555#25463'-'#26080
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      OnClick = Button6Click
      OnDragDrop = Button6DragDrop
      OnDragOver = Button6DragOver
    end
    object Button10: TButton
      Left = 344
      Top = 192
      Width = 75
      Height = 25
      Caption = #24555#25463'-'#26080
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
      OnClick = Button6Click
      OnDragDrop = Button6DragDrop
      OnDragOver = Button6DragOver
    end
  end
  object Button11: TButton
    Left = 288
    Top = -1
    Width = 97
    Height = 19
    Hint = #28857#27492#25353#38062#26469#25511#21046#21160#30011#21644#36879#26126#25928#26524#20197#21450#24618#29289#38899#25928
    Caption = #26356#22810#36873#39033
    TabOrder = 7
    OnClick = Button11Click
  end
  object Edit1: TEdit
    Left = 168
    Top = 432
    Width = 145
    Height = 27
    Hint = #24320#22836#38190#20837#19968#31354#26684#65292#24403#21069#21333#35789#20250#20316#20026#29983#35789#22810#32972#19968#27425#12290#25353'CTRL+P'#20851#38381#21333#35789#25340#20889#65292#25913#36873#25321#24335#32972#21333#35789
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    Visible = False
    OnChange = Edit1Change
    OnKeyUp = Edit1KeyUp
  end
  object Button14: TButton
    Left = 406
    Top = 5
    Width = 34
    Height = 14
    Caption = 'go'
    TabOrder = 9
    Visible = False
    OnClick = Button14Click
  end
  object OpenDialog1: TOpenDialog
    Filter = #35789#24211#25991#20214'|*.ini|'#28216#25103#33050#26412'|*.dat|'#25152#26377#25991#20214'|*.*'
    Left = 48
    Top = 56
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = Timer1Timer
    Left = 104
    Top = 56
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.ini'
    Filter = #35789#24211#25991#20214'|*.ini|'#28216#25103#33050#26412'|*.dat'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 48
    Top = 8
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer2Timer
    Left = 8
    Top = 152
  end
  object Timer3: TTimer
    Enabled = False
    OnTimer = Timer3Timer
    Left = 8
    Top = 208
  end
  object Timer4: TTimer
    Enabled = False
    Interval = 200
    OnTimer = Timer4Timer
    Left = 8
    Top = 264
  end
  object AsphyreDevice1: TAsphyreDevice
    Width = 640
    Height = 480
    BitDepth = bdHigh
    Refresh = 0
    Windowed = True
    VSync = False
    HardwareTL = True
    DepthBuffer = False
    WindowHandle = 0
    OnInitialize = AsphyreDevice1Initialize
    OnRender = AsphyreDevice1Render
    Left = 208
    Top = 48
  end
  object AsphyreTimer1: TAsphyreTimer
    Speed = 60.000000000000000000
    MaxFPS = 100
    Enabled = False
    OnTimer = AsphyreTimer1Timer
    OnProcess = AsphyreTimer1Process
    Left = 240
    Top = 48
  end
  object AsphyreCanvas1: TAsphyreCanvas
    Publisher = AsphyreDevice1
    AlphaTesting = True
    VertexCache = 4096
    Antialias = True
    Dithering = False
    Left = 272
    Top = 48
  end
  object AsphyreImages1: TAsphyreImages
    Publisher = AsphyreDevice1
    MipMappping = False
    Left = 304
    Top = 48
  end
  object AsphyreFonts1: TAsphyreFonts
    Publisher = AsphyreDevice1
    Canvas = AsphyreCanvas1
    Left = 344
    Top = 48
  end
  object Timer_donghua: TTimer
    Enabled = False
    OnTimer = Timer_donghuaTimer
    Left = 216
    Top = 96
  end
  object ASDb1: TASDb
    OpenMode = opUpdate
    Left = 384
    Top = 48
  end
  object ActionList1: TActionList
    OnExecute = ActionList1Execute
    Left = 24
    Top = 376
    object Action1: TAction
      Caption = 'Action1'
      ShortCut = 71
      OnExecute = Action1Execute
    end
    object Action2: TAction
      Caption = 'Action2'
      ShortCut = 70
      OnExecute = Action2Execute
    end
    object Action3: TAction
      Caption = 'Action3'
      ShortCut = 83
      OnExecute = Action3Execute
    end
    object Action4: TAction
      Caption = 'Action4'
      ShortCut = 87
      OnExecute = Action4Execute
    end
    object Action5: TAction
      Caption = 'Action5'
      ShortCut = 84
      OnExecute = Action5Execute
    end
    object Action6: TAction
      Caption = 'Action6'
      ShortCut = 89
      OnExecute = Action6Execute
    end
    object Action7: TAction
      Caption = 'Action7'
      ShortCut = 72
      OnExecute = Action7Execute
    end
    object Action8: TAction
      Caption = 'Action8'
      ShortCut = 46
      OnExecute = Action8Execute
    end
    object Action9: TAction
      Caption = 'Action9'
      ShortCut = 78
      OnExecute = Action9Execute
    end
    object Action10: TAction
      Caption = 'Action10'
      ShortCut = 73
      OnExecute = Action10Execute
    end
    object Action11: TAction
      Caption = 'Action11'
      ShortCut = 49
      OnExecute = Action11Execute
    end
    object Action12: TAction
      Caption = 'Action12'
      ShortCut = 50
      OnExecute = Action12Execute
    end
    object Action13: TAction
      Caption = 'Action13'
      ShortCut = 51
      OnExecute = Action13Execute
    end
    object Action14: TAction
      Caption = 'Action14'
      ShortCut = 52
      OnExecute = Action14Execute
    end
    object Action15: TAction
      Caption = 'Action15'
      ShortCut = 53
      OnExecute = Action15Execute
    end
    object Action16: TAction
      Caption = 'Action16'
      ShortCut = 90
      OnExecute = Action16Execute
    end
    object Action17: TAction
      Caption = 'Action17'
      ShortCut = 88
      OnExecute = Action17Execute
    end
    object Action18: TAction
      Caption = 'Action18'
      ShortCut = 67
      OnExecute = Action18Execute
    end
    object Action19: TAction
      Caption = 'Action19'
      ShortCut = 86
      OnExecute = Action19Execute
    end
    object Action20: TAction
      Caption = 'Action20'
      ShortCut = 66
      OnExecute = Action20Execute
    end
    object Action21: TAction
      Caption = 'Action21'
      ShortCut = 82
      OnExecute = Action21Execute
    end
    object Action_az1: TAction
      Caption = 'Action_az1'
      OnExecute = Action_az1Execute
    end
    object Action_az2: TAction
      Caption = 'Action_az2'
      OnExecute = Action_az2Execute
    end
    object Action_az3: TAction
      Caption = 'Action_az3'
      OnExecute = Action_az3Execute
    end
    object Action22: TAction
      Caption = 'Action22'
      ShortCut = 37
      OnExecute = Action22Execute
    end
    object Action23: TAction
      Caption = 'Action23'
      ShortCut = 39
      OnExecute = Action23Execute
    end
    object Action24: TAction
      Caption = 'Action24'
      ShortCut = 38
      OnExecute = Action24Execute
    end
    object Action25: TAction
      Caption = 'Action25'
      ShortCut = 16464
      OnExecute = Action25Execute
    end
  end
  object AsphyreParticles1: TAsphyreParticles
    Publisher = AsphyreDevice1
    Canvas = AsphyreCanvas1
    Images = AsphyreImages1
    Left = 424
    Top = 48
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 280
    Top = 112
    object N17: TMenuItem
      Caption = #28155#21152#26032#21333#35789
      OnClick = N17Click
    end
    object N16: TMenuItem
      Caption = #20462#25913#24403#21069#21333#35789
      OnClick = N16Click
    end
    object N15: TMenuItem
      Caption = #21024#38500#24403#21069#21333#35789' Del'
      OnClick = N15Click
    end
    object N14: TMenuItem
      Caption = #32534#36753#24403#21069#35789#24211
      OnClick = N14Click
    end
    object N13: TMenuItem
      Caption = '-'
    end
    object N1: TMenuItem
      Caption = #20851#38381#21333#35789#21160#30011
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #20851#38381#21333#35789#36879#26126#25928#26524
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object N4: TMenuItem
      Caption = #20851#38381#31574#30053#31383#21475#21160#30011
      OnClick = N4Click
    end
    object N5: TMenuItem
      Caption = #20851#38381#31574#30053#31383#21475#36879#26126
      OnClick = N5Click
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object N7: TMenuItem
      Caption = #21551#29992#40657#23631#32972#26223
      OnClick = N7Click
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object N10: TMenuItem
      Caption = #20851#38381#24618#29289#21483#22768
      Hint = #20851#38381#24618#29289#21644#25105#26041#21463#20260#26102#30340#21483#22768
      OnClick = N10Click
    end
    object N9: TMenuItem
      Caption = #20851#38381#25112#26007#22768
      Hint = #20851#38381#20854#20182#30340#21508#31181#22768#25928
      OnClick = N9Click
    end
    object N11: TMenuItem
      Caption = '-'
    end
    object N12: TMenuItem
      Caption = #24674#22797#40664#35748#20540
      OnClick = N12Click
    end
  end
  object DXSound1: TDXSound
    AutoInitialize = True
    Options = []
    Left = 160
    Top = 88
  end
  object DXWaveList1: TDXWaveList
    DXSound = DXSound1
    Items = <>
    Left = 160
    Top = 128
  end
  object Timer_auto_attack: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer_auto_attackTimer
    Left = 24
    Top = 344
  end
  object Timer5: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer5Timer
    Left = 24
    Top = 432
  end
  object Timer_daojishi: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer_daojishiTimer
    Left = 96
    Top = 152
  end
end
