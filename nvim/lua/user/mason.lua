-- Mason setup for package management
local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
  return
end

mason.setup({
  ui = {
    border = "rounded",
    width = 0.8,
    height = 0.8,
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  },
  
  -- Automatically install missing packages
  install_root_dir = vim.fn.stdpath("data") .. "/mason",
  
  -- Package installation settings
  pip = {
    upgrade_pip = false,
    install_args = {},
  },
  
  -- Logging
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
})

-- Ensure DAP servers are installed
local mason_dap_status_ok, mason_dap = pcall(require, "mason-nvim-dap")
if mason_dap_status_ok then
  mason_dap.setup({
    ensure_installed = { "delve" }, -- Go debugger
    automatic_installation = true,
  })
end

-- Install formatters and linters via Mason (only if missing)
local function ensure_tools_installed()
  local registry = require("mason-registry")
  local tools = {
    -- Formatters
    "stylua",      -- Lua
    "black",       -- Python
    "prettier",    -- JS/TS/JSON/YAML/etc
    -- Note: gofmt is built into Go, no need to install via Mason
    
    -- Linters
    "pylint",      -- Python
    "eslint_d",    -- JS/TS
  }
  
  for _, tool in ipairs(tools) do
    local package = registry.get_package(tool)
    if not package:is_installed() then
      vim.notify("Installing " .. tool .. "...")
      package:install()
    end
  end
end

-- Try to use mason-tool-installer first, fallback to manual check
local mason_tool_installer_status_ok, mason_tool_installer = pcall(require, "mason-tool-installer")
if mason_tool_installer_status_ok then
  mason_tool_installer.setup({
    ensure_installed = {
      -- Formatters
      "stylua",      -- Lua
      "black",       -- Python
      "prettier",    -- JS/TS/JSON/YAML/etc
      -- Note: gofmt is built into Go, no need to install via Mason
      
      -- Linters
      "pylint",      -- Python
      "eslint_d",    -- JS/TS
    },
    auto_update = false,
    run_on_start = false, -- Don't run on every start
  })
else
  -- Fallback: check and install missing tools only once per session
  vim.defer_fn(function()
    local registry_ok, _ = pcall(require, "mason-registry")
    if registry_ok then
      ensure_tools_installed()
    end
  end, 1000)
end
