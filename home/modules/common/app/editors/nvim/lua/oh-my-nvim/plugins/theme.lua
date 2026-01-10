return {
	"nyoom-engineering/oxocarbon.nvim",
	{ "catppuccin/nvim", name = "catppuccin" },
	{ "folke/tokyonight.nvim" },
	{
		"joshdick/onedark.vim",
		config = function()
			vim.cmd("colorscheme tokyonight-night")
		end,
	},
}
