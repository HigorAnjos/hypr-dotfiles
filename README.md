# Hyprland Dotfiles

Minhas configurações personalizadas do Hyprland e Zsh.

## 📦 Conteúdo

- **Hyprland**: Configurações completas do compositor Wayland
  - Keybinds personalizados (10 workspaces)
  - Tema de cursor: Future-black-cursors
  - Variáveis de ambiente
  - Aplicativos de inicialização
  - Waybar configurado

- **Zsh**: Configurações do shell
  - Função `gpick` para gerenciar repositórios Git
  - Aliases personalizados
  - Integração com fzf, zoxide, tmux

## 🚀 Instalação

```bash
# Backup das configurações atuais
mv ~/.config/hypr ~/.config/hypr.backup
mv ~/.zshrc ~/.zshrc.backup

# Clonar este repositório
git clone git@github.com:SEU_USUARIO/hypr-dotfiles.git

# Copiar configurações
cp -r hypr-dotfiles/hypr ~/.config/
cp hypr-dotfiles/.zshrc ~/

# Recarregar Hyprland
hyprctl reload
```

## ⚙️ Principais Recursos

### Workspaces
- `SUPER + [1-0]`: Trocar entre workspaces 1-10
- `SUPER + SHIFT + [1-0]`: Mover janela para workspace
- `SUPER + CTRL + [1-0]`: Mover janela silenciosamente

### Função gpick
```bash
gpick              # Menu interativo para clonar repositórios
gpick 1            # Clona projeto 1
gpick 1 -db        # Mostra configuração do banco de dados
gpick 1 -r         # Abre repositório no navegador
```

### Backup Automático
```bash
hypr-backup        # Faz backup das configurações para o GitHub
```

Esta função automaticamente:
- Copia as configurações atuais do Hyprland e Zsh
- Faz commit com timestamp
- Envia para o GitHub

## 📝 Notas

- Cursor configurado: Future-black-cursors (24px)
- Shell: Zsh com Oh My Zsh
- Terminal: Configurado para usar Kiro/Kitty

---

Última atualização: $(date +%Y-%m-%d)
