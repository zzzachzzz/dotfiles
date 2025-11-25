# Useful references:
#
# https://superuser.com/questions/992511/emulate-a-keyboard-button-via-the-command-line
# https://ss64.com/vb/sendkeys.html
# https://social.technet.microsoft.com/Forums/windowsserver/en-US/96b339e2-e9da-4802-a66d-be619aeb21ac/execute-function-one-time-in-every-10-mins-in-windows-powershell?forum=winserverpowershell
# https://learn-powershell.net/2013/02/08/powershell-and-events-object-events/
#
# Future enhancements - use events rather than an infinite loop
$wsh = New-Object -ComObject WScript.Shell
while (1) {
  # Send Shift+F15 - this is the least intrusive key combination I can think of and is also used as default by:
  # http://www.zhornsoftware.co.uk/caffeine/
  # Unfortunately the above triggers a malware alert on Sophos so I needed to find a native solution - hence this script...
  $wsh.SendKeys('+{F15}')
  Start-Sleep -seconds 59
}

