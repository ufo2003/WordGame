object Form_task: TForm_task
  Left = 234
  Top = 128
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #20219#21153#21015#34920
  ClientHeight = 441
  ClientWidth = 521
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 521
    Height = 441
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = #26410#23436#25104#30340#20219#21153
      object ListBox2: TListBox
        Left = 0
        Top = 16
        Width = 521
        Height = 353
        ItemHeight = 13
        TabOrder = 0
      end
      object Button1: TButton
        Left = 120
        Top = 384
        Width = 75
        Height = 25
        Caption = #21024#38500
        TabOrder = 1
        OnClick = Button1Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = #24050#23436#25104#30340#20219#21153
      ImageIndex = 1
      object ListBox1: TListBox
        Left = 0
        Top = 8
        Width = 521
        Height = 377
        ItemHeight = 13
        TabOrder = 0
      end
      object Button3: TButton
        Left = 120
        Top = 392
        Width = 75
        Height = 25
        Caption = #28165#31354
        TabOrder = 1
        OnClick = Button3Click
      end
    end
    object TabSheet3: TTabSheet
      Caption = #28040#24687
      ImageIndex = 2
      object ListBox3: TListBox
        Left = 0
        Top = 8
        Width = 521
        Height = 377
        ItemHeight = 13
        TabOrder = 0
      end
      object Button2: TButton
        Left = 120
        Top = 392
        Width = 75
        Height = 25
        Caption = #28165#31354
        TabOrder = 1
        OnClick = Button2Click
      end
    end
  end
end
