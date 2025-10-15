-- Modern LSP initialization (no direct lspconfig dependency)
require("user.lsp.configs")
require("user.lsp.handlers").setup()
require("user.lsp.null-ls")
