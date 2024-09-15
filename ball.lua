-- Notification for loading
game.StarterGui:SetCore("SendNotification", {
	Title = "Sebastian's Character Ball";
	Text = "Loading.";
	Duration = 5; -- Duration should be a number
})

-- Wait for the character
local Character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local Stepped = game:GetService("RunService").Heartbeat
local IsR6 = Humanoid.RigType == Enum.HumanoidRigType.R6

-- Handle R6 and R15 rig type
local Ball = IsR6 and Character:WaitForChild("Torso") or Character:WaitForChild("UpperTorso")

-- R6/R15 detection notifications
if IsR6 then
	game.StarterGui:SetCore("SendNotification", {
		Title = "Info📃";
		Text = "R6 Detected.";
		Duration = 5;
	})
else
	game.StarterGui:SetCore("SendNotification", {
		Title = "WARNING⚠";
		Text = "R15 Detected! May be Unstable.";
		Duration = 5;
	})
end

-- Load the UI library (local vs server)
local Library
if game:GetService("RunService"):IsStudio() then
	Library = require(script:WaitForChild("ModuleScript"))
else
	Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
end

-- Create the main UI window
local Window = Library.CreateLib("Sebastian's Character Ball", "DarkTheme")

-- Home tab
local Home = Window:NewTab("Home")
local HomeSection = Home:NewSection("Home")
HomeSection:NewLabel("Welcome, " .. game.Players.LocalPlayer.DisplayName)

-- Functions tab
local Functions = Window:NewTab("Functions")
local CharacterSection = Functions:NewSection("Player")
local BallFunctions = Functions:NewSection("Ball")

-- Ball toggle setup
local EnabledBall = false
local ToggleBall = BallFunctions:NewToggle("Enabled Ball", "Summons the ball and welds it to you.", function(Value)
	EnabledBall = Value
	if EnabledBall then
		Ball.Size = Vector3.new(5, 5, 5)
		Ball.Transparency = 0.6
		Character:WaitForChild("HumanoidRootPart").Transparency = 0
		Ball.Shape = Enum.PartType.Ball
		Ball.Massless = true
		for _,Player in pairs(game.Players:GetPlayers()) do
			if Player ~= game.Players.LocalPlayer then
				for i,v in pairs(Player.Character:GetDescendants()) do
					if v:IsA("MeshPart") or v:IsA("Part") then
						v.CanCollide = true
					end
				end
			end
		end
	else
		Ball.Size = Vector3.new(2, 2, 1)
		Ball.Shape = Enum.PartType.Block
		Ball.Transparency = 0
		Character:WaitForChild("HumanoidRootPart").Transparency = 1
		for _,Player in pairs(game.Players:GetPlayers()) do
			if Player ~= game.Players.LocalPlayer then
				for i,v in pairs(Player.Character:GetDescendants()) do
					if v:IsA("MeshPart") or v:IsA("Part") then
						v.CanCollide = false
					end
				end
			end
		end
	end
end)

-- Stepped connection to handle movement and ball physics
Stepped:Connect(function()
	if EnabledBall then
		Humanoid.Sit = true
		Ball.Velocity = Ball.Velocity + Humanoid.MoveDirection -- Adjust the speed factor
		if IsR6 then
			Character.Head.CanCollide = false
		else
			Character.LowerTorso.CanCollide = false
		end
	else
		Humanoid.Sit = false
	end
end)
