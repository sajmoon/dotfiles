local map = require("utils").map

require('telescope').load_extension('fzf')
require("telescope").load_extension("ui-select")

map("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>")
map("n", "<C-p>", ":Telescope find_files <CR>")
map("n", "<leader>fg", ":Telescope live_grep <CR>")
map("n", "<leader>fb", ":Telescope buffers <CR>")
map("n", "<leader>fh", ":Telescope help_tags <CR>")
map("n", "<leader>fr", ":Telescope resume <CR>")
