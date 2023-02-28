object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = #1042#1080#1088#1090#1091#1072#1083#1100#1085#1099#1081' '#1087#1088#1086#1094#1077#1089#1089#1086#1088' 8-bit-AON'
  ClientHeight = 811
  ClientWidth = 1200
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
  object Label1: TLabel
    Left = 954
    Top = 326
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
  object Label2: TLabel
    Left = 1024
    Top = 326
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
  object Label3: TLabel
    Left = 1088
    Top = 326
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
  object Label4: TLabel
    Left = 1152
    Top = 326
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
  object labelRegA: TLabel
    Left = 984
    Top = 326
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
  object labelRegB: TLabel
    Left = 1048
    Top = 326
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
  object labelRegC: TLabel
    Left = 1112
    Top = 326
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
  object labelRegD: TLabel
    Left = 1178
    Top = 326
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
    Left = 954
    Top = 355
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
    Left = 984
    Top = 355
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
  object Label11: TLabel
    Left = 1024
    Top = 379
    Width = 31
    Height = 16
    Caption = 'TMP:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object labelRegTMP: TLabel
    Left = 1054
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
  end
  object labelRegACC: TLabel
    Left = 984
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
  end
  object labelRegMAR: TLabel
    Left = 984
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
    Left = 954
    Top = 427
    Width = 19
    Height = 16
    Caption = 'IR:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object labelRegIR: TLabel
    Left = 984
    Top = 427
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
  end
  object Label28: TLabel
    Left = 954
    Top = 451
    Width = 20
    Height = 16
    Caption = 'ST:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object labelRegST: TLabel
    Left = 984
    Top = 451
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
  end
  object Label62: TLabel
    Left = 1054
    Top = 722
    Width = 51
    Height = 16
    Caption = 'TMP set:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label63: TLabel
    Left = 1109
    Top = 722
    Width = 7
    Height = 16
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuHighlight
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
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
  end
  object Image1: TImage
    Left = 985
    Top = 27
    Width = 160
    Height = 120
  end
  object Label68: TLabel
    Left = 926
    Top = 0
    Width = 274
    Height = 13
    Caption = 'EGA 160x120 64 color Text Mode 26x15  6x8 3120 bytes'
  end
  object Label5: TLabel
    Left = 540
    Top = 0
    Width = 42
    Height = 13
    Caption = 'Memory:'
  end
  object Label69: TLabel
    Left = 8
    Top = 0
    Width = 41
    Height = 13
    Caption = 'Editor: 0'
  end
  object Label70: TLabel
    Left = 8
    Top = 648
    Width = 42
    Height = 13
    Caption = 'Console:'
  end
  object sgMemory: TStringGrid
    Left = 540
    Top = 19
    Width = 397
    Height = 767
    ColCount = 17
    DefaultColWidth = 22
    DefaultRowHeight = 22
    RowCount = 17
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected]
    ParentFont = False
    TabOrder = 0
  end
  object mEditor: TMemo
    Left = 8
    Top = 19
    Width = 526
    Height = 623
    ScrollBars = ssVertical
    TabOrder = 1
    OnChange = mEditorChange
  end
  object mConsole: TMemo
    Left = 8
    Top = 664
    Width = 526
    Height = 122
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object ComboBox1: TComboBox
    Left = 951
    Top = 267
    Width = 75
    Height = 22
    Style = csOwnerDrawFixed
    ItemIndex = 0
    TabOrder = 3
    Text = '1 kHz'
    Items.Strings = (
      '1 kHz')
  end
  object btnRun: TButton
    Left = 951
    Top = 295
    Width = 75
    Height = 25
    Caption = 'Run'
    TabOrder = 4
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 792
    Width = 1200
    Height = 19
    Panels = <>
  end
  object btnStep: TButton
    Left = 1032
    Top = 295
    Width = 75
    Height = 25
    Caption = 'Step'
    TabOrder = 6
    OnClick = btnStepClick
  end
  object btnReset: TButton
    Left = 1113
    Top = 295
    Width = 75
    Height = 25
    Caption = 'Reset'
    TabOrder = 7
    OnClick = btnResetClick
  end
  object ComboBox2: TComboBox
    Left = 1032
    Top = 267
    Width = 75
    Height = 22
    Style = csOwnerDrawFixed
    ItemIndex = 0
    TabOrder = 8
    Text = 'Simulator'
    Items.Strings = (
      'Simulator'
      'AON')
  end
  object MainMenu1: TMainMenu
    Left = 1144
    Top = 624
    object File1: TMenuItem
      Caption = 'Compiler'
      object Openfile1: TMenuItem
        Caption = 'Open source'
      end
      object Save1: TMenuItem
        Caption = 'Save source'
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Assembly1: TMenuItem
        Caption = 'Assemble'
      end
      object OberonCompile1: TMenuItem
        Caption = 'Oberon Compile'
      end
      object CCompile1: TMenuItem
        Caption = 'C Compile'
      end
    end
    object VM1: TMenuItem
      Caption = 'VM'
      object LoadProgram1: TMenuItem
        Caption = 'Load program'
        OnClick = LoadProgram1Click
      end
      object Saveprogram1: TMenuItem
        Caption = 'Save program'
      end
      object Clearmemory1: TMenuItem
        Caption = 'Clear memory'
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Run1: TMenuItem
        Caption = 'Run'
      end
      object Step1: TMenuItem
        Caption = 'Step'
      end
      object Reset1: TMenuItem
        Caption = 'Reset'
      end
    end
    object est1: TMenuItem
      Caption = 'Test'
      object UpperCase1: TMenuItem
        Caption = 'UpperCase'
        OnClick = UpperCase1Click
      end
      object LowerCase1: TMenuItem
        Caption = 'LowerCase'
        OnClick = LowerCase1Click
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
end
