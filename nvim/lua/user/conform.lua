local conform_status_ok, conform = pcall(require, "conform")
if not conform_status_ok then
  return
end

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
    ruby = { "standardrb" },
    go = { "gofmt" },
  },
  
  -- No auto-formatting on save
  
  -- Customize formatters
  formatters = {
    standardrb = {
      condition = function(ctx)
        return vim.fs.find({ ".standard.yml", ".standardrb" }, { path = ctx.filename, upward = true })[1]
      end,
    },
  },
})

-- Manual format keymap
vim.keymap.set({ "n", "v" }, "<leader>s", function()
  conform.format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 500,
  })
end, { desc = "Format file or range (in visual mode)" })
