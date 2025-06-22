local status_ok, mason = pcall(require, 'mason')
if not status_ok then
  return
end

mason.setup {
  ui = {
    border = 'rounded',
    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗',
    },
  },
}

local packages_to_install = {
  -- LSP servers
  'asm-lsp',
  'bash-language-server',
  'clangd',
  'clojure-lsp',
  'css-lsp',
  'dockerfile-language-server',
  'eslint-lsp',
  'fsautocomplete',
  'gopls',
  'graphql-language-service-cli',
  'haskell-language-server',
  'html-lsp',
  'jdtls',
  'json-lsp',
  'lua-language-server',
  'ocaml-lsp',
  'pyright',
  'ruby-lsp',
  'rust-analyzer',
  'sqlls',
  'svelte-language-server',
  'tailwindcss-language-server',
  'typescript-language-server',
  'yaml-language-server',
  'zls',

  -- Formatters
  'black',
  'clang-format',
  'isort',
  'prettier',
  'prettierd',
  'rubyfmt',
  'shfmt',
  'sleek',
  'stylua',

  -- Linters
  'checkstyle',
  'cpplint',
  'eslint_d',
  'flake8',
  'golangci-lint',
  'luacheck',
  'markdownlint',
  'pylint',
  'rubocop',
  'shellcheck',
  'vale',
}

-- Simple function to ensure packages are installed
local function ensure_installed()
  local registry_status_ok, registry = pcall(require, 'mason-registry')
  if not registry_status_ok then
    vim.notify('Mason registry not available', vim.log.levels.ERROR)
    return
  end

  -- Refresh registry first
  registry.refresh(function()
    local installed_packages = {}
    local packages_to_install_list = {}

    -- Get currently installed packages
    for _, pkg in ipairs(registry.get_installed_packages()) do
      installed_packages[pkg.name] = true
    end

    -- Check which packages need to be installed
    for _, package_name in ipairs(packages_to_install) do
      if not installed_packages[package_name] then
        if registry.has_package(package_name) then
          table.insert(packages_to_install_list, package_name)
        else
          vim.notify('Package not found: ' .. package_name, vim.log.levels.WARN)
        end
      end
    end

    -- Install missing packages
    if #packages_to_install_list > 0 then
      vim.notify(
        string.format('Installing %d Mason packages...', #packages_to_install_list),
        vim.log.levels.INFO,
        { title = 'Mason Auto Install' }
      )

      -- Install packages
      for _, package_name in ipairs(packages_to_install_list) do
        local package = registry.get_package(package_name)
        if package and not package:is_installed() then
          vim.notify('Starting installation: ' .. package_name, vim.log.levels.INFO)
          package:install()
        end
      end

      -- Open Mason UI
      local ui_ok, ui = pcall(require, 'mason.ui')
      if not ui_ok then
        vim.notify('Mason UI not available', vim.log.levels.ERROR)
        return
      end
      ui.open()
    end
  end)
end

-- Add status function to check installation status
local function check_status()
  local registry_status_ok, registry = pcall(require, 'mason-registry')
  if not registry_status_ok then
    vim.notify('Mason registry not available', vim.log.levels.ERROR)
    return
  end

  local installed_packages = {}
  local missing_packages = {}

  -- Get installed packages
  for _, pkg in ipairs(registry.get_installed_packages()) do
    installed_packages[pkg.name] = true
  end

  -- Check status of our predefined packages
  for _, package_name in ipairs(packages_to_install) do
    if not installed_packages[package_name] then
      table.insert(missing_packages, package_name)
    end
  end

  -- Report status
  local total = #packages_to_install
  local installed = total - #missing_packages
  local percentage = math.floor((installed / total) * 100)

  print 'Mason Package Status:'
  print(string.format('Progress: %d%% (%d/%d)', percentage, installed, total))

  if #missing_packages > 0 then
    print '\nMissing packages:'
    for i, pkg in ipairs(missing_packages) do
      print(string.format('  %d. %s', i, pkg))
    end
    print '\nRun :MasonAutoInstall to install missing packages'
  else
    print '✓ All packages are installed!'
  end
end

-- Auto-install on startup
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    ensure_installed()
  end,
})

-- Create user commands for manual operations
vim.api.nvim_create_user_command('MasonAutoInstall', ensure_installed, {
  desc = 'Install all predefined Mason packages',
})

vim.api.nvim_create_user_command('MasonAutoInstallStatus', check_status, {
  desc = 'Check status of predefined Mason packages',
})
