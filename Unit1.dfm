object Form1: TForm1
  Left = 19
  Top = 167
  Width = 1267
  Height = 450
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 8
    Top = 16
    Width = 393
    Height = 377
  end
  object Label1: TLabel
    Left = 898
    Top = 88
    Width = 121
    Height = 13
    Caption = #1052#1080#1085#1080#1084#1072#1083#1100#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077
  end
  object Label2: TLabel
    Left = 896
    Top = 112
    Width = 127
    Height = 13
    Caption = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077
  end
  object Label3: TLabel
    Left = 897
    Top = 139
    Width = 38
    Height = 13
    Caption = #1044#1077#1083#1100#1090#1072
  end
  object Label6: TLabel
    Left = 895
    Top = 166
    Width = 70
    Height = 13
    Caption = #1044#1077#1083#1077#1085#1080#1081' '#1087#1086' X'
  end
  object Label7: TLabel
    Left = 896
    Top = 191
    Width = 70
    Height = 13
    Caption = #1044#1077#1083#1077#1085#1080#1081' '#1087#1086' Y'
  end
  object Chart1: TChart
    Left = 408
    Top = 14
    Width = 465
    Height = 377
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'TChart')
    Legend.Visible = False
    View3D = False
    TabOrder = 0
    object Series1: TPointSeries
      Marks.ArrowLength = 0
      Marks.Visible = False
      SeriesColor = clRed
      Pointer.HorizSize = 1
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.VertSize = 1
      Pointer.Visible = True
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
    object Series2: TPointSeries
      Marks.ArrowLength = 0
      Marks.Visible = False
      SeriesColor = clGreen
      Pointer.HorizSize = 1
      Pointer.InflateMargins = True
      Pointer.Pen.Color = clRed
      Pointer.Style = psCircle
      Pointer.VertSize = 1
      Pointer.Visible = True
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
    object Series3: TPointSeries
      Marks.ArrowLength = 0
      Marks.Visible = False
      SeriesColor = clYellow
      Pointer.HorizSize = 1
      Pointer.InflateMargins = True
      Pointer.Pen.Color = clLime
      Pointer.Style = psCircle
      Pointer.VertSize = 1
      Pointer.Visible = True
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
    object Series4: TPointSeries
      Marks.ArrowLength = 0
      Marks.Visible = False
      SeriesColor = clBlue
      Pointer.HorizSize = 1
      Pointer.InflateMargins = True
      Pointer.Pen.Color = clBlue
      Pointer.Style = psCircle
      Pointer.VertSize = 1
      Pointer.Visible = True
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
  end
  object Button3: TButton
    Left = 888
    Top = 16
    Width = 201
    Height = 22
    Caption = #1048#1085#1080#1094#1080#1072#1083#1080#1079#1072#1094#1080#1103
    TabOrder = 1
    OnClick = Button3Click
  end
  object Button1: TButton
    Left = 888
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Chart'
    Enabled = False
    TabOrder = 2
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 1049
    Top = 83
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 3
    Text = 'Edit1'
    OnExit = Edit1Exit
  end
  object Edit2: TEdit
    Left = 1050
    Top = 110
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 4
    Text = 'Edit2'
    OnExit = Edit2Exit
  end
  object Edit3: TEdit
    Left = 1051
    Top = 136
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 5
    Text = 'Edit3'
    OnExit = Edit3Exit
  end
  object Edit6: TEdit
    Left = 1051
    Top = 160
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 6
    Text = 'Edit6'
    OnExit = Edit6Exit
  end
  object Edit7: TEdit
    Left = 1051
    Top = 185
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 7
    Text = 'Edit7'
    OnExit = Edit7Exit
  end
  object CheckBox1: TCheckBox
    Left = 903
    Top = 246
    Width = 153
    Height = 17
    Caption = #1058#1088#1077#1073#1091#1077#1090#1089#1103' '#1090#1086#1095#1085#1086#1089#1090#1100
    Enabled = False
    TabOrder = 8
    OnClick = CheckBox1Click
  end
  object CheckBox2: TCheckBox
    Left = 903
    Top = 270
    Width = 225
    Height = 17
    Caption = #1058#1077#1088#1084#1080#1085#1072#1083#1100#1085#1099#1077' '#1079#1085#1072#1095#1077#1085#1080#1103' '#1085#1072' '#1086#1089#1103#1093
    Enabled = False
    TabOrder = 9
    OnClick = CheckBox2Click
  end
end
