--[==[
	
	[ESP.lua]:
		Live example of how an ESP script might work.

	[Author(s)]:
		- Vyon (https://github.com/Vyon/)

-]==]

-- Services:
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules:
local Drawing = require(ReplicatedStorage.Shared.Drawing)

-- Folders:
local NPCs = workspace.NPCs

-- Locals:
local Player = Players.LocalPlayer

-- Main:
if not Player.Character then
	Player.CharacterAdded:Wait() --> If the player is able to fully load so can the NPCs
end

-- Connections:
RunService.RenderStepped:Connect(function()
	for _, NPC: Model in NPCs:GetChildren() do
		Drawing.AttachBoxTo(NPC)
	end
end)

return {}
