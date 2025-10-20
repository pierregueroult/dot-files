return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "auto",
      background = {
        dark = "macchiato",
        light = "latte",
      },
      transparent_background = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
      },
    });

    vim.cmd("colorscheme catppuccin")
  end

}
