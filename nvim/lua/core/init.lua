local global = require("core.global")

local load_core = function()
	require("core.options")
	require("core.pack")
	require("mapping")
	require("settings")
end

load_core()
