alias cmd="cmd.exe"
alias psh="powershell.exe"
alias explorer="explorer.exe"
alias subl="subl.exe"
alias code="code.exe"
alias chrome="chrome.exe"
# For VcXsrv to sync WSL & Windows clipboards
export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
export LIBGL_ALWAYS_INDIRECT=1
