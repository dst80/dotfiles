local M = {}

M.dependencies = {
  "j-hui/fidget.nvim",
  tag = "legacy",
}

M.mason_opts = {
  ensure_installed = {
    "lua-language-server",

    "clangd",
    "neocmakelsp",

    "taplo",
    "rust-analyzer",
    "wgsl-analyzer",

    "gopls",

    "jedi-language-server",

    "typescript-language-server",
    "angular-language-server",
    "vue-language-server",

    "bash-language-server",
  },
}

local utils = require("core.utils")

M.on_attach = function(client, bufnr)
  utils.load_mappings("lspconfig", { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad_ui.signature").setup(client)
  end

  if not utils.load_config().ui.lsp_semantic_tokens then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.on_attach_no_format = function(client, bufnr)
  client.server_capabilities.ducumentHighlightProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
  utils.load_mappings("lspconfig", { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad_ui.signature").setup(client)
  end

  if not utils.load_config().ui.lsp_semantic_tokens then
    client.server_capabilities.semanticTokensProvider = nil
  end
end
M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

function M.format()
  vim.lsp.buf.format({ async = false })
end

function M.rename()
  require("nvchad_ui.renamer").open()
end

function M.config()
  require("plugins.configs.lspconfig")
  local on_attach = M.on_attach

  local capabilities = M.capabilities
  local lspconfig = require("lspconfig")
  local util = require("lspconfig/util")

  local servers = {
    "jedi_language_server",
    "taplo",

    "angularls",
    "volar",

    "neocmake",
    "wgsl_analyzer",
  }

  if string.find(vim.loop.os_uname().sysname, "Windows") == nil then
    servers.bashls = {}
  end

  -- use default configuration of lspconfig
  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end

  -- specialized language server configurations
  lspconfig.lua_ls.setup({
    on_attach = M.on_attach_no_format,
    capabilities = capabilities,

    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
            [vim.fn.stdpath("data") .. "/lazy/extensions/nvchad_types"] = true,
            [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  })

  lspconfig.gopls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gompl" },
    root_dir = util.root_pattern("go_work", "go.mod", ".git"),
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = true,
        analyses = {
          unusedparams = true,
        },
      },
    },
  })

  require("fidget").setup({
    text = {
      spinner = "dots",
      commenced = "",
      compleded = "",
    },
  })

  local lsp_group = vim.api.nvim_create_augroup("LSPGroup", { clear = true })
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    command = [[lua vim.lsp.buf.format({async = false})]],
    group = lsp_group,
  })
end

return M
