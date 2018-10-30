object ConfigurationForm: TConfigurationForm
  Left = 0
  Top = 0
  Caption = 'Configuration'
  ClientHeight = 411
  ClientWidth = 364
  Color = clBtnFace
  Constraints.MinHeight = 450
  Constraints.MinWidth = 380
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    364
    411)
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 349
    Height = 361
    ActivePage = TabSheet1
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Connection'
      DesignSize = (
        341
        333)
      object GroupBox1: TGroupBox
        Left = 5
        Top = 3
        Width = 331
        Height = 169
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Listening Server'
        Constraints.MinWidth = 330
        TabOrder = 0
        DesignSize = (
          331
          169)
        object ServerPort: TUpDown
          Left = 133
          Top = 79
          Width = 16
          Height = 21
          Associate = LabeledEdit1
          Min = 1
          Max = 65535
          Position = 25
          TabOrder = 3
        end
        object LabeledEdit1: TLabeledEdit
          Left = 84
          Top = 79
          Width = 49
          Height = 21
          EditLabel.Width = 20
          EditLabel.Height = 13
          EditLabel.Caption = 'Port'
          LabelPosition = lpLeft
          LabelSpacing = 10
          TabOrder = 2
          Text = '25'
        end
        object ServerUserName: TLabeledEdit
          Left = 84
          Top = 106
          Width = 233
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 51
          EditLabel.Height = 13
          EditLabel.Caption = 'User name'
          LabelPosition = lpLeft
          LabelSpacing = 10
          TabOrder = 6
          TextHint = '<User name>'
        end
        object ServerPassword: TLabeledEdit
          Left = 84
          Top = 133
          Width = 233
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 46
          EditLabel.Height = 13
          EditLabel.Caption = 'Password'
          LabelPosition = lpLeft
          LabelSpacing = 10
          PasswordChar = #9679
          TabOrder = 7
          TextHint = '<Password>'
        end
        object ServerSslMode: TComboBox
          Left = 155
          Top = 79
          Width = 90
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 4
          Text = 'Optional SSL'
          TextHint = 'SSL Mode'
          Items.Strings = (
            'Optional SSL'
            'Forced SSL')
        end
        object ServerStatus: TComboBox
          Left = 251
          Top = 79
          Width = 68
          Height = 21
          Style = csDropDownList
          ItemIndex = 1
          TabOrder = 5
          Text = 'Active'
          TextHint = '<Server Status>'
          Items.Strings = (
            'Passive'
            'Active')
        end
        object ServerIp: TLabeledEdit
          Left = 84
          Top = 52
          Width = 233
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 10
          EditLabel.Height = 13
          EditLabel.Caption = 'IP'
          LabelPosition = lpLeft
          LabelSpacing = 10
          TabOrder = 1
          Text = '0.0.0.0'
          TextHint = '<User name>'
        end
        object ServerName: TLabeledEdit
          Left = 84
          Top = 25
          Width = 233
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 65
          EditLabel.Height = 13
          EditLabel.Caption = 'Service Name'
          LabelPosition = lpLeft
          LabelSpacing = 10
          TabOrder = 0
          Text = 'My SMTP'
          TextHint = '<Server name>'
        end
      end
      object GroupBox2: TGroupBox
        Left = 3
        Top = 178
        Width = 333
        Height = 143
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Remote Server'
        Constraints.MinWidth = 330
        TabOrder = 1
        DesignSize = (
          333
          143)
        object ClientHost: TLabeledEdit
          Left = 84
          Top = 20
          Width = 235
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 64
          EditLabel.Height = 13
          EditLabel.Caption = 'Host Address'
          LabelPosition = lpLeft
          LabelSpacing = 10
          TabOrder = 0
          TextHint = '<Host Address>'
        end
        object ClientPassword: TLabeledEdit
          Left = 84
          Top = 102
          Width = 235
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 46
          EditLabel.Height = 13
          EditLabel.Caption = 'Password'
          LabelPosition = lpLeft
          LabelSpacing = 10
          PasswordChar = #9679
          TabOrder = 5
          TextHint = '<Password>'
        end
        object ClientUserName: TLabeledEdit
          Left = 84
          Top = 75
          Width = 235
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 52
          EditLabel.Height = 13
          EditLabel.Caption = 'User Name'
          LabelPosition = lpLeft
          LabelSpacing = 10
          TabOrder = 4
          TextHint = '<User Name>'
        end
        object LabeledEdit2: TLabeledEdit
          Left = 84
          Top = 47
          Width = 49
          Height = 21
          EditLabel.Width = 20
          EditLabel.Height = 13
          EditLabel.Caption = 'Port'
          LabelPosition = lpLeft
          LabelSpacing = 10
          TabOrder = 1
          Text = '25'
        end
        object ClientPort: TUpDown
          Left = 133
          Top = 47
          Width = 16
          Height = 21
          Associate = LabeledEdit2
          Min = 1
          Max = 65535
          Position = 25
          TabOrder = 2
        end
        object ClientSslMode: TComboBox
          Left = 155
          Top = 47
          Width = 90
          Height = 21
          Style = csDropDownList
          ItemIndex = 1
          TabOrder = 3
          Text = 'Require SSL'
          TextHint = 'SSL Mode'
          Items.Strings = (
            'No SSL'
            'Require SSL')
        end
        object ClientTest: TButton
          Left = 251
          Top = 46
          Width = 69
          Height = 23
          Caption = 'Test'
          TabOrder = 6
          OnClick = ClientTestClick
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Authentication'
      ImageIndex = 1
    end
  end
  object ButtonClose: TButton
    Left = 187
    Top = 375
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    ModalResult = 2
    TabOrder = 2
  end
  object ButtonApply: TButton
    Left = 273
    Top = 375
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Apply'
    TabOrder = 1
    OnClick = ButtonApplyClick
  end
end
