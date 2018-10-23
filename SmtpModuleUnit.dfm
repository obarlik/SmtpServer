object SmtpModule: TSmtpModule
  OldCreateOrder = False
  Height = 307
  Width = 332
  object MailServer: TIdSMTPServer
    Bindings = <>
    DefaultPort = 465
    IOHandler = SslHandlerServer
    MaxConnections = 1000
    CommandHandlers = <>
    ExceptionReply.Code = '500'
    ExceptionReply.Text.Strings = (
      'Unknown Internal Error')
    Greeting.Code = '220'
    Greeting.Text.Strings = (
      'Welcome to the our SMTP Server')
    MaxConnectionReply.Code = '300'
    MaxConnectionReply.Text.Strings = (
      'Too many connections. Try again later.')
    ReplyTexts = <>
    ReplyUnknownCommand.Code = '500'
    ReplyUnknownCommand.Text.Strings = (
      'Syntax Error')
    ReplyUnknownCommand.EnhancedCode.StatusClass = 5
    ReplyUnknownCommand.EnhancedCode.Subject = 5
    ReplyUnknownCommand.EnhancedCode.Details = 2
    ReplyUnknownCommand.EnhancedCode.Available = True
    ReplyUnknownCommand.EnhancedCode.ReplyAsStr = '5.5.2'
    ServerName = 'Indy SMTP Server'
    UseTLS = utUseImplicitTLS
    Left = 80
    Top = 24
  end
  object MailClient: TIdSMTP
    IOHandler = SslHandlerClient
    SASLMechanisms = <>
    Left = 24
    Top = 24
  end
  object SslHandlerServer: TIdServerIOHandlerSSLOpenSSL
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 88
    Top = 96
  end
  object SslHandlerClient: TIdSSLIOHandlerSocketOpenSSL
    Destination = ':25'
    MaxLineAction = maException
    Port = 25
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 24
    Top = 96
  end
end
