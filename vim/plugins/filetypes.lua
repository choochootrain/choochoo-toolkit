return {
  {
    'sheerun/vim-polyglot',
    config = function()
      vim.g.jsx_ext_required = 0
      vim.g.vim_markdown_conceal = 0
    end
  },
  {
    'peitalin/vim-jsx-typescript',
    config = function()
      vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
        pattern = {'*.tsx', '*.jsx'},
        command = 'set filetype=typescriptreact'
      })
    end
  },
}
