object Form_trade: TForm_trade
  Left = 84
  Top = 165
  Width = 790
  Height = 493
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #20132#26131
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
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 782
    Height = 466
    ActivePage = TabSheet1
    Align = alClient
    TabIndex = 0
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #20080#20837
      OnShow = TabSheet1Show
      object Label1: TLabel
        Left = 56
        Top = 392
        Width = 409
        Height = 25
        AutoSize = False
        Caption = 'Label1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 8
        Top = 352
        Width = 48
        Height = 16
        Caption = 'Label3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Button2: TButton
        Left = 552
        Top = 360
        Width = 75
        Height = 25
        Caption = #25968#37327#20943
        TabOrder = 2
        OnClick = Button2Click
      end
      object StringGrid1: TStringGrid
        Left = 0
        Top = 0
        Width = 777
        Height = 345
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
        TabOrder = 0
        OnDrawCell = StringGrid1DrawCell
        OnKeyPress = StringGrid1KeyPress
        OnKeyUp = StringGrid1KeyUp
        OnSelectCell = StringGrid1SelectCell
        ColWidths = (
          64
          120
          460
          51
          49)
      end
      object Button1: TButton
        Left = 472
        Top = 360
        Width = 75
        Height = 25
        Caption = #25968#37327#21152
        TabOrder = 1
        OnClick = Button1Click
      end
      object Button3: TButton
        Left = 472
        Top = 392
        Width = 75
        Height = 25
        Caption = #20080#20837
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        OnClick = Button3Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = #21334#20986
      ImageIndex = 1
      OnShow = TabSheet2Show
      object Label2: TLabel
        Left = 48
        Top = 392
        Width = 377
        Height = 25
        AutoSize = False
        Caption = 'Label1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 16
        Top = 352
        Width = 42
        Height = 13
        Caption = 'Label4'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object StringGrid2: TStringGrid
        Left = 0
        Top = 0
        Width = 777
        Height = 345
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        TabOrder = 0
        OnDrawCell = StringGrid1DrawCell
        OnKeyPress = StringGrid1KeyPress
        OnKeyUp = StringGrid1KeyUp
        OnSelectCell = StringGrid1SelectCell
        ColWidths = (
          64
          103
          475
          51
          47)
      end
      object Button4: TButton
        Left = 432
        Top = 392
        Width = 75
        Height = 25
        Caption = #21334#20986
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 432
        Top = 360
        Width = 75
        Height = 25
        Caption = #25968#37327#21152
        TabOrder = 2
        OnClick = Button5Click
      end
      object Button6: TButton
        Left = 512
        Top = 360
        Width = 75
        Height = 25
        Caption = #25968#37327#20943
        TabOrder = 3
        OnClick = Button6Click
      end
    end
  end
end
