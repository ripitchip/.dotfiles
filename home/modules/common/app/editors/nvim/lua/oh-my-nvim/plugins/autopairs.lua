return {
    "windwp/nvim-autopairs",

  config = function()
    -- Directly set up nvim-autopairs if enabled
    if nvim.autopairs.enable then
      require("nvim-autopairs").setup()
    end
  end
}

