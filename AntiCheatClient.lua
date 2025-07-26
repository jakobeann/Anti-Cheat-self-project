local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local FlagEvent = RS:WaitForChild("RemoteEvents"):WaitForChild("AntiCheatFlag")

-- GUI check
task.spawn(function()
	while true do
		task.wait(2)
		if not player:FindFirstChild("PlayerGui") then
			FlagEvent:FireServer("UI Tampering")
		end
	end
end)

-- speed and jump check ( can edit if player has gamepass or gear (e.g Gravity Coil, Jetpack gamepass, etc..) )
task.spawn(function()
	while humanoid and humanoid.Parent do
		task.wait(1)
		if humanoid.WalkSpeed > 20 then
			FlagEvent:FireServer("SpeedHack")
		end
		if humanoid.JumpPower > 50 then
			FlagEvent:FireServer("SpeedHack")
		end
	end
end)

-- tool injection check
task.spawn(function()
	while true do
		task.wait(3)
		for _, tool in ipairs(player.Backpack:GetChildren()) do
			if not tool:IsA("Tool") then continue end
			if not tool:FindFirstChild("Handle") then
				FlagEvent:FireServer("ToolInjection")
			end
		end
	end
end)

-- fly detection ( can edit if player has gamepass or gear (e.g Gravity Coil, Jetpack gamepass, etc..) )
local lastY = char:WaitForChild("HumanoidRootPart").Position.Y
task.spawn(function()
	while true do
		task.wait(0.5)
		local currentY = char.HumanoidRootPart.Position.Y
		if (currentY - lastY) > 25 and humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
			FlagEvent:FireServer("FlyHack")
		end
		lastY = currentY
	end
end)
