-- Startup optimizations
-- Disable some built-in plugins for faster startup
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

-- Optimize some vim settings for startup
vim.opt.shadafile = "NONE" -- Disable shada during startup
vim.g.did_install_default_menus = 1
vim.g.did_install_syntax_menu = 1
vim.g.skip_loading_mswin = 1
vim.g.did_load_filetypes = 0
vim.g.do_filetype_lua = 1

-- Re-enable shada after startup (with error handling)
vim.defer_fn(function()
  vim.opt.shadafile = ""
  local ok, err = pcall(vim.cmd, "rshada!")
  if not ok then
    -- Silently handle shada errors
    vim.schedule(function()
      vim.notify("Shada restore error (suppressed): " .. tostring(err), vim.log.levels.DEBUG)
    end)
  end
end, 100)
