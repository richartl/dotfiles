#!/usr/bin/env bash
# Instala y configura el entorno DevOps. Idempotente: se puede correr N veces.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/common.sh
source "$REPO_DIR/lib/common.sh"

OS="$(os_name)"
[[ "$OS" == unknown ]] && die "Sistema operativo no soportado: $(uname -s)"

install_homebrew() {
  log "Homebrew"
  if command -v brew >/dev/null 2>&1 || load_brew_env; then
    ok "Homebrew ya instalado ($(brew --prefix))"
    return 0
  fi
  NONINTERACTIVE=1 /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  load_brew_env || die "Homebrew se instaló pero no se encontró el binario"
  ok "Homebrew instalado"
}

brew_bundle() {
  log "brew bundle"
  if brew bundle check --file="$REPO_DIR/Brewfile" >/dev/null 2>&1; then
    ok "Brewfile ya satisfecho"
  else
    brew bundle install --file="$REPO_DIR/Brewfile"
  fi
}

setup_mise() {
  log "mise"
  command -v mise >/dev/null 2>&1 || brew install mise
  ok "$(mise --version)"

  link_file "$REPO_DIR/mise/config.toml" "$HOME/.config/mise/config.toml"

  log "mise install"
  MISE_YES=1 mise install
}

setup_dotfiles() {
  log "Dotfiles"
  link_file "$REPO_DIR/nvim"                   "$HOME/.config/nvim"
  link_file "$REPO_DIR/tmux/tmux.conf"         "$HOME/.tmux.conf"
  link_file "$REPO_DIR/starship/starship.toml" "$HOME/.config/starship.toml"
  link_file "$REPO_DIR/ghostty/config"         "$HOME/.config/ghostty/config"
  link_file "$REPO_DIR/bat"                    "$HOME/.config/bat"
  link_file "$REPO_DIR/eza"                    "$HOME/.config/eza"

  # bat solo ve temas nuevos después de reconstruir su caché.
  if command -v bat >/dev/null 2>&1; then
    bat cache --build >/dev/null
    ok "caché de temas de bat reconstruida"
  fi
}

setup_wd() {
  log "wd (warp directories)"
  if [[ -d "$HOME/.local/wd/.git" ]]; then
    ok "wd ya instalado"
  else
    mkdir -p "$HOME/.local"
    git clone --depth 1 https://github.com/mfaerevaag/wd.git "$HOME/.local/wd"
  fi
}

setup_shell() {
  log "Activación en zsh"
  ensure_block "$HOME/.zshrc" "devops-env" \
    "[ -f \"$REPO_DIR/zsh/zshrc\" ] && source \"$REPO_DIR/zsh/zshrc\""
}

main() {
  log "Bootstrap ($OS/$(uname -m)) desde $REPO_DIR"
  install_homebrew
  brew_bundle
  setup_mise
  setup_dotfiles
  setup_wd
  setup_shell
  log "Listo. Abre una terminal nueva o corre: exec zsh"
}

# Solo corre main si se ejecuta directo (permite hacer `source` para pruebas).
if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  main "$@"
fi
