-- Avante Usage:
--
-- Chat Interface:
--   :AvanteAsk - Ask a question about current buffer
--   :AvanteChat - Open chat window
--   :AvanteToggle - Toggle chat sidebar
--
-- Inline Editing (Cursor-like):
--   Select code in visual mode → :AvanteEdit - Get AI suggestions as inline diffs
--   Tab / Shift+Tab - Cycle through suggested changes
--   Enter - Accept current suggestion
--   Esc - Reject and close
--
-- Auto-suggestions:
--   Should appear automatically as you code (if configured)
--   Ghost text shows suggested changes inline
--   Accept with keybinding (check :help avante for defaults)
--
-- Context:
--   Avante sees your current buffer
--   Add files to context with @filename in chat
--   Uses your project structure for better suggestions
--
-- Cost warning: auto_suggestions_provider = "claude" hits API frequently
-- Consider changing to "copilot" (free) if costs get high

local M = {}

function M.setup()
  local status_ok, avante = pcall(require, "avante")
  if not status_ok then
    return
  end

  avante.setup({
    provider = "claude",
    auto_suggestions_provider = "claude-haiku",
    hints = { enabled = true },
    behaviour = {
      auto_suggestions = true,
    },
    mappings = {
      suggestion = {
        accept = "<Tab>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
      ask = "<leader>aa",  -- Opens sidebar chat
    },
    providers = {
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-sonnet-4-5-20250929",
        api_key_name = "NVIM_ANTHROPIC_KEY",
      },
      ["claude-haiku"] = {
        endpoint = "https://api.anthropic.com",
        model = "claude-haiku-4-5-20251001",
        api_key_name = "NVIM_ANTHROPIC_KEY",
      },
    },
  })
end

return M
