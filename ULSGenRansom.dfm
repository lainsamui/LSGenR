object F_FFGenRansomware: TF_FFGenRansomware
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'FF Generic Ransomware'
  ClientHeight = 316
  ClientWidth = 479
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -18
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 22
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 479
    Height = 316
    ActivePage = TabSheetCript
    Align = alClient
    TabOrder = 0
    object TabSheetCript: TTabSheet
      Caption = 'Criptografia'
      object Image: TImage
        AlignWithMargins = True
        Left = 239
        Top = 3
        Width = 229
        Height = 193
        Align = alClient
        Center = True
        Proportional = True
        Stretch = True
        Transparent = True
        ExplicitLeft = 360
        ExplicitTop = 80
        ExplicitWidth = 105
        ExplicitHeight = 105
      end
      object GroupBoxTeste: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 230
        Height = 193
        Align = alLeft
        Caption = ' Testar um arquivo'
        TabOrder = 0
        object lblBits: TLabel
          Left = 11
          Top = 60
          Width = 154
          Height = 22
          Caption = 'Deslocamento bit'#180's'
        end
        object btnEncript: TButton
          Left = 129
          Top = 119
          Width = 94
          Height = 30
          Caption = 'Encriptar'
          TabOrder = 0
          OnClick = btnEncriptClick
        end
        object editFile: TEdit
          Left = 11
          Top = 24
          Width = 181
          Height = 30
          TabOrder = 1
        end
        object Button3: TButton
          Left = 193
          Top = 24
          Width = 30
          Height = 30
          Caption = '@'
          TabOrder = 2
          OnClick = Button3Click
        end
        object EditSenha: TEdit
          Left = 11
          Top = 83
          Width = 212
          Height = 30
          TabOrder = 3
          Text = '0'
          OnKeyPress = EditSenhaKeyPress
        end
      end
      object btnFullCript: TButton
        AlignWithMargins = True
        Left = 3
        Top = 202
        Width = 465
        Height = 51
        Align = alBottom
        Caption = 'Encriptar Tudo!!!'
        Enabled = False
        TabOrder = 1
      end
      object ProgressBar: TProgressBar
        AlignWithMargins = True
        Left = 3
        Top = 259
        Width = 465
        Height = 17
        Align = alBottom
        TabOrder = 2
      end
    end
    object TabSheetStat: TTabSheet
      Caption = 'Estat'#237'sticas'
      ImageIndex = 1
      object GroupBoxStat: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 465
        Height = 273
        Align = alClient
        TabOrder = 0
      end
    end
    object TabSheetAbt: TTabSheet
      Caption = 'Sobre'
      ImageIndex = 2
      object MemoSobre: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 465
        Height = 273
        Align = alClient
        ReadOnly = True
        TabOrder = 0
      end
    end
  end
  object OpenDialog: TOpenDialog
    Left = 264
    Top = 43
  end
end
