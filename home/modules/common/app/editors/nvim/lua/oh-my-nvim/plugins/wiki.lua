return {
	{
		"vimwiki/vimwiki",
		init = function()
			vim.g.vimwiki_list = {
				{
					path = "~/documents/4_wiki/",
					template_path = "~/documents/4_wiki/templates/",
					syntax = "markdown",
					ext = ".md",
					links_space_char = "-",
					custom_wiki2html = "vimwiki_markdown",
					path_html = "~/documents/4_wiki/html/",
					html_filename_parameterization = 1,
					template_ext = ".tpl",
				},
			}
			vim.g.vimwiki_ext2syntax = { [".md"] = "markdown", [".markdown"] = "markdown", [".mdown"] = "markdown" }
			vim.g.vimwiki_use_mouse = 1
			vim.g.vimwiki_markdown_link_ext = 1
		end,
	},
}
