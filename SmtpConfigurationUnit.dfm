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
  OnShow = FormShow
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
    MultiLine = True
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Local'
      DesignSize = (
        341
        333)
      object GroupBox1: TGroupBox
        Left = 5
        Top = 3
        Width = 331
        Height = 110
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Listening Server'
        Constraints.MinWidth = 311
        TabOrder = 0
        DesignSize = (
          331
          110)
        object ServerPortUpDown: TUpDown
          Left = 133
          Top = 74
          Width = 16
          Height = 21
          Associate = ServerPort
          Min = 1
          Max = 65535
          Position = 25
          TabOrder = 3
        end
        object ServerPort: TLabeledEdit
          Left = 84
          Top = 74
          Width = 49
          Height = 21
          EditLabel.Width = 20
          EditLabel.Height = 13
          EditLabel.Caption = 'Port'
          LabelPosition = lpLeft
          LabelSpacing = 10
          TabOrder = 2
          Text = '25'
          OnChange = OnConfigurationChange
        end
        object ServerSslMode: TComboBox
          Left = 155
          Top = 74
          Width = 90
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 4
          Text = 'Optional SSL'
          TextHint = 'SSL Mode'
          OnChange = OnConfigurationChange
          Items.Strings = (
            'Optional SSL'
            'Forced SSL')
        end
        object ServerIp: TLabeledEdit
          Left = 84
          Top = 47
          Width = 110
          Height = 21
          EditLabel.Width = 10
          EditLabel.Height = 13
          EditLabel.Caption = 'IP'
          LabelPosition = lpLeft
          LabelSpacing = 10
          TabOrder = 1
          Text = '0.0.0.0'
          TextHint = '<User name>'
          OnChange = OnConfigurationChange
        end
        object ServerName: TLabeledEdit
          Left = 84
          Top = 20
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
          OnChange = OnConfigurationChange
        end
      end
      object GroupBox3: TGroupBox
        Left = 5
        Top = 119
        Width = 331
        Height = 79
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Authentication'
        TabOrder = 1
        DesignSize = (
          331
          79)
        object ServerPassword: TLabeledEdit
          Left = 84
          Top = 47
          Width = 233
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 46
          EditLabel.Height = 13
          EditLabel.Caption = 'Password'
          LabelPosition = lpLeft
          LabelSpacing = 10
          PasswordChar = #9679
          TabOrder = 1
          TextHint = '<Password>'
          OnChange = OnConfigurationChange
        end
        object ServerUserName: TLabeledEdit
          Left = 84
          Top = 20
          Width = 233
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 51
          EditLabel.Height = 13
          EditLabel.Caption = 'User name'
          LabelPosition = lpLeft
          LabelSpacing = 10
          TabOrder = 0
          TextHint = '<User name>'
          OnChange = OnConfigurationChange
        end
      end
      object GroupBox5: TGroupBox
        Left = 3
        Top = 204
        Width = 331
        Height = 105
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Queue'
        TabOrder = 2
        DesignSize = (
          331
          105)
        object QueueDirectory: TLabeledEdit
          Left = 82
          Top = 20
          Width = 203
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 44
          EditLabel.Height = 13
          EditLabel.Caption = 'Directory'
          LabelPosition = lpLeft
          LabelSpacing = 10
          TabOrder = 0
          OnChange = OnConfigurationChange
        end
        object SelectFolder: TButton
          Left = 291
          Top = 20
          Width = 24
          Height = 21
          Anchors = [akTop, akRight]
          Caption = '...'
          TabOrder = 1
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Remote'
      ImageIndex = 1
      DesignSize = (
        341
        333)
      object GroupBox2: TGroupBox
        Left = 5
        Top = 3
        Width = 333
        Height = 78
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Remote Server'
        Constraints.MinWidth = 313
        TabOrder = 0
        DesignSize = (
          333
          78)
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
          OnChange = OnConfigurationChange
        end
        object ClientPort: TLabeledEdit
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
          OnChange = OnConfigurationChange
        end
        object ClientPortUpDown: TUpDown
          Left = 133
          Top = 47
          Width = 16
          Height = 21
          Associate = ClientPort
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
          OnChange = OnConfigurationChange
          Items.Strings = (
            'No SSL'
            'Require SSL')
        end
      end
      object GroupBox4: TGroupBox
        Left = 3
        Top = 87
        Width = 335
        Height = 82
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Authentication'
        TabOrder = 1
        DesignSize = (
          335
          82)
        object ClientPassword: TLabeledEdit
          Left = 86
          Top = 47
          Width = 161
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 46
          EditLabel.Height = 13
          EditLabel.Caption = 'Password'
          LabelPosition = lpLeft
          LabelSpacing = 10
          PasswordChar = #9679
          TabOrder = 1
          TextHint = '<Password>'
          OnChange = OnConfigurationChange
        end
        object ClientUserName: TLabeledEdit
          Left = 86
          Top = 20
          Width = 161
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 52
          EditLabel.Height = 13
          EditLabel.Caption = 'User Name'
          LabelPosition = lpLeft
          LabelSpacing = 10
          TabOrder = 0
          TextHint = '<User Name>'
          OnChange = OnConfigurationChange
        end
        object ClientTest: TButton
          Left = 253
          Top = 20
          Width = 68
          Height = 48
          Anchors = [akTop, akRight]
          Caption = 'SEND TEST MAIL'
          TabOrder = 2
          WordWrap = True
          OnClick = ClientTestClick
        end
      end
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
    Enabled = False
    TabOrder = 1
    OnClick = ButtonApplyClick
  end
end
