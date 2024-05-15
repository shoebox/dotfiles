return {
	{
		"nvimtools/none-ls.nvim",
		event = "VimEnter",
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.completion.spell,

					-- code actions
					null_ls.builtins.code_actions.impl,
					null_ls.builtins.code_actions.refactoring,
					null_ls.builtins.code_actions.statix,

					-- diagnostics
					null_ls.builtins.diagnostics.ansiblelint,
					null_ls.builtins.diagnostics.commitlint,
					null_ls.builtins.diagnostics.deadnix,
					null_ls.builtins.diagnostics.golangci_lint,
					null_ls.builtins.diagnostics.hadolint,
					null_ls.builtins.diagnostics.sqlfluff.with({
						extra_args = { "--dialect", "postgres" }, -- change to your dialects
					}),
					null_ls.builtins.diagnostics.statix,
					null_ls.builtins.diagnostics.vale,
					null_ls.builtins.diagnostics.yamllint,
					null_ls.builtins.diagnostics.zsh,

					-- Formatting
					-- Formatting/nix
					null_ls.builtins.formatting.alejandra,
					null_ls.builtins.formatting.nixfmt,
					null_ls.builtins.formatting.nixpkgs_fmt,
					-- Formatting/golang
					null_ls.builtins.formatting.gofmt,
					null_ls.builtins.formatting.gofumpt,
					null_ls.builtins.formatting.goimports,
					null_ls.builtins.formatting.goimports_reviser,
					null_ls.builtins.formatting.golines,
					-- Formatting/lua
					null_ls.builtins.formatting.prettierd,
					null_ls.builtins.formatting.stylua,
					-- Formatting/sql
					null_ls.builtins.formatting.sqlfluff.with({
						extra_args = { "--dialect", "postgres" }, -- change to your dialects
					}),
					null_ls.builtins.formatting.pg_format,
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd({ "BufWritePre", "InsertLeave" }, {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ async = false })
							end,
						})
					end
				end,
			})
		end,
	},
}
