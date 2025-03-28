local dap = require 'dap'
local dapui = require 'dapui'

-- Configure the LLDB adapter
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode', -- Adjust path if needed
  name = 'lldb',
}

-- Define a configuration for Rust
dap.configurations.rust = {
  {
    name = 'Debug Rust executable',
    type = 'lldb',
    request = 'launch',
    program = function()
      -- Prompt for the executable path relative to your project directory.
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}

-- dapui.setup({
--   -- You can tweak UI settings here (layouts, icons, etc.)
-- })

-- Optionally, set keymaps to open/close the UI
vim.keymap.set('n', '<F5>', function()
  require('dap').continue()
end)
vim.keymap.set('n', '<F10>', function()
  require('dap').step_over()
end)
vim.keymap.set('n', '<F11>', function()
  require('dap').step_into()
end)
vim.keymap.set('n', '<F12>', function()
  require('dap').step_out()
end)
vim.keymap.set('n', '<leader>du', function()
  dapui.toggle()
end)

return {
  -- Debug Adapter Protocol for Neovim
  { 'mfussenegger/nvim-dap' },
  -- Optional UI for nvim-dap (provides a sidebar, breakpoints list, etc.)
  { 'rcarriga/nvim-dap-ui', dependencies = { 'mfussenegger/nvim-dap' } },
  -- Optional: Virtual text support for inline variable values
  { 'theHamsta/nvim-dap-virtual-text' },
  -- ... any other plugins you might be using
}
