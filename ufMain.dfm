object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = #1042#1080#1088#1090#1091#1072#1083#1100#1085#1099#1081' '#1087#1088#1086#1094#1077#1089#1089#1086#1088' 8-bit-AON - New'
  ClientHeight = 811
  ClientWidth = 1206
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label11: TLabel
    Left = 952
    Top = 425
    Width = 31
    Height = 16
    Caption = 'TMP:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object labelRegTMP: TLabel
    Left = 989
    Top = 425
    Width = 14
    Height = 16
    Caption = '00'
    Color = clMaroon
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
    Visible = False
  end
  object Label13: TLabel
    Left = 954
    Top = 403
    Width = 31
    Height = 16
    Caption = 'ACC:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object labelRegACC: TLabel
    Left = 989
    Top = 403
    Width = 14
    Height = 16
    Caption = '00'
    Color = clMaroon
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
    Visible = False
  end
  object Label15: TLabel
    Left = 954
    Top = 379
    Width = 35
    Height = 16
    Caption = 'MAR:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object labelRegMAR: TLabel
    Left = 990
    Top = 379
    Width = 14
    Height = 16
    Caption = '00'
    Color = clMaroon
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
    Visible = False
  end
  object Label17: TLabel
    Left = 1113
    Top = 379
    Width = 18
    Height = 16
    Caption = 'FL:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object labelRegFC: TLabel
    Left = 1137
    Top = 379
    Width = 7
    Height = 16
    Caption = '0'
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
  end
  object Label19: TLabel
    Left = 1137
    Top = 361
    Width = 8
    Height = 16
    Caption = 'C'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object labelRegFA: TLabel
    Left = 1152
    Top = 379
    Width = 7
    Height = 16
    Caption = '0'
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
  end
  object Label21: TLabel
    Left = 1152
    Top = 361
    Width = 10
    Height = 16
    Caption = 'A'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object labelRegFE: TLabel
    Left = 1168
    Top = 379
    Width = 7
    Height = 16
    Caption = '0'
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
  end
  object Label23: TLabel
    Left = 1168
    Top = 361
    Width = 7
    Height = 16
    Caption = 'E'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object labelRegFZ: TLabel
    Left = 1185
    Top = 379
    Width = 7
    Height = 16
    Caption = '0'
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
  end
  object Label25: TLabel
    Left = 1185
    Top = 361
    Width = 7
    Height = 16
    Caption = 'Z'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label26: TLabel
    Left = 953
    Top = 447
    Width = 19
    Height = 16
    Caption = 'IR:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object labelRegIR: TLabel
    Left = 988
    Top = 447
    Width = 56
    Height = 16
    Caption = '00000000'
    Color = clMaroon
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
    Visible = False
  end
  object Label28: TLabel
    Left = 953
    Top = 471
    Width = 20
    Height = 16
    Caption = 'ST:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object labelRegST: TLabel
    Left = 988
    Top = 471
    Width = 49
    Height = 16
    Caption = '0000000'
    Color = clMaroon
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
    Visible = False
  end
  object Label30: TLabel
    Left = 954
    Top = 530
    Width = 32
    Height = 16
    Caption = 'Bus1:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label31: TLabel
    Left = 1009
    Top = 530
    Width = 7
    Height = 16
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuHighlight
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label32: TLabel
    Left = 954
    Top = 554
    Width = 34
    Height = 16
    Caption = 'IP en:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label34: TLabel
    Left = 954
    Top = 578
    Width = 49
    Height = 16
    Caption = 'RAM en:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label35: TLabel
    Left = 1009
    Top = 578
    Width = 7
    Height = 16
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuHighlight
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label36: TLabel
    Left = 954
    Top = 602
    Width = 47
    Height = 16
    Caption = 'ACC en:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label37: TLabel
    Left = 1009
    Top = 602
    Width = 7
    Height = 16
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuHighlight
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label38: TLabel
    Left = 954
    Top = 626
    Width = 39
    Height = 16
    Caption = 'AX en:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label39: TLabel
    Left = 1009
    Top = 626
    Width = 7
    Height = 16
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuHighlight
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label46: TLabel
    Left = 1054
    Top = 530
    Width = 38
    Height = 16
    Caption = 'IR set:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label47: TLabel
    Left = 1109
    Top = 530
    Width = 7
    Height = 16
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuHighlight
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label48: TLabel
    Left = 1054
    Top = 551
    Width = 37
    Height = 16
    Caption = 'IP set:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label49: TLabel
    Left = 1109
    Top = 552
    Width = 7
    Height = 16
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuHighlight
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label50: TLabel
    Left = 1054
    Top = 578
    Width = 52
    Height = 16
    Caption = 'RAM set:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label51: TLabel
    Left = 1109
    Top = 578
    Width = 7
    Height = 16
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuHighlight
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label62: TLabel
    Left = 1054
    Top = 725
    Width = 51
    Height = 16
    Caption = 'TMP set:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label63: TLabel
    Left = 1109
    Top = 725
    Width = 7
    Height = 16
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuHighlight
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label64: TLabel
    Left = 1054
    Top = 746
    Width = 39
    Height = 16
    Caption = 'FL set:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label65: TLabel
    Left = 1109
    Top = 746
    Width = 7
    Height = 16
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuHighlight
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label66: TLabel
    Left = 1054
    Top = 770
    Width = 28
    Height = 16
    Caption = 'BUS:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label33: TLabel
    Left = 1009
    Top = 555
    Width = 7
    Height = 16
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuHighlight
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label40: TLabel
    Left = 954
    Top = 653
    Width = 38
    Height = 16
    Caption = 'BX en:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label41: TLabel
    Left = 1009
    Top = 653
    Width = 7
    Height = 16
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuHighlight
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label42: TLabel
    Left = 954
    Top = 679
    Width = 39
    Height = 16
    Caption = 'CX en:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label43: TLabel
    Left = 1009
    Top = 679
    Width = 7
    Height = 16
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuHighlight
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label44: TLabel
    Left = 954
    Top = 702
    Width = 39
    Height = 16
    Caption = 'DX en:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label45: TLabel
    Left = 1009
    Top = 702
    Width = 7
    Height = 16
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuHighlight
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label52: TLabel
    Left = 1054
    Top = 601
    Width = 50
    Height = 16
    Caption = 'ACC set:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label53: TLabel
    Left = 1109
    Top = 602
    Width = 7
    Height = 16
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuHighlight
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label54: TLabel
    Left = 1054
    Top = 626
    Width = 42
    Height = 16
    Caption = 'AX set:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label55: TLabel
    Left = 1109
    Top = 626
    Width = 7
    Height = 16
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuHighlight
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label56: TLabel
    Left = 1054
    Top = 653
    Width = 41
    Height = 16
    Caption = 'BX set:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label57: TLabel
    Left = 1109
    Top = 654
    Width = 7
    Height = 16
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuHighlight
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label58: TLabel
    Left = 1054
    Top = 679
    Width = 42
    Height = 16
    Caption = 'CX set:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label59: TLabel
    Left = 1109
    Top = 679
    Width = 7
    Height = 16
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuHighlight
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label60: TLabel
    Left = 1054
    Top = 702
    Width = 42
    Height = 16
    Caption = 'DX set:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label61: TLabel
    Left = 1109
    Top = 703
    Width = 7
    Height = 16
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuHighlight
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label67: TLabel
    Left = 1109
    Top = 770
    Width = 56
    Height = 16
    Caption = '00000000'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuHighlight
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 792
    Width = 1206
    Height = 19
    Panels = <>
  end
  object aPanel1: TPanel
    Left = 542
    Top = 23
    Width = 664
    Height = 769
    Align = alRight
    BevelOuter = bvSpace
    TabOrder = 1
    object Label5: TLabel
      Left = 12
      Top = 8
      Width = 42
      Height = 13
      Caption = 'Memory:'
    end
    object Label68: TLabel
      Left = 382
      Top = 8
      Width = 274
      Height = 13
      Caption = 'EGA 160x120 64 color Text Mode 26x15  6x8 3120 bytes'
    end
    object Image1: TImage
      Left = 464
      Top = 27
      Width = 160
      Height = 120
    end
    object Label1: TLabel
      Left = 421
      Top = 294
      Width = 15
      Height = 16
      Caption = 'A:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object labelRegA: TLabel
      Left = 442
      Top = 294
      Width = 14
      Height = 16
      Caption = '00'
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Label2: TLabel
      Left = 491
      Top = 294
      Width = 13
      Height = 16
      Caption = 'B:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object labelRegB: TLabel
      Left = 510
      Top = 294
      Width = 14
      Height = 16
      Caption = '00'
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Label3: TLabel
      Left = 556
      Top = 294
      Width = 13
      Height = 16
      Caption = 'C:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object labelRegC: TLabel
      Left = 575
      Top = 294
      Width = 14
      Height = 16
      Caption = '00'
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Label4: TLabel
      Left = 624
      Top = 294
      Width = 14
      Height = 16
      Caption = 'D:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object labelRegD: TLabel
      Left = 644
      Top = 294
      Width = 14
      Height = 16
      Caption = '00'
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Label9: TLabel
      Left = 421
      Top = 323
      Width = 18
      Height = 16
      Caption = 'IP:'
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object labelRegIP: TLabel
      Left = 445
      Top = 323
      Width = 14
      Height = 16
      Caption = '00'
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Label6: TLabel
      Left = 484
      Top = 323
      Width = 21
      Height = 16
      Caption = 'SP:'
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      Visible = False
    end
    object labelRegSP: TLabel
      Left = 510
      Top = 323
      Width = 14
      Height = 16
      Caption = '00'
      Color = clGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
      Visible = False
    end
    object cmbHz: TComboBox
      Left = 421
      Top = 235
      Width = 75
      Height = 22
      Style = csOwnerDrawFixed
      ItemIndex = 2
      TabOrder = 0
      Text = '100 Hz'
      OnChange = cmbHzChange
      Items.Strings = (
        '1 Hz'
        '10 Hz'
        '100 Hz'
        '1 kHz'
        'MAX')
    end
    object cmbCPUType: TComboBox
      Left = 502
      Top = 235
      Width = 75
      Height = 22
      Style = csOwnerDrawFixed
      ItemIndex = 0
      TabOrder = 1
      Text = 'Simulator'
      OnChange = cmbCPUTypeChange
      Items.Strings = (
        'Simulator'
        'AON'
        'OVM')
    end
    object btnRun: TButton
      Left = 421
      Top = 263
      Width = 75
      Height = 25
      Caption = 'Run'
      TabOrder = 2
      OnClick = btnRunClick
    end
    object btnStep: TButton
      Left = 502
      Top = 263
      Width = 75
      Height = 25
      Caption = 'Step'
      TabOrder = 3
      OnClick = btnStepClick
    end
    object btnReset: TButton
      Left = 583
      Top = 263
      Width = 75
      Height = 25
      Caption = 'Reset'
      TabOrder = 4
      OnClick = btnResetClick
    end
    object sgMemory: TStringGrid
      Left = 9
      Top = 27
      Width = 397
      Height = 750
      Color = clWhite
      ColCount = 17
      DefaultColWidth = 22
      DefaultRowHeight = 22
      RowCount = 17
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      GradientStartColor = clMedGray
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected]
      ParentFont = False
      TabOrder = 5
    end
  end
  object mPanel1: TPanel
    Left = 0
    Top = 23
    Width = 542
    Height = 769
    Align = alClient
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 1
      Top = 471
      Width = 540
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 1
      ExplicitWidth = 603
    end
    object mEditor: TMemo
      Left = 1
      Top = 1
      Width = 540
      Height = 470
      Align = alClient
      Color = clHighlight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clYellow
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object mConsole: TMemo
      Left = 1
      Top = 474
      Width = 540
      Height = 294
      Align = alBottom
      Color = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clSilver
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 1
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1206
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object SpeedButton1: TSpeedButton
      Left = 1183
      Top = 0
      Width = 23
      Height = 23
      Align = alRight
      OnClick = SpeedButton1Click
      ExplicitLeft = 1
      ExplicitHeight = 22
    end
    object SpeedButton2: TSpeedButton
      Left = 0
      Top = 0
      Width = 23
      Height = 23
      Align = alLeft
      OnClick = SpeedButton2Click
      ExplicitHeight = 1206
    end
  end
  object MainMenu1: TMainMenu
    Left = 1144
    Top = 624
    object File1: TMenuItem
      Caption = 'File'
      object Openfile1: TMenuItem
        Caption = 'Open'
        ShortCut = 16463
        OnClick = Openfile1Click
      end
      object Save1: TMenuItem
        Caption = 'Save'
        ShortCut = 16467
        OnClick = Save1Click
      end
    end
    object est1: TMenuItem
      Caption = 'Edit'
      object UpperCase1: TMenuItem
        Caption = 'UpperCase'
        OnClick = UpperCase1Click
      end
      object LowerCase1: TMenuItem
        Caption = 'LowerCase'
        OnClick = LowerCase1Click
      end
    end
    object Compile1: TMenuItem
      Caption = 'Compile'
      object Assembly1: TMenuItem
        Caption = 'Assemble'
        ShortCut = 115
        OnClick = Assembly1Click
      end
      object OberonCompile1: TMenuItem
        Caption = 'Oberon Compile'
        ShortCut = 116
        OnClick = OberonCompile1Click
      end
      object CCompile1: TMenuItem
        Caption = 'C Compile'
      end
    end
    object VM1: TMenuItem
      Caption = 'Run'
      object LoadProgram1: TMenuItem
        Caption = 'Load from file'
        OnClick = LoadProgram1Click
      end
      object Saveprogram1: TMenuItem
        Caption = 'Save to file'
        OnClick = Saveprogram1Click
      end
      object Clearmemory1: TMenuItem
        Caption = 'Clear memory'
        OnClick = Clearmemory1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Run1: TMenuItem
        Caption = 'Run'
        ShortCut = 120
        OnClick = Run1Click
      end
      object Step1: TMenuItem
        Caption = 'Step'
        ShortCut = 118
        OnClick = Step1Click
      end
      object Reset1: TMenuItem
        Caption = 'Reset'
        ShortCut = 119
        OnClick = Reset1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object LoadOVM1: TMenuItem
        Caption = 'Load OVM-program'
        OnClick = LoadOVM1Click
      end
    end
    object Settings1: TMenuItem
      Caption = 'Settings'
      object Font1: TMenuItem
        Caption = 'Font'
        OnClick = Font1Click
      end
      object Color1: TMenuItem
        Caption = 'Color'
        OnClick = Color1Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 1144
    Top = 672
  end
  object SaveDialog1: TSaveDialog
    Left = 1144
    Top = 720
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = Timer1Timer
    Left = 1144
    Top = 584
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Left = 1144
    Top = 544
  end
  object ColorDialog1: TColorDialog
    Left = 1144
    Top = 504
  end
end
