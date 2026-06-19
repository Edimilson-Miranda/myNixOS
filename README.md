# 🌙 nixos-config

Configuração declarativa e modular de NixOS + Home Manager para um ambiente desktop Wayland completo, com foco em desenvolvimento e produtividade.

---

## ✨ Visão Geral

Esta configuração gerencia um sistema NixOS completo usando **Flakes**, integrando:

- **NixOS** — configuração do sistema operacional
- **Home Manager** — configuração do ambiente do usuário
- **Niri** — compositor Wayland em tiling
- **Noctalia Shell** — barra de status e shell customizada
- **Neovim (LazyVim)** — editor principal com plugins de IA
- **Fish** — shell interativa com ferramentas modernas
- **Stow** — gerenciamento de dotfiles via symlinks

---

## 🗂️ Estrutura do Projeto

```
nixos-config/
├── flake.nix                    # Ponto de entrada, inputs e outputs
├── flake.lock                   # Lock dos inputs do flake
├── configuration.nix            # Configuração do sistema NixOS
├── hardware-configuration.nix   # Configuração de hardware (gerada automaticamente)
├── home.nix                     # Configuração principal do Home Manager
│
├── modules/
│   ├── base/
│   │   ├── packages.nix         # Pacotes base e cursor
│   │   ├── shell.nix            # Fish, Starship, Atuin, Zoxide, aliases
│   │   └── cli-tools.nix        # Bat, Ripgrep, variáveis de ambiente
│   ├── features/
│   │   ├── desktop.nix          # GUI apps, Spicetify, Brave, Vesktop
│   │   ├── dev-tools.nix        # Neovim, Git, GitHub CLI, LazyGit, Bun
│   │   ├── fonts.nix            # Configuração de fontes do sistema
│   │   └── noctalia.nix         # Integração com o Noctalia Shell
│   ├── system/
│   │   └── codespace.nix        # Configurações para ambientes Codespace
│   └── wayland/
│       ├── default.nix          # Integração com o flake do Niri
│       └── packages.nix         # Pacotes Wayland (kitty, swaylock, grim...)
│
├── profiles/
│   ├── desktop.nix              # Perfil completo (devtools + desktop + software + fonts)
│   ├── cli-dev.nix              # Perfil CLI (sem desktop)
│   └── codespace.nix            # Perfil Codespace (herda cli-dev)
│
├── users/
│   └── miranda.nix              # Definição do usuário (username + stateVersion)
│
├── scripts/
│   ├── ai-cmd                   # CLI de IA via Claude Haiku (Anthropic API)
│   └── listallusers.sh          # Lista todos os usuários do sistema
│
└── stow/                        # Dotfiles gerenciados via GNU Stow (symlinks)
    ├── fastfetch/               # Configuração do fastfetch
    ├── kitty/                   # Terminal Kitty
    ├── niri/                    # Compositor Niri (config.kdl)
    ├── noctalia/                # Noctalia Shell (cores, plugins)
    ├── nvim/                    # Neovim (LazyVim)
    ├── opencode/                # OpenCode (MCP + modelo)
    └── starship/                # Prompt Starship
```

---

## ⚙️ Sistema (NixOS)

**Arquivo:** `configuration.nix`

| Configuração | Valor |
|---|---|
| Hostname | `nixos` |
| Timezone | `America/Sao_Paulo` |
| Locale | `pt_BR.UTF-8` |
| Teclado | `br-abnt2` |
| Bootloader | `systemd-boot` (EFI) |
| CPU | AMD (com atualização de microcódigo) |
| Kernel | KVM-AMD habilitado |
| Filesystem raiz | ext4 |
| Audio | PipeWire (sem PulseAudio) |
| Display Manager | SDDM com tema **SilentSDDM** |
| Desktop Environment |**Niri** (Wayland principal) |
| Shell padrão do usuário | Fish |
| Java | JDK 21 |

**Manutenção automática:**
- `system.autoUpgrade` — atualização semanal automática do sistema
- `nix.gc.automatic` — garbage collection diária (remove gerações com mais de 10 dias)
- `nix.settings.auto-optimise-store` — otimização automática do Nix store

---

## 🏠 Home Manager

**Arquivo:** `home.nix`

O Home Manager usa um sistema de opções customizadas (`myconfig`) para ativar/desativar funcionalidades de forma modular:

```nix
myconfig.features = {
  desktop  = true;   # Apps GUI, Wayland, Kitty, Spicetify
  devtools = true;   # Neovim, Git, LazyGit, GitHub CLI, Bun
  fonts    = true;   # JetBrainsMono, Inter, Noto, emojis
  software = true;   # Brave, Obsidian, Steam, Vesktop, VLC...
};
```

---

## 📦 Pacotes Instalados

### Ferramentas de Desenvolvimento
| Pacote | Descrição |
|---|---|
| `gcc`, `gnumake` | Compilação C/C++ |
| `rustc`, `cargo` | Toolchain Rust |
| `nodejs_24` | Node.js 24 |
| `uv` | Gerenciador Python ultrarrápido |
| `bun` | Runtime/bundler JavaScript |
| `tree-sitter` | Parser para sintaxe |
| `lua-language-server` | LSP para Lua |
| `nil`, `nixd` | LSPs para Nix |
| `biome` | Linter/formatter JS/TS |
| `opencode` | CLI de IA para desenvolvimento |
| `vscodium` | VS Code sem telemetria |
| `zed-editor` | Editor moderno e rápido |

### Ferramentas CLI
| Pacote | Descrição |
|---|---|
| `bat` | `cat` com syntax highlighting |
| `eza` | `ls` moderno com ícones e Git |
| `fzf` | Fuzzy finder |
| `fd` | `find` moderno |
| `ripgrep` | `grep` ultrarrápido |
| `zoxide` | `cd` inteligente |
| `atuin` | Histórico de shell sincronizável |
| `btop` | Monitor de recursos |
| `lsof` | Lista arquivos abertos |
| `trash-cli` | Lixeira via CLI |
| `nh` | Helper para rebuild NixOS |
| `fastfetch` | Informações do sistema |
| `mermaid-cli` | Geração de diagramas |

### Aplicativos Desktop
| Pacote | Descrição |
|---|---|
| `firefox` | Navegador |
| `brave` | Navegador focado em privacidade |
| `obsidian` | Notas com links |
| `steam` | Plataforma de jogos |
| `vlc` | Player de mídia |
| `obs-studio` | Gravação e streaming |
| `gpu-screen-recorder` | Gravação de tela via GPU |
| `mpv` | Player de vídeo minimalista |
| `teams-for-linux` | Microsoft Teams |
| `vesktop` | Discord aprimorado |
| `nemo` | Gerenciador de arquivos |
| `nautilus` | Gerenciador de arquivos GNOME |
| `pavucontrol` | Controle de volume PipeWire |
| `webtorrent_desktop` | Cliente BitTorrent |
| `obsidian`, `wootility` | Apps opcionais de software |

### Wayland / Composição
| Pacote | Descrição |
|---|---|
| `niri` | Compositor tiling Wayland |
| `kitty` | Terminal GPU-accelerated |
| `swaylock` | Bloqueador de tela |
| `swayidle` | Gerenciamento de inatividade |
| `swaybg` | Wallpaper |
| `grim` + `slurp` | Screenshot de região |
| `wl-clipboard` + `cliphist` | Clipboard Wayland |
| `xwayland-satellite` | Suporte a apps X11 no Wayland |
| `playerctl` | Controle de mídia MPRIS |
| `brightnessctl` | Controle de brilho |

---

## 🐚 Shell (Fish)

**Arquivo:** `modules/base/shell.nix`

### Integrações
- **Starship** — prompt customizável (config em `stow/starship/`)
- **Atuin** — histórico de comandos pesquisável
- **Zoxide** — navegação inteligente (substitui `cd`)
- **Carapace** — autocompleção avançada
- **Eza** — listagem de arquivos (`--long --all`, ícones, git)

### Aliases Principais
| Alias | Comando |
|---|---|
| `rebuild` | `sudo nixos-rebuild switch --flake .#nixos` |
| `update` | Atualiza flake + rebuild |
| `hh` | Aplica configuração do Home Manager |
| `cleanup` | `sudo nix-collect-garbage -d` |
| `ns` | `nix search nixpkgs` |
| `nsh` | `nix shell nixpkgs` |
| `vi` | Abre nvim na pasta `~/myNixOS` |
| `ll`, `la`, `lt` | Variações do `eza` |
| `nvim-fresh` | Limpa cache do Neovim e reinicia |
| `kilo` | Executa o CLI do Kilo Code |

### Função `ai`
Chama o script `ai-cmd` para gerar comandos shell usando IA:
```fish
ai "compactar pasta src em tar.gz excluindo node_modules"
# Saída: tar --exclude='./node_modules' -czf src.tar.gz src/
```

---

## 🤖 Script `ai-cmd`

**Arquivo:** `scripts/ai-cmd`

Script Node.js que consulta a **API da Anthropic** (Claude Haiku) para gerar comandos shell a partir de descrições em linguagem natural.

**Requisito:** variável `ANTHROPIC_API_KEY` definida (carregada de `~/.secrets`).

```bash
# Uso direto
~/myNixOS/scripts/ai-cmd "listar arquivos modificados hoje"

# Via função Fish
ai "listar arquivos modificados hoje"
```

---

## 📝 Neovim

**Base:** LazyVim (`stow/nvim/`)

### Extras do LazyVim habilitados
- `extras.editor.inc-rename` — renomeação incremental
- `extras.lang.typescript` — suporte TypeScript
- `extras.ui.smear-cursor` — animação de cursor

### Plugins customizados
| Plugin | Finalidade |
|---|---|
| `claudecode.lua` | Integração com Claude Code |
| `opencode.lua` | Integração com OpenCode |
| `gitsigns.lua` | Indicadores Git no editor |
| `leetcode.lua` | Plataforma LeetCode integrada |
| `snacks.lua` | Utilitários UI (Snacks.nvim) |
| `neo-tree.lua` | Explorador de arquivos |
| `colorscheme.lua` | Tema visual |
| `vim-visual-multi.lua` | Multi-cursor |
| `smear-cursor.lua` | Animação do cursor |
| `telescope.lua` | Fuzzy finder integrado |

---

## 🖥️ Niri (Compositor Wayland)

**Config:** `stow/niri/.config/niri/config.kdl`

Compositor de tiling Wayland com suporte a scroll horizontal de workspaces. A configuração KDL define:
- Atalhos de teclado
- Regras de janelas
- Integração com Noctalia Shell
- Tema via `noctalia.kdl`

---

## 🌙 Noctalia Shell

**Config:** `stow/noctalia/.config/noctalia/`

Barra de status/shell customizada integrada ao Niri.

**Tema de cores (Catppuccin Mocha):**
| Token | Cor |
|---|---|
| Primary | `#cba6f7` (Mauve) |
| Secondary | `#fab387` (Peach) |
| Tertiary | `#94e2d5` (Teal) |
| Surface | `#1e1e2e` |
| Error | `#f38ba8` |
| Text | `#cdd6f4` |

**Plugins ativos:**
- `keybind-cheatsheet` — cheatsheet de atalhos do Niri (com i18n em 20+ idiomas)
- `port-monitor` — monitoramento de portas de rede em tempo real

---

## 🎵 Spicetify (Spotify)

Spotify customizado com o tema **OnePunch** e extensões:
- `adblockify` — bloqueia anúncios
- `shuffle` — embaralhamento melhorado

---

## 🤖 OpenCode

**Config:** `stow/opencode/.config/opencode/opencode.json`

| Configuração | Valor |
|---|---|
| Modelo padrão | `openai/gpt-5.4` |
| Plugin | `oh-my-openagent` |
| MCP Server | `mcp-nixos` (via `nix run`) |
| Autoupdate | Desativado |

O servidor MCP `nixos` permite ao OpenCode consultar opções do NixOS, pacotes e configurações diretamente durante a sessão de IA.

---

## 🖋️ Fontes

| Tipo | Fonte |
|---|---|
| Monospace | JetBrainsMono Nerd Font |
| Sans-serif | Inter, Noto Sans |
| Serif | Noto Serif |
| Emoji | Noto Color Emoji |

**Cursor:** Bibata-Modern-Classic (tamanho 24)
**Ícones:** Papirus-Dark

---

## 🚀 Instalação e Uso

### Pré-requisitos
- NixOS instalado com Flakes habilitado
- Git configurado

### Clonar a configuração

```bash
git clone <seu-repositório> ~/myNixOS
cd ~/myNixOS
```

### Aplicar configuração do sistema

```bash
sudo nixos-rebuild switch --flake .#nixos
# ou usando o alias:
rebuild
```

### Aplicar apenas Home Manager

```bash
nix run home-manager -- switch --flake .#miranda@nixos \
  --extra-experimental-features 'nix-command flakes'
# ou usando o alias:
hh
```

### Atualizar inputs do flake

```bash
sudo nix flake update && sudo nixos-rebuild switch --flake .#nixos
# ou usando o alias:
update
```

### Aplicar dotfiles via Stow

```bash
cd ~/myNixOS
stow stow/kitty stow/nvim stow/niri stow/starship stow/noctalia stow/opencode
```

> **Nota:** A maioria dos dotfiles é vinculada automaticamente via `home.file` com `mkOutOfStoreSymlink`, apontando para `~/myNixOS/stow/...`. O `stow` manual só é necessário fora do contexto do Home Manager.

### Limpeza de gerações antigas

```bash
sudo nix-collect-garbage -d
# ou usando o alias:
cleanup
```

---

## 👤 Usuário

| Configuração | Valor |
|---|---|
| Username | `` |
| Shell | Fish |
| Grupos | `networkmanager`, `wheel` |
| Git name | `` |
| Git email | `` |
| State Version | `26.05` |

---

## 🔧 Perfis Disponíveis

| Perfil | Devtools | Desktop | Software | Fonts | Uso |
|---|---|---|---|---|---|
| `desktop` | ✅ | ✅ | ✅ | ✅ | Desktop completo |
| `cli-dev` | ✅ | ❌ | ❌ | ✅ | Servidor / headless |
| `codespace` | ✅ | ❌ | ❌ | ✅ | GitHub Codespaces |

---

## 📌 Inputs do Flake

| Input | Fonte |
|---|---|
| `nixpkgs` | `github:nixos/nixpkgs/nixos-26.05` |
| `home-manager` | `github:nix-community/home-manager/release-26.05` |
| `niri` | `github:sodiboo/niri-flake` |
| `noctalia` | `github:noctalia-dev/noctalia-shell` |
| `spicetify-nix` | `github:Gerg-L/spicetify-nix` |
| `silentSDDM` | `github:uiriansan/SilentSDDM` |
