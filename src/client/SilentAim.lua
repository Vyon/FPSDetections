--[==[
	
	[SilentAim.lua]:
		Used to toggle whether the silent aim will be used or not.

	[Author(s)]:
		- Vyon (https://github.com/Vyon/)

-]==]

-- Services:
local UserInputService = game:GetService("UserInputService")

-- Connections:
UserInputService.InputBegan:Connect(function(Input: InputObject, IsProcessedEvent: boolean)
	if Input.KeyCode ~= Enum.KeyCode.K then
		return
	end

	_G.SILENT_AIM_TOGGLED = not _G.SILENT_AIM_TOGGLED
end)

return {}
