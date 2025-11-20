require("core.options")

require("plugins")

require("fuzzyfinder").setup()
require("config.lsp.init").setup()
require("config.git.init").setup()
require("completion")
require("codeactions").setup()
require("keymapinfo")
require("git")

require("lookandfeel")
require("syntaxhighlight")
require("navigation")

require("aibuddy").setup()
