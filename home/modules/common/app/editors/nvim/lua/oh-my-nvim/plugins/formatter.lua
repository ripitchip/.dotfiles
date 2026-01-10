return {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {

				python = { "black", "ruff" },
				rust = { "rustfmt" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				csharp = { "csharpier" },
				sql = { "sql-formatter" },

				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				vue = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },

				json = { "prettier" },
				yaml = { "prettier" },

				markdown = { "prettier" },
				md = { "prettier" },
				graphql = { "prettier" },
				lua = { "stylua" },
				java = { "google-java-format" },
				proto = { "buf" },
				kotlin = { "ktfmt" },
				go = { "gofumpt" },
				toml = { "taplo" },
				dart = { "dart_format" },
				xml = { "xmlformatter" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
