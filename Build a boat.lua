local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
	Title = "ArcticX | V0.4.5 | Build a Boat",
	SubTitle = "by narpyyy",
	TabWidth = 120,
	Size = UDim2.fromOffset(440, 330),
	Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
	Theme = "Amethyst",
	MinimizeKey = Enum.KeyCode.RightControl -- Used when theres no MinimizeKeybind
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
	Home = Window:AddTab({ Title = "Home", Icon = "home" }),
	Main = Window:AddTab({ Title = "Scripts", Icon = "file-code" }),
	Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options
local at = false

do
	Fluent:Notify({
		Title = "ArcticX",
		Content = "Thank you for using our hub!",
		SubContent = " ", -- Optional
		Duration = 5 -- Set to nil to make the notification not disappear
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

	local SSlider = Tabs.Main:AddSlider("SpeedSlider", {
		Title = "Speed",
		Description = "Slider that changes ur speed",
		Default = 16,
		Min = 16,
		Max = 150,
		Rounding = .1,
		Callback = function(Value)
			game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").WalkSpeed = Value
		end
	})
	
	local FOVSlider = Tabs.Main:AddSlider("FOVdSlider", {
		Title = "FOV",
		Description = "Slider that changes ur FOV",
		Default = game.Workspace.CurrentCamera.FieldOfView,
		Min = 70,
		Max = 120,
		Rounding = 1,
		Callback = function(Value)
			game.Workspace.CurrentCamera.FieldOfView = Value
		end
	})

--[[
	local Dropdown = Tabs.Main:AddDropdown("Dropdown", {
		Title = "Dropdown",
		Values = {"one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen"},
		Multi = false,
		Default = 1,
	})

	Dropdown:SetValue("four")

	Dropdown:OnChanged(function(Value)
		print("Dropdown changed:", Value)
	end)



	local MultiDropdown = Tabs.Main:AddDropdown("MultiDropdown", {
		Title = "Dropdown",
		Description = "You can select multiple values.",
		Values = {"one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen"},
		Multi = true,
		Default = {"seven", "twelve"},
	})

	MultiDropdown:SetValue({
		three = true,
		five = true,
		seven = false
	})

	MultiDropdown:OnChanged(function(Value)
		local Values = {}
		for Value, State in next, Value do
			table.insert(Values, Value)
		end
		print("Mutlidropdown changed:", table.concat(Values, ", "))
	end)



	local Colorpicker = Tabs.Main:AddColorpicker("Colorpicker", {
		Title = "Colorpicker",
		Default = Color3.fromRGB(96, 205, 255)
	})

	Colorpicker:OnChanged(function()
		print("Colorpicker changed:", Colorpicker.Value)
	end)

	Colorpicker:SetValueRGB(Color3.fromRGB(0, 255, 140))



	local TColorpicker = Tabs.Main:AddColorpicker("TransparencyColorpicker", {
		Title = "Colorpicker",
		Description = "but you can change the transparency.",
		Transparency = 0,
		Default = Color3.fromRGB(96, 205, 255)
	})

	TColorpicker:OnChanged(function()
		print(
			"TColorpicker changed:", TColorpicker.Value,
			"Transparency:", TColorpicker.Transparency
		)
	end)



	local Keybind = Tabs.Main:AddKeybind("Keybind", {
		Title = "KeyBind",
		Mode = "Toggle", -- Always, Toggle, Hold
		Default = "LeftControl", -- String as the name of the keybind (MB1, MB2 for mouse buttons)

		-- Occurs when the keybind is clicked, Value is `true`/`false`
		Callback = function(Value)
			print("Keybind clicked!", Value)
		end,

		-- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
		ChangedCallback = function(New)
			print("Keybind changed!", New)
		end
	})

	-- OnClick is only fired when you press the keybind and the mode is Toggle
	-- Otherwise, you will have to use Keybind:GetState()
	Keybind:OnClick(function()
		print("Keybind clicked:", Keybind:GetState())
	end)

	Keybind:OnChanged(function()
		print("Keybind changed:", Keybind.Value)
	end)

	task.spawn(function()
		while true do
			wait(1)

			-- example for checking if a keybind is being pressed
			local state = Keybind:GetState()
			if state then
				print("Keybind is being held down")
			end

			if Fluent.Unloaded then break end
		end
	end)

	Keybind:SetValue("MB2", "Toggle") -- Sets keybind to MB2, mode to Hold


	local Input = Tabs.Main:AddInput("Input", {
		Title = "Input",
		Default = "Default",
		Placeholder = "Placeholder",
		Numeric = false, -- Only allows numbers
		Finished = false, -- Only calls callback when you press enter
		Callback = function(Value)
			print("Input changed:", Value)
		end
	})

	Input:OnChanged(function()
		print("Input updated:", Input.Value)
	end)
]]--
end


-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- InterfaceManager (Allows you to have a interface managment system)

-- Hand the library over to our managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game

InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")
--[[
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
]]--

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
--game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health = -5
-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()

local Autoing = false

game["Run Service"].Heartbeat:Connect(function()
	if Autoing == true then
		game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0,30,0)
	end
end)

while true do
	wait(.1)
	if at == true then
		local Char = game.Players.LocalPlayer.Character
		local Main = Char:WaitForChild("HumanoidRootPart")
		local Tween = game:GetService("TweenService")
		--workspace:WaitForChild(game.Players.LocalPlayer.TeamColor .. "Zone"):WaitForChild("VoteLaunchRE"):FireServer()
		Autoing = true
		Tween:Create(Main,TweenInfo.new(2),{CFrame = CFrame.new(-45, 15, 275)}):Play()
		task.wait(2)
		Tween:Create(Main,TweenInfo.new(60),{CFrame = CFrame.new(-45, 15, 9490)}):Play()
		task.wait(35)
		Tween:Create(Main,TweenInfo.new(2),{CFrame = CFrame.new(-45, -358, 275)}):Play()
		task.wait(2)
		Autoing = false
		game.Players.LocalPlayer.CharacterAdded:Wait()
	end
end