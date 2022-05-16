object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 256
  ClientWidth = 435
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 352
    Top = 225
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 62
    Width = 417
    Height = 157
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 8
    Top = 8
    Width = 417
    Height = 21
    TabOrder = 2
    Text = 'C:\MyRepository\scaling-lamp\delphi\cap01\play.json'
  end
  object Edit2: TEdit
    Left = 8
    Top = 35
    Width = 417
    Height = 21
    TabOrder = 3
    Text = 'C:\MyRepository\scaling-lamp\delphi\cap01\invoices.json'
  end
end
