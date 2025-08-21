local dap = require("dap")
local ui = require("dapui")

local function map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true })
end

require("overseer").setup()
ui.setup()

map("n", "<leader>db", dap.toggle_breakpoint)
map("n", "<leader>dx", dap.clear_breakpoints)
map("n", "<leader>dc", dap.run_to_cursor)

-- Eval var under cursor
map("n", "<leader>dh", function()
    ---@diagnostic disable-next-line: missing-fields Those fields are defaulted
    require("dapui").eval(nil, { enter = true })
end)

map("n", "<F1>", dap.continue)
map("n", "<F2>", dap.step_over)
map("n", "<F3>", dap.step_into)
map("n", "<F4>", dap.step_out)
map("n", "<F5>", dap.restart)

dap.listeners.before.attach.dapui_config = function()
    ui.open()
end
dap.listeners.before.launch.dapui_config = function()
    ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    ui.close()
end

dap.adapters.codelldb = {
    name = "codelldb",
    type = "server",
    port = "${port}",
    executable = {
        command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
        args = { "--port", "${port}" },
    },
}
