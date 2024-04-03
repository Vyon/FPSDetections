--[==[
	
	[Drawing.lua]:
		Very simple Drawing library using what is available through the Roblox API

	[Author(s)]:
		- Vyon (https://github.com/Vyon/)

-]==]

-- Main Module:
local Drawing = {}

function Drawing.AttachBoxTo(Object: Model | BasePart)
	local _, Size

	if Object:IsA("Model") then
		_, Size = Object:GetBoundingBox()
	else
		_, Size = Object.CFrame, Object.Size
	end

	local BillboardGui = Object:FindFirstChild("Drawing")

	if not BillboardGui then
		BillboardGui = Instance.new("BillboardGui")
		BillboardGui.Name = "Drawing"
		BillboardGui.Active = true
		BillboardGui.AlwaysOnTop = true
		BillboardGui.ClipsDescendants = true
		BillboardGui.Size = UDim2.fromScale(Size.X, Size.Y)
		BillboardGui.ResetOnSpawn = false
		BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		BillboardGui.Parent = Object
	end

	if BillboardGui:GetAttribute("Box") then
		return
	end

	BillboardGui:SetAttribute("Box", true)

	local Line1 = Instance.new("Frame")
	Line1.Name = "Line1"
	Line1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Line1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Line1.BorderSizePixel = 0
	Line1.Size = UDim2.new(1, 0, 0, 1)
	Line1.Parent = BillboardGui

	local Line2 = Instance.new("Frame")
	Line2.Name = "Line2"
	Line2.AnchorPoint = Vector2.new(0, 1)
	Line2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Line2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Line2.BorderSizePixel = 0
	Line2.Position = UDim2.fromScale(0, 1)
	Line2.Size = UDim2.new(1, 0, 0, 1)
	Line2.Parent = BillboardGui

	local Line3 = Instance.new("Frame")
	Line3.Name = "Line3"
	Line3.AnchorPoint = Vector2.new(0, 1)
	Line3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Line3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Line3.BorderSizePixel = 0
	Line3.Position = UDim2.fromScale(0, 1)
	Line3.Size = UDim2.new(0, 1, 1, 0)
	Line3.Parent = BillboardGui

	local Line4 = Instance.new("Frame")
	Line4.Name = "Line4"
	Line4.AnchorPoint = Vector2.new(1, 0)
	Line4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Line4.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Line4.BorderSizePixel = 0
	Line4.Position = UDim2.fromScale(1, 0)
	Line4.Size = UDim2.new(0, 1, 1, 0)
	Line4.Parent = BillboardGui
end

return Drawing
