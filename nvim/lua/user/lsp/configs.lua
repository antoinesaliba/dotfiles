-- Modern LSP configuration using vim.lsp.config (Neovim 0.11+)
local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
  return
end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
  return
end

-- Setup Mason
mason.setup({
  ui = {
    border = "rounded",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

-- LSP servers to install and configure
local servers = {
  "lua_ls",
  "terraformls", 
  "solargraph",
  "pylsp",
  "gopls"
}

-- Setup mason-lspconfig
mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_installation = true,
})

-- Get handlers for reuse
local handlers = require("user.lsp.handlers")

-- Setup each LSP server using modern vim.lsp.config
local function setup_server(server_name)
  local opts = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
  }
  
  -- Load server-specific settings if they exist
  local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server_name)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
  end
  
  -- Use modern vim.lsp.config if available (Neovim 0.11+)
  if vim.lsp.config then
    vim.lsp.config[server_name] = opts
  else
    -- Fallback to lspconfig for older Neovim versions
    local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
    if lspconfig_status_ok then
      lspconfig[server_name].setup(opts)
    end
  end
end

-- Setup all servers
for _, server in pairs(servers) do
  setup_server(server)
end