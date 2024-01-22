
local npairs = require("nvim-autopairs")
npairs.setup({
    -- check_ts = true,
    -- ts_config = {
        --   lua = { "string", "source" },
        --   javascript = { "string", "template_string" },
        --   java = false,
        -- },
    disable_filetype = { "TelescopePrompt", "spectre_panel" },
    -- put a single prantes and press alt+e then 
    --   it ask you where you want to put next parantes for closing
    fast_wrap = {
      map = '<M-e>', -- alt +e in insert mode
      chars = { '{', '[', '(', '"', "'" }, -- fast_wrap works with this signs
      pattern = [=[[%'%"%>%]%)%}%,]]=],
      end_key = '$',
      before_key = 'h',
      after_key = 'l',
      cursor_pos_before = true,
      keys = 'qwertyuiopzxcvbnmasdfghjkl', -- keys show up for fast_wrap
      manual_position = true,
      highlight = 'Search',
      highlight_grey='Comment'
    },
})

-- If you want insert `(` after select function or method item
-- in default lsp of python if you select print lsp dont put () but with this config it will
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)