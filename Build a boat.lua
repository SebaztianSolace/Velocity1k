local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
	Title = "SebastianHub | V0.1.0 | Build a Boat",
	SubTitle = "by _.sebastiansolace._",
	TabWidth = 120,
	Size = UDim2.fromOffset(460, 360),
	Acrylic = false,
	Theme = "Amethyst",
	MinimizeKey = Enum.KeyCode.RightControl
})

local Tabs = {
	Home = Window:AddTab({ Title = "Home", Icon = "home" }),
	Main = Window:AddTab({ Title = "Scripts", Icon = "file-code" }),
	Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options
local at = false
local tweenSpeed = 35 -- Default speed

do
	Fluent:Notify({
		Title = "ArcticX",
		Content = "Thank you for using our hub!",
		SubContent = " ",
		Duration = 5
	})

	Tabs.Home:AddButton({
		Title = "Reset",
		Description = "Kills Your character",
		Callback = function()
			game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health = -5
		end
	})

	Tabs.Home:AddParagraph({
		Title = "Welcome, ".. game.Players.LocalPlayer.DisplayName,
		Content = " "
	})
	Tabs.Home:AddParagraph({
		Title = "UserID: ".. game.Players.LocalPlayer.UserId,
		Content = " "
	})
	Tabs.Home:AddParagraph({
		Title = "Default User: ".. game.Players.LocalPlayer.Name,
		Content = " "
	})

	Tabs.Main:AddToggle("Auto-Farm", {
		Title = "Auto Farm",
		Description = "Detectable but works",
		Callback = function(Value)
			at = Value
		end
	})

	Tabs.Main:AddDropdown("SpeedDropdown", {
		Title = "Auto-Farm Speed",
		Description = "Select the speed of the auto-farm",
		Values = {"Default", "Fast", "Slow"},
		Default = 1,
		Multi = false,
		Callback = function(Value)
			if Value == "Default" then
				tweenSpeed = 32.5
			elseif Value == "Fast" then
				tweenSpeed = 17
			elseif Value == "Slow" then
				tweenSpeed = 38
			end
		end
	})

	local FOVSlider = Tabs.Main:AddSlider("FOVSlider", {
		Title = "FOV",
		Description = "Slider that changes your FOV",
		Default = game.Workspace.CurrentCamera.FieldOfView,
		Min = 70,
		Max = 120,
		Rounding = 1,
		Callback = function(Value)
			game.Workspace.CurrentCamera.FieldOfView = Value
		end
	})

end

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

Window:SelectTab(1)

Window:Dialog({
	Title = "ArcticX",
	Content = "Script has been loaded.",
	Buttons = {
		{
			Title = "Ok",
			Callback = function()
				print("ok")
			end
		}
	}
})

SaveManager:LoadAutoloadConfig()

local Autoing = false

game["Run Service"].Heartbeat:Connect(function()
	if Autoing == true then
		game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, -5, 0)
	end
end)

while true do
	wait(.1)
	if at == true then
		local Char = game.Players.LocalPlayer.Character
		if Char:FindFirstChild("HumanoidRootPart") then
			local Main = Char:WaitForChild("HumanoidRootPart")
			local Tween = game:GetService("TweenService")
			Autoing = true
			Tween:Create(Main, TweenInfo.new(0.1), {CFrame = CFrame.new(-45, 55, 70)}):Play()
			task.wait(0.1)
			Tween:Create(Main, TweenInfo.new(tweenSpeed,Enum.EasingStyle.Linear), {CFrame = CFrame.new(-45, 55, 9490)}):Play()
			task.wait(tweenSpeed)
			Main.CFrame = CFrame.new(-45, -358, 9490)
			Autoing = false
			game.Players.LocalPlayer.CharacterAdded:Wait()
		else
			repeat
				wait(2)
			until Char:FindFirstChild("HumanoidRootPart")
		end
	end
end
