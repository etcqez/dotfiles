if status is-interactive
set -U fish_greeting
#
#
#
#
############################## test ##############################
function backward-until-space
    set -l cursor_pos (commandline -C)
    set -l cmd (commandline)

    for i in (seq $cursor_pos -1 1)
        if test (string sub -s $i -l 1 -- $cmd) = " "
            # 跳过连续的空格
            while test $i -gt 1 -a (string sub -s $i -l 1 -- $cmd) = " "
                set i (math $i - 1)
            end
            commandline -C $i
            break
        end
    end
end
bind alt-B backward-until-space

function forward-to-space
    set -l cmdline (commandline)
    set -l cursor_pos (commandline -C)
    set -l remaining_str (string sub -s (math $cursor_pos + 1) -- "$cmdline")

    # 找到下一个空格的位置
    set -l next_space_pos (string match -r '^[^ ]*\ ' -- "$remaining_str")
    if test -n "$next_space_pos"
        set -l jump_length (string length -- "$next_space_pos")
        commandline -C (math $cursor_pos + $jump_length)
    else
        # 如果没有空格，就跳到行尾
        commandline -C (string length -- "$cmdline")
    end
end
bind alt-F forward-to-space  # Alt+f

# function forward-until-space
#     set -l cursor_pos (commandline -C)
#     set -l cmd (commandline)
#     set -l cmd_length (string length $cmd)

#     for i in (seq (math $cursor_pos + 1) $cmd_length)
#         if test (string sub -s $i -l 1 -- $cmd) = " "
#             # 跳过连续的空格
#             while test $i -lt $cmd_length -a (string sub -s $i -l 1 -- $cmd) = " "
#                 set i (math $i + 1)
#             end
#             commandline -C $i
#             break
#         end
#     end
# end
# bind alt-F forward-until-space
#
#
#
#
############################## 改变shell需更改 ##############################
# function e
#     # 检查 emacs daemon 是否在运行

#     if not pgrep -f "emacs" > /dev/null
#         # 如果未运行，启动 emacs daemon
#         emacs --daemon
#     end

#     # 使用 emacsclient 打开文件
#     emacsclient -nw $argv
# end
alias e="TERM=xterm-emacs emacsclient -nw"
alias .="source ~/.config/fish/config.fish"

# alias e='TERM=xterm-emacs emacsclient -nw -c -a ""'
export EDITOR='e'

############################## 键绑定 ##############################
    bind \e\x7f 'commandline -f backward-kill-word'
    bind \cw 'commandline -f backward-kill-bigword'
    # Ctrl+p - 智能历史搜索
    bind \cp 'history-prefix-search-backward'
    # Ctrl+n - 智能历史搜索
    bind \cn 'history-prefix-search-forward'

#
#
#
#
############################## 多系统 ##############################
if test (uname) = "Darwin"
  # Mac 配置
  set -gx PATH "/usr/local/opt/coreutils/libexec/gnubin" $PATH
  set -gx HOMEBREW_NO_AUTO_UPDATE 1
  set -gx LDFLAGS "-L/usr/local/opt/qt@5/lib"
  set -gx CPPFLAGS "-I/usr/local/opt/qt@5/include"
  set -gx PKG_CONFIG_PATH "/usr/local/opt/qt@5/lib/pkgconfig"
  alias lsblk="diskutil list"
  alias a="ls -hA"
  alias l="ls"
  alias ll="ls -lh"
  alias al="ls -lhA"
  alias netstat="netstat -an | grep LISTEN"

  # 切换到 Finder 当前目录
function pfd
  osascript 2> /dev/null -e '
tell application "Finder"
  return POSIX path of (target of window 1 as alias)
end tell'
end

  function cdf
    cd (pfd)
  end

  function rm
    set DIR (mktemp -d /tmp/trash-(date +%F_%H-%M-%S)_XXXXXX)
    mv $argv $DIR
  end
else
  # Linux 配置
  alias a="ls -hA --group-directories-first"
  alias l="ls --group-directories-first"
  alias ll="ls -lh --group-directories-first"
  alias al="ls -lhA --group-directories-first"
  alias sl="sudo ls --color=tty -lhAt"
  alias hx="helix"

  function rm
    set DIR (mktemp -d /tmp/trash-(date +%F_%H-%M-%S)_XXXXXX)
    mv -t $DIR $argv
  end
end
#
#
#
#
############################## alias ##############################
alias lg="lazygit"
alias du="sudo du -sh"
alias df="df -hP"
alias mkdir="mkdir -pv"
alias h="history -50"
alias nf="neofetch"

## macos
alias b="brew install"
alias yq="yabai -m query --windows | grep app"

## ddcutil 亮度控制
alias d+="ddcutil -b 5 setvcp 10 + 5"
alias d-="ddcutil -b 5 setvcp 10 - 5"

## git
# alias gi="git init -b main"
alias gi="git init;gam"
alias gam="git add * .*;git commit -am '更新配置文件'"
alias gg="git remote get-url origin"
alias grr="git remote remove origin"
alias gra="git remote add origin"
alias gs="git status"
alias gcl="git clone --depth 1"
alias ga="git add"
alias gc="git commit"
alias gps="git push --set-upstream origin main"
alias gpl="git pull"
alias gl="git log"
alias gp="gam;git push"

## proxy
# alias v2="env all_proxy='socks://127.0.0.1:20170' https_proxy='http://127.0.0.1:20170' http_proxy='http://127.0.0.1:20170'"
# alias cl="env all_proxy='socks://127.0.0.1:7890' https_proxy='http://127.0.0.1:7890' http_proxy='http://127.0.0.1:7890'"
#export http_proxy="http://127.0.0.1:20122"; export https_proxy="http://127.0.0.1:20122"
# alias sb='export http_proxy="http://127.0.0.1:20122"; export https_proxy="http://127.0.0.1:20122"'
# alias ge='export http_proxy="http://127.0.0.1:9910"; export https_proxy="http://127.0.0.1:9910"'
# alias ge5='export http_proxy="http://127.0.0.1:19999"; export https_proxy="http://127.0.0.1:19999"'
# alias hi='export http_proxy="http://127.0.0.1:12334"; export https_proxy="http://127.0.0.1:12334"'
# alias ka='export http_proxy="http://127.0.0.1:3067"; export https_proxy="http://127.0.0.1:3067"'
# alias va='export http_proxy="http://127.0.0.1:20171"; export https_proxy="http://127.0.0.1:20171"'
function xy --description "动态设置 HTTP/HTTPS 代理端口"
    if test (count $argv) -eq 0
        echo "使用方法: set_proxy <端口号>"
        echo "当前代理设置:"
        echo "http_proxy: $http_proxy"
        echo "https_proxy: $https_proxy"
        return 1
    end
    
    set -l port $argv[1]
    
    # 验证端口号是否合法
    if not string match -qr '^[0-9]+$' -- $port
        echo "错误: 端口号必须是数字" >&2
        return 1
    end
    
    if test $port -lt 1 -o $port -gt 65535
        echo "错误: 端口号必须在 1-65535 范围内" >&2
        return 1
    end
    
    # 设置代理
    set -gx http_proxy "http://127.0.0.1:$port"
    set -gx https_proxy "http://127.0.0.1:$port"
    
    echo "代理已设置为:"
    echo "http_proxy: $http_proxy"
    echo "https_proxy: $https_proxy"
end
## 字体
alias font="fc-list :lang=zh"
alias fcc="sudo fc-cache -f -v"
## 前端
alias cnpm="npm --registry=https://registry.npmmirror.com  --cache=$HOME/.npm/.cache/cnpm  --disturl=https://npmmirror.com/mirrors/node  --userconfig=$HOME/.cnpmrc"

## android
alias an="screen waydroid show-full-ui"
alias anstop="waydroid session stop"

## cd
alias cf="cd ~/.config/"
alias cl="cd ~/.local/share/"
alias cm="cd ~/myconfig/"
alias desk="cd ~/Desktop/"
alias docu="cd ~/Documents/"
alias ..='cd ..'
alias ...='cd ../..'

## 编辑器
alias zs="$EDITOR ~/myconfig/zshrc"
alias fc="$EDITOR ~/.config/fish/config.fish"
alias doc="cd ~/myconfig/doc"
alias dot="cd ~/dotfiles/"
alias docc="$EDITOR ~/myconfig/doc/c.sh"
alias docj="$EDITOR ~/myconfig/doc/java.sh"
alias doce="$EDITOR ~/myconfig/doc/emacs.sh"
alias docv="$EDITOR ~/myconfig/doc/vim.sh"
alias docn="$EDITOR ~/myconfig/doc/nvim.sh"
alias docjs="$EDITOR ~/myconfig/doc/js.sh"
alias docnano="$EDITOR ~/myconfig/doc/nano.sh"
alias zp="$EDITOR ~/myconfig/_zprofile"
# alias vr="ee ~/.vim/vimrc"
alias n="nvim"
alias v="nvim"
alias vi="nvim"
alias sv="sudo nvim"
alias fv="nvim \$(fzf) "
alias emacsbef="emacs -nw --init-directory=~/.emacs.d.bef -bg black"
alias doom="emacs -nw --init-directory=~/.config/emacs"

## docker
alias eee="docker attach --detach-keys 'ctrl-z,ctrl-q' emacs"
alias d="docker"
alias dup="docker update"
alias oneemacs="docker run -it --rm silex/emacs"
alias dex="docker exec -it"
alias dat="docker attach"
alias dim="docker images"
alias dsp="docker stop"
alias dst="docker start"
alias dps="docker ps"
alias dpa="docker ps -a"
alias dre="docker restart"
alias ddf="docker system df"
alias drm="docker rm"
alias dri="docker rmi"

## mysql
alias my='mysql -uroot -pf'
alias sql='mysql -uroot -pf mysql'

## cp
alias cp="cp -aiv"
#同名文件只覆盖旧的
alias cpuv="\cp -auv"
#同名文件先备份再覆盖
alias cpb="\cp -av --backup=numbered"
alias mv="mv -iv"

## rm
alias t="tree -cr /tmp"
alias t2="tree -L 2"
#alias rmall="\rm -rf *;\rm -rf .[^.]*"
#cp /etc/skel/. (复制全部文件)
alias cpall="cp ."
#
#
#
#
############################## linux ##############################
alias umnt="cd; sudo umount -R /mnt"
alias um="cd; sudo umount -R"

alias mods="sudo chmod u+s,u-x"
alias modx="sudo chmod u-s,u+x"

alias facl="sudo setfacl -m u:f:rwx"

## find
alias finds="sudo find /bin/ -perm /7000 | xargs ls --color=tty -lh --time=ctime -t"
alias findall="sudo find / \( -path '/sys' -o -path '/proc' -o -path '/run' -o -path '/.snapshots' -o -path '/tmp' \) -a -prune -o -iname" # 1. -a -prune -o 必须成对出现 2. \(\) 前后必须留空
alias findtmp="sudo find /tmp/ -iname"
alias shx="find -maxdepth 1 -mindepth 1 -name '*.sh' -exec chmod +x {} \;"
alias shrx="find -maxdepth 1 -mindepth 1 -name '*.sh' -exec chmod -x {} \;"

##  jouralctl
alias j="journalctl"
alias jx="journalctl -xe" # xe (x: show explanatory texts e: end)
alias ju="journalctl -u" # u: unit
alias jbl="journalctl -u bluetooth"

## nixos
alias ni="sudo nix-env -iA"
alias niu="sudo nix-env --uninstall"
# alias nc="vim ~/mynix/configuration.nix"
alias ns="sudo nixos-rebuild switch"

## lvm
alias lvs="sudo lvs"
alias vgs="sudo vgs"
alias pvs="sudo pvs"

## 杳看硬件.操作系统信息 	id	lsblk
alias fr="free -h"
alias release="cat /etc/*-release"
alias cpu="cat /proc/cpuinfo"
alias part="cat /proc/partitions"
alias swap="cat /proc/swaps"
alias me="sudo dmidecode -t memory"
alias version="cat /proc/version"
alias cmdline="cat /proc/cmdline"
alias sysrq="sudo sh -c 'echo 1 > /proc/sys/kernel/sysrq'"
alias timezone="sudo timedatectl set-timezone"
alias ntp="sudo timedatectl set-ntp 1"
alias eng="LANG=en_US.UTF-8"
alias loc="locale"
alias nvme="sudo smartctl /dev/nvme0n1p1 -a"
alias mt="mount | column -t"
alias blk="lsblk -f"
alias route="route -n"
alias grubmk="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias grubin="sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch"
alias p="ping"
alias io="sudo iotop -o -d 2 -q"
alias iotop="sudo iotop"

## snapper
alias sn="sudo snapper status"
alias un="sudo snapper undochange"
alias li="sudo snapper list"
alias de="sudo snapper delete"
alias pr="sudo snapper -c root create -t pre -p"
alias po="sudo snapper -c root create -t post -p --pre-number"

## arch
alias s="sudo pacman -S"
alias sy="sudo pacman -Sy"
alias syyu="sudo pacman -Syyu"
alias Syyu="yay -Syyu --noconfirm"
# Remove dependencies not required by other packages
alias rs="sudo pacman -Rs"
# Remove all dependent packages
alias rc="sudo pacman -Rc"
alias yaycacha="yay -Scc Cache directory: /var/cache/pacman/pkg"
alias y="yay -S --noconfirm"
alias qs="pacman -Qs" # pacman -Qs pipewire
alias rr="sudo pacman -Rd --nodeps"

## reflector
alias refrat="command -v /usr/bin/reflector && sudo sh -c 'reflector --verbose -c CN --protocol https --sort rate --latest 5 --download-timeout 5 --threads 5 | tee /etc/pacman.d/mirrorlist' 2> /dev/null"
alias refage="command -v /usr/bin/reflector && sudo sh -c 'reflector --verbose --protocol https --sort age --latest 5 --download-timeout 5 --threads 5 | tee /etc/pacman.d/mirrorlist' 2> /dev/null"
alias tees="sudo tee -a"

## nmcli
alias rescan="nmcli device wifi rescan"
alias hotspot="nmcli device wifi hotspot"
alias offhotspot="nmcli connection down Hotspot"
#
#
#
#
############################## 函数 ##############################
## 用于创建一个目录并立即进入该目录
function mcd
  mkdir -p $argv[1] && cd $argv[1]
end

## 用于创建一个文件及其父目录
function ,touch
  mkdir -p (dirname "$argv[1]") && touch "$argv[1]"
end

## 用于创建一个文件及其父目录（如果父目录不存在），然后切换到该文件的父目录
function ,take
  mkdir -p (dirname "$argv[1]") && touch "$argv[1]" && take (dirname "$argv[1]")
end

## 调用 Bash 内置的 help 命令来显示帮助信息
function help
  bash -c "help $argv"
end

# 绑定 Alt+C 复制当前命令行内容
function copzy-current-line
commandline | pbcopy
end
bind alt-c copy-current-line

# 绑定 Alt+S 复制上一条命令的输出
function copy-last-output
    eval $history[1] | pbcopy
end
bind alt-C copy-last-output

#
#
#
#
############################## python ##############################
alias pyenv="~/.pyenv/bin/pyenv"
alias py="python"
alias pydoc="sudo pydoc -p 80"
alias jn="jupyter notebook"
alias i="ipython"

test -f /bin/pipx && eval "$(register-python-argcomplete pipx)"

## pyenv
[ -e ~/.pyenv/bin/pyenv ] && eval "$(pyenv virtualenv-init -)"
#
#
#
#
############################## end ##############################
set -l MY_VMOPTIONS_SHELL_FILE "$HOME/.jetbrains.vmoptions.sh"
if test -f "$MY_VMOPTIONS_SHELL_FILE"
    source "$MY_VMOPTIONS_SHELL_FILE"
end
end
