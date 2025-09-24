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
              checkOnSave = { command = "clippy" },
            },
          },
        },

        -- Nix
        nil_ls = {
          settings = { ["nil"] = { formatting = { command = { "nixfmt" } } } },
        },

        -- Fish
        bashls = { filetypes = { "sh", "bash", "fish" } },
      },
    },
  },
}


