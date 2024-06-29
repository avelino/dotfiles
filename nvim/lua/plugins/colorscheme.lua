-- Plugins: Colorschemes
function ColorMyPencils(color)
  color = color or "rose-pine"
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
	-- Use last-used colorscheme
	{
		"rose-pine/neovim",
		lazy = false,
		priority = 99,
		name = "rose-pine",
		opts = {
			variant = "auto",
			dark_variant = "auto",
			extend_background_behind_borders = true,
			disable_background = true,
			enable = {
				terminal = true,
				legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
				migrations = true, -- Handle deprecated options automatically
			},
			styles = {
				transparency = false,
			},
		},
		config = function(_, opts)
			require("rose-pine").setup(opts)
			vim.cmd.colorscheme("rose-pine-main")
			ColorMyPencils()
		end,
	},

	{ 'rafi/neo-hybrid.vim', priority = 100, lazy = false },
	{ 'rafi/awesome-vim-colorschemes', lazy = false },
}
