object Form_pic: TForm_pic
  Left = 163
  Top = 145
  Caption = #25130#22270
  ClientHeight = 453
  ClientWidth = 572
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  DesignSize = (
    572
    453)
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 232
    Top = 136
    Width = 105
    Height = 105
    AutoSize = True
    OnDblClick = Image1DblClick
    OnMouseDown = Image1MouseDown
    OnMouseMove = Image1MouseMove
    OnMouseUp = Image1MouseUp
  end
  object Label1: TLabel
    Left = 8
    Top = 408
    Width = 195
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #22270#29255#36807#22823#65292#35831#36873#25321#35201#25130#22270#30340#21306#22495#12290
  end
  object Button1: TButton
    Left = 432
    Top = 408
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = #20445#23384
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 208
    Top = 408
    Width = 113
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = #20174#22270#29255#25991#20214#36733#20837
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 328
    Top = 408
    Width = 97
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = #20174#21098#36148#26495#36733#20837
    TabOrder = 2
    OnClick = Button3Click
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 
      'All (.jpg;*.bmp)|*.jpg;*.bmp|JPEG Image File (*.jpg)|*.jpg|Bitma' +
      'ps (*.bmp)|*.bmp'
    Left = 80
    Top = 192
  end
end
