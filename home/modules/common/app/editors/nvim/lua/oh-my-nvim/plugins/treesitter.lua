return {

	--Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
		ensure_installed = { "vimdoc", "javascript", "typescript", "c", "lua", "rust" },
		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = false,
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
	},
	"nvim-treesitter/playground",
	"nvim-treesitter/nvim-treesitter-context",
}
