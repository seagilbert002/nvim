return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls", "jdtls", "pyright",
                    "html", "vimls", "ast_grep"
                },
                automatic_installation = true,
            })

            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup({})
                end,
            })
        end,
    },

    -- nvim-cmp setup for autocompletion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",    -- LSP source for nvim-cmp
            "hrsh7th/cmp-buffer",      -- Buffer source for nvim-cmp
            "hrsh7th/cmp-path",        -- Path source for nvim-cmp
            "hrsh7th/cmp-cmdline",     -- Cmdline source for nvim-cmp
            "saadparwaiz1/cmp_luasnip",-- Snippet source for nvim-cmp
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                -- Completion options
                completion = {
                    completeopt = "menu,menuone,noselect",
                },
                -- Snippet configuration
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                -- Key mappings
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                }),
                -- Completion sources
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },   -- LSP-based completions
                    { name = "buffer" },     -- Buffer-based completions
                    { name = "path" },       -- Path completions
                    { name = "luasnip" },    -- Snippet completions
                }),
            })

            -- Cmdline completion
            cmp.setup.cmdline(":", {
                sources = cmp.config.sources({
                    { name = "path" },
                    { name = "cmdline" },
                }),
            })

            -- Cmdline completion for searching files
            cmp.setup.cmdline("/", {
                sources = {
                    { name = "buffer" },
                },
            })
        end,
    },


    {
        "neovim/nvim-lspconfig",
        config = function()
            -- Setup for LSP servers with `nvim-lspconfig`
            require("mason-lspconfig").setup({
                ensure_installed = {"lua_ls", "pyright", "html", "vimls"},
                automatic_installation = true,
            })
        end,
    },
}
