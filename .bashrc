# Si no se está ejecutando de forma interactiva, no hacer nada
case $- in
*i*) ;;
*) return ;; # Salir si no es interactivo
esac

# Agregar al archivo de historial, no sobrescribirlo
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

# Verificar el tamaño de la ventana después de cada comando y, si es necesario, actualizar los valores de LINES y COLUMNS
shopt -s checkwinsize

# Establecer un prompt elegante
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# Habilitar el soporte de color para ls y agregar alias útiles
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
fi

# Cargar alias de bash si el archivo existe
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# Habilitar características de completado programable
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# dprint
export DPRINT_INSTALL="$HOME/.dprint"
export PATH="$DPRINT_INSTALL/bin:$PATH"

##nvim
export PATH="$PATH:/opt/nvim-linux64/bin"

# fnm
export PATH="$HOME/.local/share/fnm:$PATH"
eval "$(fnm env)"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# zoxide
eval "$(zoxide init bash)"

# starship
eval "$(starship init bash)"

# fnm
FNM_PATH="/home/johneyder/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env)"
fi
. "$HOME/.cargo/env"
