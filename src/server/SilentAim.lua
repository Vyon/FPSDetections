--[==[
	
	[SilentAim.lua]:
		Server-side of the SilentAim detection.

	[Author(s)]:
		- Vyon (https://github.com/Vyon/)

-]==]

-- Services:
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Remotes:
local Shoot = ReplicatedStorage.Remotes.Shoot

-- Connections:
Shoot.OnServerEvent:Connect(function(Player: Player, Direction: Vector3)
	local Character = Player.Character

	if not Character then
		return
	end

	local Origin = Character.Head.CFrame
	local HeadPosition = Origin.Position

	local LookVector = Origin.LookVector

	do --> Check for Silent Aim
		local Delta = LookVector - Direction

		-- BUG: Currently the
		if math.abs(Delta.X) > 0.6 or math.abs(Delta.Z) > 0.8 then
			warn("This player is cheating.")
			return
		end
	end

	local Params = RaycastParams.new()
	Params.FilterDescendantsInstances = { Character }
	Params.FilterType = Enum.RaycastFilterType.Exclude

	local Result = workspace:Raycast(HeadPosition, Direction * 100, Params)
	local EndPosition = (CFrame.new(HeadPosition) * CFrame.new(Direction * 100)).Position

	if Result then
		EndPosition = Result.Position
	end

	local Distance = (HeadPosition - EndPosition).Magnitude
	local Size = Vector3.new(0.1, 0.1, Distance)

	local Part = Instance.new("Part")
	Part.Name = "ShotVisual"
	Part.Transparency = 0.5
	Part.Color = Color3.new(1, 0, 0)
	Part.CanCollide = false
	Part.CanQuery = false
	Part.CastShadow = false
	Part.Anchored = true
	Part.Size = Size
	Part.CFrame = CFrame.lookAt(HeadPosition, EndPosition) * CFrame.new(0, 0, -Distance / 2)
	Part.Parent = workspace

	Debris:AddItem(Part, 3)
end)

return {}
