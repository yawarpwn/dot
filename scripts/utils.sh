BOLD="$(tput bold 2>/dev/null || printf '')"
GREY="$(tput setaf 0 2>/dev/null || printf '')"
UNDERLINE="$(tput smul 2>/dev/null || printf '')"
RED="$(tput setaf 1 2>/dev/null || printf '')"
GREEN="$(tput setaf 2 2>/dev/null || printf '')"
YELLOW="$(tput setaf 3 2>/dev/null || printf '')"
BLUE="$(tput setaf 4 2>/dev/null || printf '')"
MAGENTA="$(tput setaf 5 2>/dev/null || printf '')"
NO_COLOR="$(tput sgr0 2>/dev/null || printf '')"

info() {
  printf '%s\n' "${BOLD}${GREY}>${NO_COLOR} $*"
}

warn() {
  printf '%s\n' "${YELLOW}! $*${NO_COLOR}"
}

error() {
  printf '%s\n' "${RED}x $*${NO_COLOR}" >&2
}

success() {
  printf '%s\n' "${GREEN}✓${NO_COLOR} $*"
}

has() {
  command -v "$1" 1>/dev/null 2>&1
}

# get_tempFile() {
#   if has mktemp; then
#     echo "$"
#   fi
# }

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
