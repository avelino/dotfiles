return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "InsertEnter",
  opts = {
    suggestion = { enabled = true },
    panel = { enabled = true },
    filetypes = {
      ["*"] = true,
    },
  },
}
