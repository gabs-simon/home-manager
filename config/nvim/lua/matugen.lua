 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#1e1e2e',
    base01 = '#313244',
    base02 = '#3a3b50',
    base03 = '#6c7086',
    base04 = '#a6adc8',
    base05 = '#cdd6f4',
    base06 = '#cdd6f4',
    base07 = '#cdd6f4',
    base08 = '#f38ba8',
    base09 = '#89dceb',
    base0A = '#89b4fa',
    base0B = '#74c7ec',
    base0C = '#92dfed',
    base0D = '#8fd2f0',
    base0E = '#85b1fa',
    base0F = '#c8043a',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#cdd6f4',          bg = '#1e1e2e' })
  hi('TelescopeBorder',         { fg = '#6c7086',             bg = '#1e1e2e' })
  hi('TelescopePromptNormal',   { fg = '#cdd6f4',          bg = '#1e1e2e' })
  hi('TelescopePromptBorder',   { fg = '#6c7086',             bg = '#1e1e2e' })
  hi('TelescopePromptPrefix',   { fg = '#74c7ec',             bg = '#1e1e2e' })
  hi('TelescopePromptCounter',  { fg = '#a6adc8',  bg = '#1e1e2e' })
  hi('TelescopePromptTitle',    { fg = '#1e1e2e',             bg = '#74c7ec' })
  hi('TelescopePreviewTitle',   { fg = '#1e1e2e',             bg = '#89b4fa' })
  hi('TelescopeResultsTitle',   { fg = '#1e1e2e',             bg = '#89dceb' })
  hi('TelescopeSelection',      { fg = '#cdd6f4',          bg = '#3a3b50' })
  hi('TelescopeSelectionCaret', { fg = '#74c7ec',             bg = '#3a3b50' })
  hi('TelescopeMatching',       { fg = '#74c7ec',             bold = true })
end

 -- Register a signal handler for SIGUSR1 (matugen updates)
 local signal = vim.uv.new_signal()
 signal:start(
   'sigusr1',
   vim.schedule_wrap(function()
     package.loaded['matugen'] = nil
     require('matugen').setup()
   end)
 )

 return M
