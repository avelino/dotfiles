return {
  -- GitHub Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<M-l>",
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        panel = { enabled = false },
      })
    end,
  },

  -- Clojure support
  {
    "Olical/conjure",
    ft = { "clojure" },
    config = function()
      vim.g["conjure#log#botright"] = true
      vim.g["conjure#mapping#doc_word"] = "K"
    end,
  },
  {
    "guns/vim-sexp",
    ft = { "clojure" },
    dependencies = { "tpope/vim-sexp-mappings-for-regular-people" },
  },

  -- Python/Django support
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    config = true,
    event = "VeryLazy",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "python",
          "django",
          "html",
          "css",
          "javascript",
          "typescript",
        })
      end
    end,
  },

  -- Rust support
  {
    "simrat39/rust-tools.nvim",
    ft = { "rust" },
    opts = {
      tools = { inlay_hints = { auto = true } },
      server = { standalone = true },
    },
  },

  -- Nix support
  { "LnL7/vim-nix", ft = { "nix" } },

  -- Fish support
  { "dag/vim-fish", ft = { "fish" } },
}


