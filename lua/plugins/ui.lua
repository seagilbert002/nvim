return {
    {
        --Treesitter Config
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",

        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = { "make", "javascript", "typescript", "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

                sync_install = false,

                auto_install = true,

                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },

                playground = { enable = true},
            })
        end,
    },

    {
        "nvim-treesitter/playground",
        config = function()
            require("nvim-treesitter.configs").setup({
                playground = {
                    enable = true,
                    disable = {},
                    updatetime = 25,
                    persist_queries = false,
                },
            })
        end,
    },

    --Color Theme
    {
        "rebelot/kanagawa.nvim",
        config = function()
            -- Function to apply color scheme and customize highlights
            function ColorMyPencils(color)
                color = color or "kanagawa"
                vim.cmd.colorscheme(color)

                -- Setting background transparency
                vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
                vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            end

            -- Function to set colors for line numbers above and below the cursor
            function LineNumberColors()
                vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFD700" })

                -- Colors for line numbers above and below the cursor
                vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#FFA500" }) -- North of cursor
                vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#73A11F" }) -- South of cursor
            end

            -- Apply the color scheme and custom highlight on load
            ColorMyPencils()
            LineNumberColors()

            -- Optional global command to reapply colors
            function Color()
                ColorMyPencils()
                LineNumberColors()
            end
        end
    },


    --Lualine config
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {'nvim-tree/nvim-web-devicons'},

        config = function()

            require('lualine').setup({
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = { left = '', right = ''},
                    section_separators = { left = '', right = ''},
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    always_show_tabline = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 100,
                        tabline = 100,
                        winbar = 100,
                    }
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff', 'diagnostics'},
                    lualine_c = {'filename'},
                    lualine_x = {'encoding', 'fileformat', 'filetype'},
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {'filename'},
                    lualine_x = {'location'},
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {}
            })
        end,

    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        config = function()
            require("neo-tree").setup({
                -- Basic configuration for Neo-tree
                window = {
                    position = "left", -- Position the file explorer on the left
                    width = 30,        -- Width of the window
                },
                filesystem = {
                    filtered_items = {
                        visible = true,   -- Set to false to hide filtered items
                    },
                },
                default_component_configs = {
                    container = {
                        enable_character_fade = true,
                    },
                },
            })

            -- Set up keybindings for Neo-tree
            vim.api.nvim_set_keymap("n", "<leader>nt", ":Neotree toggle<CR>", { noremap = true, silent = true })
            vim.api.nvim_set_keymap("n", "<leader>nf", ":Neotree focus<CR>", { noremap = true, silent = true })
        end,
    },

}
