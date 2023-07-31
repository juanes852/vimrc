-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- Packer can manage itself

    -- Language Server Protocol
    use 'neovim/nvim-lspconfig'

    -- LSP/DAP package manager
    use 'williamboman/mason.nvim'
    require('mason').setup()

    -- Auto-Completion
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    -- For vsnip users.
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

end)

--
-- auto-completion (nvim-cmp)
--
local cmp = require('cmp')
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end
cmp.setup({
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer' },
  }),
  snippet = {
    expand = function(args) vim.fn["vsnip#anonymous"](args.body) end,
  },
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends an already mapped key (probably `<Tab>` here).
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
    --   ['<C-f>']     = cmp.mapping(cmp.mapping.scroll_docs(4),  { 'i', 'c' }),
    --   ['<C-b>']     = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    --   ['<C-f>']     = cmp.mapping(cmp.mapping.scroll_docs(4),  { 'i', 'c' }),
    --   ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(),      { 'i', 'c' }),
    --   ['<C-y>']     = cmp.config.disable, --  remove the default `<C-y>` mapping
    --   ['<C-e>']     = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
    --   ['<CR>']      = cmp.mapping.confirm({ select = true }),
  },
})

--
-- LSP buffer-specific options and keymaps
--
local set_lsp_keymaps = function(client, bufnr)
  local opts = { buffer=bufnr, noremap=true, silent=true }
  local telescope = require('telescope.builtin')
  -- mappings
  vim.keymap.set( 'n',       'K',        vim.lsp.buf.hover,          opts)
  vim.keymap.set( 'n',       '<C-k>',    vim.lsp.buf.signature_help, opts)
  vim.keymap.set( 'n',       'gA',       vim.lsp.buf.code_action,    opts) -- {apply=true}
  vim.keymap.set( 'n',       'gR',       vim.lsp.buf.rename,         opts)
  vim.keymap.set({'n', 'v'}, 'g=',       vim.lsp.buf.format,         opts)
  vim.keymap.set( 'n',       'gi',       vim.lsp.buf.implementation, opts)
  vim.keymap.set( 'n',       '[<Enter>', vim.diagnostic.goto_prev,   opts)
  vim.keymap.set( 'n',       ']<Enter>', vim.diagnostic.goto_next,   opts)
  -- LSP references, definitions and diagnostics are handled by Telescope
  vim.keymap.set( 'n',       'gr',       telescope.lsp_references,   opts)
  vim.keymap.set( 'n',       'gd',       telescope.lsp_definitions,  opts)
  vim.keymap.set( 'n',       'gD',       telescope.diagnostics,      opts)
  -- source/header switch (should be restricted to clangd)
  vim.keymap.set('n', 'gh', ':ClangdSwitchSourceHeader<CR>', opts)
  -- enable completion triggered by <c-x><c-o> (and nvim-cmp)
  vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'
end

require'lspconfig'.kotlin_language_server.setup{}