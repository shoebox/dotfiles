local vim = vim

return {
	{
		"L3MON4D3/LuaSnip",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
		event = "VeryLazy",
		tag = "v2.3.0",
		run = "make install_jsregexp",
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason.nvim",
			"lsp_signature.nvim",
		},
		event = "BufReadPre",
		config = function()
			local cmp_lsp = require("cmp_nvim_lsp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities()
			)
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"gopls",
					"lua_ls",
				},
				handlers = {
					function(server_name) -- default handler (optional)
						local server = require("lspconfig")[server_name]
						server.setup({
							capabilities = capabilities,
							on_attach = function(client, bufnr)
								require("lsp_signature").on_attach(require("lsp_signature"), bufnr)
							end,
						})
					end,
				},
			})

			vim.diagnostic.config({
				update_in_insert = false,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			})
		end,
		init = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf }

					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

					-- formatting
					vim.keymap.set("n", "<leader>f", function()
						vim.lsp.buf.format({ async = true })
					end, opts)

					-- code actions
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

					-- workspace
					vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set("n", "<space>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)

					-- diagnostics
					vim.keymap.set("n", "<leader>dl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
					vim.keymap.set("n", "<leader>dn", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
					vim.keymap.set("n", "<leader>dp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
					vim.keymap.set("n", "<leader>dh", "<cmd>lua vim.diagnostic.hide()<CR>", opts)
					vim.keymap.set("n", "<leader>ds", "<cmd>lua vim.diagnostic.show()<CR>", opts)
				end,
			})
		end,
	},
}
