-- This example was taken from the OS script hub 'AztubHub'
-- Taken from: games/Arsenal/main.lua

local oldNamecall

oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
	SX_VM_CNONE()
	if checkcaller() then
		return oldNamecall(self, ...)
	end

	local method = getnamecallmethod() --> Gets the method used on the object Ex: workspace:Raycast
	local caller = getcallingscript() --> Gets the script the called the method

	if
		method == "FindPartOnRayWithIgnoreList"
		and library.flags.silentAim
		and caller
		and caller.Name == "Client"
		and rayCastSpoofs < 250
	then
		rayCastSpoofs = rayCastSpoofs + 1
		local rootPart = LocalPlayer.Character and LocalPlayer.Character.PrimaryPart
		local character = Utility:getClosestCharacter()

		character = character and character.Character
		local head = character and character.FindFirstChild(character, "Head")

		if character and head then
			return head, (head.Position - rootPart.Position).Unit
		end
	end

	return oldNamecall(self, ...)
end)
