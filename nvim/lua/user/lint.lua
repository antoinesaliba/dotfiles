local lint_status_ok, lint = pcall(require, "lint")
if not lint_status_ok then
  return
end

-- Configure linters by filetype
lint.linters_by_ft = {
  python = { "pylint" },
  ruby = { "standardrb" },
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  go = { "golangcilint" },
}

-- Auto-lint on save and text change
local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})

-- Manual lint keymap
vim.keymap.set("n", "<leader>ml", function()
  lint.try_lint()
end, { desc = "Trigger linting for current file" })
