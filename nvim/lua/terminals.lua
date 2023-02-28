local Terminal  = require('toggleterm.terminal').Terminal
local gitui = Terminal:new({ cmd = "gitui", hidden = true })

function _gitui_toggle()
  gitui:toggle(45)
end

vim.api.nvim_set_keymap("n", "<leader>gu", "<cmd>lua _gitui_toggle()<CR>", {noremap = true, silent = true})
