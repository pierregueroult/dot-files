return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "AndreM222/copilot-lualine" },
  opts = function()
    local macchiato = require("catppuccin.palettes").get_palette("macchiato")
    local icons = LazyVim.config.icons
    local used_spaces_table = {}

    local function get_used_space(opts)
     local used_space = 0
      for k, v in pairs(used_spaces_table) do
        if vim.tbl_contains(opts.exclude, k) then
          goto continue
        end
        used_space = used_space + v
        ::continue::
      end
      return used_space
    end

    local components = {
      mode = {
        "mode",
        color = { fg = macchiato.crust, bg = macchiato.blue },
        fmt = function(str)
          if str == "" then
            used_spaces_table["mode"] = 0
          else
            used_spaces_table["mode"] = #str + 2 -- 2 is the length of padding
          end
          return str
        end,
      },
     branch = {
        "b:gitsigns_head",
        icon = "",
        color = { fg = macchiato.crust, bg = macchiato.sapphire },
        cond = function()
          local should_show = vim.opt.columns:get() > 60
          if not should_show then
            used_spaces_table["branch"] = 0
          end
          return should_show
        end,
        fmt = function(str)
          if str == "" then
            used_spaces_table["branch"] = 0
          else
            used_spaces_table["branch"] = #str + 2 + 2 -- 4 is the length of icon (unicode), 2 is the length of padding
          end
          return str
        end,
      },
      copilot = {
        "copilot",
        show_colors = false,
        color = { fg = macchiato.crust, bg = macchiato.sapphire },
        symbols = {
          status = {
            icons = {
              enabled = " ",
              sleep = " ", -- auto-trigger disabled
              disabled = " ",
              warning = " ",
              -- unknown = " ",
              unknown = "",
            },
          },
        },
        show_loading = false,
        on_click = function() vim.cmd("Copilot toggle") end,
        fmt = function(str)
          if str == "" then
            used_spaces_table["copilot"] = 0
          else
            used_spaces_table["copilot"] = vim.fn.strchars(str) + 2
          end
          return str
        end,
      },
      file_icon = {
        "filetype",
        icon_only = true,
        separator = "",
        padding = { left = 0, right = 0 },
        fmt = function(str)
          if str == "" then
            used_spaces_table["filetype"] = 0
          else
            used_spaces_table["filetype"] = 2 + 1 -- 2 is the length of icon (unicode), 1 is the length of padding
          end
          return str
        end,
      },
      file_path = {
        "filename",
        fmt = function(filename)
          if filename == "" then
            used_spaces_table["filename"] = 0
            return ""
          end
          local free_space = vim.opt.columns:get() - get_used_space({ exclude = { "filetype", "filename", "fill_space" } })
          -- if the filename is longer than the free space, use the filename
          if free_space < #filename + used_spaces_table["filetype"] + 4 then
            filename = vim.fs.basename(filename)
          end
          used_spaces_table["filename"] = #filename + 1 -- 1 is the length of padding
          return filename
        end,
      },
      diagnostics = {
        "diagnostics",
        symbols = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warn,
          info = icons.diagnostics.Info,
          hint = icons.diagnostics.Hint,
        },
      },
      lsp_status = {
        "lsp_status",
        icon = "",
        color = { fg = macchiato.crust, bg = macchiato.sky },
        ignore_lsp = { "null-ls", "copilot" },
        symbols = {
          -- Standard unicode symbols to cycle through for LSP progress:
          spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
          -- Standard unicode symbol for when LSP is done:
          done = '',
          -- Delimiter inserted between LSP names:
          separator = ' ',
        },
        fmt = function(str)
          local l = vim.fn.strchars(str)
          local remain_space = vim.opt.columns:get() - get_used_space({ exclude = { "lsp_status" } })
          if remain_space < l + 4 then
            str = ""
          end
          if str == "" then
            used_spaces_table["lsp_status"] = 0
          else
            used_spaces_table["lsp_status"] = vim.fn.strchars(str) + 2 + 2 + 1
          end
          return str
        end,
      },
      diff = {
        "diff",
        symbols = {
          added = icons.git.added,
          modified = icons.git.modified,
          removed = icons.git.removed,
        },
        color = { fg = macchiato.crust, bg = macchiato.sky },
        diff_color = {
          added = { fg = macchiato.crust },
          modified = { fg = macchiato.crust },
          removed = { fg = macchiato.crust },
        },
        source = function()
          local gitsigns = vim.b.gitsigns_status_dict
          if gitsigns then
            return {
              added = gitsigns.added,
              modified = gitsigns.changed,
              removed = gitsigns.removed,
            }
          end
        end,
        fmt = function(str)
          if str == "" then
            used_spaces_table["diff"] = 0
          else
            local evaled_str = vim.api.nvim_eval_statusline(str, {}).str
            used_spaces_table["diff"] = vim.fn.strchars(evaled_str) + 2 -- 2 is the length of padding
          end
          return str
        end,
      },
      location = { "location", padding = { left = 0, right = 1 } },
      fill_space = {
        function()
          local used_space = used_spaces_table["mode"] + used_spaces_table["branch"] + used_spaces_table["diff"]
          local win_width = vim.opt.columns:get()
          local fill_space = string.rep(
            " ",
            math.floor((win_width - used_spaces_table["filename"] - used_spaces_table["filetype"]) / 2) - used_space
          )
          return fill_space
        end,
        padding = { left = 0, right = 0 },
        cond = function()
          return vim.opt.columns:get() > 60
        end,
        fmt = function(str)
          if str == "" then
            used_spaces_table["fill_space"] = 0
          else
            used_spaces_table["fill_space"] = #str
          end
          return str
        end,
      },
    }

    local spacer = {
      function()
        return " "
      end,
      padding = { left = 0, right = 0 }, -- augmente pour plus d'espace (ex: {2,2} ou {3,3})
      separator = "",
      color = { bg = "transparent" },
    }

    local opts = {
      options = {
        globalstatus = true,
        disabled_filetypes = {
          statusline = { "alpha", "snacks_dashboard" },
        },
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {
          components.mode,
          spacer,
        },
        lualine_b = {
          components.branch,
          spacer,
          components.diff,
          spacer,
        },
        lualine_c = {
          components.fill_space,
          components.file_icon,
          components.file_path,
        },
        lualine_x = {
          components.diagnostics,
          spacer,
        },
        lualine_y = {
          components.lsp_status,
          spacer,
          components.copilot,
          spacer,
        },
        lualine_z = {
          components.location
        },
      },
      extensions = { "neo-tree", "lazy", "fzf" },
    }

    return opts
  end,
}
