local lsp = {}

local p = require("packer")

function lsp.packer()
    -- p.use({ "pearofducks/ansible-vim" })
    p.use({ "mfussenegger/nvim-ansible" })

    -- p.use({
    --     "folke/neodev.nvim",
    --     config = function()
    --         require("neodev").setup({})
    --     end,
    -- })

	p.use({
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup({
				auto_close_after = 200,
				bind = true,
				close_timeout = 200,
				doc_lines = 20,
				noice = true,
				transparency = 10,
				wrap = true,
			})
		end,
	})

	p.use({ "nvim-lua/lsp-status.nvim" })

	p.use({
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		config = function()
            local servers = {
                -- "ansiblels",
                "bashls",
                "cucumber_language_server",
                "gopls",
                "rnix",
                "terraform_lsp",
                "terraformls",
                "tsserver",
                "yamlls",
            }

            local lspcfg = require("lspconfig")
            local sign = require("lsp_signature")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            for _, def in pairs(servers) do
                local cfg = lspcfg[def]
                cfg.setup({
                    capabilities = capabilities,
                })

                sign.setup(cfg)
            end
	    end,
		requires = {
			"hrsh7th/cmp-nvim-lsp",
		},
		after = {
			"lsp_signature.nvim",
		},
	})

	p.use({
		"mfussenegger/nvim-lint",
		config = function()
            local lint = require('lint')
            local configFile = vim.fn.getcwd().."/.golangci.yml"

            lint.linters.golangcilint.args = {
                'run',
                '--out-format',
                'json',
                '--config',
                configFile,
                function()
                    return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
                end
            }

            lint.linters_by_ft = {
                asciidoc = { "vale" },
                dockerfile = { "hadolint" },
                markdown = { "vale" },
                go = { "golangcilint" },
                lua = { "luacheck" },
                nix = { "nix" },
                sh = { "shellcheck" },
                yaml = { "yamllint" },
                ["yaml.ansible"] = { "ansible_lint", "yamllint" },
            }

            -- local golangcilint = require('lint').linters.golangcilint
            -- golangcilint.args = {
            --     'run',
            --     '--out-format',
            --     'json',
            --     '--config',
            --     vim.loop.cwd() .. "/.golangci.yml",
            --     function()
            --         return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
            --     end
            -- }
	    end,
	})

	p.use({
		"hrsh7th/nvim-cmp",
		config = function()
            local cmp = require("cmp")
            local sources = {
                { name = "nvim_lsp" },
                { name = "treesitter", keyword_length = 2 },
                { name = "look", keyword_length = 2 },
                { name = "path" },
            }
            cmp.setup({
                completion = {
                    autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
                    completeopt = "menu,menuone,noselect",
                },
                formatting = {
                    format = function(entry, vim_item)
                        vim_item.menu = ({
                            buffer = " ﬘",
                            nvim_lsp = " ",
                            luasnip = " 🐍",
                            treesitter = " ",
                            nvim_lua = " ",
                            spell = " 暈",
                            emoji = "ﲃ",
                            copilot = "🤖",
                            look = "﬜",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
                mapping = {
                    ["<up>"] = cmp.mapping.select_prev_item(),
                    ["<down>"] = cmp.mapping.select_next_item(),
                    ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                sources = sources,
            })
	    end,
		requires = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
		},
	})
end
return lsp
