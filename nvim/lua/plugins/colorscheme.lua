return {
  "rose-pine/neovim",
  name = "rose-pine",
  opts =  {
    dark_variant = "dawn",
    extend_background_behind_borders = true,
    enable = {
      terminal = true,
      legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
      migrations = true, -- Handle deprecated options automatically
    },
  },
  config = function(_, opts)
    require("rose-pine").setup(opts)
    vim.cmd.colorscheme("rose-pine-dawn")
  end
}
