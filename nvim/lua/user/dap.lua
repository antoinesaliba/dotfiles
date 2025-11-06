local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end

local dapui_status_ok, dapui = pcall(require, "dapui")
if not dapui_status_ok then
  return
end

local dap_go_status_ok, dap_go = pcall(require, "dap-go")
if not dap_go_status_ok then
  return
end

-- Setup dapui
dapui.setup()

-- Setup dap-go
dap_go.setup()

-- Auto open/close dapui
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end