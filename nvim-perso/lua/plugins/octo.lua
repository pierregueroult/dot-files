return {
  "pwntester/octo.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("octo").setup()

    vim.keymap.set("n", "<leader>gr", "<cmd>Octo repo browser<CR>", { desc = "Open Octo Repo Browser" })
  end
}
