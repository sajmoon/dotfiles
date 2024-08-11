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

--  telescope.load_extension('fzf')
  telescope.load_extension("ui-select")

  vim.keymap.set("n", "<C-p>", ":Telescope find_files <CR>", { desc = "Find Files" })
  vim.keymap.set("n", "<leader>ff", ":Telescope find_files <CR>", { desc = "Find Files" })
  vim.keymap.set("n", "<leader>fb", ":Telescope buffers <CR>", { desc = "Find buffers" })
  vim.keymap.set("n", "<leader>fg", ":Telescope live_grep theme=ivy<CR>", { desc = "Find Text" })
  vim.keymap.set("n", "<leader>fc", ":Telescope resume<CR>", { desc = "Resume last search" })
  vim.keymap.set("n", "<leader>fr", ":Telescope oldfiles<CR>", { desc = "Recent files" })
  vim.keymap.set("n", "<leader>fh", ":Telescope helptags<CR>", { desc = "Help tags" })
  vim.keymap.set("n", "<leader>fM", ":Telescope man_pages<CR>", { desc = "Man pages" })
  vim.keymap.set("n", "<leader>fR", ":Telescope registers<CR>", { desc = "Registers" })
  vim.keymap.set("n", "<leader>fk", ":Telescope keymaps<CR>", { desc = "Keymaps" })
  vim.keymap.set("n", "<leader>fC", ":Telescope commands<CR>", { desc = "Commands" })

end

return M
