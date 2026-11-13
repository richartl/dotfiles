# CLAUDE.md

Repo para tener un entorno DevOps reproducible en macOS (Apple Silicon e Intel) y,
opcionalmente, Linux. En una máquina nueva: clonar y correr `./bootstrap.sh`.

## Estructura

- `bootstrap.sh`: punto de entrada. Instala Homebrew, corre `brew bundle`, instala mise,
  enlaza su config, corre `mise install`, enlaza los dotfiles, clona `wd` y agrega el
  bloque `devops-env` a `~/.zshrc`.
- `lib/common.sh`: helpers (`log`, `link_file`, `ensure_block`, `load_brew_env`).
- `Brewfile`: utilidades sin versión importante y apps (casks dentro de `if OS.mac?`).
- `mise/config.toml`: herramientas con versión. Enlazado a `~/.config/mise/config.toml`.
- `zsh/zshrc`: config portable de zsh (brew, mise, plugins, aliases, funciones). `~/.zshrc`
  sigue siendo un archivo local que solo la carga desde el bloque `devops-env`. Lo
  específico de cada máquina va en `~/.zshrc`, fuera del bloque, nunca en el repo.
- Dotfiles enlazados con symlink:
  - `nvim/` → `~/.config/nvim` (lazy.nvim; `lazy-lock.json` se versiona)
  - `tmux/tmux.conf` → `~/.tmux.conf`
  - `starship/starship.toml` → `~/.config/starship.toml`
  - `ghostty/config` → `~/.config/ghostty/config`
  - `bat/` → `~/.config/bat` (tema en `bat/themes/`; requiere `bat cache --build`)
  - `eza/` → `~/.config/eza` (`theme.yml`; necesita `EZA_CONFIG_DIR` en macOS)
- `git/fanzine.gitconfig`: solo colores de git. Bootstrap lo agrega a `~/.gitconfig` con
  `include.path`. Nunca versionar `~/.gitconfig` completo, porque contiene nombre, correo y
  configuración de cada máquina.
- Estilo visual "fanzine": tmux, nvim (`nvim/colors/fanzine.lua`), ghostty, starship, fzf
  (en `zsh/zshrc`), bat, eza y git comparten una misma paleta. Al cambiar un color o agregar
  una herramienta con colores, mantenerla en esa paleta.
- `docker/`: imagen "toolbox" opcional y wrapper `devops-run` (secundario: CI o máquinas ajenas).
- `legacy/`: dotfiles viejos de Linux/i3. No se usan en el bootstrap.

## Convenciones

- Todo script debe ser idempotente y seguro de correr varias veces.
  Para archivos del usuario usar `link_file` (respalda antes de reemplazar) y
  `ensure_block` (bloques con marcadores, nunca `echo >>` a ciegas).
- Nunca guardar secretos ni credenciales en el repo (`~/.aws`, `~/.kube`, `~/.ssh`, `.env`,
  tfvars, tfstate, etc. se quedan fuera).
- Al agregar una herramienta:
  1. Si tiene versión relevante → `mise/config.toml`; si no → `Brewfile`.
  2. Si aplica, también en `docker/Dockerfile`.
  3. Documentarla en la tabla del `README.md`.
- Preferir versiones `latest` en el config global, salvo que el usuario pida fijar una.
- Antes de cambios grandes, proponer el plan y esperar confirmación.
- En `zsh/zshrc`, cargar cada herramienta o plugin solo si existe y no fijar rutas como
  `/opt/homebrew` o `/Users/<usuario>` (usar `$HOMEBREW_PREFIX` y `$HOME`).
- Validar scripts con `shellcheck` y probar sintaxis con `bash -n` (`zsh -n` para `zsh/zshrc`).
- Mensajes de commit cortos en español.
