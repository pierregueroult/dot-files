return {
  {
    "mrloop/telescope-git-branch.nvim"
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {
        desc = "Find Files"
      })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {
        desc = "Live Grep"
      })
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      require("telescope").load_extension("git_branch")
      require("telescope").load_extension("ui-select")

      vim.keymap.set("n", '<leader>gb', function()
        require('git_branch').files()
      end)
    end,
  },
}
