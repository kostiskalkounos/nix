return {
  { "folke/neodev.nvim", ft = "lua" },
  { "mfussenegger/nvim-jdtls" },
  { "stevearc/conform.nvim" },
  { "towolf/vim-helm", ft = "helm" },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      {
        "neovim/nvim-lspconfig",
        event = "BufReadPost",
        config = function()
          require("config.handlers").setup()
          require("mason").setup()

          local mason_lspconfig = require("mason-lspconfig")

          local capabilities = require("config.handlers").capabilities
          local on_attach = require("config.handlers").on_attach

          local servers = {
            bashls = {},
            clangd = {},
            cssls = {},
            dockerls = {},
            eslint = {},
            gopls = {},
            helm_ls = {},
            html = {},
            jsonls = {},
            lemminx = {},
            lua_ls = {
              Lua = {
                diagnostics = {
                  globals = { "hs", "vim", "jit" },
                },
                telemetry = { enable = false },
                workspace = { checkThirdParty = false },
              },
            },
            pyright = {},
            taplo = {},
            terraformls = {},
            tsserver = {},
            vimls = {},
            yamlls = {},
          }

          mason_lspconfig.setup({
            ensure_installed = vim.tbl_keys(servers),
            automatic_installation = true,
          })

          mason_lspconfig.setup_handlers({
            function(server_name)
              require("lspconfig")[server_name].setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = servers[server_name],
                filetypes = (servers[server_name] or {}).filetypes,
              })
            end,
          })

          require("conform").setup({
            formatters_by_ft = {
              lua = { "stylua" },
              python = { "isort", "black" },
              javascript = { { "prettierd", "prettier" } },
            },
            format_on_save = function()
              if vim.g.disable_autoformat then
                return
              end
              return { timeout_ms = 500, lsp_format = "true", quiet = "true" }
            end,
          })

          vim.api.nvim_create_user_command("FormatToggle", function()
            vim.g.disable_autoformat = not vim.g.disable_autoformat
            print("Setting autoformatting to: " .. tostring(not vim.g.disable_autoformat))
          end, {})
        end,
      },
      {
        "j-hui/fidget.nvim",
        config = function()
          require("fidget").setup({
            text = {
              spinner = "star",
            },
            window = {
              relative = "editor",
            },
          })
        end,
        tag = "legacy",
      },
      {
        "lewis6991/gitsigns.nvim",
        config = function()
          require("gitsigns").setup()
        end,
      },
    },
  },
}
