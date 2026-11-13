#!/usr/bin/env bash
# Helpers compartidos por los scripts del repo. Se usa con `source`.

log()  { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
ok()   { printf '\033[1;32m ✓\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m !\033[0m %s\n' "$*" >&2; }
die()  { printf '\033[1;31m ✗\033[0m %s\n' "$*" >&2; exit 1; }

os_name() {
  case "$(uname -s)" in
    Darwin) echo macos ;;
    Linux)  echo linux ;;
    *)      echo unknown ;;
  esac
}

# Carga brew en el PATH de este proceso si está instalado en alguna ruta conocida.
load_brew_env() {
  local candidate
  for candidate in \
    /opt/homebrew/bin/brew \
    /usr/local/bin/brew \
    /home/linuxbrew/.linuxbrew/bin/brew \
    "$HOME/.linuxbrew/bin/brew"; do
    if [[ -x "$candidate" ]]; then
      eval "$("$candidate" shellenv)"
      return 0
    fi
  done
  return 1
}

# link_file <origen> <destino>
# Crea un symlink. Si el destino ya existe y no apunta al origen, lo respalda.
link_file() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"

  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    ok "$dest ya enlazado"
    return 0
  fi

  if [[ -e "$dest" || -L "$dest" ]]; then
    local backup
    backup="$dest.bak.$(date +%Y%m%d%H%M%S)"
    mv "$dest" "$backup"
    warn "$dest existía; respaldado en $backup"
  fi

  ln -s "$src" "$dest"
  ok "$dest -> $src"
}

# ensure_block <archivo> <nombre> <contenido>
# Escribe un bloque delimitado por marcadores. Si ya existe lo reemplaza
# en su lugar (no duplica); si no existe, lo agrega al final.
ensure_block() {
  local file="$1" name="$2" content="$3"
  local begin="# >>> $name >>>" end="# <<< $name <<<"
  local block tmp
  block="$(printf '%s\n%s\n%s' "$begin" "$content" "$end")"
  touch "$file"
  tmp="$(mktemp)"

  if grep -qxF "$begin" "$file"; then
    # Reemplaza el bloque existente en la misma posición.
    BLOCK="$block" awk -v b="$begin" -v e="$end" '
      $0 == b { print ENVIRON["BLOCK"]; skip = 1; next }
      $0 == e { skip = 0; next }
      !skip   { print }
    ' "$file" > "$tmp"
  else
    { cat "$file"; [[ -s "$file" ]] && printf '\n'; printf '%s\n' "$block"; } > "$tmp"
  fi

  if cmp -s "$tmp" "$file"; then
    ok "$file sin cambios"
  else
    # cat > en lugar de mv para conservar permisos y symlinks del archivo.
    cat "$tmp" > "$file"
    ok "$file actualizado (bloque $name)"
  fi
  rm -f "$tmp"
}
