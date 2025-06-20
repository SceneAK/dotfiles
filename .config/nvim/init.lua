vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { 'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')
      lspconfig.clangd.setup({})
    end
  },
  { 'rmagatti/auto-session', lazy = false },
  { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },
  {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
  {'akinsho/toggleterm.nvim', version = "*", config = true},
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})

-- Other Pluggins
require("auto-session").setup {
  auto_save = true,
  auto_restore = true,
  root_dir = vim.fn.stdpath("data") .. "/nvim_sessions/",
}
require("catppuccin").setup({
    flavour = "mocha",
    no_italic = true,
    background = { 
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false,
})
require("ibl").setup({})
require("bufferline").setup({
    options = {
        mode = 'tabs',
        separator_style = 'slant',
    },
})
require("toggleterm").setup({
    size=7,
    open_mapping = [[<c-\>]],
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"


-- Bubbles config for lualine
-- Author: lokesh-krishna 
local colors = {
  lightblue   = '#ADD8E6',
  pink   = '#ff91a4',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  lime = '#b5e550',
  grey   = '#303030',
  yellow = '#FDFD96',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.lime },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white },
  },
  command = { a = { fg = colors.black, bg = colors.yellow } }, 
  insert = { a = { fg = colors.black, bg = colors.lightblue } },
  visual = { a = { fg = colors.black, bg = colors.pink } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white },
  },
}

local function has_space(limit) 
    return function() return vim.fn.winwidth(0) > limit end
end
require('lualine').setup({
  options = {
    theme = bubbles_theme,
    component_separators = '',
    section_separators = { left = ' ', right = ' ' },
  },
  sections = {
    lualine_a = { { 'mode', separator = {  left = ' ', right = '' }, right_padding = 2 } },
    lualine_b = { {'diagnostics', cond = has_space(50) }, {'branch', cond = has_space(70) } },
    lualine_c = { "%=", "filename", },
    lualine_x = { {'filetype', cond = has_space(50) } },
    lualine_y = { {'progress', cond = has_space(75) }, },
    lualine_z = { { 'location', separator = { right = ' ', left = '' } }, },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
})

