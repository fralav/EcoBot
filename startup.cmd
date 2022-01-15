ECHO OFF
ECHO [%DATE%] [%TIME%] - [ngrok] Initialize >> startupLogs.log
START ngrok.exe http 8080
ECHO [%DATE%] [%TIME%] - [ngrok] Terminated [Return: %errorlevel%] >> startupLogs.log
ECHO [%DATE%] [%TIME%] - [webhook] Initialize >> startupLogs.log
START python webhook.py
ECHO [%DATE%] [%TIME%] - [webhook] Terminated [Return: %errorlevel%] >> startupLogs.log
ECHO [%DATE%] [%TIME%] - end   >> startupLogs.log

exit

