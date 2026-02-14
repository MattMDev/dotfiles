# AGENTS.md - Dotfiles Configuration Repository

This repository contains Linux configuration files for Hyprland, Neovim, Zsh, and other tools.

## Repository Structure

```
.
├── hypr/           # Hyprland window manager config
├── nvim/           # Neovim configuration (Lua)
├── kitty/          # Kitty terminal config
├── quickshell/     # Custom status bar (QML)
├── wofi/           # Application launcher config
├── dunst/          # Notification daemon config
├── wpaperd/        # Wallpaper daemon config
├── wallpapers/     # Wallpaper images
├── install.sh      # Installation script
└── .zshrc         # Zsh configuration
```

## Build/Lint/Test Commands

This is a configuration repository - there are no traditional build/test commands. However:

### Testing Configurations

- **Hyprland**: Run `hyprctl reload` to reload config changes (or restart Hyprland)
- **Neovim**: Run `:Lazy` or `:LazySync` to sync plugins; `:checkhealth` for diagnostics
- **Zsh**: Run `source ~/.zshrc` to reload, or `zsh -n ~/.zshrc` for syntax check

### Installation

```bash
./install.sh        # Copy configs to ~/.config/ and reload Hyprland
```

### Neovim Plugin Management

```bash
nvim --headless "+Lazy! sync" +qa    # Sync all plugins
nvim --headless "+Lazy" +qa          # Open Lazy UI
```

### Single Test Patterns

- For config changes, manually test in the running application
- No automated tests exist - manual verification required

## Code Style Guidelines

### General Principles

- Configuration files should be well-organized with clear section headers
- Use comments to explain non-obvious settings
- Keep files modular (e.g., Neovim plugins in separate files)
- Use consistent naming conventions within each tool

### Hyprland (hyprland.conf)

- Use `### SECTION` headers for major sections
- Indent with 4 spaces
- Keybinds: `bind = $mainMod, KEY, action, args`
- Window rules: Use `windowrule` and `windowrulev2` for specific apps
- Monitor config at top of file

### Neovim (Lua)

- Follow Lua conventions: lowercase with underscores for variables
- Use `require()` for module imports
- 2-space indentation in Lua files
- Keymaps use `vim.keymap.set(mode, key, rhs, opts)`
- Leader key is `<Space>`, localleader is `\`
- Use descriptive `desc` in keymap options
- See `lua/config/options.lua` for standard settings:
  - `expandtab = true`, `tabstop = 4`, `shiftwidth = 4`
  - `number`, `relativenumber` enabled
  - `splitbelow`, `splitright` enabled

### Zsh (.zshrc)

- Lowercase for aliases and functions
- Group related settings (history, PATH, aliases)
- Use comments to describe what each section does
- Plugins listed in `plugins` array

### Kitty (kitty.conf)

- Simple key=value format
- Use `include theme.conf` for theming
- Group related settings together
- Map format: `map key action`

### QML (Quickshell)

- Follow Qt naming conventions (camelCase for properties)
- Use descriptive property names
- Group related UI elements
- Keep the panel height at 30px

### General Conventions

- Use semantic naming (e.g., `$terminal`, `$browser` in Hyprland)
- Prefer 4-space indentation in config files
- Use hex colors in format `#RRGGBB` or `#AARRGGBB`
- Sort keybinds logically (group by function)
- Document non-standard keybindings

## Editor Setup

This repository uses Neovim with:
- Lazy.nvim for plugin management
- blink.cmp for completion
- nvim-lspconfig for LSP
- nvim-treesitter for syntax highlighting

## Notes

- Primary display: DP-1 (2560x1440@164.96Hz)
- Secondary: DP-3 (1920x1080@60)
- TV: HDMI-A-3 (2560x1440@60)
- Terminal: Kitty with 0.85 opacity
- Main modifier key: ALT
