local util = require("lspconfig/util")
local py_root = { "venv/", "requirements.txt", "setup.py", "pyproject.toml", "setup.cfg" }

local opts = {
  cmd = { "pylyzer", "--server" },
  filetypes = { "python" },
  handlers = {
    ["textDocument/publishDiagnostics"] = function() end,
  },
  root_dir = util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt"),
  settings = {
    python = {
      checkOnType = false,
      diagnostics = false,
      inlayHints = false,
      smartCompletion = false
    }
  }
}

return opts
