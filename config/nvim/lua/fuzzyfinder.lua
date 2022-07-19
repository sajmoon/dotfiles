local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local M = {}


function M.setup()
  telescope.setup {
    extensions = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                         -- the default case_mode is "smart_case"
      }
    }
  }

  telescope.load_extension('fzf')
  telescope.load_extension("ui-select")

  local map = require("utils").map
  map("n", "<C-p>", ":Telescope find_files <CR>")
end

return M
