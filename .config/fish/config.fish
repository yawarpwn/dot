
if status is-interactive
    # Commands to run in interactive sessions can go here
end

#path
set -x fish_user_paths
fish_add_path ~/.bun/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.local/bin
fish_add_path /bin


starship init fish | source
zoxide init fish | source
# export (cat env_file.txt |xargs -L 1)

#exa
abbr ls exa
abbr ll "exa -lah"
abbr tree "exa --tree"


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
