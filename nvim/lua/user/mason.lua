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
