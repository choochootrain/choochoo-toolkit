return {
  'ervandew/supertab',

  -- TODO
  -- {
  --   'hrsh7th/nvim-cmp',
  --   event = 'InsertEnter',            -- lazy-load when you enter Insert mode
  --   dependencies = {
  --     'hrsh7th/cmp-nvim-lsp',         -- LSP completions
  --     'L3MON4D3/LuaSnip',             -- snippet engine
  --     'saadparwaiz1/cmp_luasnip',     -- cmp <-> luasnip bridge
  --     'rafamadriz/friendly-snippets', -- (optional) huge set of community snippets
  --   },
  --   config = function()
  --     local cmp = require('cmp')
  --     local luasnip = require('luasnip')

  --     luasnip.config.setup({ history = true, updateevents = 'TextChanged,TextChangedI' })

  --     cmp.setup({
  --       completion = { completeopt = 'menu,menuone,noinsert' },
  --       snippet = {
  --         expand = function(args) luasnip.lsp_expand(args.body) end,
  --       },
  --       mapping = cmp.mapping.preset.insert({
  --         ['<CR>']     = cmp.mapping.confirm({ select = true }),  -- ⏎ to accept
  --         ['<C-Space>']= cmp.mapping.complete(),                  -- trigger menu
  --         ['<Tab>']    = cmp.mapping(function(fallback)
  --           if cmp.visible() then cmp.select_next_item()
  --           elseif luasnip.jumpable(1) then luasnip.jump(1)
  --           else fallback() end
  --         end, { 'i', 's' }),
  --         ['<S-Tab>']  = cmp.mapping(function(fallback)
  --           if cmp.visible() then cmp.select_prev_item()
  --           elseif luasnip.jumpable(-1) then luasnip.jump(-1)
  --           else fallback() end
  --         end, { 'i', 's' }),
  --       }),
  --       sources = {
  --         { name = 'nvim_lsp' },
  --         { name = 'luasnip'  },
  --         -- add { name = 'buffer' } or others later if you like
  --       },
  --     })
  --   end,
  -- },
}
