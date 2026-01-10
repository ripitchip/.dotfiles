return {
	"junegunn/fzf.vim",
	"salkin-mada/openscad.nvim",
	dependencies = {
		"L3MON4D3/LuaSnip",
	},
	config = function()
		require("openscad")

		-- Load snippets (requires additional setup for LuaSnip)
		vim.g.openscad_load_snippets = true

		-- Set other options
		vim.g.openscad_fuzzy_finder = "skim"
		vim.g.openscad_cheatsheet_window_blend = 15 -- % transparency
		vim.g.openscad_auto_open = false

		-- Enable default mappings
		vim.g.openscad_default_mappings = true

		-- Custom mappings with Ctrl instead of Alt
		vim.g.openscad_cheatsheet_toggle_key = "<Enter>"
		vim.g.openscad_help_trig_key = "<C-h>"
		vim.g.openscad_help_manual_trig_key = "<C-m>"
		vim.g.openscad_exec_openscad_trig_key = "<C-o>"
		vim.g.openscad_top_toggle = "<C-c>"
	end,
}
