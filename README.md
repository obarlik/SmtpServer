# SmtpServer
Delphi SMTP server application

This project fills a gap between an SMTP service provider and applications.
Applications need a unified control mechanism over sent mails to apply some business rules on them.
And SMTP services have some limitations like sent mail count per second limits or bounce limits.

This project provides a bridge by applying logic to sent mails to overcome these situations.
