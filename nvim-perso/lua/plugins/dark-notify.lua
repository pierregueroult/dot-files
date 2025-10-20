-- File: ~/.config/nvim/lua/plugins/dark-notify.lua
return {
  {
    -- Plugin Lua côté Neovim
    "cormacrelf/dark-notify",
    lazy = false, -- on veut suivre le système dès le lancement
    priority = 1000, -- s'assurer qu'il se charge tôt (avant le choix du colorscheme)
    config = function()
      local ok, dn = pcall(require, "dark_notify")
      if not ok then
        vim.notify("dark-notify: require failed", vim.log.levels.ERROR)
        return
      end

      -- Configuration basique: suit macOS et règle :set background=light/dark
      -- Pour un mapping pratique:
      vim.keymap.set("n", "<F5>", function()
        dn.toggle()
      end, { desc = "Toggle light/dark via dark-notify" })

      -- Exemple de configuration avancée avec couleurs différentes selon le mode.
      -- Adapte les noms de schemes à tes thèmes LazyVim (catppuccin, tokyonight, etc.)
      dn.run({
        schemes = {
          dark = "catppuccin-macchiato", -- ex: mode sombre
          light = {
            colorscheme = "catppuccin-latte", -- ex: mode clair
            -- background = "light", -- optionnel: forcer background si besoin
            -- lightline = "my_lightline_theme", -- si tu utilises lightline
          },
        },
        -- Callback déclenché au démarrage et à chaque changement
        onchange = function(mode)
          -- Tu peux ajouter ici des ajustements complémentaires (statusline, transparency, etc.)
          -- Exemple: adapter la transparence de Ghostty/alacritty via Neovim si tu synchronises
          -- vim.notify("Mode système: " .. mode)
        end,
      })
    end,
  },
}

