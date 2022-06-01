local util = require("lspconfig/util")

local opts = {
  cmd = { "bundle", "exec", "solargraph", "stdio" },
  filetypes = { "ruby" },
  init_options = {
    formatting = false,
  },
  root_dir = util.root_pattern("Gemfile", ".git"),
  settings = {
    solargraph = {
      autoformat = true,
      completion = true,
      diagnostic = true,
      folding = true,
      references = true,
      rename = true,
      symbols = true,
    },
  },
}

return opts
