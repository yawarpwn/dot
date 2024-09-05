# fnm
set PATH "$HOME/.local/share/fnm" $PATH

# fnm env | source
fnm env --use-on-cd | source

# # fnm
# set FNM_PATH "/home/johneyder/.local/share/fnm"
# if [ -d "$FNM_PATH" ]
#   set PATH "$FNM_PATH" $PATH
#   fnm env | source
# end
