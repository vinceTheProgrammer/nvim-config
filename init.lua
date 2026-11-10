vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set <space> as the leader key
-- See `:h mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '

-- nvim-tree recommends disabling netrw before plugins are loaded.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- OPTIONS
--
-- See `:h vim.o`
-- NOTE: You can change these options as you wish!
-- For more options, you can see `:h option-list`
-- To see documentation for an option, you can use `:h 'optionname'`, for example `:h 'number'`
-- (Note the single quotes)

vim.o.number = true
vim.o.relativenumber = true

-- nvim-tree / icons
vim.opt.termguicolors = true

-- Sync clipboard between OS and Neovim.
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    vim.o.clipboard = 'unnamedplus'
  end,
})

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.list = true

-- If performing an operation that would fail due to unsaved changes in the buffer,
-- ask whether you wish to save the current file(s).
vim.o.confirm = true

-- KEYMAPS
--
-- See `:h vim.keymap.set()`, `:h mapping`, `:h keycodes`

-- Use <Esc> to exit terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Navigate between windows with Alt + h/j/k/l.
vim.keymap.set({ 't', 'i' }, '<A-h>', '<C-\\><C-n><C-w>h', { desc = 'Move to left window' })
vim.keymap.set({ 't', 'i' }, '<A-j>', '<C-\\><C-n><C-w>j', { desc = 'Move to lower window' })
vim.keymap.set({ 't', 'i' }, '<A-k>', '<C-\\><C-n><C-w>k', { desc = 'Move to upper window' })
vim.keymap.set({ 't', 'i' }, '<A-l>', '<C-\\><C-n><C-w>l', { desc = 'Move to right window' })

vim.keymap.set('n', '<A-h>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<A-j>', '<C-w>j', { desc = 'Move to lower window' })
vim.keymap.set('n', '<A-k>', '<C-w>k', { desc = 'Move to upper window' })
vim.keymap.set('n', '<A-l>', '<C-w>l', { desc = 'Move to right window' })

-- PROJECT NAVIGATION
--
-- fzf-lua
vim.keymap.set('n', '<leader>ff', function()
  require('fzf-lua').files()
end, { desc = 'Find files' })

vim.keymap.set('n', '<leader>fg', function()
  require('fzf-lua').live_grep()
end, { desc = 'Live grep' })

vim.keymap.set('n', '<leader>fb', function()
  require('fzf-lua').buffers()
end, { desc = 'Find buffers' })

vim.keymap.set('n', '<leader>fr', function()
  require('fzf-lua').oldfiles()
end, { desc = 'Recent files' })

vim.keymap.set('n', '<leader>fd', function()
  require('fzf-lua').diagnostics_workspace()
end, { desc = 'Workspace diagnostics' })

vim.keymap.set('n', '<leader>fD', vim.diagnostic.setloclist, {
  desc = 'Buffer diagnostics',
})

vim.keymap.set('n', '<leader>k', vim.diagnostic.open_float, {
  desc = 'Show diagnostic',
})

vim.keymap.set('n', '<leader>fs', function()
  require('fzf-lua').lsp_document_symbols()
end, { desc = 'Document symbols' })

vim.keymap.set('n', '<leader>fw', function()
  require('fzf-lua').lsp_workspace_symbols()
end, { desc = 'Workspace symbols' })

vim.keymap.set('n', '<leader>q', '<cmd>close<cr>', {
  desc = 'Close window',
})

-- nvim-tree
vim.keymap.set('n', '<leader>e', function()
  require('nvim-tree.api').tree.toggle()
end, { desc = 'Toggle file tree' })

-- Jump history
vim.keymap.set('n', '<C-o>', '<C-o>', { desc = 'Jump backward' })
vim.keymap.set('n', '<C-i>', '<C-i>', { desc = 'Jump forward' })

-- AUTOCOMMANDS (EVENT HANDLERS)
--
-- See `:h lua-guide-autocommands`, `:h autocmd`, `:h nvim_create_autocmd()`

-- Highlight when yanking (copying) text.
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.hl.on_yank()
  end,
})

-- USER COMMANDS
--
-- See `:h nvim_create_user_command()` and `:h user-commands`

-- Create a command `:GitBlameLine` that prints the git blame for the current line.
vim.api.nvim_create_user_command('GitBlameLine', function()
  local line_number = vim.fn.line('.')
  local filename = vim.api.nvim_buf_get_name(0)
  print(vim.system({ 'git', 'blame', '-L', line_number .. ',+1', filename }):wait().stdout)
end, { desc = 'Print git blame for current line' })

-- PLUGINS
--
-- See `:h :packadd`, `:h vim.pack`

-- Add the "nohlsearch" package to automatically disable search highlighting after
-- 'updatetime' and when going to insert mode.
vim.cmd('packadd! nohlsearch')

-- Install third-party plugins via vim.pack.add().
vim.pack.add({
  -- LSP
  'https://github.com/neovim/nvim-lspconfig',

  -- Fuzzy finder / project navigation
  'https://github.com/ibhagwan/fzf-lua',

  -- File explorer
  'https://github.com/nvim-tree/nvim-tree.lua',

  -- Icons for nvim-tree, fzf-lua, and which-key
  'https://github.com/nvim-tree/nvim-web-devicons',

  -- Keymap helper
  'https://github.com/folke/which-key.nvim',

  -- Autocompletion
  'https://github.com/nvim-mini/mini.completion',

  -- Enhanced quickfix/loclist
  'https://github.com/stevearc/quicker.nvim',

  -- Git integration
  'https://github.com/lewis6991/gitsigns.nvim',

  'https://github.com/savq/melange-nvim',
  'https://github.com/j-hui/fidget.nvim',
})

-- PLUGIN SETUP

vim.cmd.colorscheme('melange')

vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      check = {
        command = 'clippy',
      },
    },
  },
})

vim.lsp.enable('rust_analyzer')

require('fidget').setup({})

vim.api.nvim_set_hl(0, 'NvimTreeFolderName', {
  fg = '#d8c7a5',
})
vim.api.nvim_set_hl(0, 'NvimTreeOpenedFolderName', {
  fg = '#c9a86a',
})

vim.api.nvim_set_hl(0, 'NvimTreeGitIgnored', {
  fg = '#837f7c',
})

require('fzf-lua').setup({
  fzf_colors = true,
})

require('nvim-tree').setup({
  sort = {
    sorter = 'case_sensitive',
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
    highlight_git = "all",
  },
  filters = {
    dotfiles = false,
    git_ignored = false,
  },
  hijack_cursor = true,
  diagnostics = {
    enable = true,
    show_on_dirs = true
  },
})

require('mini.completion').setup {
  mappings = {
    scroll_down = '<C-j>',
    scroll_up = '<C-k>',
  },
}
require('quicker').setup {}
require('gitsigns').setup {}

-- Which-Key
require('which-key').setup({
  preset = 'classic',
})

require('which-key').add({
  -- Project navigation
  { '<leader>f', group = 'find / search' },
  { '<leader>ff', desc = 'Find files' },
  { '<leader>fg', desc = 'Live grep' },
  { '<leader>fb', desc = 'Find buffers' },
  { '<leader>fr', desc = 'Recent files' },
  { '<leader>fd', desc = 'Workspace diagnostics' },
  { '<leader>fs', desc = 'Document symbols' },
  { '<leader>fw', desc = 'Workspace symbols' },

  -- Explorer
  { '<leader>e', desc = 'Toggle file tree' },

  -- Optional explicit groups for future mappings
  { '<leader>g', group = 'git' },
  { '<leader>l', group = 'lsp' },
  { '<leader>w', group = 'windows' },
})
