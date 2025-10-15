-- Modern LSP configuration using vim.lsp.config (Neovim 0.11+)
local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

-- servers installed on my devices : When you install a server add this to this list
local servers = { "lua_ls", "terraformls", "solargraph", "pylsp", "gopls" }

lsp_installer.setup {
  ensure_installed = servers
}

-- Get handlers for reuse
local handlers = require("user.lsp.handlers")

for _, server in pairs(servers) do
  local opts = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
  }
  
  -- Load server-specific settings if they exist
  local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
  end
  
  -- Use the modern vim.lsp.config API for Neovim 0.11+
  if vim.lsp.config then
    vim.lsp.config[server] = opts
  else
    -- Fallback to lspconfig for older Neovim versions
    local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
    if lspconfig_ok then
      lspconfig[server].setup(opts)
    end
  end
end
