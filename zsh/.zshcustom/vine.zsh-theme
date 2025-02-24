autoload -Uz vcs_info
zstyle ':vcs_info:git*' formats ' %F{011}[%b]%f'
precmd() { vcs_info }

time='[%*]'
user='%F{green}%n%f'
hostname='%F{blue}%m%f'
workingDir='%F{blue}%1~%f'

setopt promptsubst
PROMPT='${time} ${user}@${hostname}: ${workingDir}${vcs_info_msg_0_:+${vcs_info_msg_0_}} %F{green}%%%f '

