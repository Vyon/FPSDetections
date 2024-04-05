--[==[
	
	[init.client.lua]:
		Entry point for the client-side detections script.

	[Author(s)]:
		- Vyon (https://github.com/Vyon/)

-]==]

-- Services:
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Folders:
local NPCs = workspace.NPCs

-- Remotes:
local Shoot = ReplicatedStorage.Remotes.Shoot

-- Locals:
local Player = Players.LocalPlayer

local Camera = workspace.CurrentCamera

-- Initialize "Cheats":
require(script.Aimbot)
require(script.ESP)
require(script.SilentAim)

-- Constants:
local FPS = 60

-- Variables:
local BodyParts = {
	--"Head",
	--"HumanoidRootPart",
	--"Torso",
	--"Left Arm",
	--"Right Arm",
	--"Left Leg",
	--"Right Leg",
}

local Frame = 0
local DetectedAmount = 0

-- Main:
-- Connections:
UserInputService.InputBegan:Connect(function(Input: InputObject, IsProcessedEvent: boolean)
	if Input.UserInputType ~= Enum.UserInputType.MouseButton1 then
		return
	end

	repeat
		local Origin = Camera.CFrame

		local Direction = Origin.LookVector

		for _, NPC: any in NPCs:GetChildren() do
			local Head = NPC.Head

			if _G.SILENT_AIM_TOGGLED then
				Direction = (Head.Position - Origin.Position).Unit
			end

			Shoot:FireServer(Direction)
		end

		task.wait(0.1)
	until not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
end)

RunService.RenderStepped:Connect(function()
	Frame += 1

	if Frame >= FPS then
		warn(`Player '{Player.Name}' had {string.format("%.2f%%", (DetectedAmount / FPS) * 100)} accuracy.`)

		Frame = 0
		DetectedAmount = 0
	end

	local MouseLocation = UserInputService:GetMouseLocation()

	for _, NPC: Model in NPCs:GetChildren() do
		for _, BodyPart in BodyParts do
			local Part = NPC:FindFirstChild(BodyPart)

			if not Part then
				continue
			end

			local Point = Camera:WorldToViewportPoint(Part.Position)

			local Delta = MouseLocation - Vector2.new(Point.X, Point.Y)
			local Distance = Delta.Magnitude

			if math.round(Distance) == 0 and DetectedAmount <= FPS then
				DetectedAmount += 1
			end
		end
	end
end)
