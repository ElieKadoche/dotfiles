-- global
-- ------------------------------------------
-- ------------------------------------------

-- Set leader key
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Disable Nerd font
vim.g.have_nerd_font = false

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode
vim.opt.mouse = "a"

-- Show mode
vim.opt.showmode = true

-- Synchronize clipboard between OS
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Use many much levels of undo
vim.opt.undolevels = 1000

-- Case-insensitive searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = "> ", trail = "·", nbsp = "~" }

-- Preview substitutions live
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Maximum column
vim.opt.colorcolumn = "79"

-- Minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 0

-- DISABLED
-- Ask to save file if unsaved changes
-- vim.opt.confirm = true

-- Use spaces instead of tabs
vim.opt.expandtab = true

-- Be smart when using tabs
vim.opt.smarttab = true

-- Auto indent
vim.opt.autoindent = true

-- Smart indent
vim.opt.smartindent = true

-- Number of spaces to use for autoindenting
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- Always show the status line
vim.opt.laststatus = 2

-- Set show matching parenthesis
vim.opt.showmatch = true

-- Indent comments starting with #
vim.opt.cindent = true
vim.opt.cinkeys:remove("0#")

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- custom
-- ------------------------------------------
-- ------------------------------------------

-- Colors
vim.opt.termguicolors = true

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Keep visual mode
vim.keymap.set("v", "<", "<gv", { silent = true })
vim.keymap.set("v", ">", ">gv", { silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Compile tex document
vim.keymap.set("n", "<leader>b", ":TexlabBuild<CR>", { noremap = true, silent = true })

-- Disable arrow keys in normal mode
-- vim.keymap.set("n", "<left>", "<cmd>echo "Use h to move!!"<CR>")
-- vim.keymap.set("n", "<right>", "<cmd>echo "Use l to move!!"<CR>")
-- vim.keymap.set("n", "<up>", "<cmd>echo "Use k to move!!"<CR>")
-- vim.keymap.set("n", "<down>", "<cmd>echo "Use j to move!!"<CR>")

-- Keybinds to make split navigation easier
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Vertical split
vim.keymap.set("n", "<leader>v", ":vsplit<CR>", { silent = true })

-- Change spelllang
vim.opt.spell = false
vim.keymap.set("n", "<leader>sn", ":set nospell<CR>", { silent = true })
vim.keymap.set("n", "<leader>sf", ":set spelllang=fr<CR>:set spell<CR>", { silent = true })
vim.keymap.set("n", "<leader>se", ":set spelllang=en<CR>:set spell<CR>", { silent = true })

-- Move around buffers
vim.keymap.set("n", "<leader>h", ":bp<CR>", { silent = true })
vim.keymap.set("n", "<leader>l", ":bn<CR>", { silent = true })

-- Close file and keep buffer
vim.keymap.set("n", "<leader>x", ":bp<bar>bd #<CR>", { silent = true, noremap = true })

-- Display full errors
vim.keymap.set("n", "<leader><space>", ":lua vim.diagnostic.open_float(0, {scope='line'})<CR>", { silent = true })

-- 1 sentence per line
vim.keymap.set("n", "<leader>p", function()
    vim.cmd([[:.s/\. \+/\.\r/g]])
end, { silent = true })

-- Enable / disable wrap
vim.keymap.set("n", "<leader>w", function()
    vim.opt.wrap = not vim.opt.wrap:get()
    print("wrap: " .. tostring(vim.opt.wrap:get()))
end, { desc = "Toggle wrap" })

-- Trim white spaces at the end of lines
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        vim.cmd([[%s/\s\+$//e]])
    end,
})

-- Install lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
    spec = {
        -- nvim-treesitter
        -- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
        -- ------------------------------------------
        -- ------------------------------------------
        {
            "nvim-treesitter/nvim-treesitter",
            branch = "main",
            lazy = false,
            build = ":TSUpdate",
            config = function()
                -- List of languages
                local languages = {
                    "bash",
                    "bibtex",
                    "c",
                    "cmake",
                    "cpp",
                    "csv",
                    "diff",
                    "git_config",
                    "git_rebase",
                    "gitattributes",
                    "gitcommit",
                    "gitignore",
                    "lua",
                    "make",
                    "markdown",
                    "markdown_inline",
                    "python",
                    "ssh_config",
                    "vim",
                    "vimdoc",
                    "yaml",
                }

                -- Install
                require("nvim-treesitter").install({ languages })

                -- Launch
                vim.api.nvim_create_autocmd("FileType", {
                    pattern = languages,
                    callback = function() vim.treesitter.start() end,
                })
            end,
        },

        -- nvim-tree.lua
        -- ------------------------------------------
        -- ------------------------------------------
        {
            "nvim-tree/nvim-tree.lua",
            version = "*",
            lazy = false,
            config = function()
                -- Parameters
                require("nvim-tree").setup({
                    renderer = {
                        icons = {
                            show = {
                                file = false,
                                folder = false,
                                folder_arrow = false,
                                git = false,
                            },
                        },
                    },
                    filters = {
                        dotfiles = false,
                        git_clean = false,
                        no_buffer = false,
                    },
                    git = {
                        enable = true,
                        ignore = false,
                    },
                })
                vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<cr>")
                vim.api.nvim_create_autocmd("VimEnter", {
                    callback = function()
                        local current_buf = vim.api.nvim_get_current_buf()
                        if vim.fn.argc() == 0 and vim.fn.bufname(current_buf) == "" then
                            vim.cmd("NvimTreeOpen")
                        end
                    end,
                })
            end,
        },

        -- bufferline.nvim
        -- ------------------------------------------
        -- ------------------------------------------
        {
            "akinsho/bufferline.nvim",
            config = function()
                local status_ok, bufferline = pcall(require, "bufferline")
                if not status_ok then
                    return
                end
                bufferline.setup({
                    options = {
                        show_buffer_icons = false,
                        show_close_icon = false,
                        show_buffer_close_icons = false,
                    },
                })
            end,
        },

        -- lualine.nvim
        -- ------------------------------------------
        -- ------------------------------------------
        {
            "nvim-lualine/lualine.nvim",
            config = function()
                require("lualine").setup({
                    options = {
                        theme = "16color",
                    },
                    sections = {
                        lualine_a = { "mode" },
                        lualine_b = { "branch" },
                        lualine_c = { "filename" },
                        lualine_x = { "encoding", "filetype" },
                        lualine_y = { "progress" },
                        lualine_z = { "location" },
                    },
                    inactive_sections = {
                        lualine_a = {},
                        lualine_b = {},
                        lualine_c = { "filename" },
                        lualine_x = { "location" },
                        lualine_y = {},
                        lualine_z = {},
                    },
                })
            end,
        },

        -- fzf-lua
        -- ------------------------------------------
        -- ------------------------------------------
        {
            "ibhagwan/fzf-lua",
            config = function()
                vim.keymap.set("n", "<leader>o", ":FzfLua files<cr>")
            end,
        },

        -- indent-blankline.nvim
        -- ------------------------------------------
        -- ------------------------------------------
        {
            "lukas-reineke/indent-blankline.nvim",
            main = "ibl",
            ---@module "ibl"
            ---@type ibl.config
            opts = {},
        },

        -- oil.nvim
        -- ------------------------------------------
        -- ------------------------------------------
        {
            "stevearc/oil.nvim",
            ---@module "oil"
            ---@type oil.SetupOpts
            lazy = false,
            opts = {
                default_file_explorer = true,
                delete_to_trash = false,
                view_options = { show_hidden = true },
                columns = {
                    "icon",
                    "permissions",
                    "size",
                    "mtime",
                },
            },
        },

        -- nvim-lspconfig
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
        -- ------------------------------------------
        -- ------------------------------------------
        {
            "neovim/nvim-lspconfig",
            config = function()
                local capabilities = require("cmp_nvim_lsp").default_capabilities()

                -- Shared on_attach
                local on_attach = function(client, bufnr)
                    -- Format on save
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ async = false })
                            end,
                        })
                    end
                end

                -- Diagnostic config
                -- See :help vim.diagnostic.Opts
                vim.diagnostic.config {
                    severity_sort = true,
                    float = { border = "rounded", source = "if_many" },
                    underline = { severity = vim.diagnostic.severity.ERROR },
                    signs = vim.g.have_nerd_font and {
                        text = {
                            [vim.diagnostic.severity.ERROR] = "󰅚 ",
                            [vim.diagnostic.severity.WARN] = "󰀪 ",
                            [vim.diagnostic.severity.INFO] = "󰋽 ",
                            [vim.diagnostic.severity.HINT] = "󰌶 ",
                        },
                    } or {},
                    virtual_text = {
                        source = "if_many",
                        spacing = 2,
                        format = function(diagnostic)
                            local diagnostic_message = {
                                [vim.diagnostic.severity.ERROR] = diagnostic.message,
                                [vim.diagnostic.severity.WARN] = diagnostic.message,
                                [vim.diagnostic.severity.INFO] = diagnostic.message,
                                [vim.diagnostic.severity.HINT] = diagnostic.message,
                            }
                            return diagnostic_message[diagnostic.severity]
                        end,
                    },
                }

                -- ltex-ls-plus
                vim.lsp.config("ltex", {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    cmd = { "ltex-ls-plus" },
                    filetypes = {
                        "bib",
                        "context",
                        "gitcommit",
                        "html",
                        "latex",
                        "markdown",
                        "org",
                        "pandoc",
                        "plaintex",
                        "rst",
                        "tex",
                        "text",
                        "typst",
                        "xhtml",
                    },
                    settings = {
                        ltex = {
                            enabled = true,
                            language = { "en-US", "fr" },
                        },
                    },
                })
                vim.lsp.enable("ltex")

                -- lua-language-server
                vim.lsp.config("lua_ls", {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    cmd = { "lua-language-server" },
                    filetypes = { "lua" },
                    settings = {
                        Lua = {
                            completion = { callSnippet = "Replace" },
                            diagnostics = { globals = { "vim" } },
                            format = { enbale = true },
                            workspace = { checkThirdParty = false },
                        },
                    },
                })
                vim.lsp.enable("lua_ls")

                -- python-language-server (+ ruff)
                vim.lsp.config("pylsp", {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    cmd = { "pylsp" },
                    filetypes = { "python" },
                    settings = {
                        pylsp = {
                            plugins = {
                                autopep8 = { enabled = true },
                                flake8 = { enabled = false },
                                jedi_completion = { enabled = true },
                                jedi_definition = { enabled = true },
                                jedi_hover = { enabled = true },
                                jedi_references = { enabled = true },
                                jedi_signature_help = { enabled = true },
                                jedi_symbols = { enabled = true },
                                pycodestyle = {
                                    ignore = { "W391" },
                                    maxLineLength = 79,
                                },
                                pydocstyle = { enabled = true },
                                pyflakes = { enabled = false },
                                pylint = { enabled = false },
                                isort = { enabled = true },
                                ruff = {
                                    enabled = true,
                                    formatEnabled = true,
                                    lineLength = 79,
                                },
                            },
                        },
                    },
                })
                vim.lsp.enable("pylsp")

                -- ruff
                -- vim.lsp.config("ruff", {
                --     capabilities = capabilities,
                --     on_attach = on_attach,
                --     cmd = { "ruff", "server" },
                --     filetypes = { "python" },
                --     settings = {
                --         ruff = {
                --             configuration = { format = { ["quote-style"] = "single" } },
                --             configurationPreference = "filesystemFirst",
                --             lineLength = 79,
                --             organizeImports = true,
                --             showSyntaxErrors = true,
                --             logLevel = "debug",
                --             disableRuleComment = { enable = false },
                --             lint = { enable = false, preview = true, },
                --             format = { preview = true, },
                --         },
                --     },
                -- })
                -- vim.lsp.enable("ruff")

                -- texlab
                vim.lsp.config("texlab", {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    cmd = { "texlab" },
                    filetypes = { "tex", "plaintex", "bib" },
                    settings = {
                        texlab = {
                            build = {
                                args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
                                executable = "latexmk",
                                forwardSearchAfter = true,
                                onSave = false,
                            },
                            chktex = {
                                onEdit = false,
                                onOpenAndSave = true,
                            },
                            diagnosticsDelay = 300,
                            forwardSearch = {
                                executable = "open",
                                args = { "-a", "Skim", "%p" },
                            },
                            bibtexFormatter = "texlab",
                            latexFormatter = "latexindent",
                            latexindent = {
                                modifyLineBreaks = false,
                            },
                        },
                    },
                })
                vim.lsp.enable("texlab")
            end,
        },

        -- cmp
        -- ------------------------------------------
        -- ------------------------------------------
        {
            "hrsh7th/nvim-cmp",
            dependencies = {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline",
                "L3MON4D3/LuaSnip",
                "saadparwaiz1/cmp_luasnip",
            },

            config = function()
                -- See `:help cmp`
                local cmp = require("cmp")
                local luasnip = require("luasnip")
                local fmt = require("luasnip.extras.fmt").fmt
                luasnip.config.setup({})

                -- Custom global snippets
                luasnip.add_snippets("all", {
                    luasnip.snippet("42", {
                        luasnip.insert_node(1),
                        luasnip.text_node(" ------------------------------------------"),
                    }),
                })

                -- Custom python snippets
                luasnip.add_snippets("python", {
                    luasnip.snippet("main", fmt([[if __name__ == "__main__":]], {})),
                    luasnip.snippet(
                        "debug",
                        fmt(
                            [[
import ipdb
ipdb.set_trace(context={})]],
                            { luasnip.insert_node(1) }
                        )
                    ),
                    luasnip.snippet(
                        "log",
                        fmt(
                            [[
from rich.traceback import install
install(show_locals=False, word_wrap=True)
import numpy as np
import torch
np.set_printoptions(precision=3, linewidth=200, suppress=True)
torch.set_printoptions(precision=3, linewidth=200)]],
                            {}
                        )
                    ),
                    luasnip.snippet(
                        "plot",
                        fmt(
                            [[
import matplotlib.pyplot as plt
import numpy as np
def f(x, k): return np.power(x, k)
x = np.linspace(0, 1, 1000)
plt.plot(x, f(x, 2), label="2")
plt.plot(x, f(x, 3), label="3")
plt.legend()
plt.show()]],
                            {}
                        )
                    ),
                })

                -- Main setup
                cmp.setup({
                    snippet = {
                        expand = function(args)
                            luasnip.lsp_expand(args.body)
                        end,
                    },

                    -- Please read `:help ins-completion`
                    mapping = cmp.mapping.preset.insert({
                        ["<S-Space>"] = cmp.mapping.complete({}),
                        ["<Tab>"] = cmp.mapping.confirm({ select = true }),
                        ["<S-Uown>"] = cmp.mapping.select_next_item({}),
                        ["<S-Up>"] = cmp.mapping.select_prev_item(),
                        ["<S-Left>"] = cmp.mapping.scroll_docs(-4),
                        ["<S-Right>"] = cmp.mapping.scroll_docs(4),
                    }),
                    sources = {
                        { name = "nvim_lsp" },
                        { name = "luasnip" },
                        { name = "buffer" },
                        { name = "path" },
                        { name = "nvim_lsp_signature_help" },
                    },
                })
            end,
        },
    },
    -- Disable luarocks and updates check
    rocks = { enabled = false },
    checker = { enabled = false },
})

-- Use vim colorscheme
-- Change colors (use :highlight and :Inspect)
vim.cmd("colorscheme vim")

-- Main
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#3b3b3b" })
vim.api.nvim_set_hl(0, "Comment", { bg = "#000000", fg = "#808080" })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#3b3b3b" })
vim.api.nvim_set_hl(0, "LineNr", { bg = "#000000", fg = "#00ff00" })
vim.api.nvim_set_hl(0, "StatusLine", { bg = "#00ff00", fg = "#000000", bold = true })
vim.api.nvim_set_hl(0, "TabLineFill", { bg = "#000000" })

-- Syntax
vim.api.nvim_set_hl(0, "@function.method.call.python", { bg = "#000000", fg = "#ff1493" })
vim.api.nvim_set_hl(0, "@variable.member.python", { bg = "#000000", fg = "#ff00ff" })
vim.api.nvim_set_hl(0, "@variable.python", { bg = "#000000", fg = "#00ffff" })
vim.api.nvim_set_hl(0, "Constant", { bg = "#000000", fg = "#729fcf" })
vim.api.nvim_set_hl(0, "Special", { bg = "#000000", fg = "#00ff00" })

-- nvim-tree
vim.api.nvim_set_hl(0, "NvimTreeExecFile", { fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NvimTreeFileName", { fg = "#ffffff", bg = "#000000" })
vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = "#ff0000" })
vim.api.nvim_set_hl(0, "NvimTreeModifiedFile", { fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NvimTreeOpenedFile", { fg = "#ffffff", bold = true })
vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = "#ff0000" })
vim.api.nvim_set_hl(0, "NvimTreeSymlink", { fg = "#ffffff", italic = true })
vim.api.nvim_set_hl(0, "NvimTreeWindowPicker", { bg = "#00ff00", fg = "#000000" })

-- bufferline
vim.api.nvim_set_hl(0, "BufferLineBackground", { bg = "#000000" })
vim.api.nvim_set_hl(0, "BufferLineBuffer", { bg = "#000000", fg = "#000000" })
vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { bg = "#000000", fg = "#00ff00" })
vim.api.nvim_set_hl(0, "BufferLineBufferVisible", { bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "BufferLineFill", { bg = "#000000", fg = "#000000" })
vim.api.nvim_set_hl(0, "BufferLineGroupLabel", { bg = "#000000", fg = "#000000" })
vim.api.nvim_set_hl(0, "BufferLineSeparator", { bg = "#000000", fg = "#000000" })
vim.api.nvim_set_hl(0, "BufferLineSeparatorSelected", { bg = "#000000", fg = "#000000" })
vim.api.nvim_set_hl(0, "BufferLineSeparatorVisible", { bg = "#000000", fg = "#000000" })

-- Update modeline
-- vim: ts=4 sts=4 sw=4 et
