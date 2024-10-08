
if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Path
set -x fish_user_paths
fish_add_path ~/.bun/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.local/bin
fish_add_path /opt/nvim-linux64/bin
fish_add_path ~/.local/bin/pnpm
fish_add_path ~/Library/Python/3.{8,9}/bin
fish_add_path /usr/local/opt/sqlite/bin
fish_add_path /bin
fish_add_path /.local/bin/pnpm

set -gx DENO_INSTALL '~/.deno'
fish_add_path ~/.deno/bin

set -gx EDITOR (which nvim)
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR

starship init fish | source
zoxide init fish | source

# Dev
alias lazygit "TERM=xterm-256color command lazygit"
abbr gg lazygit
abbr gl 'git l --color | devmoji --log --color | less -rXF'
abbr gs "git st"
abbr gb "git checkout -b"
abbr gc "git commit"
abbr gpr "git pr checkout"
abbr gm "git branch -l main | rg main > /dev/null 2>&1 && hub checkout main || hub checkout master"
abbr gcp "git commit -p"
abbr gpp "git push"
abbr gp "git pull"

# Files & Directories
abbr mv "mv -iv"
abbr cp "cp -riv"
abbr mkdir "mkdir -vp"
alias ls="eza --color=always --icons --group-directories-first"
alias la 'eza --color=always --icons --group-directories-first --all'
alias ll 'eza --color=always --icons --group-directories-first --all --long'
abbr l ll

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
