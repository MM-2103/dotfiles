if status is-interactive

# Functions
	
## Make all dots into cd ../
function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end

function take
    mkdir -p $argv && cd $argv
end

# Function to extract files
function extract
    echo Extracting $argv ...
    if test -f $argv[1]
        switch $argv[1]
            case '*.tar.bz2'
                tar xjf $argv[1]
            case '*.tar.gz'
                tar xzf $argv[1]
            case '*.bz2'
                bunzip2 $argv[1]
            case '*.rar'
                tar xzf $argv[1]
            case '*.gz'
                gunzip $argv[1]
            case '*.tar'
                tar xf $argv[1]
            case '*.tbz2'
                tar xjf $argv[1]
            case '*.tgz'
                tar xzf $argv[1]
            case '*.zip'
                unzip $argv[1]
            case '*.Z'
                uncompress $argv[1]
            case '*.7z'
                7z x $argv[1]
            case '*.lz4'
                lz4 -dc $argv[1] | tar -xv
            case '*'
                echo "'$argv[1]' cannot be extracted via extract()"
        end
    else
        echo "'$argv[1]' is not a valid file"
    end
end

function rmrf
    if not set -q argv[1]
        echo "Usage: rmrf <directory> [directory...]"
        return 1
    end

    set -l delete_all false

    for directory in $argv
        if not test -e "$directory"
            echo "Error: '$directory' does not exist"
            continue
        end

        # Use fd to check if directory has contents (including hidden files)
        if test -n (fd --hidden --no-ignore --min-depth 1 --max-depth 1 . "$directory" -1)
            if test "$delete_all" = true
                rm -rf "$directory"
                echo "Deleted '$directory'"
            else
                echo "Directory '$directory' is not empty"
                read -P "Delete '$directory'? (y/n/a): " -l response
                switch (string lower $response)
                    case y
                        rm -rf "$directory"
                        echo "Deleted '$directory'"
                    case a
                        rm -rf "$directory"
                        echo "Deleted '$directory'"
                        set delete_all true
                    case '*'
                        echo "Skipped '$directory'"
                end
            end
        else
            rm -rf "$directory"
            echo "Deleted '$directory'"
        end
    end
end

function switchphp
        if test -f /usr/bin/php
            sudo rm /usr/bin/php
            sudo rm -rf /etc/php
            sudo rm -rf /usr/lib/php/modules
        end

        sudo ln -s /usr/bin/php$argv[1] /usr/bin/php
        sudo ln -s /etc/php$argv[1] /etc/php
        sudo ln -s /usr/lib/php$argv[1] /usr/lib/php
end

# Abbreviations
abbr --add dotdot --regex '^\.\.+$' --function multicd
abbr --add :q exit
abbr --add nixupdate "sudo nixos-rebuild switch --flake /etc/nixos#default"
abbr --add nixedit "sudoe nvim /etc/nixos/configuration.nix"

# PHP
abbr --add art "php artisan"
abbr --add arts "php artisan serve"
abbr --add artg "php artisan | grep"
abbr --add artt "php artisan test"

# Aliases
alias sudo="sudo "
alias sudoe="sudo -E "

alias protontricks="flatpak run com.github.Matoking.protontricks"
alias protontricks-launch="flatpak run --command=protontricks-launch com.github.Matoking.protontricks"

alias nvidia-status="cat /sys/bus/pci/devices/0000:01:00.0/power/runtime_status"

alias vim="nvim"
alias vi="nvim"
alias nedit="nvim ~/dotfiles/nvim/"


alias ll="eza -l --icons"
alias l="eza -l --icons"
alias ls="eza --icons"

alias cat="bat"

alias dotfiles="cd ~/dotfiles && vim"

alias t="sesh connect (sesh list | fzf-tmux -p 55%,60% \
    --no-sort --border-label ' sesh ' --prompt '⚡  ' \
    --header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
    --bind 'tab:down,btab:up' \
    --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list)' \
    --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t)' \
    --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c)' \
    --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z)' \
    --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
    --bind 'ctrl-d:execute(tmux kill-session -t {})+change-prompt(⚡  )+reload(sesh list)')"

abbr --add dcrm 'docker rm $(docker ps -a -q)'
abbr --add dcirm 'docker rmi $(docker images -q)'
end

# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

set -gx PATH "$HOME/.local/bin" "$HOME/go/bin" "$HOME/.composer/vendor/bin" "$HOME/.cargo/bin" $PATH

# Zoxide
zoxide init fish | source

# fnm
fnm env --use-on-cd --shell fish | source

# Starship
starship init fish | source
