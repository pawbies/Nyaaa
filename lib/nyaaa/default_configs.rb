# frozen_string_literal: true

module Nyaaa
  DEFAULT_CONFIGS = {
    nvim: { folders: %w[nvim], to: "~/.config/nvim", type: "sym" },
    kitty: { folders: %w[kitty], to: "~/.config/kitty", type: "sym" }
  }
end
