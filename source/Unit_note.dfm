object Form_note: TForm_note
  Left = 216
  Top = 172
  Width = 498
  Height = 425
  Caption = #28040#24687
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 48
    Top = 24
    Width = 80
    Height = 16
    Caption = #28040#24687#20844#21578#65306
  end
  object RichEdit1: TRichEdit
    Left = 48
    Top = 56
    Width = 385
    Height = 201
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    OnMouseDown = RichEdit1MouseDown
  end
  object Button1: TButton
    Left = 56
    Top = 304
    Width = 75
    Height = 25
    Caption = #19978#19968#26465
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 176
    Top = 304
    Width = 75
    Height = 25
    Caption = #19979#19968#26465
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button4: TButton
    Left = 286
    Top = 304
    Width = 75
    Height = 25
    Caption = #28165#31354
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button3: TButton
    Left = 360
    Top = 304
    Width = 75
    Height = 25
    Caption = #20851#38381
    TabOrder = 3
    OnClick = Button3Click
  end
end
