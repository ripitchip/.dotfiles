return {
    "lervag/vimtex",
    config = function()
        local g = vim.g

        -- Set the PDF viewer to zathura
        g.vimtex_view_method = "zathura"
        -- g.vimtex_view_method = "zathura_simple"  -- Uncomment if you prefer a simpler view

        -- Set the LaTeX engine to xelatex
        g.vimtex_compiler_latexmk_engines = { ["_"] = "-xelatex" }

        -- Configure latexmk with the desired options
        g.vimtex_compiler_latexmk = {
            aux_dir = ".build", -- Output auxiliary files here
            options = {
                "--shell-escape",
                "-verbose",                 -- Show detailed output
                "-file-line-error",         -- Show file and line number for errors
                "-synctex=1",               -- Enable synctex for forward and reverse search
                "-interaction=nonstopmode", -- Continue compilation despite errors
            },
            -- Add custom option to enable shell escape for minted
        }
    end,
}
