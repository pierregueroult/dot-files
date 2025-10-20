local function custom_sort(a, b)
  -- fallback pour les noms manquants
  local name_a = type(a.name) == "string" and a.name or ""
  local name_b = type(b.name) == "string" and b.name or ""

  -- fallback pour les types manquants
  local type_a = a.type or ""
  local type_b = b.type or ""

  -- Dossiers avant fichiers
  if type_a == "directory" and type_b ~= "directory" then
    return true
  elseif type_a ~= "directory" and type_b == "directory" then
    return false
  end

  -- Fonction utilitaire pour extraire l'extension
  local function get_extension(filename)
    return filename:match("^.+(%..+)$") or ""
  end

  -- Deux dossiers => tri alphabétique
  if type_a == "directory" and type_b == "directory" then
    return name_a:lower() < name_b:lower()
  end

  -- Deux fichiers => tri par extension puis par nom
  local ext_a = get_extension(name_a):lower()
  local ext_b = get_extension(name_b):lower()

  if ext_a ~= ext_b then
    return ext_a < ext_b
  end

  return name_a:lower() < name_b:lower()
end

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  lazy = false,
  opts = {},
  config = function()
    require("neo-tree").setup({
      filesystem = {
        hijack_netrw_behavior = "open_default",
        window = { position = "left", width = 35 },
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          never_show = { ".DS_Store", "thumbs.db",  ".git", "node_modules", "vendor" },
        },
      },
      window = { position = "right", width = 35 },
      sort_case_insensitive = true,
      sort_function = custom_sort,
    })
    vim.keymap.set("n", "<leader>fv", ":Neotree filesystem reveal left<CR>")
  end,
}
