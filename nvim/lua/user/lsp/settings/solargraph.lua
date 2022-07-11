local util = require("lspconfig/util")

local opts = {
  cmd = { "solargraph", "stdio" },
  filetypes = { "ruby" },
  init_options = {
    formatting = false,
  },
  root_dir = util.root_pattern("Gemfile", ".git"),
  settings = {
    solargraph = {
      commandPath = "/Users/antoinesaliba/.rvm/gems/ruby-2.7.5/bin/solargraph",
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
