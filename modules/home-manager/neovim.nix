{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.neovim = {
    enable = true;
    defaultEditor = false;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      # Language servers
      clojure-lsp
      pyright
      rust-analyzer
      nil # Nix LSP
      nodePackages.bash-language-server

      # Tools
      ripgrep
      fd
      tree-sitter
      nodejs # Required for Copilot

      # Formatters and linters
      black
      ruff
      ruff-lsp
      nixfmt-classic
      rustfmt
    ];
  };

  xdg.configFile = {
    # LazyVim base configuration
    "nvim/init.lua".text = ''
      -- bootstrap lazy.nvim
      local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
      if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
          "git",
          "clone",
          "--filter=blob:none",
          "https://github.com/folke/lazy.nvim.git",
          "--branch=stable",
          lazypath,
        })
      end
      vim.opt.rtp:prepend(lazypath)

      -- setup lazy.nvim
      require("lazy").setup({
        spec = {
          { "LazyVim/LazyVim", import = "lazyvim.plugins" },
          { import = "plugins" },
        },
        defaults = { lazy = true },
        install = { colorscheme = { "tokyonight", "habamax" } },
        checker = { enabled = true },
        performance = {
          rtp = {
            disabled_plugins = {
              "gzip",
              "tarPlugin",
              "tohtml",
              "tutor",
              "zipPlugin",
            },
          },
        },
      })
    '';

    # Plugin configurations
    "nvim/lua/plugins/lang.lua".text = ''
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
            tools = {
              inlay_hints = {
                auto = true,
              },
            },
            server = {
              standalone = true,
            },
          },
        },

        -- Nix support
        {
          "LnL7/vim-nix",
          ft = { "nix" },
        },

        -- Fish support
        {
          "dag/vim-fish",
          ft = { "fish" },
        },
      }
    '';

    # LSP configurations
    "nvim/lua/plugins/lsp.lua".text = ''
      return {
        {
          "neovim/nvim-lspconfig",
          opts = {
            servers = {
              -- Clojure
              clojure_lsp = {},

              -- Python
              pyright = {
                settings = {
                  python = {
                    analysis = {
                      typeCheckingMode = "basic",
                      autoSearchPaths = true,
                      useLibraryCodeForTypes = true,
                      diagnosticMode = "workspace",
                    },
                  },
                },
              },
              ruff_lsp = {},

              -- Rust
              rust_analyzer = {
                settings = {
                  ["rust-analyzer"] = {
                    checkOnSave = {
                      command = "clippy",
                    },
                  },
                },
              },

              -- Nix
              nil_ls = {
                settings = {
                  ["nil"] = {
                    formatting = {
                      command = { "nixfmt" },
                    },
                  },
                },
              },

              -- Fish
              bashls = {
                filetypes = { "sh", "bash", "fish" },
              },
            },
          },
        },
      }
    '';

    # Editor configurations
    "nvim/lua/config/options.lua".text = ''
      vim.opt.expandtab = true
      vim.opt.shiftwidth = 2
      vim.opt.tabstop = 2
      vim.opt.softtabstop = 2
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.wrap = false
      vim.opt.clipboard = "unnamedplus"
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.termguicolors = true
      vim.opt.signcolumn = "yes"
      vim.opt.updatetime = 250
      vim.opt.timeoutlen = 300
      vim.opt.splitright = true
      vim.opt.splitbelow = true
      vim.opt.list = true
      vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
      vim.opt.inccommand = "split"
      vim.opt.cursorline = true
      vim.opt.scrolloff = 10
      vim.opt.mouse = "a"
    '';

    # Keymaps
    "nvim/lua/config/keymaps.lua".text = ''
      local map = vim.keymap.set

      -- Better window navigation
      map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
      map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
      map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
      map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

      -- Resize window using <ctrl> arrow keys
      map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
      map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
      map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
      map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

      -- Move Lines
      map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
      map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
      map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
      map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
      map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
      map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

      -- Clear search with <esc>
      map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

      -- Save file
      map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

      -- Better indenting
      map("v", "<", "<gv")
      map("v", ">", ">gv")
    '';
  };
}
