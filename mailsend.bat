@Rem Scripted by Deon van Zyl
@echo ---Start--  >> sendmail.txt

Rem -----Set Enviroment Vars---

@SET required_space=Threshold
@SET source_email=websystems@somesystem.com
@SET destination_email=deonvz@somesystem.com
@SET mailserver=10.0.0.1
@SET domain=somesystem.com
Rem ----------------------------

date /t >> sendmail.txt
time /t >> sendmail.txt
MAILSEND -d %domain% -smtp %mailserver% -t %destination_email% -f %source_email% -sub "ALERT ! %computername% has less than the set %required_space%" -v < msg.txt >> sendmail.txt
@echo ---ENd--  >> sendmail.txt
@echo -----------  >> sendmail.txt
exit