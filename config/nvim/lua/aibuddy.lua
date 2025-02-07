local status_ok, codecompanion = pcall(require, "codecompanion")
if not status_ok then
  return
end

local M = {}

function M.setup()
  codecompanion.setup({
    strategies = {
      chat = {
        adapter = "anthropic",
      },
      inline = {
        adapter = "anthropic",
      },
    },
  })

  vim.keymap.set("n", "<leader>ac", ":CodeCompanionChat Toggle<CR>", { desc = "Open existing chat" })
  vim.keymap.set("n", "<leader>an", ":CodeCompanionChat<CR>", { desc = "New existing chat" })
  vim.keymap.set("n", "<leader>ap", ":CodeCompanion<CR>", { desc = "Code prompt" })
  vim.keymap.set("n", "<leader>aa", ":CodeCompanionActions<CR>", { desc = "Code companion actions" })
end

return M
