return {
	-- LSP
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"VonHeikemen/lsp-zero.nvim",
		"folke/neodev.nvim",
		"b0o/schemastore.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		vim.lsp.set_log_level("debug")
		local on_attach = function(_, bufnr)
			local bufmap = function(keys, func)
				vim.keymap.set("n", keys, func, { buffer = bufnr })
			end

			bufmap("<leader>r", vim.lsp.buf.rename)
			bufmap("<leader>w", vim.lsp.buf.code_action)

			bufmap("gd", vim.lsp.buf.definition)
			bufmap("gD", vim.lsp.buf.declaration)
			bufmap("gI", vim.lsp.buf.implementation)
			bufmap("<leader>D", vim.lsp.buf.type_definition)

			bufmap("gr", require("telescope.builtin").lsp_references)
			bufmap("<leader>s", require("telescope.builtin").lsp_document_symbols)
			bufmap("<leader>S", require("telescope.builtin").lsp_dynamic_workspace_symbols)

			bufmap("K", vim.lsp.buf.hover)

			vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
				vim.lsp.buf.format()
			end, {})
		end

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		require("neodev").setup()
		lspconfig.lua_ls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			root_dir = function()
				return vim.loop.cwd()
			end,
			cmd = { "lua-language-server" },
			settings = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			},
		})
		lspconfig.rust_analyzer.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			-- root_dir = util.root_pattern("Cargo.toml"),
			settings = {
				["rust-analyzer"] = {
					cargo = {
						allFeatures = true,
					},
				},
			},
		})
		lspconfig.ruff.setup({
			on_attach = on_attach,
		})
		lspconfig.pyright.setup({
			on_attach = on_attach,
			filetypes = { "python" },
			capabilities = (function()
				local _capabilities = vim.lsp.protocol.make_client_capabilities()
				_capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
				return _capabilities
			end)(),
			settings = {
				python = {
					analysis = {
						typeCheckingMode = "off",
					},
				},
			},
		})
		-- lspconfig.jedi_language_server.setup({})
		lspconfig.nil_ls.setup({
			on_attach = on_attach,
		})
		lspconfig.dockerls.setup({
			settings = {
				docker = {
					languageserver = {
						formatter = {},
					},
				},
			},
		})
		lspconfig.docker_compose_language_service.setup({})
		lspconfig.ts_ls.setup({})
		lspconfig.mdx_analyzer.setup({})
		lspconfig.marksman.setup({})
		lspconfig.texlab.setup({})
		lspconfig.dartls.setup({})
		lspconfig.ccls.setup({})
		lspconfig.lemminx.setup({})
		lspconfig.yamlls.setup({
			settings = {
				yaml = {
					schemaStore = {
						enable = false,
						url = "",
					},
					schemas = require("schemastore").yaml.schemas(),
				},
			},
		})
		lspconfig.jsonls.setup({
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		})
	end,
	-- LSP Support
}
