------------------------------------------
-- steps for having lsp in neovim:
-- install cmp-nvim  
-- instal nvim-lspconfig 
-- install cmp-nvim-lsp
-- instsll lsp like: npm install -g typescript typescript-language-server
-- instead of handy install you can use mason for install LSPs
-- install mason-lspconfig for closeing gaps between mason.nvim and lspconfig
-- you should import by order 1.mason 2. mason-lspconfig 3.setup LSP config
-----------------------------------mason-------------------------------
local settings = {
    ui = {
        border = "none",
        icons = {
            package_installed = "◍",
            package_pending = "◍",
            package_uninstalled = "◍",
        },
    },
	-- log_level Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
    -- debugging issues with package installations.
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4, -- Limit for the maximum amount of packages to be installed at the same time.
}
require("mason").setup(settings)
-------------------------------mason-lspconfig-------------------------------
-- :h mason-lspconfig-settings
local servers = {
    "lua_ls",
    "pyright",
    "jsonls",
}
require("mason-lspconfig").setup({
    ensure_installed = servers,   -- A list of servers to automatically install if they're not already installed
    automatic_installation = true,  -- All servers set up via lspconfig are automatically installed.
})
-----------------------------------lspconfig-------------------------------
-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    return
end

local opts = {}

-- setup LSPs
for _, server in pairs(servers) do
    opts = {
        on_attach = require("user.lsp.handlers").on_attach,  -- my_custom_on_attach in the handlers.lua file
        capabilities = require("user.lsp.handlers").capabilities,
    }

    server = vim.split(server, "@")[1] --Extract server name

    local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
    if require_ok then
        opts = vim.tbl_deep_extend("force", conf_opts, opts)
    end

    lspconfig[server].setup(opts)
end
  
-- lspconfig.tsserver.setup {}