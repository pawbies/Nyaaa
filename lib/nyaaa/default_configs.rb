# frozen_string_literal: true

module Nyaaa
  DEFAULT_CONFIGS = {
    # Shells
    zsh: { folders: %w[zsh], to: "~/.config/zsh", type: "sym" },
    bash: { folders: %w[bashrc bash], to: "~/.bashrc", type: "sym" },
    fish: { folders: %w[fish], to: "~/.config/fish", type: "sym" },

    # Terminal emulators
    alacritty: { folders: %w[alacritty], to: "~/.config/alacritty", type: "sym" },
    wezterm: { folders: %w[wezterm], to: "~/.config/wezterm", type: "sym" },
    tmux: { folders: %w[tmux], to: "~/.config/tmux", type: "sym" },
    kitty: { folders: %w[kitty], to: "~/.config/kitty", type: "sym" },

    # Version control
    git: { folders: %w[git], to: "~/.config/git", type: "sym" },
    lazygit: { folders: %w[lazygit], to: "~/.config/lazygit", type: "sym" },

    # Text editors
    vim: { folders: %w[vim], to: "~/.vim", type: "sym" },
    nvim: { folders: %w[nvim], to: "~/.config/nvim", type: "sym" },
    # ye i know emacs isnt a text editor but i dont care leave me alone
    emacs: { folders: %w[emacs], to: "~/.config/emacs", type: "sym" },
    doom: { folders: %w[doom], to: "~/.config/doom", type: "sym" },
    helix: { folders: %w[helix], to: "~/.config/helix", type: "sym" }
  }.freeze
end
