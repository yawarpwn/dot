#
# Fancy color output
#

show_error() {
  local red=$'\033[0;91m'
  local nc=$'\033[0m'
  if [[ "${1:--e}" =~ ^(-e|-n)$ ]]; then
    echo "${1:--e}" "${red}${*:2}${nc}" 1>&2
  else
    echo -e "${red}${*}${nc}" 1>&2
  fi
}
export -f show_error

show_info() {
  local green=$'\033[0;92m'
  local nc=$'\033[0m'
  if [[ "${1:--e}" =~ ^(-e|-n)$ ]]; then
    echo "${1:--e}" "${green}${*:2}${nc}"
  else
    echo -e "${green}${*}${nc}"
  fi
}
export -f show_info

show_warning() {
  local yellow=$'\033[0;93m'
  local nc=$'\033[0m'
  if [[ "${1:--e}" =~ ^(-e|-n)$ ]]; then
    echo "${1:--e}" "${yellow}${*:2}${nc}"
  else
    echo -e "${yellow}${*}${nc}"
  fi
}
export -f show_warning

show_question() {
  local blue=$'\033[0;94m'
  local nc=$'\033[0m'
  if [[ "${1:--e}" =~ ^(-e|-n)$ ]]; then
    echo "${1:--e}" "${blue}${*:2}${nc}"
  else
    echo -e "${blue}${*}${nc}"
  fi
}
export -f show_question

ask_question() {
  local blue=$'\033[0;94m'
  local nc=$'\033[0m'
  local var
  read -r -p "${blue}$*${nc} " var
  echo "${var}"
}
export -f ask_question

ask_secret() {
  local blue=$'\033[0;94m'
  local nc=$'\033[0m'
  local var
  stty -echo echonl
  read -r -p "${blue}$*${nc} " var
  stty echo -echonl
  echo "${var}"
}
export -f ask_secret

show_success() {
  local purple=$'\033[0;95m'
  local nc=$'\033[0m'
  if [[ "${1:--e}" =~ ^(-e|-n)$ ]]; then
    echo "${1:--e}" "${purple}${*:2}${nc}"
  else
    echo -e "${purple}${*}${nc}"
  fi
}
export -f show_success

show_header() {
  local cyan=$'\033[0;96m'
  local nc=$'\033[0m'
  if [[ "${1:--e}" =~ ^(-e|-n)$ ]]; then
    echo "${1:--e}" "${cyan}${*:2}${nc}"
  else
    echo -e "${cyan}${*}${nc}"
  fi
}
export -f show_header

show_listitem() {
  local white=$'\033[0;97m'
  local nc=$'\033[0m'
  if [[ "${1:--e}" =~ ^(-e|-n)$ ]]; then
    echo "${1:--e}" "${white}${*:2}${nc}"
  else
    echo -e "${white}${*}${nc}"
  fi
}
export -f show_listitem

##
# Utility functions
##

function check_user {
  if [ ${EUID} -eq 0 ]; then
    show_error "Do not run this script as root. Exiting."
    exit 1
  fi
}

function check_root {
  if [ ${EUID} -eq 0 ]; then
    show_info "I am root."
  else
    show_error "I need to be root."
    exit 1
  fi
}

function check-installed {
local metacount
local installcount
local package
local to_install
while read -r package; do
  [ -z "${pacakge}" ] && continue
  metacount=$(pacman -Ss "${package") | 
    grep -c "(^local.*(.*${package}.*)$" || true
done

}

download() {
  file="$1"
  url="$2"

  if has curl; then
    cmd="curl --fail --silent --location --output $file $url"
  elif has wget; then
    cmd="wget --quiet --output-document=$file $url"
  elif has fetch; then
    cmd="fetch --quiet --output=$file $url"
  else
    error "No HTTP download program (curl, wget, fetch) found exiting..."
  fi

  # Ejecuta el comando de descarga y retorna 0 si tiene éxito, de lo contrario captura el código de error.
  $cmd && return 0 || rc=$?

  error "Command failed (exit code $rc): ${BLUE}${cmd}${NO_COLOR}"
  printf "\n" >&2

  return "$rc" # Retorna el código de salida del comando fallido.

}

unpack() {
  archive=$1 # El primer argumento es la ruta del archivo de archivo (archive) que se desea descomprimir.
  bin_dir=$2 # El segundo argumento es el directorio de destino (bin_dir) donde se extraerá el contenido del archivo.
  sudo=${3-} # El tercer argumento opcional es el comando sudo, que se utiliza si es necesario permisos de superusuario.

  case "$archive" in
  # Si el archivo tiene la extensión .tar.gz
  *.tar.gz)
    # Define las banderas (flags) para el comando tar, dependiendo de si la variable VERBOSE está establecida.
    flags=$(test -n "${VERBOSE-}" && echo "-xzvof" || echo "-xzof")
    # Ejecuta el comando tar para extraer el archivo .tar.gz en el directorio bin_dir.
    ${sudo} tar "${flags}" "${archive}" -C "${bin_dir}"
    return 0 # Retorna 0 si el comando tiene éxito.
    ;;
  # Si el archivo tiene la extensión .zip
  *.zip)
    # Define las banderas (flags) para el comando unzip, dependiendo de si la variable VERBOSE no está establecida.
    flags=$(test -z "${VERBOSE-}" && echo "-qqo" || echo "-o")
    # Ejecuta el comando unzip para extraer el archivo .zip en el directorio bin_dir.
    UNZIP="${flags}" ${sudo} unzip "${archive}" -d "${bin_dir}"
    return 0 # Retorna 0 si el comando tiene éxito.
    ;;
  esac

  # Si el archivo no tiene una extensión reconocida (.tar.gz o .zip), muestra un mensaje de error.
  error "Unknown package extension."
  return 1 # Retorna 1 indicando un error.
}

confirm() {
  # Verifica si la variable FORCE está vacía
  if [ -z "${FORCE-}" ]; then
    # Muestra el mensaje de confirmación con formato especial
    printf "%s " "${MAGENTA}?${NO_COLOR} $* ${BOLD}[y/N]${NO_COLOR}"

    # Desactiva la opción de salida inmediata en caso de error
    set +e

    # Lee la respuesta del usuario desde el terminal (no de la entrada estándar)
    read -r yn </dev/tty
    rc=$? # Guarda el código de retorno de read

    # Reactiva la opción de salida inmediata en caso de error
    set -e

    # Verifica si hubo un error al leer la entrada del usuario
    if [ $rc -ne 0 ]; then
      # Muestra un mensaje de error y termina el script si hubo un error
      error "Error reading from prompt (please re-run with the '--yes' option)"
      exit 1
    fi

    # Verifica si la respuesta del usuario no es "y" o "yes"
    if [ "$yn" != "y" ] && [ "$yn" != "yes" ]; then
      # Muestra un mensaje de error y termina el script si la respuesta no es afirmativa
      error 'Aborting (please answer "yes" to continue)'
      exit 1
    fi
  fi
}

test_writeable() {
  path="${1:-}/test.txt"

  if touch "$path" 2>/dev/null; then
    rm "${path}"
    return 0
  else
    return 1
  fi
}

install() {
  # ext="$1"
  url="$1"

  if test_writeable "$1"; then
    sudo=""
    msg="Installing, please wait..."
  else
    warn "Elevated permissions are reuired to install"
    #elevate_priv
    sudo="subo"
    msg="Installing as root, please wait..."
  fi
  info "$msg"

  archive=$(get_tempFile)

  download "$archive" "$url"

  unpack "$archive" "/usr/bin" "$sudo"

}
