-- put this in serverscriptservice

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local FlagEvent = RS:WaitForChild("RemoteEvents"):WaitForChild("AntiCheatFlag")

local MAX_TELEPORT = 50 -- studs/sec
local MAX_SPEED = 20
local MAX_JUMP = 50

-- Flag and Kick
local function flagPlayer(player, reason)
	warn("[Anti-Cheat]: "..player.Name.." flagged for: "..reason)
	player:Kick("Cheating Detected: "..reason)
end

-- Validate Remote Reports
FlagEvent.OnServerEvent:Connect(function(player, code)
	if code == "SpeedHack" then
		flagPlayer(player, "Speed Hack")
	elseif code == "UI Tampering" then
		flagPlayer(player, "UI Removed")
	elseif code == "ToolInjection" then
		flagPlayer(player, "Tool Injection")
	elseif code == "FlyHack" then
		flagPlayer(player, "Flying Detected")
	end
end)

-- Movement Validator
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)
		local hrp = char:WaitForChild("HumanoidRootPart")
		local lastPos = hrp.Position

		while char and char.Parent do
			task.wait(1)

			local dist = (hrp.Position - lastPos).Magnitude
			if dist > MAX_TELEPORT then
				flagPlayer(player, "Teleport/NoClip")
			end

			lastPos = hrp.Position
		end
	end)
end)
