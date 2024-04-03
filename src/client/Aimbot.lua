--[==[
	
	[Aimbot.lua]:
		Live example of how an Aimbot script might work.

	[Author(s)]:
		- Vyon (https://github.com/Vyon/)

-]==]

-- Services:
local ContextActionService = game:GetService("ContextActionService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Folders:
local NPCs = workspace.NPCs

-- Locals:
local Camera = workspace.CurrentCamera

-- Variables:
local IsMB2Down = false
local CurrentTarget: Model?
local TargetDistance = math.huge

ContextActionService:BindAction("Aimbot", function(_: string, State: Enum.UserInputState)
	IsMB2Down = State == Enum.UserInputState.Begin

	if not IsMB2Down then
		return
	end

	local Connection
	Connection = RunService.RenderStepped:Connect(function()
		if not IsMB2Down then
			Connection:Disconnect()
			Connection = nil
			return
		end

		local MouseLocation = UserInputService:GetMouseLocation()

		for _, NPC: Model in NPCs:GetChildren() do
			local Point, OnScreen = Camera:WorldToViewportPoint(NPC:GetPivot().Position)

			if not OnScreen then
				continue
			end

			local Delta = MouseLocation - Vector2.new(Point.X, Point.Y)
			local Distance = Delta.Magnitude

			if Distance > 50 then
				continue
			end

			if CurrentTarget ~= NPC and Distance > TargetDistance then
				continue
			end

			CurrentTarget = NPC
			TargetDistance = Distance
		end

		if not CurrentTarget then
			return
		end

		Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, (CurrentTarget :: any).Torso.Position)
	end)
end, false, Enum.UserInputType.MouseButton2)

return {}
