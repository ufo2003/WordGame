object Form_ZJ_LY: TForm_ZJ_LY
  Left = 194
  Top = 123
  Width = 696
  Height = 480
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #38136#21073#12289#28860#33647
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 688
    Height = 453
    ActivePage = TabSheet1
    Align = alClient
    TabIndex = 0
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #38136#21073
      OnShow = TabSheet1Show
      object Label1: TLabel
        Left = 528
        Top = 16
        Width = 145
        Height = 225
        AutoSize = False
        Caption = #25551#36848#65306
        WordWrap = True
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 8
        Width = 217
        Height = 409
        Caption = #21487#38136#36896#30340#27494#22120
        TabOrder = 0
        object ListBox1: TListBox
          Left = 2
          Top = 15
          Width = 213
          Height = 392
          Style = lbOwnerDrawVariable
          Align = alClient
          ItemHeight = 13
          TabOrder = 0
          OnClick = ListBox1Click
          OnDrawItem = ListBox1DrawItem
          OnMeasureItem = ListBox1MeasureItem
        end
      end
      object StringGrid1: TStringGrid
        Left = 224
        Top = 16
        Width = 297
        Height = 401
        ColCount = 2
        FixedCols = 0
        RowCount = 15
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
        TabOrder = 1
        OnDrawCell = StringGrid1DrawCell
        ColWidths = (
          117
          111)
      end
      object Button1: TButton
        Left = 568
        Top = 320
        Width = 75
        Height = 25
        Caption = #24320#22987#38136#36896
        TabOrder = 2
        OnClick = Button4Click
      end
    end
    object TabSheet3: TTabSheet
      Caption = #28860#33647
      ImageIndex = 2
      OnShow = TabSheet3Show
      object Label2: TLabel
        Left = 525
        Top = 16
        Width = 153
        Height = 185
        AutoSize = False
        Caption = #25551#36848#65306
        WordWrap = True
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 8
        Width = 217
        Height = 409
        Caption = #21487#28860#33647#26448
        TabOrder = 0
        object ListBox2: TListBox
          Left = 2
          Top = 15
          Width = 213
          Height = 392
          Style = lbOwnerDrawVariable
          Align = alClient
          ItemHeight = 13
          TabOrder = 0
          OnClick = ListBox1Click
          OnDrawItem = ListBox1DrawItem
          OnMeasureItem = ListBox1MeasureItem
        end
      end
      object StringGrid2: TStringGrid
        Left = 224
        Top = 16
        Width = 297
        Height = 401
        ColCount = 2
        FixedCols = 0
        RowCount = 15
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
        TabOrder = 1
        OnDrawCell = StringGrid1DrawCell
        ColWidths = (
          117
          111)
      end
      object Button2: TButton
        Left = 568
        Top = 320
        Width = 75
        Height = 25
        Caption = #24320#22987#28860#21046
        TabOrder = 2
        OnClick = Button4Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = #21046#35013#22791
      ImageIndex = 2
      OnShow = TabSheet2Show
      object Label3: TLabel
        Left = 525
        Top = 16
        Width = 153
        Height = 185
        AutoSize = False
        Caption = #25551#36848#65306
        WordWrap = True
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 8
        Width = 217
        Height = 409
        Caption = #21487#21512#25104#35013#22791
        TabOrder = 0
        object ListBox3: TListBox
          Left = 2
          Top = 15
          Width = 213
          Height = 392
          Style = lbOwnerDrawVariable
          Align = alClient
          ItemHeight = 13
          TabOrder = 0
          OnClick = ListBox1Click
          OnDrawItem = ListBox1DrawItem
          OnMeasureItem = ListBox1MeasureItem
        end
      end
      object StringGrid3: TStringGrid
        Left = 224
        Top = 16
        Width = 297
        Height = 401
        ColCount = 2
        FixedCols = 0
        RowCount = 15
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
        TabOrder = 1
        OnDrawCell = StringGrid1DrawCell
        ColWidths = (
          117
          111)
      end
      object Button3: TButton
        Left = 568
        Top = 320
        Width = 75
        Height = 25
        Caption = #24320#22987#21512#25104
        TabOrder = 2
        OnClick = Button4Click
      end
    end
    object TabSheet4: TTabSheet
      Caption = #21046#26263#22120
      ImageIndex = 3
      OnShow = TabSheet4Show
      object Label4: TLabel
        Left = 525
        Top = 16
        Width = 153
        Height = 185
        AutoSize = False
        Caption = #25551#36848#65306
        WordWrap = True
      end
      object GroupBox4: TGroupBox
        Left = 0
        Top = 8
        Width = 217
        Height = 409
        Caption = #21487#21046#20316#26263#22120
        TabOrder = 0
        object ListBox4: TListBox
          Left = 2
          Top = 15
          Width = 213
          Height = 392
          Style = lbOwnerDrawVariable
          Align = alClient
          ItemHeight = 13
          TabOrder = 0
          OnClick = ListBox1Click
          OnDrawItem = ListBox1DrawItem
          OnMeasureItem = ListBox1MeasureItem
        end
      end
      object StringGrid4: TStringGrid
        Left = 224
        Top = 16
        Width = 297
        Height = 401
        ColCount = 2
        FixedCols = 0
        RowCount = 15
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
        TabOrder = 1
        OnDrawCell = StringGrid1DrawCell
        ColWidths = (
          117
          111)
      end
      object Button4: TButton
        Left = 568
        Top = 320
        Width = 75
        Height = 25
        Caption = #24320#22987#21046#20316
        TabOrder = 2
        OnClick = Button4Click
      end
    end
  end
  object ProgressBar1: TProgressBar
    Left = 64
    Top = 200
    Width = 529
    Height = 25
    Min = 0
    Max = 100
    Smooth = True
    Step = 1
    TabOrder = 1
    Visible = False
  end
end
