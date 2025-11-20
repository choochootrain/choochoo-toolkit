return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      spec = {
        -- Files group
        { "<leader>f", "<cmd>FzfLua files<cr>", desc = "File files", mode = "n" },
        { "<leader>f", group = "Files" },
        { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files", mode = "n" },
        { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent files", mode = "n" },

        -- Git/Diffview group
        { "<leader>g", "<cmd>FzfLua live_grep_native<cr>", desc = "Live grep", mode = "n" },
        { "<leader>g", group = "Git" },
        { "<leader>gg", "<cmd>Gitsigns toggle_signs<cr>", desc = "Toggle git signs", mode = "n" },
        { "<leader>gb", "<cmd>BlameToggle window<cr>", desc = "Toggle blame", mode = "n" },
        { "<leader>gl", "<cmd>LazyGit<cr>", desc = "LazyGit", mode = "n" },
        { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview open", mode = "n" },
        { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "File history", mode = "n" },
        { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Diffview close", mode = "n" },
        { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "Current file history", mode = "n" },

        -- Search/Symbols group
        { "<leader>s", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Document symbols", mode = "n" },
        { "<leader>s", group = "Search/Symbols" },
        { "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Document symbols", mode = "n" },
        { "<leader>sw", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", desc = "Workspace symbols", mode = "n" },
        { "<leader>sf", "<cmd>FzfLua lsp_finder<cr>", desc = "LSP finder", mode = "n" },
        { "<leader>sg", "<cmd>FzfLua grep_cword<cr>", desc = "Grep word under cursor", mode = "n" },
        { "<leader>sl", "<cmd>FzfLua live_grep_native<cr>", desc = "Live grep", mode = "n" },
        { "<leader>sr", "<cmd>FzfLua lsp_references<cr>", desc = "References", mode = "n" },

        -- LSP group
        { "<leader>l", group = "LSP" },
        { "<leader>ld", function() vim.lsp.buf.definition() end, desc = "Go to definition", mode = "n" },
        { "<leader>lD", function() vim.lsp.buf.declaration() end, desc = "Go to declaration", mode = "n" },
        { "<leader>li", function() vim.lsp.buf.implementation() end, desc = "Go to implementation", mode = "n" },
        { "<leader>lr", function() vim.lsp.buf.references() end, desc = "References", mode = "n" },
        { "<leader>lt", function() vim.lsp.buf.type_definition() end, desc = "Type definition", mode = "n" },
        { "<leader>ln", function() vim.lsp.buf.rename() end, desc = "Rename", mode = "n" },
        { "<leader>la", "<cmd>FzfLua lsp_code_actions<cr>", desc = "Code action", mode = "n" },
        { "<leader>lh", function() vim.lsp.buf.hover() end, desc = "Hover", mode = "n" },
        { "<leader>ls", function() vim.lsp.buf.signature_help() end, desc = "Signature help", mode = "n" },
        { "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, desc = "Format", mode = "n" },
        { "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, desc = "Format", mode = "v" },

        -- Diagnostics/Trouble group
        { "<leader>x", "<cmd>Trouble diagnostics toggle<cr>", desc = "Toggle diagnostics", mode = "n" },
        { "<leader>x", group = "Diagnostics" },
        { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Toggle trouble", mode = "n" },
        { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Document diagnostics", mode = "n" },
        { "<leader>xw", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace diagnostics", mode = "n" },
        { "<leader>xf", function() vim.diagnostic.open_float() end, desc = "Float diagnostic", mode = "n" },
        { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list", mode = "n" },
        { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location list", mode = "n" },
        { "<leader>xj", function() vim.diagnostic.goto_next() end, desc = "Next diagnostic", mode = "n" },
        { "<leader>xk", function() vim.diagnostic.goto_prev() end, desc = "Previous diagnostic", mode = "n" },
        { "<leader>xu", "<cmd>LspLinesToggle<cr>", desc = "Toggle LSP lines", mode = "n" },

        -- Buffers group
        { "<leader>b", "<cmd>FzfLua buffers<cr>", desc = "Buffers", mode = "n" },
        { "<leader>b", group = "Buffers" },
        { "<leader>bb", "<cmd>FzfLua buffers<cr>", desc = "Buffer list", mode = "n" },
        { "<leader>bn", "<cmd>bn<cr>", desc = "Next buffer", mode = "n" },
        { "<leader>bp", "<cmd>bp<cr>", desc = "Previous buffer", mode = "n" },
        { "<leader>bd", "<cmd>bd<cr>", desc = "Delete buffer", mode = "n" },

        -- Windows/Tabs group
        { "<leader>w", group = "Windows/Tabs" },
        { "<leader>wn", "<cmd>tabnext<cr>", desc = "Next tab", mode = "n" },
        { "<leader>wp", "<cmd>tabprevious<cr>", desc = "Previous tab", mode = "n" },

        -- Terminal group
        { "<leader>t", "<cmd>FloatermToggle<cr>", desc = "Toggle terminal", mode = "n" },
        { "<leader>t", group = "Terminal" },
        { "<leader>tt", "<cmd>FloatermToggle<cr>", desc = "Toggle terminal", mode = "n" },

        -- Notifications group
        { "<leader>n", "<cmd>Noice pick<cr>", desc = "Noice picker", mode = "n" },
        { "<leader>n", group = "Notifications" },
        { "<leader>nn", "<cmd>Noice pick<cr>", desc = "Noice picker", mode = "n" },
        { "<leader>nd", "<cmd>Noice dismiss<cr>", desc = "Dismiss notifications", mode = "n" },
        { "<leader>nl", "<cmd>Noice last<cr>", desc = "Last notification", mode = "n" },
        { "<leader>nh", "<cmd>Noice history<cr>", desc = "Notification history", mode = "n" },

        -- UI group
        { "<leader>u", group = "UI" },
        { "<leader>uw", "<cmd>set list!<cr>", desc = "Toggle whitespace", mode = "n" },
        { "<leader>um", "<cmd>SignatureToggleSigns<cr>", desc = "Toggle marks", mode = "n" },
        { "<leader>uf", function() FoldColumnToggle() end, desc = "Toggle fold column", mode = "n" },
        { "<leader>uz", "za", desc = "Toggle fold", mode = "n" },

        -- Config group
        { "<leader>c", group = "Config/Code" },
        { "<leader>ce", "<cmd>tabe $MYVIMRC<cr>", desc = "Edit config", mode = "n" },
        { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason", mode = "n" },
        { "<leader>cp", "<cmd>Lazy<cr>", desc = "Lazy plugins", mode = "n" },
      },
    },
    keys = {
      {
        "<space>",
        function()
          require("which-key").show()
        end,
        desc = "Show all keymaps (which-key)",
      },
    },
  },
}
