return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
        -- Make the server aware of Neovim runtime files
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
