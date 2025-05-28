local lint_status_ok, lint = pcall(require, 'lint')
if not lint_status_ok then
  return
end

lint.linters_by_ft = {
  c = { 'cpplint' },
  cpp = { 'cpplint' },
  go = { 'golangcilint' },
  java = { 'checkstyle' },
  javascript = { 'eslint_d' },
  lua = { 'luacheck' },
  markdown = { 'vale', 'markdownlint' },
  python = { 'pylint', 'flake8' },
  ruby = { 'rubocop' },
  rust = { 'clippy' },
  sh = { 'shellcheck' },
  typescript = { 'eslint_d' },
}

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  callback = function()
    -- runs the linters defined in `linters_by_ft` for the current filetype
    lint.try_lint()
  end,
})
