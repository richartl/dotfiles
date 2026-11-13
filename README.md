# Entorno DevOps

Entorno reproducible para macOS (Apple Silicon e Intel) y, opcionalmente, Linux.

## Instalación

```sh
git clone <url-del-repo> ~/Developer/personal/dotfiles
cd ~/Developer/personal/dotfiles
./bootstrap.sh
exec zsh
```

Puedes correr `./bootstrap.sh` las veces que quieras. Solo instala o cambia lo que falte.

Qué hace:

1. Instala Homebrew si falta.
2. Corre `brew bundle` con el `Brewfile`.
3. Instala mise, enlaza `mise/config.toml` a `~/.config/mise/config.toml` y corre `mise install`.
4. Enlaza los dotfiles: nvim, tmux, starship y ghostty (ver abajo).
5. Clona [wd](https://github.com/mfaerevaag/wd) en `~/.local/wd` si falta.
6. Agrega a `~/.zshrc` un bloque `# >>> devops-env >>>` que carga `zsh/zshrc`. Nunca lo duplica.

Si un destino ya existía como archivo real, se respalda como `<archivo>.bak.<fecha>` antes de
enlazarlo.

## Dotfiles

| Repo | Destino | Notas |
|---|---|---|
| `zsh/zshrc` | cargado desde `~/.zshrc` | `~/.zshrc` queda local, para lo propio de cada máquina |
| `nvim/` | `~/.config/nvim` | lazy.nvim; `lazy-lock.json` versionado |
| `tmux/tmux.conf` | `~/.tmux.conf` | prefijo `C-a` |
| `starship/starship.toml` | `~/.config/starship.toml` | |
| `ghostty/config` | `~/.config/ghostty/config` | JetBrainsMono Nerd Font |
| `bat/` | `~/.config/bat` | tema `fanzine`; bootstrap corre `bat cache --build` |
| `eza/` | `~/.config/eza` | `theme.yml`; `zsh/zshrc` exporta `EZA_CONFIG_DIR` |

Todo usa la misma paleta "fanzine" (tinta `#0b0b0b`, papel `#efe9dc`, rosa `#ff2a6d`,
ácido `#f7e600`, sangre `#e10600`, xerox `#2de2e6`). Si cambias un color, cámbialo en todos.

Como son symlinks, editar `~/.tmux.conf` o la config de nvim cambia el repo directamente.
Solo falta hacer commit.

`~/.zshrc` no se versiona. Lo que agregan instaladores (Docker Desktop, gcloud, etc.) o lo que
es propio de una máquina va ahí, fuera del bloque `devops-env`.

## Herramientas

| Herramienta | Fuente | Versión | Notas |
|---|---|---|---|
| terraform | mise | latest | |
| aws-cli | mise | latest | |
| kubectl | mise | latest | |
| helm | mise | latest | |
| node | mise | lts | respeta `.nvmrc` / `.node-version` |
| ansible | mise (`pipx:ansible-core`) | latest | incluye las colecciones `ansible` y `boto3` |
| uv | mise | latest | backend para herramientas de Python |
| git, jq, fzf, ripgrep, shellcheck | Brewfile | — | |
| mise | Brewfile | — | |
| zsh-autosuggestions, zsh-syntax-highlighting | Brewfile | — | |
| zoxide, starship, eza, bat | Brewfile | — | |
| tmux, neovim | Brewfile | — | |
| libpq (psql) | Brewfile | — | |
| Ghostty, JetBrainsMono Nerd Font | Brewfile (cask) | — | solo macOS |

## Agregar una herramienta

- **Con versión relevante** (CLIs de nube, IaC, k8s, runtimes):
  ```sh
  mise use -g <herramienta>@latest   # escribe en mise/config.toml por el symlink
  ```
  Para buscar el nombre: `mise registry | grep <nombre>`.
- **Sin versión relevante** (utilidades, apps): agrégala al `Brewfile` y corre `./bootstrap.sh`.
- Si aplica, agrégala también a `docker/Dockerfile`.
- Agrégala a la tabla de arriba.

## Fijar versiones por proyecto

Dentro del proyecto:

```sh
mise use terraform@1.9.8 kubectl@1.31 node@22
```

Esto crea un `mise.toml` en el proyecto, que conviene versionar. Al entrar al directorio, mise
cambia de versión solo, y fuera de él vuelve a las del config global. mise también lee
`.nvmrc`, `.node-version` y `.tool-versions`. Para overrides personales sin commitear, usa
`mise.local.toml`.

## Docker (opcional)

`docker/` tendrá una imagen "toolbox" con las mismas herramientas y el wrapper `devops-run`,
para CI o máquinas ajenas. Pendiente.
