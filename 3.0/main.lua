------------------------------------ HOL UP ------------------------------------
repeat wait() until game:IsLoaded()
local LoadingTime = tick();
------------------------------------ REPO ------------------------------------
local repo = 'https://raw.githubusercontent.com/deaddigi/stuff/main/'
------------------------------------ LINKS ------------------------------------
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'Linoria%20Themes.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'Save%20Manager.lua'))()

Library:Notify('Loading UI...');
wait(3)
------------------------------------ WINDOW -----------------------------------
local Window = Library:CreateWindow({
    Title = 'pepsi.club',
    Center = true, 
    AutoShow = true,
})
------------------------------------ TABS ------------------------------------
local Tabs = {
    Legitbot = Window:AddTab('Aimbot'), 
    Visuals = Window:AddTab('Visuals'),
    Misc = Window:AddTab('Misc'),
    ['UI Settings'] = Window:AddTab('Settings'),
}
------------------------------------ SECTIONS ------------------------------------
local AimbotSec1 = Tabs.Legitbot:AddLeftGroupbox('Bullet Redirection')
local AimbotSec2 = Tabs.Legitbot:AddRightGroupbox('Aim Assist')

--local VisualSec1 = Tabs.Visuals:AddLeftGroupbox('ESP')
--local VisualSec12 = Tabs.Visuals:AddLeftGroupbox('ESP Settings')
--local VisualSec2 = Tabs.Visuals:AddRightGroupbox('World')
--local VisualSec3 = Tabs.Visuals:AddRightGroupbox('Self')
local ESPTabbox = Tabs.Visuals:AddLeftTabbox()
local ESPTab  = ESPTabbox:AddTab('ESP')
local ESPSTab = Tabs.Visuals:AddLeftGroupbox('ESP Settings')
local LocalTab = ESPTabbox:AddTab('Local')

local CameraTabbox = Tabs.Visuals:AddRightTabbox()
local CamTab  = CameraTabbox:AddTab('Client')
local VWTab = CameraTabbox:AddTab('Viewmodel')

local MiscTabbox = Tabs.Visuals:AddRightTabbox()
local WRLTab  = MiscTabbox:AddTab('World')
local MiscTab  = MiscTabbox:AddTab('Misc')
local ArmsTab = MiscTabbox:AddTab('Self')
local BulletsTab = MiscTabbox:AddTab('Bullet')
--local HitsTab = MiscTabbox:AddTab('Hit')
local MiscESPTab = Tabs.Visuals:AddLeftGroupbox('Misc ESP')

local MiscSec1 = Tabs.Misc:AddLeftGroupbox('Main')
local MiscSec2 = Tabs.Misc:AddLeftGroupbox('Movement')
local MiscSec3 = Tabs.Misc:AddRightGroupbox('Tweaks')
local MiscSec4 = Tabs.Misc:AddRightGroupbox('Hit')
local MiscSec5 = Tabs.Misc:AddRightGroupbox('Others')
local MiscSec6 = Tabs.Misc:AddRightGroupbox('Gun Mods')

local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')
------------------------------------ VARS ------------------------------------
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local workspace = game:GetService("Workspace")
local currentCamera = workspace.CurrentCamera
local guiService = game:GetService("GuiService")
local runService = game:GetService("RunService")
local lighting = game.Lighting
local mouse = localPlayer:GetMouse()
local userInput = game:GetService('UserInputService')
local TweenService = game:GetService("TweenService")
local rayignore = workspace.Ray_Ignore
local CNew, CF, C3, Vec2, Vec3 = ColorSequence.new, CFrame.new, Color3.fromRGB, Vector2.new, Vector3.new
local GetPlayers = players.GetPlayers
local cbClient = getsenv(localPlayer.PlayerGui:WaitForChild("Client"))

local SkyboxesTable = {
    ["Galaxy"] = {
        SkyboxBk = "http://www.roblox.com/asset/?id=159454299",
        SkyboxDn = "http://www.roblox.com/asset/?id=159454296",
        SkyboxFt = "http://www.roblox.com/asset/?id=159454293",
        SkyboxLf = "http://www.roblox.com/asset/?id=159454286",
        SkyboxRt = "http://www.roblox.com/asset/?id=159454300",
        SkyboxUp = "http://www.roblox.com/asset/?id=159454288"
    },
    ["Pink Sky"] = {
        SkyboxLf = "rbxassetid://271042310",
		SkyboxBk = "rbxassetid://271042516",
		SkyboxDn = "rbxassetid://271077243",
		SkyboxFt = "rbxassetid://271042556",
		SkyboxRt = "rbxassetid://271042467",
		SkyboxUp = "rbxassetid://271077958"
    },
    ["Sunset"] = {
        SkyboxBk = "http://www.roblox.com/asset/?id=458016711",
        SkyboxDn = "http://www.roblox.com/asset/?id=458016826",
        SkyboxFt = "http://www.roblox.com/asset/?id=458016532",
        SkyboxLf = "http://www.roblox.com/asset/?id=458016655",
        SkyboxRt = "http://www.roblox.com/asset/?id=458016782",
        SkyboxUp = "http://www.roblox.com/asset/?id=458016792"
    },
    ["Night"] = {
        SkyboxBk = "rbxassetid://48020371",
        SkyboxDn = "rbxassetid://48020144",
        SkyboxFt = "rbxassetid://48020234",
        SkyboxLf = "rbxassetid://48020211",
        SkyboxRt = "rbxassetid://48020254",
        SkyboxUp = "rbxassetid://48020383"
    },
    ["Evening"] = {
        SkyboxLf = "http://www.roblox.com/asset/?id=7950573918",
        SkyboxBk = "http://www.roblox.com/asset/?id=7950569153",
		SkyboxDn = "http://www.roblox.com/asset/?id=7950570785",
		SkyboxFt = "http://www.roblox.com/asset/?id=7950572449",
		SkyboxRt = "http://www.roblox.com/asset/?id=7950575055",
		SkyboxUp = "http://www.roblox.com/asset/?id=7950627627"
    }
}

local saturationeffect = Instance.new("ColorCorrectionEffect", currentCamera)
saturationeffect.Enabled = false
local Blur = Instance.new("BlurEffect", currentCamera)
Blur.Enabled = false

local bullettracerstexture = 446111271
local armschamstexture = 414144526
local weaponchamstexture = 414144526
local retardarmschams = C3(255, 0, 0)

local ebCooldown = false
local oldState = Enum.HumanoidStateType.None
local ebenabled = false
local ebsfx = 6887181639
local timeout = 0
local ebcount = 0
local graphLines = {}
local lastPos = currentCamera.ViewportSize.Y-90

local HitSoundType = 3124331820
local KillSoundType = 5902468562
------------------------------------ GUI STUFF ------------------------------------
local watermark = Instance.new("ScreenGui")
local ScreenLabel = Instance.new("Frame")
local WatermarkColor = Instance.new("Frame")
local UIGradient = Instance.new("UIGradient")
local Container = Instance.new("Frame")
local UIPadding = Instance.new("UIPadding")
local Text = Instance.new("TextLabel")
local Background = Instance.new("Frame")

watermark.Name = "watermark"
watermark.Parent = game.CoreGui
watermark.Enabled = false

ScreenLabel.Name = "ScreenLabel"
ScreenLabel.Parent = watermark
ScreenLabel.BackgroundColor3 = C3(28, 28, 28)
ScreenLabel.BackgroundTransparency = 1.000
ScreenLabel.BorderColor3 = C3(20, 20, 20)
ScreenLabel.Position = UDim2.new(0, 12, 0, 7)
ScreenLabel.Size = UDim2.new(0, 260, 0, 20)

WatermarkColor.Name = "Color"
WatermarkColor.Parent = ScreenLabel
WatermarkColor.BackgroundColor3 = C3(0, 89, 149)
WatermarkColor.BorderSizePixel = 0
WatermarkColor.Size = UDim2.new(0.534260333, 0, 0, 2)
WatermarkColor.ZIndex = 2

UIGradient.Color = CNew{ColorSequenceKeypoint.new(0.00, C3(255, 255, 255)), ColorSequenceKeypoint.new(1.00, C3(60, 60, 60))}
UIGradient.Rotation = 90
UIGradient.Parent = WatermarkColor

Container.Name = "Container"
Container.Parent = ScreenLabel
Container.BackgroundTransparency = 1.000
Container.BorderSizePixel = 0
Container.Position = UDim2.new(0, 0, 0, 4)
Container.Size = UDim2.new(1, 0, 0, 14)
Container.ZIndex = 3

UIPadding.Parent = Container
UIPadding.PaddingLeft = UDim.new(0, 4)

Text.Name = "Text"
Text.Parent = Container
Text.BackgroundTransparency = 1.000
Text.Position = UDim2.new(0.0230768919, 0, 0, 0)
Text.Size = UDim2.new(0.48046875, 0, 1, 0)
Text.ZIndex = 4
Text.Font = Enum.Font.RobotoMono
Text.Text = "pepsi.club | user"
Text.TextColor3 = C3(65025, 65025, 65025)
Text.TextSize = 14.000
Text.TextStrokeTransparency = 0.000
Text.TextXAlignment = Enum.TextXAlignment.Left

Background.Name = "Background"
Background.Parent = ScreenLabel
Background.BackgroundColor3 = C3(23, 23, 23)
Background.BorderColor3 = C3(20, 20, 20)
Background.Size = UDim2.new(0.534260333, 0, 1, 0)

local function ZWWNPAB_fake_script() -- ScreenLabel.LocalScript 
	local script = Instance.new('LocalScript', ScreenLabel)

	local gui = script.Parent
	gui.Draggable = true
	gui.Active = true
end
coroutine.wrap(ZWWNPAB_fake_script)()

local SpectatorViewer = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Spectators = Instance.new("TextLabel")
local Background = Instance.new("Frame")
local UIGradient = Instance.new("UIGradient")
local SpectColor = Instance.new("Frame")
local UIGradient_2 = Instance.new("UIGradient")
local Frame = Instance.new("Frame")
local Example = Instance.new("TextLabel")
local UIListLayout = Instance.new("UIListLayout")

SpectatorViewer.Name = "SpectatorViewer"
SpectatorViewer.Parent = game.CoreGui

Main.Name = "Main"
Main.Parent = SpectatorViewer
Main.BackgroundColor3 = C3(23, 23, 23)
Main.BackgroundTransparency = 1.000
Main.BorderColor3 = C3(20, 20, 20)
Main.Position = UDim2.new(0.00779589033, 0, 0.400428265, 0)
Main.Size = UDim2.new(0, 153, 0, 20)
Main.Visible = true

Spectators.Name = "Spectators"
Spectators.Parent = Main
Spectators.BackgroundTransparency = 1.000
Spectators.Size = UDim2.new(1, 0, 1, 0)
Spectators.ZIndex = 4
Spectators.Font = Enum.Font.RobotoMono
Spectators.Text = " Spectators"
Spectators.TextColor3 = C3(255, 255, 255)
Spectators.TextSize = 15.000
Spectators.TextStrokeTransparency = 0.000
Spectators.TextXAlignment = Enum.TextXAlignment.Left

Background.Name = "Background"
Background.Parent = Main
Background.BackgroundColor3 = C3(45, 45, 45)
Background.BorderColor3 = C3(20, 20, 20)
Background.Size = UDim2.new(1.00657892, 0, 1, 0)
Background.BorderSizePixel = 0  

UIGradient.Color = CNew{ColorSequenceKeypoint.new(0.00, C3(255, 255, 255)), ColorSequenceKeypoint.new(1.00, C3(112, 112, 112))}
UIGradient.Rotation = 90
UIGradient.Parent = Background

SpectColor.Name = "Color"
SpectColor.Parent = Main
SpectColor.BackgroundColor3 = C3(255, 0, 0)
SpectColor.BorderSizePixel = 0
SpectColor.Position = UDim2.new(0, 1, 0, 1)
SpectColor.Size = UDim2.new(0.991, 0, 0, 2)
SpectColor.ZIndex = 2

UIGradient_2.Color = CNew{ColorSequenceKeypoint.new(0.00, C3(255, 255, 255)), ColorSequenceKeypoint.new(1.00, C3(60, 60, 60))}
UIGradient_2.Rotation = 90
UIGradient_2.Parent = SpectColor

Frame.Parent = Main
Frame.BackgroundColor3 = C3(7, 7, 7)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0, 0, 1, 0)
Frame.Size = UDim2.new(0, 153, 0, 1)

Example.Name = "Example"
Example.Parent = Frame
Example.BackgroundColor3 = C3(22, 22, 22)
Example.BorderSizePixel = 0
Example.Position = UDim2.new(-0.00653594732, 0, 1, 0)
Example.Size = UDim2.new(0, 156, 0, 20)
Example.Font = Enum.Font.RobotoMono
Example.Text = "Name"
Example.Visible = false
Example.TextColor3 = C3(255, 255, 255)
Example.TextSize = 13.000
Example.TextXAlignment = Enum.TextXAlignment.Left

UIListLayout.Parent = Frame
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function spectlist()
	local script = Instance.new('LocalScript', Frame)

	
	local function GetSpectators()
		local CurrentSpectators = {}
		for i,v in pairs(game:GetService("Players"):GetChildren()) do 
			if v ~= game:GetService("Players").LocalPlayer and not v.Character and v:FindFirstChild("CameraCF") and (v.CameraCF.Value.Position - workspace.CurrentCamera.CFrame.p).Magnitude < 10 then 
				table.insert(CurrentSpectators, #CurrentSpectators+1, v)
			end
		end
		return CurrentSpectators
	end
	
	while wait(0.05) do
		for i,v in next, script.Parent:GetChildren() do
			if v.Name ~= "Example" and not v:IsA("UIListLayout") and not v:IsA("LocalScript") then
				v:Destroy()
			end
		end
		for i,v in next, GetSpectators() do
			local new = script.Parent.Example:Clone()
			new.Parent = script.Parent
			new.Visible = true
			new.ZIndex = 5
			new.Name = v.Name
			new.Text = " ".. v.Name
			new.TextSize = 13
			new.Size = UDim2.new(0, 154,0, 20)
			new.Font = Enum.Font.RobotoMono
			new.BackgroundColor3 = C3(20, 20, 20)
			new.TextColor3 = C3(225, 225, 225)
			new.TextStrokeTransparency = 0
		end
	end
	
end
coroutine.wrap(spectlist)()

local keystrokesGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local W = Instance.new("TextLabel")
local S = Instance.new("TextLabel")
local A = Instance.new("TextLabel")
local D = Instance.new("TextLabel")
local E = Instance.new("TextLabel")
local R = Instance.new("TextLabel")
local Space = Instance.new("TextLabel")

keystrokesGui.Parent = game.CoreGui
keystrokesGui.Name = "keystrokess"
keystrokesGui.Enabled = false

Frame.Parent = keystrokesGui
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BackgroundTransparency = 1.000
Frame.Position = UDim2.new(0.453987718, 0, 0.738977075, 0)
Frame.Size = UDim2.new(0, 72, 0, 75)

W.Name = "W"
W.Parent = Frame
W.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
W.BackgroundTransparency = 1.000
W.Position = UDim2.new(0.287764132, 0, -0.0102292299, 0)
W.Size = UDim2.new(0, 29, 0, 28)
W.Font = Enum.Font.Code
W.Text = "_"
W.TextColor3 = Color3.fromRGB(255, 255, 255)
W.TextSize = 14.000
W.TextStrokeTransparency = 0.000

S.Name = "S"
S.Parent = Frame
S.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
S.BackgroundTransparency = 1.000
S.Position = UDim2.new(0.287764132, 0, 0.35915342, 0)
S.Size = UDim2.new(0, 29, 0, 28)
S.Font = Enum.Font.Code
S.Text = "_"
S.TextColor3 = Color3.fromRGB(255, 255, 255)
S.TextSize = 14.000
S.TextStrokeTransparency = 0.000

A.Name = "A"
A.Parent = Frame
A.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
A.BackgroundTransparency = 1.000
A.Position = UDim2.new(-0.0950409099, 0, 0.35915345, 0)
A.Size = UDim2.new(0, 29, 0, 28)
A.Font = Enum.Font.Code
A.Text = "_"
A.TextColor3 = Color3.fromRGB(255, 255, 255)
A.TextSize = 14.000
A.TextStrokeTransparency = 0.000

D.Name = "D"
D.Parent = Frame
D.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
D.BackgroundTransparency = 1.000
D.Position = UDim2.new(0.684458077, 0, 0.35915342, 0)
D.Size = UDim2.new(0, 29, 0, 28)
D.Font = Enum.Font.Code
D.Text = "_"
D.TextColor3 = Color3.fromRGB(255, 255, 255)
D.TextSize = 14.000
D.TextStrokeTransparency = 0.000

E.Name = "E"
E.Parent = Frame
E.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
E.BackgroundTransparency = 1.000
E.Position = UDim2.new(-0.0950409099, 0, -0.0102293491, 0)
E.Size = UDim2.new(0, 29, 0, 28)
E.Font = Enum.Font.Code
E.Text = "_"
E.TextColor3 = Color3.fromRGB(255, 255, 255)
E.TextSize = 14.000
E.TextStrokeTransparency = 0.000

R.Name = "R"
R.Parent = Frame
R.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
R.BackgroundTransparency = 1.000
R.Position = UDim2.new(0.683231115, 0, -0.0102292895, 0)
R.Size = UDim2.new(0, 29, 0, 28)
R.Font = Enum.Font.Code
R.Text = "_"
R.TextColor3 = Color3.fromRGB(255, 255, 255)
R.TextSize = 14.000
R.TextStrokeTransparency = 0.000

Space.Name = "Space"
Space.Parent = Frame
Space.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Space.BackgroundTransparency = 1.000
Space.Position = UDim2.new(-0.104209319, 0, 0.620387971, 0)
Space.Size = UDim2.new(0, 87, 0, 28)
Space.Font = Enum.Font.Code
Space.Text = "_"
Space.TextColor3 = Color3.fromRGB(255, 255, 255)
Space.TextSize = 14.000
Space.TextStrokeTransparency = 0.000

-- Scripts:

local function SJBA_fake_script() -- Frame.LocalScript 
    local script = Instance.new('LocalScript', Frame)
    local gui = script.Parent
    gui.Draggable = true
    gui.Active = true
end
coroutine.wrap(SJBA_fake_script)()

local function UTCCBQ_fake_script() -- Frame.LocalScript 
    local script = Instance.new('LocalScript', Frame)
    local UIS = game:GetService("UserInputService")
    local Sp = script.Parent.Space
    local W = script.Parent.W
    local A = script.Parent.A
    local S = script.Parent.S
    local D = script.Parent.D
    local E = script.Parent.E
    local R = script.Parent.R
	
    UIS.InputBegan:Connect(function(key)
        if key.KeyCode == Enum.KeyCode.W then
            W.Text = "W"
        elseif key.KeyCode == Enum.KeyCode.A then
            A.Text = "A"
        elseif key.KeyCode == Enum.KeyCode.S then
            S.Text = "S"
        elseif key.KeyCode == Enum.KeyCode.D then
            D.Text = "D"
        elseif key.KeyCode == Enum.KeyCode.E then
            E.Text = "E"
        elseif key.KeyCode == Enum.KeyCode.R then
            R.Text = "R"
        elseif key.KeyCode == Enum.KeyCode.Space then
            Sp.Text = "Space"
        end
    end)
    
    UIS.InputEnded:Connect(function(key)
        if key.KeyCode == Enum.KeyCode.W then
            W.Text = "_"
        elseif key.KeyCode == Enum.KeyCode.A then
            A.Text = "_"
        elseif key.KeyCode == Enum.KeyCode.S then
            S.Text = "_"
        elseif key.KeyCode == Enum.KeyCode.D then
            D.Text = "_"
        elseif key.KeyCode == Enum.KeyCode.E then
            E.Text = "_"
        elseif key.KeyCode == Enum.KeyCode.R then
            R.Text = "_"
        elseif key.KeyCode == Enum.KeyCode.Space then
            Sp.Text = "_"
            end
        end)
    end
coroutine.wrap(UTCCBQ_fake_script)()

local ebtxt = Drawing.new("Text");ebtxt.Text = "EB";ebtxt.Center = true;ebtxt.Outline = true;ebtxt.Color = C3(255, 255, 255);ebtxt.Font = 3;ebtxt.Position = Vec2(currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y - 80);ebtxt.Size = 18;ebtxt.Visible = false;
local ebcounter = Drawing.new("Text");ebcounter.Text = "eb: "..ebcount.."";ebcounter.Center = true;ebcounter.Outline = true;ebcounter.Color = C3(255, 255, 255);ebcounter.Font = 3;ebcounter.Position = Vec2(currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y - 50);ebcounter.Size = 18;ebcounter.Visible = false
local VelocityCounter = Drawing.new("Text");VelocityCounter.Text = "";VelocityCounter.Center = true;VelocityCounter.Outline = true;VelocityCounter.Color = Color3.new(1,1,1);VelocityCounter.Font = 3;VelocityCounter.Position = Vec2(currentCamera.ViewportSize.X/2, currentCamera.ViewportSize.Y-70);VelocityCounter.Size = 20;VelocityCounter.Visible = false
------------------------------------ MAIN FUNCS ------------------------------------
local function IsAlive(plr)
	if plr and plr.Character and plr.Character.FindFirstChild(plr.Character, "Humanoid") and plr.Character.Humanoid.Health > 0 then
		return true
	end

	return false
end

function isButtonDown(key)
    if string.find(tostring(key),"KeyCode") then
        return game:GetService("UserInputService"):IsKeyDown(key) 
    else
        for _,v in pairs(game:GetService("UserInputService"):GetMouseButtonsPressed()) do
            if v.UserInputType == key then
                return true
            end
        end
    end
	return false
end
------------------------------------ SILENT AIM STUFF ------------------------------------
--// all of the silent aim was made by xaxa, credits to him.
local SilentAimSettings = {
    Enabled = false,
    
    ClassName = "Universal Silent Aim - Averiias, Stefanuk12, xaxa",
    ToggleKey = "RightAlt",
    
    TeamCheck = false,
    VisibleCheck = false, 
    TargetPart = "HumanoidRootPart",
    SilentAimMethod = "FindPartOnRayWithIgnoreList",
    
    FOVRadius = 130,
    FOVVisible = false,
    ShowSilentAimTarget = false, 
    
    MouseHitPrediction = false,
    MouseHitPredictionAmount = 0.165,
    HitChance = 100
}

-- variables
getgenv().SilentAimSettings = Settings

local ValidTargetParts = {"Head", "HumanoidRootPart"}
local PredictionAmount = 0.165

--// Aim Assist FOV Circles
local as_fov_circleout1 = Drawing.new("Circle")
as_fov_circleout1.Thickness = 1
as_fov_circleout1.NumSides = 100
as_fov_circleout1.Radius = 130
as_fov_circleout1.Filled = false
as_fov_circleout1.Visible = false
as_fov_circleout1.ZIndex = 9
as_fov_circleout1.Transparency = 1
as_fov_circleout1.Color = C3(0, 0, 0)
local as_fov_circle = Drawing.new("Circle")
as_fov_circle.Thickness = 1
as_fov_circle.NumSides = 100
as_fov_circle.Radius = 130
as_fov_circle.Filled = false
as_fov_circle.Visible = false
as_fov_circle.ZIndex = 10
as_fov_circle.Transparency = 1
as_fov_circle.Color = C3(54, 57, 241)
local as_fov_circleout2 = Drawing.new("Circle")
as_fov_circleout2.Thickness = 1
as_fov_circleout2.NumSides = 100
as_fov_circleout2.Radius = 130
as_fov_circleout2.Filled = false
as_fov_circleout2.Visible = false
as_fov_circleout2.ZIndex = 9
as_fov_circleout2.Transparency = 1
as_fov_circleout2.Color = C3(0, 0, 0)
--// Silent Aim FOV Circles
local br_fov_circleout1 = Drawing.new("Circle")
br_fov_circleout1.Thickness = 1
br_fov_circleout1.NumSides = 100
br_fov_circleout1.Radius = 130
br_fov_circleout1.Filled = false
br_fov_circleout1.Visible = false
br_fov_circleout1.ZIndex = 9
br_fov_circleout1.Transparency = 1
br_fov_circleout1.Color = C3(0, 0, 0)
local br_fov_circle = Drawing.new("Circle")
br_fov_circle.Thickness = 1
br_fov_circle.NumSides = 100
br_fov_circle.Radius = 130
br_fov_circle.Filled = false
br_fov_circle.Visible = false
br_fov_circle.ZIndex = 10
br_fov_circle.Transparency = 1
br_fov_circle.Color = C3(54, 57, 241)
local br_fov_circleout2 = Drawing.new("Circle")
br_fov_circleout2.Thickness = 1
br_fov_circleout2.NumSides = 100
br_fov_circleout2.Radius = 130
br_fov_circleout2.Filled = false
br_fov_circleout2.Visible = false
br_fov_circleout2.ZIndex = 9
br_fov_circleout2.Transparency = 1
br_fov_circleout2.Color = C3(0, 0, 0)

runService.RenderStepped:Connect(function()
    local mousepos = Vec2(userInput:GetMouseLocation().X, userInput:GetMouseLocation().Y)
    br_fov_circleout1.Position = mousepos
    br_fov_circle.Position = mousepos
    br_fov_circleout2.Position = mousepos
    
    as_fov_circleout1.Position = mousepos
    as_fov_circle.Position = mousepos
    as_fov_circleout2.Position = mousepos
end)

local ExpectedArguments = {
    FindPartOnRayWithIgnoreList = {
        ArgCountRequired = 3,
        Args = {
            "Instance", "Ray", "table", "boolean", "boolean"
        }
    }
}

function CalculateChance(Percentage)
    -- // Floor the percentage
    Percentage = math.floor(Percentage)

    -- // Get the chance
    local chance = math.floor(Random.new().NextNumber(Random.new(), 0, 1) * 100) / 100

    -- // Return
    return chance <= Percentage / 100
end

local function getPositionOnScreen(Vector)
    local Vec3, OnScreen = currentCamera.WorldToScreenPoint(currentCamera, Vector)
    return Vec2(Vec3.X, Vec3.Y), OnScreen
end

local function ValidateArguments(Args, RayMethod)
    local Matches = 0
    if #Args < RayMethod.ArgCountRequired then
        return false
    end
    for Pos, Argument in next, Args do
        if typeof(Argument) == RayMethod.Args[Pos] then
            Matches = Matches + 1
        end
    end
    return Matches >= RayMethod.ArgCountRequired
end

local function getDirection(Origin, Position)
    return (Position - Origin).Unit * 1000
end

local function getMousePosition()
    return userInput.GetMouseLocation(userInput)
end

local function IsPlayerVisible(Player)
    local PlayerCharacter = Player.Character
    local LocalPlayerCharacter = localPlayer.Character
    
    if not (PlayerCharacter or LocalPlayerCharacter) then return end 
    
    local PlayerRoot = game.FindFirstChild(PlayerCharacter, Options.TargetPart.Value) or game.FindFirstChild(PlayerCharacter, "HumanoidRootPart")
    
    if not PlayerRoot then return end 
    
    local CastPoints, IgnoreList = {PlayerRoot.Position, LocalPlayerCharacter, PlayerCharacter}, {LocalPlayerCharacter, PlayerCharacter}
    local ObscuringObjects = #currentCamera.GetPartsObscuringTarget(currentCamera, CastPoints, IgnoreList)
    
    return ((ObscuringObjects == 0 and true) or (ObscuringObjects > 0 and false))
end

local function getClosestPlayer()
    if not Options.TargetPart.Value then return end
    local Closest
    local DistanceToMouse
    for _, Player in next, players.GetPlayers(players) do
        if Player == localPlayer then continue end
        if Toggles.TeamCheck.Value and Player.Team == localPlayer.Team then continue end

        local Character = Player.Character
        if not Character then continue end
        
        if Toggles.VisibleCheck.Value and not IsPlayerVisible(Player) then continue end

        local HumanoidRootPart = game.FindFirstChild(Character, "HumanoidRootPart")
        local Humanoid = game.FindFirstChild(Character, "Humanoid")
        if not HumanoidRootPart or not Humanoid or Humanoid and Humanoid.Health <= 0 then continue end

        local ScreenPosition, OnScreen = getPositionOnScreen(HumanoidRootPart.Position)
        if not OnScreen then continue end

        local Distance = (getMousePosition() - ScreenPosition).Magnitude
        if Distance <= (DistanceToMouse or Options.Radius.Value or 2000) then
            Closest = ((Options.TargetPart.Value == "Random" and Character[ValidTargetParts[math.random(1, #ValidTargetParts)]]) or Character[Options.TargetPart.Value])
            DistanceToMouse = Distance
        end
    end
    return Closest
end
------------------------------------ AIM ASSIST CODE ------------------------------------
local AimSettings = {
    Enabled = false,
    TeamCheck = false,
    --Key = 'E',
    Smoothness = 1,
    Radius = 50,
    Hitbox = 'Head'
}

local function getClosest(cframe)
   local ray = Ray.new(cframe.Position, cframe.LookVector).Unit
   
   local target = nil
   local mag = math.huge
   
    for i,v in pairs(players:GetPlayers()) do
        --if AimSettings.VisibleCheck and not IsPlayerVisible(target) then continue end
        if v.Character and v.Character:FindFirstChild("Head") and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("HumanoidRootPart") and v ~= localPlayer and (v.Team ~= localPlayer.Team or (not AimSettings.TeamCheck)) then
            local magBuf = (v.Character[AimSettings.Hitbox].Position - ray:ClosestPoint(v.Character[AimSettings.Hitbox].Position)).Magnitude
            
            if magBuf < mag then
                mag = magBuf
                target = v
            end
        end
    end
   
   return target
end
------------------------------------ ESP CODE ------------------------------------
local esp = {
    playerObjects = {},
    enabled = false,
    teamcheck = true,
    fontsize = 13,
    font = 1,
    settings = {
        name = {enabled = false, outline = false, displaynames = false, color = C3(255, 255, 255)},
        box = {enabled = false, outline = false, color = C3(255, 255, 255)},
        boxfill = {enabled = false, color = C3(255, 0, 0), transparency = 0.5},
        healthbar = {enabled = false, outline = false},
        healthtext = {enabled = false, outline = false, color = C3(255, 255, 255)},
        distance = {enabled = false, outline = false, color = C3(255, 255, 255)},
        viewangle = {enabled = false, color = C3(255, 255, 255)},
    }
}

esp.NewDrawing = function(type, properties)
    local newD = Drawing.new(type)
    for i,v in next, properties or {} do
        local s,e = pcall(function()
            newD[i] = v
        end)

        if not s then
            warn(e)
        end
    end
    return newD
end

esp.HasCharacter = function(v)
    local pass = false
    -- if u dont want an self esp then do this: if v ~= game.Players.LocalPlayer and v.Character, else if v ~= v.Character
    if v ~= localPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Head") then
        pass = true
    end

    if s then return pass; end; return pass;
end

esp.TeamCheck = function(v)
    local pass = true
    if localPlayer.TeamColor == v.TeamColor then
        pass = false
    end

    if s then return pass; end; return pass;
end --[true = Same Team | false = Same Teama]

esp.NewPlayer = function(v)
    esp.playerObjects[v] = {
        name = esp.NewDrawing("Text", {Color = C3(255, 255, 255), Outline = true, Center = true, Size = 13, Font = 2}),
        boxOutline = esp.NewDrawing("Square", {Color = C3(0, 0, 0), Thickness = 3, ZIndex = 2}),
        box = esp.NewDrawing("Square", {Color = C3(255, 255, 255), Thickness = 1, ZIndex = 3}),
        boxfill = esp.NewDrawing("Square", {Color = C3(255, 255, 255), Thickness = 1, ZIndex = 1}),
        healthBarOutline = esp.NewDrawing("Line", {Color = C3(0, 0, 0), Thickness = 3}),
        healthBar = esp.NewDrawing("Line", {Color = C3(255, 255, 255), Thickness = 1}),
        healthText = esp.NewDrawing("Text", {Color = C3(255, 255, 255), Outline = true, Center = true, Size = 13, Font = 2}),
        distance = esp.NewDrawing("Text", {Color = C3(255, 255, 255), Outline = true, Center = true, Size = 13, Font = 2}),
        viewAngle = esp.NewDrawing("Line", {Color = C3(255, 255, 255), Thickness = 1}),
    }
end

for _,v in ipairs(players:GetPlayers()) do
    esp.NewPlayer(v)
end

players.PlayerAdded:Connect(esp.NewPlayer)

local mainLoop = runService.RenderStepped:Connect(function()
    for i,v in pairs(esp.playerObjects) do
        if not esp.HasCharacter(i) then
            v.name.Visible = false
            v.boxOutline.Visible = false
            v.box.Visible = false
            v.boxfill.Visible = false
        end
    
        if esp.HasCharacter(i) then
            local hum = i.Character.Humanoid
            local hrp = i.Character.HumanoidRootPart
            local head = i.Character.Head

            local Vector, onScreen = currentCamera:WorldToViewportPoint(i.Character.HumanoidRootPart.Position)
    
            local Size = (currentCamera:WorldToViewportPoint(hrp.Position - Vec3(0, 3, 0)).Y - currentCamera:WorldToViewportPoint(hrp.Position + Vec3(0, 2.6, 0)).Y) / 2
            local BoxSize = Vec2(math.floor(Size * 1.5), math.floor(Size * 1.9))
            local BoxPos = Vec2(math.floor(Vector.X - Size * 1.5 / 2), math.floor(Vector.Y - Size * 1.6 / 2))
            
            local BoxFillSize = Vec2(math.floor(Size * 1.5), math.floor(Size * 1.9)) --same as box
            local BoxFillPos = Vec2(math.floor(Vector.X - Size * 1.5 / 2), math.floor(Vector.Y - Size * 1.6 / 2)) -- this 1 too
    
            local BottomOffset = BoxSize.Y + BoxPos.Y + 1

            if onScreen and esp.enabled then
                if esp.settings.name.enabled then
                    v.name.Position = Vec2(BoxSize.X / 2 + BoxPos.X, BoxPos.Y - 16)
                    v.name.Outline = esp.settings.name.outline
                    v.name.Color = esp.settings.name.color

                    v.name.Font = esp.font
                    v.name.Size = esp.fontsize

                    if esp.settings.name.displaynames then
                        v.name.Text = tostring(i.DisplayName)
                    else
                        v.name.Text = tostring(i.Name)
                    end

                    v.name.Visible = true
                else
                    v.name.Visible = false
                end

                if esp.settings.distance.enabled and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    v.distance.Position = Vec2(BoxSize.X / 2 + BoxPos.X, BottomOffset)
                    v.distance.Outline = esp.settings.distance.outline
                    v.distance.Text = "[ " .. math.floor((hrp.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude) .. " studs]"
                    v.distance.Color = esp.settings.distance.color
                    BottomOffset = BottomOffset + 15

                    v.distance.Font = esp.font
                    v.distance.Size = esp.fontsize

                    v.distance.Visible = true
                else
                    v.distance.Visible = false
                end

                if esp.settings.box.enabled then
                    v.boxOutline.Size = BoxSize
                    v.boxOutline.Position = BoxPos
                    v.boxOutline.Visible = esp.settings.box.outline
    
                    v.box.Size = BoxSize
                    v.box.Position = BoxPos
                    v.box.Color = esp.settings.box.color
                    v.box.Visible = true
                else
                    v.boxOutline.Visible = false
                    v.box.Visible = false
                end
                
                if esp.settings.boxfill.enabled then
                    v.boxfill.Position = BoxFillPos
                    v.boxfill.Size = BoxFillSize
                    v.boxfill.Visible = esp.settings.boxfill.enabled
                    v.boxfill.Filled = true
                    v.boxfill.Color = esp.settings.boxfill.color
                    v.boxfill.Transparency = esp.settings.boxfill.transparency
                else
                    v.boxfill.Visible = false
                    v.boxfill.Filled = false
                end

                if esp.settings.healthbar.enabled then
                    v.healthBar.From = Vec2((BoxPos.X - 5), BoxPos.Y + BoxSize.Y)
                    v.healthBar.To = Vec2(v.healthBar.From.X, v.healthBar.From.Y - (hum.Health / hum.MaxHealth) * BoxSize.Y)
                    v.healthBar.Color = C3(255 - 255 / (hum["MaxHealth"] / hum["Health"]), 255 / (hum["MaxHealth"] / hum["Health"]), 0)
                    v.healthBar.Visible = true

                    v.healthBarOutline.From = Vec2(v.healthBar.From.X, BoxPos.Y + BoxSize.Y + 1)
                    v.healthBarOutline.To = Vec2(v.healthBar.From.X, (v.healthBar.From.Y - 1 * BoxSize.Y) -1)
                    v.healthBarOutline.Visible = esp.settings.healthbar.outline
                else
                    v.healthBarOutline.Visible = false
                    v.healthBar.Visible = false
                end

                if esp.settings.healthtext.enabled then
                    v.healthText.Text = tostring(math.floor((hum.Health / hum.MaxHealth) * 100 + 0.5))
                    v.healthText.Position = Vec2((BoxPos.X - 20), (BoxPos.Y + BoxSize.Y - 1 * BoxSize.Y) -1)
                    v.healthText.Color = esp.settings.healthtext.color
                    v.healthText.Outline = esp.settings.healthtext.outline

                    v.healthText.Font = esp.font
                    v.healthText.Size = esp.fontsize

                    v.healthText.Visible = true
                else
                    v.healthText.Visible = false
                end

                if esp.settings.viewangle.enabled then
                    local fromHead = currentCamera:worldToViewportPoint(head.CFrame.p)
                    local toPoint = currentCamera:worldToViewportPoint((head.CFrame + (head.CFrame.lookVector * 10)).p)
                    v.viewAngle.From = Vec2(fromHead.X, fromHead.Y)
                    v.viewAngle.To = Vec2(toPoint.X, toPoint.Y)
                    v.viewAngle.Color = esp.settings.viewangle.color
                    v.viewAngle.Visible = true
                end
                
                
                if esp.teamcheck then
                    if esp.TeamCheck(i) then
                        v.name.Visible = esp.settings.name.enabled
                        v.box.Visible = esp.settings.box.enabled
                        v.boxfill.Visible = esp.settings.boxfill.enabled
                        v.healthBar.Visible = esp.settings.healthbar.enabled
                        v.healthText.Visible = esp.settings.healthtext.enabled
                        v.distance.Visible = esp.settings.distance.enabled
                        v.viewAngle.Visible = esp.settings.viewangle.enabled
                        if ESPOutline then
                            if esp.settings.box.enabled then
                                v.boxOutline.Visible = esp.settings.box.outline
                                v.boxOutline.Visible = esp.settings.box.outline
                            end

                            if esp.settings.healthbar.enabled then
                                v.healthBarOutline.Visible = esp.settings.healthbar.outline
                            end
                        end
                    else
                        v.name.Visible = false
                        v.boxOutline.Visible = false
                        v.box.Visible = false
                        v.boxfill.Visible = false
                        v.healthBarOutline.Visible = false
                        v.healthBar.Visible = false
                        v.healthText.Visible = false
                        v.distance.Visible = false
                        v.viewAngle.Visible = false
                    end
                end
            else
                v.name.Visible = false
                v.boxOutline.Visible = false
                v.box.Visible = false
                v.boxfill.Visible = false
                v.healthBarOutline.Visible = false
                v.healthBar.Visible = false
                v.healthText.Visible = false
                v.distance.Visible = false
                v.viewAngle.Visible = false
            end
        else
            v.name.Visible = false
            v.boxOutline.Visible = false
            v.box.Visible = false
            v.boxfill.Visible = false
            v.healthBarOutline.Visible = false
            v.healthBar.Visible = false
            v.healthText.Visible = false
            v.distance.Visible = false
            v.viewAngle.Visible = false
        end
    end
end)
------------------------------------ CONTENT ------------------------------------
AimbotSec1:AddToggle("aim_Enabled", {Text = "Enabled"}):AddKeyPicker("aim_Enabled_KeyPicker", {Default = "RightAlt", SyncToggleState = true, Mode = "Toggle", Text = "Silent Aim", NoUI = false});
Options.aim_Enabled_KeyPicker:OnClick(function()
    SilentAimSettings.Enabled = not SilentAimSettings.Enabled
    
    Toggles.aim_Enabled.Value = SilentAimSettings.Enabled
    Toggles.aim_Enabled:SetValue(SilentAimSettings.Enabled)
end)
    
AimbotSec1:AddToggle("TeamCheck", {Text = "Team Check", Default = SilentAimSettings.TeamCheck}):OnChanged(function()
    SilentAimSettings.TeamCheck = Toggles.TeamCheck.Value
end)
AimbotSec1:AddToggle("VisibleCheck", {Text = "Visible Check", Default = SilentAimSettings.VisibleCheck}):OnChanged(function()
    SilentAimSettings.VisibleCheck = Toggles.VisibleCheck.Value
end)
AimbotSec1:AddDropdown("TargetPart", {Text = "Target Part", Default = SilentAimSettings.TargetPart, Values = {"Head", "HumanoidRootPart", "Random"}}):OnChanged(function()
    SilentAimSettings.TargetPart = Options.TargetPart.Value
end)

AimbotSec1:AddSlider('HitChance', {Text = 'Hit chance', Default = 100, Min = 0, Max = 100, Rounding = 0, Compact = false,})
Options.HitChance:OnChanged(function()
    SilentAimSettings.HitChance = Options.HitChance.Value
end)

AimbotSec1:AddSlider("Radius", {Text = "FOV Circle Radius", Min = 0, Max = 360, Default = 130, Rounding = 0}):OnChanged(function()
    br_fov_circleout1.Radius = Options.Radius.Value + 1
    br_fov_circle.Radius = Options.Radius.Value
    br_fov_circleout2.Radius = Options.Radius.Value - 1
    
    SilentAimSettings.FOVRadius = Options.Radius.Value
end)

AimbotSec1:AddToggle('br_fov', {Text = 'Show FOV Circle', Default = false})
Toggles.br_fov:OnChanged(function()
    runService.RenderStepped:Connect(function()
    br_fov_circle.Visible = Toggles.br_fov.Value
    end)
end)
Toggles.br_fov:AddColorPicker('br_fovcolor', {Default = C3(255,255,255), Title = 'FOV Circle Color'})
Options.br_fovcolor:OnChanged(function()
    br_fov_circle.Color = Options.br_fovcolor.Value
end)
AimbotSec1:AddToggle('br_fovout', {Text = 'Circle Outline', Default = false})
Toggles.br_fovout:OnChanged(function()
    runService.RenderStepped:Connect(function() --// WHY A FUCKING LOOP I WANT TO KMS
    if Toggles.br_fov.Value == true and Toggles.br_fovout.Value == true then
       br_fov_circleout1.Visible = true
       br_fov_circleout2.Visible = true
    else
        br_fov_circleout1.Visible = false
        br_fov_circleout2.Visible = false
    end
    end)
end)

AimbotSec2:AddToggle('as_enabled', {Text = 'Enabled', Default = false})
Toggles.as_enabled:OnChanged(function()
   if Toggles.as_enabled.Value == true then
        as_loop = runService.RenderStepped:Connect(function()
            local pressed = userInput:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
            
            if pressed and IsAlive(localPlayer) then
                local Line = Drawing.new("Line")
                local curTar = getClosest(currentCamera.CFrame)
                local hbpos = currentCamera:WorldToScreenPoint(curTar.Character[AimSettings.Hitbox].Position)
                hbpos = Vec2(hbpos.X, hbpos.Y)
                if (hbpos - currentCamera.ViewportSize/2).Magnitude < AimSettings.Radius then
                    currentCamera.CFrame = currentCamera.CFrame:Lerp(CFrame.new(currentCamera.CFrame.Position, curTar.Character[AimSettings.Hitbox].Position), AimSettings.Smoothness)
                end
            end
        end)
    elseif Toggles.as_enabled.Value == false and as_loop then
        as_loop:Disconnect()
    end
end)
    
AimbotSec2:AddToggle('as_tc', {Text = 'Team Check', Default = false})
Toggles.as_tc:OnChanged(function()
   AimSettings.TeamCheck = Toggles.as_tc.Value
end)

--AimbotSec2:AddToggle('as_vis', {Text = 'Visible Check', Default = false})
--Toggles.as_vis:OnChanged(function()
--   AimSettings.VisibleCheck = Toggles.as_vis.Value
--end)

AimbotSec2:AddDropdown("as_hb", {Text = "Target Part", Default = AimSettings.Hitbox, Values = {"Head", "HumanoidRootPart"}}):OnChanged(function()
    AimSettings.Hitbox = Options.as_hb.Value
end)

AimbotSec2:AddSlider('as_smoothness', {Text = 'Smoothness', Default = 1, Min = 1, Max = 10, Rounding = 0, Compact = false})
Options.as_smoothness:OnChanged(function()
    AimSettings.Smoothness = Options.as_smoothness.Value/10
end)

AimbotSec2:AddSlider('as_radius', {Text = 'FOV', Default = 50, Min = 1, Max = 420, Rounding = 0, Compact = false})
Options.as_radius:OnChanged(function()
    AimSettings.Radius = Options.as_radius.Value
    
    as_fov_circleout1.Radius = Options.as_radius.Value - 1
    as_fov_circle.Radius = Options.as_radius.Value
    as_fov_circleout2.Radius = Options.as_radius.Value + 1
end)

AimbotSec2:AddToggle('as_fov', {Text = 'Show FOV Circle', Default = false})
Toggles.as_fov:OnChanged(function()
    runService.RenderStepped:Connect(function()
    as_fov_circle.Visible = Toggles.as_fov.Value
    end)
end)
Toggles.as_fov:AddColorPicker('as_fovcolor', {Default = C3(255,255,255), Title = 'FOV Circle Color'})
Options.as_fovcolor:OnChanged(function()
    as_fov_circle.Color = Options.as_fovcolor.Value
end)
AimbotSec2:AddToggle('as_fovout', {Text = 'Circle Outline', Default = false})
Toggles.as_fovout:OnChanged(function()
    runService.RenderStepped:Connect(function() --// WHY A FUCKING LOOP I WANT TO KMS
    if Toggles.as_fov.Value == true and Toggles.as_fovout.Value == true then
       as_fov_circleout1.Visible = true
       as_fov_circleout2.Visible = true
    else
        as_fov_circleout1.Visible = false
        as_fov_circleout2.Visible = false
    end
    end)
end)
--------------------------------------------------------------------------------------
ESPTab:AddToggle('espenabled', {Text = 'Enabled', Default = false})
Toggles.espenabled:OnChanged(function()
   esp.enabled = Toggles.espenabled.Value
end)

ESPTab:AddToggle('espbox', {Text = 'Box', Default = false})
Toggles.espbox:OnChanged(function()
   esp.settings.box.enabled = Toggles.espbox.Value
end)
Toggles.espbox:AddColorPicker('espboxcolor', {Default = C3(255,255,255), Title = 'Box Color'})
Options.espboxcolor:OnChanged(function()
    esp.settings.box.color = Options.espboxcolor.Value
end)

ESPTab:AddToggle('espnames', {Text = 'Names', Default = false})
Toggles.espnames:OnChanged(function()
   esp.settings.name.enabled = Toggles.espnames.Value
end)
Toggles.espnames:AddColorPicker('espnamescolor', {Default = C3(255,0,0), Title = 'Names Color'})
Options.espnamescolor:OnChanged(function()
    esp.settings.name.color = Options.espnamescolor.Value
end)

ESPTab:AddToggle('espboxfill', {Text = 'Box Fill', Default = false})
Toggles.espboxfill:OnChanged(function()
   esp.settings.boxfill.enabled = Toggles.espboxfill.Value
end)
Toggles.espboxfill:AddColorPicker('espboxfillcolor', {Default = C3(255,0,0), Title = 'Box Fill Color'})
Options.espboxfillcolor:OnChanged(function()
    esp.settings.boxfill.color = Options.espboxfillcolor.Value
end)

ESPTab:AddToggle('esphb', {Text = 'Health bar', Default = false})
Toggles.esphb:OnChanged(function()
   esp.settings.healthbar.enabled = Toggles.esphb.Value
end)

ESPTab:AddToggle('espht', {Text = 'Health text', Default = false})
Toggles.espht:OnChanged(function()
   esp.settings.healthtext.enabled = Toggles.espht.Value
end)
Toggles.espht:AddColorPicker('esphtcolor', {Default = C3(0,255,0), Title = 'Health Text Color'})
Options.esphtcolor:OnChanged(function()
    esp.settings.healthtext.color = Options.esphtcolor.Value
end)

ESPTab:AddToggle('espdistance', {Text = 'Distance', Default = false})
Toggles.espdistance:OnChanged(function()
   esp.settings.distance.enabled = Toggles.espdistance.Value
end)
Toggles.espdistance:AddColorPicker('espdistancecolor', {Default = C3(255,255,255), Title = 'Distance Color'})
Options.espdistancecolor:OnChanged(function()
    esp.settings.distance.color = Options.espdistancecolor.Value
end)

ESPSTab:AddToggle('espoutline', {Text = 'Outline', Default = false})
Toggles.espoutline:OnChanged(function()
    for i,v in pairs(esp.settings) do
        v.outline = Toggles.espoutline.Value
    end
end)

ESPSTab:AddToggle('espdisplay', {Text = 'Use Display Names', Default = false})
Toggles.espdisplay:OnChanged(function()
    esp.settings.name.displaynames = Toggles.espdisplay.Value
end)

ESPSTab:AddSlider('esptsize', {Text = 'Text Size', Default = 13, Min = 1, Max = 50, Rounding = 0, Compact = false})
Options.esptsize:OnChanged(function()
    esp.fontsize = Options.esptsize.Value
end)

ESPSTab:AddDropdown('espfont', {Values = {'UI', 'System', 'Plex', 'Monospace'}, Default = 2, Multi = false, Text = 'Font'})
Options.espfont:OnChanged(function()
    if Options.espfont.Value == 'UI' then
        esp.font = 0
    elseif Options.espfont.Value == 'System' then
        esp.font = 1
    elseif Options.espfont.Value == 'Plex' then
        esp.font = 2
    elseif Options.espfont.Value == 'Monospace' then
        esp.font = 3
    end
end)

LocalTab:AddToggle('local_thirdperson', {Text = 'Third Person', Default = false}):AddKeyPicker('local_thirdpersonbind', {Default = 'X', SyncToggleState = true, Mode = 'Toggle', Text = "Third Person", NoUI = false})
Toggles.local_thirdperson:OnChanged(function()
    if Toggles.local_thirdperson.Value == true then
        runService:BindToRenderStep("ThirdPerson", 100, function()
			if localPlayer.CameraMinZoomDistance ~= Options.local_thirdpersondist.Value then
				localPlayer.CameraMinZoomDistance = Options.local_thirdpersondist.Value
				localPlayer.CameraMaxZoomDistance = Options.local_thirdpersondist.Value
				workspace.ThirdPerson.Value = true
			end
		end)
	elseif Toggles.local_thirdperson.Value == false then
		runService:UnbindFromRenderStep("ThirdPerson")
		if IsAlive(localPlayer) then
			wait()
			workspace.ThirdPerson.Value = false
			localPlayer.CameraMinZoomDistance = 0
			localPlayer.CameraMaxZoomDistance = 0
		end
	end
end)
LocalTab:AddSlider('local_thirdpersondist', {Text = 'Distance', Default = 15, Min = 1, Max = 50, Rounding = 0, Compact = false}):OnChanged(function() end)

local selfchmams = LocalTab:AddToggle('local_selfchams', {Text = 'Self Chams', Default = false,})
Toggles.local_selfchams:OnChanged(function()
    while wait() do
        if not Toggles.local_selfchams.Value then break end
        if IsAlive(localPlayer) then
            local chams = Instance.new("Highlight", localPlayer.Character)
            chams.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            chams.FillColor = Options.selfchams_fill.Value
            chams.FillTransparency = 0.25
            chams.OutlineColor = Options.selfchams_outline.Value
            chams.FillTransparency = 0.5
        end
    end
end)
selfchmams:AddColorPicker('selfchams_fill', {Default = C3(0, 0, 255), Title = 'Fill Color'})
selfchmams:AddColorPicker('selfchams_outline', {Default = C3(0, 0, 0), Title = 'Outline Color'})

CamTab:AddToggle('cam_fovenabled', {Text = 'Override FOV', Default = false}):OnChanged(function() end)
CamTab:AddSlider('cam_fovvalue', {Text = 'FOV', Default = 70, Min = 60, Max = 120, Rounding = 0, Compact = false}):OnChanged(function() end)

CamTab:AddToggle('cam_sway', {Text = 'Disable Weapon Swaying', Default = false}):OnChanged(function() end)

CamTab:AddToggle('cam_forcecross', {Text = 'Force Crosshair', Default = false}):OnChanged(function() end)

CamTab:AddToggle('cam_flash', {Text = 'Remove Flash', Default = false})
Toggles.cam_flash:OnChanged(function()
    if Toggles.cam_flash.Value == true then
        localPlayer.PlayerGui.Blnd.Enabled = false
    elseif Toggles.cam_flash.Value == false then
        localPlayer.PlayerGui.Blnd.Enabled = true
    end
end)

CamTab:AddToggle('cam_smoke', {Text = 'Reduce Smoke', Default = false}):OnChanged(function() end)
CamTab:AddSlider('cam_smokereduce', {Text = 'Value', Default = 100, Min = 1, Max = 100, Rounding = 0, Compact = false}):OnChanged(function() end)
CamTab:AddLabel('Aura Color'):AddColorPicker('cam_smokeauracolor', {Default = C3(255, 0, 0), Title = 'Smoke Aura Color'})

VWTab:AddToggle('vw_enabled', {Text = 'Enabled', Default = false}):OnChanged(function() end)
local vmx = VWTab:AddSlider('vw_x', {Text = 'X', Default = 0, Min = -180, Max = 180, Rounding = 0, Compact = false}):OnChanged(function() end)
local vmy = VWTab:AddSlider('vw_y', {Text = 'Y', Default = 0, Min = -180, Max = 180, Rounding = 0, Compact = false}):OnChanged(function() end)
local vmz = VWTab:AddSlider('vw_z', {Text = 'Z', Default = 0, Min = -180, Max = 180, Rounding = 0, Compact = false}):OnChanged(function() end)
VWTab:AddButton('Reset Values', function() 
    vmx:SetValue(0)
    vmy:SetValue(0)
    vmz:SetValue(0)
end)

local ambienttog = WRLTab:AddToggle('wrl_ambient', {Text = 'Ambience', Default = false})
ambienttog:AddColorPicker('wrl_ambient1', {Default = C3(75, 58, 222), Title = 'Ambient'})
ambienttog:AddColorPicker('wrl_ambient2', {Default = C3(109, 58, 206), Title = 'Outdoor'})

WRLTab:AddToggle('wrl_shadows', {Text = 'Shadow Map', Default = false})
Toggles.wrl_shadows:OnChanged(function()
    sethiddenproperty(lighting, "Technology", Toggles.wrl_shadows.Value and "ShadowMap" or "Legacy")
end)

WRLTab:AddToggle('wrl_forcetime', {Text = 'Force Time', Default = false}):OnChanged(function() end)
WRLTab:AddSlider('wrl_forcetimevalue', {Text = 'Time', Default = 12, Min = 0, Max = 24, Rounding = 0, Compact = false}):OnChanged(function() end)

WRLTab:AddToggle('wrl_saturation', {Text = 'Saturation', Default = false})
Toggles.wrl_saturation:OnChanged(function()
    if Toggles.wrl_saturation.Value == true then
        saturationeffect.Enabled = true
    elseif Toggles.wrl_saturation.Value == false then
        saturationeffect.Enabled = false
    end
end)
WRLTab:AddSlider('wrl_saturationvalue', {Text = 'Value', Default = 0, Min = 0, Max = 1, Rounding = 2, Compact = false})
Options.wrl_saturationvalue:OnChanged(function()
    saturationeffect.Saturation = Options.wrl_saturationvalue.Value
end)

WRLTab:AddToggle('wrl_skyboxenabled', {Text = 'Skybox', Default = false}):OnChanged(function() end)
WRLTab:AddDropdown('wrl_skyboxtype', {Values = {"Galaxy","Pink Sky","Sunset","Night","Evening"}, Default = 1, Multi = false, Text = 'Selected'})
Options.wrl_skyboxtype:OnChanged(function()
    if Toggles.wrl_skyboxenabled.Value == true then
        local pepsisky = lighting:FindFirstChild("pepsisky") or Instance.new("Sky")
        pepsisky.Parent = game.Lighting
        pepsisky.Name = "pepsisky"
        pepsisky.SkyboxBk = SkyboxesTable[Options.wrl_skyboxtype.Value].SkyboxBk
        pepsisky.SkyboxDn = SkyboxesTable[Options.wrl_skyboxtype.Value].SkyboxDn
        pepsisky.SkyboxFt = SkyboxesTable[Options.wrl_skyboxtype.Value].SkyboxFt
        pepsisky.SkyboxLf = SkyboxesTable[Options.wrl_skyboxtype.Value].SkyboxLf
        pepsisky.SkyboxRt = SkyboxesTable[Options.wrl_skyboxtype.Value].SkyboxRt
        pepsisky.SkyboxUp = SkyboxesTable[Options.wrl_skyboxtype.Value].SkyboxUp
    else
        if game.Lighting:FindFirstChild("pepsisky") then
            game.Lighting.pepsisky:Destroy()
        end
    end
end)

local mespbombtog = MiscESPTab:AddToggle('mesp_bomb', {Text = 'Bomb', Default = false})
mespbombtog:AddColorPicker('mesp_bombcolor', {Default = C3(255, 0, 0), Title = 'Color'})

local mespweapontog = MiscESPTab:AddToggle('mesp_weapons', {Text = 'Weapon', Default = false})
mespweapontog:AddColorPicker('mesp_weaponscolor', {Default = C3(88, 124, 220), Title = 'Color'})

--[[local mespnadetog = MiscESPTab:AddToggle('mesp_nades', {Text = 'Grenade', Default = false})
mespnadetog:AddColorPicker('mesp_nadescolor', {Default = C3(75, 58, 222), Title = 'Color'})]]

MiscTab:AddToggle('misc_molly', {Text = 'Visualize Molly Radius', Default = false})
Toggles.misc_molly:OnChanged(function()
    if Toggles.misc_molly.Value == true then 
        for i, molly in pairs(rayignore:FindFirstChild("Fires"):GetChildren()) do 
            molly.Transparency = 0
            molly.Color = Options.misc_mollycolor.Value
        end 
    else 
        for i, molly in pairs(rayignore:FindFirstChild("Fires"):GetChildren()) do 
            molly.Transparency = 1 
        end 
    end
end)
MiscTab:AddLabel('Color'):AddColorPicker('misc_mollycolor', {Default = C3(255, 0, 0), Title = 'Molly Color'})

local blurvalue = 50
local lv = Vector3.zero

runService.RenderStepped:Connect(function()
	local x,y,z = currentCamera.CFrame:ToEulerAnglesXYZ()
	x,y,z = math.deg(x),math.deg(y),math.deg(z)
	
	Blur.Size = math.clamp((Vec3(x,y,z)-lv).Magnitude/2,2,10 + blurvalue)
	lv = Vec3(x,y,z)
end)
MiscTab:AddToggle('misc_motionenabled', {Text = 'Motion Blur', Default = false})
Toggles.misc_motionenabled:OnChanged(function()
    Blur.Enabled = Toggles.misc_motionenabled.Value
end)
MiscTab:AddSlider('misc_motionvalue', {Text = 'Size', Default = 50, Min = 1, Max = 100, Rounding = 0, Compact = false})
Options.misc_motionvalue:OnChanged(function()
    blurvalue = Options.misc_motionvalue.Value
end)

ArmsTab:AddToggle('arms_chams', {Text = 'Enabled', Default = false})
local armschamstog = ArmsTab:AddToggle('arms_armschams', {Text = 'Arms Chams', Default = false})
armschamstog:AddColorPicker('arms_armschamscolor', {Default = C3(255, 0, 0), Title = 'Arm Color'})
Options.arms_armschamscolor:OnChanged(function()
    retardarmschams = Options.arms_armschamscolor.Value
end)
ArmsTab:AddDropdown('arms_armschamstexture', {Values = {"Swirl","Scan","Grid","Spiral"}, Default = 1, Multi = false, Text = 'Weapon Texture'})
Options.arms_armschamstexture:OnChanged(function()
    if Options.arms_armschamstexture.Value == "Swirl" then
        armschamstexture = 414144526
    elseif Options.arms_armschamstexture.Value == "Scan" then
        armschamstexture = 10203921
    elseif Options.arms_armschamstexture.Value == "Grid" then
        armschamstexture = 2167505061
    elseif Options.arms_armschamstexture.Value == "Spiral" then
        armschamstexture = 159534680
    end
end)

local weaponchamstog = ArmsTab:AddToggle('arms_weaponchams', {Text = 'Weapon Chams', Default = false})
weaponchamstog:AddColorPicker('arms_weaponchamscolor', {Default = C3(255, 0, 0), Title = 'Arm Color'})
ArmsTab:AddDropdown('arms_weaponchamstexture', {Values = {"Swirl","Scan","Grid","Spiral"}, Default = 1, Multi = false, Text = 'Weapon Texture'})
Options.arms_weaponchamstexture:OnChanged(function()
    if Options.arms_weaponchamstexture.Value == "Swirl" then
        weaponchamstexture = 414144526
    elseif Options.arms_weaponchamstexture.Value == "Scan" then
        weaponchamstexture = 10203921
    elseif Options.arms_weaponchamstexture.Value == "Grid" then
        weaponchamstexture = 2167505061
    elseif Options.arms_weaponchamstexture.Value == "Spiral" then
        weaponchamstexture = 159534680
    end
end)


BulletsTab:AddToggle('bullets_btenabled', {Text = 'Bullet Tracer', Default = false}):OnChanged(function() end)
BulletsTab:AddSlider('bullets_bttime', {Text = 'Tracers Life Time', Default = 2, Min = 1, Max = 10, Rounding = 0, Compact = false}):OnChanged(function() end)
BulletsTab:AddLabel('Tracer Color'):AddColorPicker('bullets_btcolor', {Default = C3(255, 0, 0), Title = 'Tracer Color'})
BulletsTab:AddDropdown('bullets_bttexture', {Values = {"Lightning","Laser 1","Laser 2","Energy"}, Default = 1, Multi = false, Text = 'Tracer Texture'})
Options.bullets_bttexture:OnChanged(function()
    if Options.bullets_bttexture.Value == "Lightning" then
        bullettracerstexture = 446111271
    elseif Options.bullets_bttexture.Value == "Laser 1" then
        bullettracerstexture = 7136858729
    elseif Options.bullets_bttexture.Value == "Laser 2" then
        bullettracerstexture = 6333823534
    elseif Options.bullets_bttexture.Value == "Energy" then
        bullettracerstexture = 5864341017
    end
end)

BulletsTab:AddToggle('bullets_impactenabled', {Text = 'Bullet Impact', Default = false}):OnChanged(function() end)
BulletsTab:AddLabel('Impact Color'):AddColorPicker('bullets_impactenabledcolor', {Default = C3(0, 0, 255), Title = 'Impact Color'})
BulletsTab:AddSlider('bullets_impacttime', {Text = 'Impact Life Time', Default = 3, Min = 1, Max = 10, Rounding = 0, Compact = false}):OnChanged(function() end)
--------------------------------------------------------------------------------------
MiscSec1:AddToggle('misc_watermark', {Text = 'Watermark', Default = false}):AddColorPicker('misc_watermarkcolor', {Default = C3(2, 103, 172), Title = 'Watermark Color'})
Toggles.misc_watermark:OnChanged(function()
    runService.RenderStepped:Connect(function() --// WHY THE FUCK DO I HAVE TO MAKE THIS A LOOP
        watermark.Enabled = Toggles.misc_watermark.Value
    end)
end)
Options.misc_watermarkcolor:OnChanged(function()
    WatermarkColor.BackgroundColor3 = Options.misc_watermarkcolor.Value
end)

MiscSec1:AddToggle('misc_binds', {Text = 'Show Keybinds List', Default = false})
Toggles.misc_binds:OnChanged(function()
    Library.KeybindFrame.Visible = Toggles.misc_binds.Value
end)

MiscSec1:AddToggle('misc_spectlist', {Text = 'Show Spectators List', Default = false}):AddColorPicker('misc_spectlistcolor', {Default = C3(2, 103, 172), Title = 'List Color'})
Toggles.misc_spectlist:OnChanged(function()
    runService.RenderStepped:Connect(function() --// WHY THE FUCK DO I HAVE TO MAKE THIS A LOPOP
        SpectatorViewer.Enabled = Toggles.misc_spectlist.Value
    end)
end)
Options.misc_spectlistcolor:OnChanged(function()
    SpectColor.BackgroundColor3 = Options.misc_spectlistcolor.Value
end)

MiscSec1:AddToggle('misc_killers', {Text = 'Remove Killers', Default = false})
Toggles.misc_killers:OnChanged(function()
    pcall(function()
        local Clips = workspace.Map.Clips; Clips.Name = "FAT"; Clips.Parent = nil
        local Killers = workspace.Map.Killers; Killers.Name = "FAT"; Killers.Parent = nil
        if Toggles.misc_killers.Value == true then
            for i,v in pairs(Clips:GetChildren()) do
                if v:IsA("BasePart") then
                    v:Remove()
                end
            end
            for i,v in pairs(Killers:GetChildren()) do
                if v:IsA("BasePart") then
                    v:Remove()
                end
            end
        end
        Killers.Name = "Killers"; Killers.Parent = workspace.Map
        Clips.Name = "Clips"; Clips.Parent = workspace.Map
    end)
end)

MiscSec1:AddToggle('misc_oldsounds', {Text = 'Old Gun Sounds', Default = false})
Toggles.misc_spectlist:OnChanged(function()
    if Toggles.misc_oldsounds.Value == true then
        OldSounds = runService.RenderStepped:Connect(function()
            pcall(function()
                if localPlayer.Character.EquippedTool.Value == "AK47" then
                    localPlayer.Character.Gun.Shoot.SoundId = "rbxassetid://1112730119"
                end
                if localPlayer.Character.EquippedTool.Value == "M4A1" then
                    localPlayer.Character.Gun.SShoot.SoundId = "rbxassetid://1665639883"
                    localPlayer.Character.Gun.Shoot.SoundId = "rbxassetid://2515498997"
                end
                if localPlayer.Character.EquippedTool.Value == "Glock" then
                    localPlayer.Character.Gun.Shoot.SoundId = "rbxassetid://1112951656"
                end
                if localPlayer.Character.EquippedTool.Value == "Galil" then
                    localPlayer.Character.Gun.Shoot.SoundId = "rbxassetid://344800912"
                end
                if localPlayer.Character.EquippedTool.Value == "USP" then
                    localPlayer.Character.Gun.SShoot.SoundId = "rbxassetid://1112952739"
                    localPlayer.Character.Gun.Shoot.SoundId = "rbxassetid://2515499360"
                end
                if localPlayer.Character.EquippedTool.Value == "P2000" then
                    localPlayer.Character.Gun.Shoot.SoundId = "rbxassetid://263589107"
                end
                if  localPlayer.Character.EquippedTool.Value == "P250" then
                    localPlayer.Character.Gun.Shoot.SoundId = "rbxassetid://340365431"
                end
                if localPlayer.Character.EquippedTool.Value == "DesertEagle" then
                    localPlayer.Character.Gun.Shoot.SoundId = "rbxassetid://202918645"
                end
                if localPlayer.Character.EquippedTool.Value == "MP9" then
                    localPlayer.Character.Gun.Shoot.SoundId = "rbxassetid://222888810"
                end
                if localPlayer.Character.EquippedTool.Value == "UMP" then
                    localPlayer.Character.Gun.Shoot.SoundId = "rbxassetid://206953341"
                end
                if localPlayer.Character.EquippedTool.Value == "Famas" then
                    localPlayer.Character.Gun.Shoot.SoundId = "rbxassetid://206953280"
                end
                if localPlayer.Character.EquippedTool.Value == "Scout" then
                    localPlayer.Character.Gun.Shoot.SoundId = "rbxassetid://1112858108"
                end
                if localPlayer.Character.EquippedTool.Value == "AUG" then
                    localPlayer.Character.Gun.Shoot.SoundId = "rbxassetid://515215839"
                end
                if localPlayer.Character.EquippedTool.Value == "AWP" then
                    localPlayer.Character.Gun.Shoot.SoundId = "rbxassetid://202918637"
                end
                if localPlayer.Character.EquippedTool.Value == "G3SG1" then
                    localPlayer.Character.Gun.Shoot.SoundId = "rbxassetid://340365815"
                end
                if localPlayer.Character.EquippedTool.Value == "SG" then
                    localPlayer.Character.Gun.Shoot.SoundId = "rbxassetid://347270113"
                end
                if localPlayer.Character.EquippedTool.Value == "M4A4" then
                    localPlayer.Character.Gun.Shoot.SoundId = "rbxassetid://202918741"
                end
                if localPlayer.Character.EquippedTool.Value == "Tec9" then
                    localPlayer.Character.Gun.Shoot.SoundId = "rbxassetid://206953317"
                end
            end)
        end)
    elseif Toggles.misc_oldsounds.Value == false and OldSounds then
        OldSounds:Disconnect()
    end
end)

MiscSec1:AddToggle('misc_lastvk', {Text = 'Rejoin on Last VK', Default = false})
Toggles.misc_lastvk:OnChanged(function()
    if Toggles.misc_lastvk.Value == true then
        game.ReplicatedStorage.Events.SendMsg.OnClientEvent:Connect(function(message)
            local msg = string.split(message, " ")
            if game.Players:FindFirstChild(msg[1]) and msg[7] == "1" and msg[12] == game.Players.LocalPlayer.Name then
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
            end
        end)
    end
end)

--[[MiscSec1:AddToggle('misc_spam', {Text = 'Spam Chat', Default = false})
Toggles.misc_spam:OnChanged(function()
    
end)
MiscSec1:AddDropdown('misc_spamtype', {Values = {'Ownage', 'Wow', "Skeet", "Godlike"}, Default = 1, Multi = false, Text = 'Spam Type'})
Options.misc_spamtype:OnChanged(function()
    if Options.misc_spamtype.Value == "Ownage" then
        ebsfx = 6887181639
    elseif Options.misc_spamtype.Value == "Wow" then
        ebsfx = 7872233648
    elseif Options.misc_spamtype.Value == "Skeet" then
        ebsfx = 5447626464
    elseif Options.misc_spamtype.Value == "Godlike" then
        ebsfx = 7463103082
    end
end)]]

MiscSec2:AddToggle('mov_bhop', {Text = 'Bunny Hop', Default = false})
Toggles.mov_bhop:OnChanged(function()
    if Toggles.mov_bhop.Value == true then
        BunnyHopLoop = runService.RenderStepped:Connect(function()
            if localPlayer.PlayerGui.GUI.Main.GlobalChat.Visible == false then
                if IsAlive(localPlayer) and userInput:IsKeyDown(Enum.KeyCode.Space) then
                    localPlayer.Character.Humanoid.Jump = true
                    local speed = Options.mov_bhopspeed.Value
                    local dir = currentCamera.CFrame.LookVector * Vec3(1,0,1)
                    local move = Vec3()
                    move = userInput:IsKeyDown(Enum.KeyCode.W) and move + dir or move
                    move = userInput:IsKeyDown(Enum.KeyCode.S) and move - dir or move
                    move = userInput:IsKeyDown(Enum.KeyCode.D) and move + Vec3(-dir.Z,0,dir.X) or move
                    move = userInput:IsKeyDown(Enum.KeyCode.A) and move + Vec3(dir.Z,0,-dir.X) or move
                    if move.Unit.X == move.Unit.X then
                        move = move.Unit
                        localPlayer.Character.HumanoidRootPart.Velocity = Vec3(move.X * speed, localPlayer.Character.HumanoidRootPart.Velocity.Y, move.Z * speed)
                    end
                end
            end
        end)
    elseif Toggles.mov_bhop.Value == false and BunnyHopLoop then
        BunnyHopLoop:Disconnect()
    end
end)
MiscSec2:AddSlider('mov_bhopspeed', {Text = 'Bhop Speed', Default = 25, Min = 1, Max = 150, Rounding = 0, Compact = false})

local ebtog = MiscSec2:AddToggle('mov_edgebug', {Text = 'Edgebug', Default = false})
Toggles.mov_edgebug:OnChanged(function()
    ebenabled = Toggles.mov_edgebug.Value
end)

--ebtog:AddKeyPicker('mov_edgebugbind', {Default = 'E', Mode = 'Hold', SyncToggleState = true, Text = 'Edgebug', NoUI = false})
MiscSec2:AddLabel('Keybind'):AddKeyPicker('mov_edgebugbind', {Default = 'E', Mode = 'Hold', Text = 'Edgebug', NoUI = false})
Options.mov_edgebugbind:SetValue({ 'E', 'Hold' })

MiscSec2:AddToggle('mov_edgebugsound', {Text = 'Edgebug Sound', Default = false}):OnChanged(function() end)
MiscSec2:AddDropdown('eb_soundtype', {Values = {'Ownage', 'Wow', "Skeet", "Godlike"}, Default = 1, Multi = false, Text = 'Edgebug Sound'})
Options.eb_soundtype:OnChanged(function()
    if Options.eb_soundtype.Value == "Ownage" then
        ebsfx = 6887181639
    elseif Options.eb_soundtype.Value == "Wow" then
        ebsfx = 7872233648
    elseif Options.eb_soundtype.Value == "Skeet" then
        ebsfx = 5447626464
    elseif Options.eb_soundtype.Value == "Godlike" then
        ebsfx = 7463103082
    end
end)

MiscSec2:AddToggle('mov_jumpbug', {Text = 'Jumpbug', Default = false})
Toggles.mov_jumpbug:OnChanged(function()
end)
MiscSec2:AddLabel('Keybind'):AddKeyPicker('mov_jumpbugbind', {Default = 'R', Mode = 'Hold', Text = 'Edgebug', NoUI = false})
Options.mov_jumpbugbind:SetValue({ 'R', 'Hold' })

MiscSec2:AddToggle('mov_keystrokes', {Text = 'Keystrokes', Default = false})
Toggles.mov_keystrokes:OnChanged(function()
    runService.RenderStepped:Connect(function()
    keystrokesGui.Enabled = Toggles.mov_keystrokes.Value
    end)
end)
Toggles.mov_keystrokes:AddColorPicker('mov_keystrokescolor', {Default = C3(255, 255, 255), Title = 'Keystrokes Color'})
Options.mov_keystrokescolor:OnChanged(function()
    W.TextColor3 = Options.mov_keystrokescolor.Value
    A.TextColor3 = Options.mov_keystrokescolor.Value
    S.TextColor3 = Options.mov_keystrokescolor.Value
    D.TextColor3 = Options.mov_keystrokescolor.Value
    E.TextColor3 = Options.mov_keystrokescolor.Value
    R.TextColor3 = Options.mov_keystrokescolor.Value
    Space.TextColor3 = Options.mov_keystrokescolor.Value
end)

MiscSec2:AddToggle('mov_edgebugc', {Text = 'Edgebug Counter', Default = false})
Toggles.mov_edgebugc:OnChanged(function()
    ebcounter.Visible = Toggles.mov_edgebugc.Value
end)

MiscSec2:AddToggle('mov_edgebugchat', {Text = 'Show Edgebug Message', Default = false})
Toggles.mov_edgebugchat:OnChanged(function()
    ebenabled = Toggles.mov_edgebugchat.Value
end)

MiscSec2:AddToggle('mov_graph', {Text = 'Velocity Graph', Default = false}):AddColorPicker('mov_graphcolor', {Default = C3(255, 255, 255), Title = 'Graph Color'})
Toggles.mov_graph:OnChanged(function()
    while Toggles.mov_graph.Value do wait()
        local normalY = currentCamera.ViewportSize.Y-90
        local velocity = IsAlive(localPlayer) and math.floor(math.clamp((localPlayer.Character.HumanoidRootPart.Velocity * Vec3(1,0,1)).magnitude*14.85,0,400)) or 0
        if Toggles.mov_graph.Value then
            local width = 2
            local line = Drawing.new("Line")
            table.insert(graphLines, line)
            line.From = Vec2(currentCamera.ViewportSize.X/2 + 98, lastPos)
            line.To = Vec2(currentCamera.ViewportSize.X/2 + 100, normalY - (velocity/6.5))
            line.Thickness = 1
            line.Transparency = 1
            line.Color = Color3.new(1,1,1)
            line.Visible = true
            if #graphLines > 1 then
                if #graphLines > 110 then
                    graphLines[1]:Remove()
                    table.remove(graphLines,1)
                    for i = 2,8 do
                        graphLines[i].Transparency = i/10
                    end
                    local count = 0
                    for i=110,110-6,-1 do
                        count = count + 1
                        graphLines[i].Transparency = count/10
                    end
                    graphLines[110-7].Transparency = 1
                end
                for i,v in ipairs(graphLines) do
                    v.To = v.To - Vec2(2,0)
                    v.From = v.From - Vec2(2,0)
                    v.Color = Options.mov_graphcolor.Value
                end
            end
            lastPos = line.To.Y
            VelocityCounter.Visible = true
            VelocityCounter.Text = tostring(velocity)
        end
    end
end)

MiscSec3:AddToggle('tweaks_fire', {Text = 'No Fire Damage', Default = false}):OnChanged(function() end)
MiscSec3:AddToggle('tweaks_fall', {Text = 'No Fall Damage', Default = false}):OnChanged(function() end)

MiscSec3:AddToggle('tweaks_cash', {Text = 'Infinite Cash', Default = false})
Toggles.tweaks_cash:OnChanged(function()
    if Toggles.tweaks_cash.Value == true then
        runService:BindToRenderStep("inf_cash", 100, function()
            localPlayer.Cash.Value = 16000
		end)
	elseif Toggles.tweaks_cash.Value == false and inf_cash then
		runService:UnbindFromRenderStep("inf_cash")
	end
end)

MiscSec3:AddToggle('tweaks_duck', {Text = 'Infinite Duck', Default = false})
Toggles.tweaks_duck:OnChanged(function()
    if Toggles.tweaks_duck.Value == true then
		runService:BindToRenderStep("Stamina", 100, function()
			if cbClient.crouchcooldown ~= 0 then
				cbClient.crouchcooldown = 0
			end
		end)
	elseif Toggles.tweaks_duck.Value == false and Stamina then
		runService:UnbindFromRenderStep("Stamina")
	end
end)

MiscSec4:AddToggle('hit_hitsound', {Text = 'Hit Sound', Default = false})
MiscSec4:AddDropdown('hit_hitsoundtype', {Values = {'Bameware', 'Bell', 'Bubble', 'Pick', 'Pop', 'Rust', 'Skeet', 'Neverlose', 'Minecraft'}, Default = 1, Multi = false, Text = 'Hit Sound Type'})
Options.hit_hitsoundtype:OnChanged(function()
    if Options.hit_hitsoundtype.Value == "Bameware" then
        HitSoundType = 3124331820
    elseif Options.hit_hitsoundtype.Value == "Bell" then
        HitSoundType = 6534947240
    elseif Options.hit_hitsoundtype.Value == "Bubble" then
        HitSoundType = 6534947588
    elseif Options.hit_hitsoundtype.Value == "Pick" then
        HitSoundType = 1347140027    
    elseif Options.hit_hitsoundtype.Value == "Pop" then
        HitSoundType = 198598793
    elseif Options.hit_hitsoundtype.Value == "Rust" then
        HitSoundType = 1255040462 
    elseif Options.hit_hitsoundtype.Value == "Skeet" then
        HitSoundType = 5633695679
    elseif Options.hit_hitsoundtype.Value == "Neverlose" then
        HitSoundType = 6534948092
    elseif Options.hit_hitsoundtype.Value == "Minecraft" then
        HitSoundType = 4018616850
    end
end)

MiscSec4:AddToggle('hit_killsound', {Text = 'Kill Sound', Default = false})
MiscSec4:AddDropdown('hit_killsoundtype', {Values = {'1 Sit', 'UltraKill', 'Minecraft'}, Default = 1, Multi = false, Text = 'Kill Sound Type'})
Options.hit_hitsoundtype:OnChanged(function()
    if Options.hit_hitsoundtype.Value == "1 Sit" then
        KillSoundType = 5902468562
    elseif Options.hit_hitsoundtype.Value == "UltraKill" then
        KillSoundType = 937885646
    elseif Options.hit_hitsoundtype.Value == "Minecraft" then
        KillSoundType = 6705984236
    end
end)

MiscSec4:AddToggle('hit_hitmarker', {Text = 'Hit Marker', Default = false}):AddColorPicker('hit_hitmarkercolor', {Default = C3(255, 255, 255), Title = 'Hit Marker Color'})
MiscSec4:AddToggle('hit_killsay', {Text = 'Kill Say', Default = false})
MiscSec4:AddInput('killsay_msg', {Default = 'sit', Numeric = false, Finished = false, Text = 'Message', Placeholder = 'Message'})

MiscSec5:AddToggle('others_killall', {Text = 'Kill All', Default = false})
Toggles.others_killall:OnChanged(function()
    if Toggles.others_killall.Value == true then
        KillAllLoop = runService.RenderStepped:Connect(function()
            pcall(function()
                for i,v in pairs(players:GetChildren()) do
					if v.Character and v.Character.Humanoid.Health > 0 and localPlayer.Character.EquippedTool and v.Team ~= localPlayer.Team then
						local Arguments = {
							[1] = v.Character.Head,
							[2] = v.Character.Head.Position,
							[3] = localPlayer.Character.EquippedTool.Value,
							[4] = 100,
							[5] = localPlayer.Character.Gun,
							[8] = 10, -- Damage Multiplier
							[9] = false,
							[10] = false, -- Is Wallbang
							[11] = Vec3(),
							[12] = 100,
							[13] = Vec3()
						}
						game.ReplicatedStorage.Events.HitPart:FireServer(unpack(Arguments))
					end
				end
			end)
		end)
	elseif Toggles.others_killall.Value == false and KillAllLoop then
		KillAllLoop:Disconnect()
	end
end)

MiscSec5:AddButton('Crash Server', function() 
    if not IsAlive(localPlayer) then
        Library:Notify('Waiting until you respawn. . .');
        repeat wait(1) until IsAlive(localPlayer)
    end
    Library:Notify('Crashing server. . .');
    while true do
        pcall(function()
            runService.RenderStepped:Wait()
            for i = 1,100,1 do
                game:GetService("ReplicatedStorage").Events.DropMag:FireServer(localPlayer.Character.Gun.Mag)
            end
        end)
    end
end)

MiscSec5:AddButton('Anti Blood Lag', function() 
    local senv = getsenv(localPlayer.PlayerGui.Client)senv.splatterBlood = function() end
end)

MiscSec6:AddToggle('mod_spread', {Text = 'No Spread', Default = false})
MiscSec6:AddToggle('mod_recoil', {Text = 'No Recoil', Default = false})
Toggles.mod_recoil:OnChanged(function()
    if Toggles.mod_recoil.Value == true then
		runService:BindToRenderStep("NoRecoil", 100, function()
			cbClient.resetaccuracy()
			cbClient.RecoilX = 0
			cbClient.RecoilY = 0
		end)
	elseif Toggles.mod_recoil.Value == false and NoRecoil then
		runService:UnbindFromRenderStep("NoRecoil")
	end
end)
--------------------------------------------------------------------------------------
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })

Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings() 

SaveManager:SetIgnoreIndexes({ 'MenuKeybind' }) 

ThemeManager:SetFolder('pepsi.club')
SaveManager:SetFolder('pepsi.club/main')

SaveManager:BuildConfigSection(Tabs['UI Settings']) 

ThemeManager:ApplyToTab(Tabs['UI Settings'])

local OthersSettings = Tabs['UI Settings']:AddRightGroupbox('Others')

OthersSettings:AddInput('uinamechange', {Default = 'pepsi.club', Numeric = false, Finished = false, Text = 'Window Title', Tooltip = 'Changes window title', Placeholder = '. . .'})
Options.uinamechange:OnChanged(function()
    Window:SetWindowTitle(Options.uinamechange.Value)
end)

OthersSettings:AddSlider('sett_fpscap', {Text = 'FPS Cap', Default = 60, Min = 1, Max = 500, Rounding = 0, Compact = false})
Options.sett_fpscap:OnChanged(function()
    setfpscap(Options.sett_fpscap.Value)
end)

OthersSettings:AddDivider()

OthersSettings:AddButton('Rejoin', function() 
    local ts = game:GetService("TeleportService")
    local p = game:GetService("Players").LocalPlayer
    ts:Teleport(game.PlaceId, p)
end)

OthersSettings:AddButton('Copy Game Invite', function() 
    setclipboard("Roblox.GameLauncher.joinGameInstance("..game.PlaceId..", "..game.JobId.."')")
end)
------------------------------------ HOOK ------------------------------------
local BeamPart = Instance.new("Part", workspace)

BeamPart.Name = "BeamPart"
BeamPart.Transparency = 1

function createBeam(v1, v2)
    local colorSequence = CNew({
    ColorSequenceKeypoint.new(0, Options.bullets_btcolor.Value),
    ColorSequenceKeypoint.new(1, Options.bullets_btcolor.Value),
    })
    -- main part
    local Part = Instance.new("Part", BeamPart)
    Part.Size = Vec3(1, 1, 1)
    Part.Transparency = 1
    Part.CanCollide = false
    Part.CFrame = CFrame.new(v1)
    Part.Anchored = true
    -- attachment
    local Attachment = Instance.new("Attachment", Part)
    -- part 2
    local Part2 = Instance.new("Part", BeamPart)
    Part2.Size = Vec3(1, 1, 1)
    Part2.Transparency = 1
    Part2.CanCollide = false
    Part2.CFrame = CFrame.new(v2)
    Part2.Anchored = true
    Part2.Color = C3(255, 255, 255)
    -- another attachment
    local Attachment2 = Instance.new("Attachment", Part2)
    -- beam
    local Beam = Instance.new("Beam", Part)
    Beam.FaceCamera = true
    Beam.Color = colorSequence
    Beam.Attachment0 = Attachment
    Beam.Attachment1 = Attachment2
    Beam.LightEmission = 6
    Beam.LightInfluence = 1
    Beam.Width0 = 1
    Beam.Width1 = 0.6
    Beam.Texture = "rbxassetid://"..bullettracerstexture
    Beam.LightEmission = 1
    Beam.LightInfluence = 1
    Beam.TextureMode = Enum.TextureMode.Wrap -- wrap so length can be set by TextureLength
    Beam.TextureLength = 3 -- repeating texture is 1 stud long 
    Beam.TextureSpeed = 3
    delay(Options.bullets_bttime.Value, function()
    for i = 0.5, 1, 0.02 do
    wait()
    Beam.Transparency = NumberSequence.new(i)
    end
    Part:Destroy()
    Part2:Destroy()
    end)
end

function CreateBulletImpact(pos)
    local BulletImpacts = Instance.new("Part")
	BulletImpacts.Anchored = true
	BulletImpacts.CanCollide = false
	BulletImpacts.Material = "ForceField"
	BulletImpacts.Color = Options.bullets_impactenabledcolor.Value
	BulletImpacts.Size = Vec3(0.25, 0.25, 0.25)
	BulletImpacts.Position = pos
	BulletImpacts.Name = "BulletImpacts"
	BulletImpacts.Parent = currentCamera
	wait(Options.bullets_impacttime.Value)
	BulletImpacts:Destroy()
end

local hookJp = nil
local meta = getrawmetatable(game)
setreadonly(meta, false)
local oldNamecall = meta.__namecall
local oldNewindex = meta.__newindex
local oldIndex = meta.__index
local oldNamecall = meta.__namecall

setreadonly(meta, false)

meta.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local callingscript = getcallingscript()
    local args = {...}
	
	if not checkcaller() then
        if method == "SetPrimaryPartCFrame" and self.Name == "Arms" and Toggles.vw_enabled.Value == true then
			args[1] = args[1] * CFrame.new(Vec3(math.rad(Options.vw_x.Value-0), math.rad(Options.vw_y.Value-0), math.rad(Options.vw_z.Value-0)))
		elseif method == "InvokeServer" and self.Name == "Moolah" then
			return wait(99e99)
		elseif self.Name == "BURNME" and Toggles.tweaks_fire.Value == true then
            return
		elseif self.Name == "FallDamage" and Toggles.tweaks_fall.Value == true then
            return
		elseif method == "FireServer" and self.Name == "HitPart" then
			spawn(function()
				if Toggles.bullets_btenabled.Value == true then
					local beam = createBeam(workspace.Camera.Arms.Flash.CFrame.p, args[2])
				end
				if Toggles.bullets_impactenabled.Value == true then
                    CreateBulletImpact(args[2])
                end
			end)
		elseif method == "Kick" then
			return
		elseif method == "FireServer" and self.Name == "ControlTurn" and SECHS == true then
			return
		end
	end
	return oldNamecall(self, unpack(args))
end)
meta.__index = newcclosure(function(self, idx)
	if idx == "Value" then
        if (self.Name == "Spread" or self.Parent.Name == "Spread") and Toggles.mod_spread.Value then
			return 0
		elseif (self.Name == "AccuracyDivisor" or self.Name == "AccuracyOffset") and Toggles.mod_spread.Value then
			return 0.001
		end
	end
    if idx == "Velocity" and self.Parent == localPlayer.Character and Toggles.cam_sway.Value then
        return Vector3.zero
    end
    return oldIndex(self, idx)
end)
meta.__newindex = newcclosure(function(self,idx,val)
    if self.Name == "Crosshair" and idx == "Visible" and val == false and localPlayer.PlayerGui.GUI.Crosshairs.Scope.Visible == false and Toggles.cam_forcecross.Value == true then
        val = true
	end
    if idx == "JumpPower" and hookJp then
        val = 26
    end
    return oldNewindex(self,idx,val)
end)

-- hooks
--[[resume(create(function()
    RenderStepped:Connect(function()
        if Toggles.MousePosition.Value and Toggles.aim_Enabled.Value then
            if getClosestPlayer() then 
                local Root = getClosestPlayer().Parent.PrimaryPart or getClosestPlayer()
                local RootToViewportPoint, IsOnScreen = WorldToViewportPoint(Camera, Root.Position);
                -- using PrimaryPart instead because if your Target Part is "Random" it will flicker the square between the Target's Head and HumanoidRootPart (its annoying)
                
                mouse_box.Visible = IsOnScreen
                mouse_box.Position = Vec2(RootToViewportPoint.X, RootToViewportPoint.Y)
            else 
                mouse_box.Visible = false 
                mouse_box.Position = Vec2()
            end
        end
        
        if Toggles.Visible.Value then 
            fov_circle.Visible = Toggles.Visible.Value
            fov_circle.Color = Options.Color.Value
            fov_circle.Position = getMousePosition()
        end
    end)
end))]]

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local Method = getnamecallmethod()
    local Arguments = {...}
    local self = Arguments[1]
    local chance = CalculateChance(SilentAimSettings.HitChance)
    if Toggles.aim_Enabled.Value and self == workspace and not checkcaller() and chance == true then
        if Method == "FindPartOnRayWithIgnoreList" and SilentAimSettings.SilentAimMethod == Method then
            if ValidateArguments(Arguments, ExpectedArguments.FindPartOnRayWithIgnoreList) then
                local A_Ray = Arguments[2]

                local HitPart = getClosestPlayer()
                if HitPart then
                    local Origin = A_Ray.Origin
                    local Direction = getDirection(Origin, HitPart.Position)
                    Arguments[2] = Ray.new(Origin, Direction)

                    return oldNamecall(unpack(Arguments))
                end
            end
        end
    end
    return oldNamecall(...)
end))
------------------------------------ MAIN FUNC ------------------------------------
currentCamera.ChildAdded:Connect(function(new)
spawn(function()
	if new.Name == "Arms" and new:IsA("Model") and Toggles.arms_chams.Value == true then
		for i,v in pairs(new:GetChildren()) do
			if v:IsA("Model") and v:FindFirstChild("Right Arm") or v:FindFirstChild("Left Arm") then
				local RightArm = v:FindFirstChild("Right Arm") or nil
				local LeftArm = v:FindFirstChild("Left Arm") or nil
					
				local RightGlove = (RightArm and (RightArm:FindFirstChild("Glove") or RightArm:FindFirstChild("RGlove"))) or nil
				local LeftGlove = (LeftArm and (LeftArm:FindFirstChild("Glove") or LeftArm:FindFirstChild("LGlove"))) or nil
					
				local RightSleeve = RightArm and RightArm:FindFirstChild("Sleeve") or nil
				local LeftSleeve = LeftArm and LeftArm:FindFirstChild("Sleeve") or nil
				
				if Toggles.arms_armschams.Value == true then
					if RightArm ~= nil then
						RightArm.Mesh.TextureId = 'rbxassetid://'..armschamstexture
						RightArm.Transparency = 0
						RightArm.Color = retardarmschams
						RightArm.Material = 'ForceField'
					end
					if LeftArm ~= nil then
						LeftArm.Mesh.TextureId = 'rbxassetid://'..armschamstexture
						LeftArm.Transparency = 0
						LeftArm.Color = retardarmschams
						LeftArm.Material = 'ForceField'
					end
				end
				
				if Toggles.arms_armschams.Value == true then
					if RightGlove ~= nil then
						RightGlove.Mesh.TextureId = 'rbxassetid://'..armschamstexture
						RightGlove.Transparency = 0
						RightGlove.Color = retardarmschams
						RightGlove.Material = 'ForceField'
					end
					if LeftGlove ~= nil then
						LeftGlove.Mesh.TextureId = 'rbxassetid://'..armschamstexture
						LeftGlove.Transparency = 0
						LeftGlove.Color = retardarmschams
						LeftGlove.Material = 'ForceField'
					end
				end

				if Toggles.arms_armschams.Value == true then
					if RightSleeve ~= nil then
						RightSleeve.Mesh.TextureId = 'rbxassetid://'..armschamstexture
						RightSleeve.Transparency = 0
						RightSleeve.Color = retardarmschams
						RightSleeve.Material = "ForceField"
						RightSleeve.Material = 'ForceField'
					end
					if LeftSleeve ~= nil then
						LeftSleeve.Mesh.TextureId = 'rbxassetid://'..armschamstexture
						LeftSleeve.Transparency = 0
						LeftSleeve.Color = retardarmschams
						LeftSleeve.Material = "ForceField"
					end
				end
			elseif Toggles.arms_weaponchams.Value == true and v:IsA("BasePart") and not table.find({"Right Arm", "Left Arm", "Flash"}, v.Name) and v.Transparency ~= 1 then
				if v:IsA("MeshPart") then v.TextureID = 'rbxassetid://'..weaponchamstexture end
				if v:FindFirstChildOfClass("SpecialMesh") then v:FindFirstChildOfClass("SpecialMesh").TextureId = 'rbxassetid://'..weaponchamstexture end

				v.Transparency = 0
				v.Color = Options.arms_weaponchamscolor.Value
				v.Material = "ForceField"
			end
		end
	end
end)
end)

workspace.Debris.ChildAdded:Connect(function(child)
    if child:IsA("BasePart") and game.ReplicatedStorage.Weapons:FindFirstChild(child.Name) and Toggles.mesp_weapons.Value == true then
        wait()
        
        local BillboardGui = Instance.new("BillboardGui")
        BillboardGui.Parent = child
        BillboardGui.Adornee = child
        BillboardGui.Active = true
        BillboardGui.AlwaysOnTop = true
        BillboardGui.LightInfluence = 1
        BillboardGui.Size = UDim2.new(0, 50, 0, 50)
            
        local TextLabelText = Instance.new("TextLabel")
		TextLabelText.Parent = BillboardGui
		TextLabelText.ZIndex = 2
		TextLabelText.BackgroundTransparency = 1
		TextLabelText.Size = UDim2.new(1, 0, 1, 0)
		TextLabelText.Font = Enum.Font.Code
		TextLabelText.TextColor3 = Options.mesp_weaponscolor.Value
		TextLabelText.TextStrokeTransparency = 0
		TextLabelText.TextSize = 14
		TextLabelText.TextYAlignment = Enum.TextYAlignment.Top
		TextLabelText.Text = "["..tostring(child.Name).."]"
	end
end)

workspace.ChildAdded:Connect(function(new)
    if new.Name == "C4" and new:IsA("Model") and Toggles.mesp_bomb.Value == true then
        local BombTimer = 40
        
        local BillboardGui = Instance.new("BillboardGui")
        BillboardGui.Parent = new
        BillboardGui.Adornee = new
        BillboardGui.Active = true
        BillboardGui.AlwaysOnTop = true
        BillboardGui.LightInfluence = 1
        BillboardGui.Size = UDim2.new(0, 50, 0, 50)
            
        local TextLabelText = Instance.new("TextLabel")
		TextLabelText.Parent = BillboardGui
		TextLabelText.ZIndex = 2
		TextLabelText.BackgroundTransparency = 1
		TextLabelText.Size = UDim2.new(1, 0, 1, 0)
		TextLabelText.Font = Enum.Font.Code
		TextLabelText.TextStrokeTransparency = 0
		TextLabelText.TextColor3 = Options.mesp_bombcolor.Value
		TextLabelText.TextStrokeColor3 = C3(0, 0, 0)
		TextLabelText.TextSize = 14
		TextLabelText.TextYAlignment = Enum.TextYAlignment.Top
		TextLabelText.Text = tostring(new.Name)
			
		local TextLabelBombTimer = Instance.new("TextLabel")
		TextLabelBombTimer.Parent = BillboardGui
		TextLabelBombTimer.ZIndex = 2
		TextLabelBombTimer.BackgroundTransparency = 1
		TextLabelBombTimer.Size = UDim2.new(1, 0, 1, 0)
		TextLabelBombTimer.Font = Enum.Font.Code
		TextLabelBombTimer.TextStrokeTransparency = 0
		TextLabelBombTimer.BackgroundTransparency = 1
		TextLabelBombTimer.TextColor3 = Options.mesp_bombcolor.Value
		TextLabelBombTimer.TextStrokeColor3 = C3(0, 0, 0)
		TextLabelBombTimer.TextSize = 14
		TextLabelBombTimer.TextYAlignment = Enum.TextYAlignment.Bottom
		TextLabelBombTimer.Text = tostring(BombTimer.. "/40")
			
		spawn(function()
            repeat
                wait(1)
                BombTimer = BombTimer - 1
                TextLabelBombTimer.Text = tostring(BombTimer.. "/40")
            until BombTimer == 0 or workspace.Status.RoundOver.Value == true
		end)
    end
end)

localPlayer.Status.Kills.Changed:Connect(function(val)
	if Toggles.hit_killsound.Value and val ~= 0 then
		local killsound = Instance.new("Sound")
		killsound.Parent = game:GetService("SoundService")
		killsound.SoundId = 'rbxassetid://'..KillSoundType
		killsound.Volume = 3
		killsound:Play()
	end
	
	if Toggles.hit_killsay.Value and val ~= 0 then
        game.ReplicatedStorage.Events.PlayerChatted:FireServer(Options.killsay_msg.Value, false, false, false, true)
    end
end)

localPlayer.Additionals.TotalDamage.Changed:Connect(function(val)
	if Toggles.hit_hitsound.Value and val ~= 0 then
		local hitsound = Instance.new("Sound")
		hitsound.Parent = game:GetService("SoundService")
		hitsound.SoundId = 'rbxassetid://'..HitSoundType
		hitsound.Volume = 3
		hitsound:Play()
	end

	if current == 0 then return end
	coroutine.wrap(function()
		if Toggles.hit_hitmarker.Value then
			local Line = Drawing.new("Line")
			local Line2 = Drawing.new("Line")
			local Line3 = Drawing.new("Line")
			local Line4 = Drawing.new("Line")

			local x, y = currentCamera.ViewportSize.X/2, currentCamera.ViewportSize.Y/2

			Line.From = Vec2(x + 4, y + 4)
			Line.To = Vec2(x + 10, y + 10)
			Line.Color = Options.hit_hitmarkercolor.Value
			Line.Visible = true 

			Line2.From = Vec2(x + 4, y - 4)
			Line2.To = Vec2(x + 10, y - 10)
			Line2.Color = Options.hit_hitmarkercolor.Value
			Line2.Visible = true 

			Line3.From = Vec2(x - 4, y - 4)
			Line3.To = Vec2(x - 10, y - 10)
			Line3.Color = Options.hit_hitmarkercolor.Value
			Line3.Visible = true 

			Line4.From = Vec2(x - 4, y + 4)
			Line4.To = Vec2(x - 10, y + 10)
			Line4.Color = Options.hit_hitmarkercolor.Value
			Line4.Visible = true

			Line.Transparency = 1
			Line2.Transparency = 1
			Line3.Transparency = 1
			Line4.Transparency = 1

			Line.Thickness = 1
			Line2.Thickness = 1
			Line3.Thickness = 1
			Line4.Thickness = 1

			wait(0.3)
			for i = 1,0,-0.1 do
				wait()
				Line.Transparency = i 
				Line2.Transparency = i
				Line3.Transparency = i
				Line4.Transparency = i
			end
			Line:Remove()
			Line2:Remove()
			Line3:Remove()
			Line4:Remove()
		end
	end)()
end)

function mainfunc()
    if IsAlive(localPlayer) then
        local currentState = localPlayer.Character.Humanoid:GetState()
        hookJp = Toggles.mov_jumpbug.Value and isButtonDown(Enum.KeyCode[Options.mov_jumpbugbind.Value])
        if currentState == Enum.HumanoidStateType.Landed and userInput:IsKeyDown(Enum.KeyCode.Space) and Toggles.mov_bhop.Value then
            localPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
        
        if Toggles.cam_fovenabled.Value then
            currentCamera.FieldOfView = Options.cam_fovvalue.Value
        else
            currentCamera.FieldOfView = 70
        end
        
        if Toggles.mov_edgebug.Value and not ebCooldown and isButtonDown(Enum.KeyCode[Options.mov_edgebugbind.Value]) then
            if oldState == Enum.HumanoidStateType.Freefall and currentState == Enum.HumanoidStateType.Landed then
                ebCooldown = true
                ebtxt.Visible = true
                local dir = localPlayer.Character.HumanoidRootPart.Velocity
                for i=1,5 do wait()
                    localPlayer.Character.HumanoidRootPart.Velocity = (Vec3(1.2,0,1.2) * dir) - Vec3(0,15,0)
                end
                wait()
                localPlayer.Character.HumanoidRootPart.Velocity *= Vec3(1.8,5,1.8) -- Vec3(1.8,1,1.8)
                spawn(function()
                    if Toggles.mov_edgebugsound.Value == true then
                        local ebsound = Instance.new("Sound")
                        ebsound.Parent = game:GetService("SoundService")
                        ebsound.SoundId = "rbxassetid://"..ebsfx
                        ebsound.Volume = 3
                        ebsound:Play()
                    else
                        print("no")
                    end
                    
                    if Toggles.mov_edgebugchat.Value == true then
                        getsenv(localPlayer.PlayerGui.GUI.Main.Chats.DisplayChat).moveOldMessages()
                        getsenv(localPlayer.PlayerGui.GUI.Main.Chats.DisplayChat).createNewMessage(
                            "pepsi.club",
                            "edgebugged",
                            C3(2, 103, 172), 
                            Color3.new(1,1,1),
                            .01)
                    end
                    
                    ebcount = ebcount + 1
                    ebcounter.Text = "eb: "..ebcount..""
                    wait(0.075)
                    ebCooldown = false
                    ebtxt.Visible = false
                end)
                print(ebCooldown)
            end
        end
        oldState = currentState
    end
    
    if not Toggles.mov_graph.Value then
        for i,v in ipairs(graphLines) do
            v:Remove()
            table.remove(graphLines, i)
        end
        VelocityCounter.Visible = false
    end
    
    if Toggles.wrl_ambient.Value then
        lighting.Ambient = Options.wrl_ambient1.Value
        lighting.OutdoorAmbient = Options.wrl_ambient2.Value
    else
        lighting.Ambient = C3(255, 255, 255)
        lighting.OutdoorAmbient = C3(255, 255, 255)
    end
    
    if Toggles.wrl_forcetime.Value then
        lighting.TimeOfDay = Options.wrl_forcetimevalue.Value
    else
        lighting.TimeOfDay = 12
    end
end
runService.RenderStepped:Connect(mainfunc)

if rayignore:FindFirstChild("Smokes") then
	for _,smoke in pairs(rayignore:FindFirstChild("Smokes"):GetChildren()) do
		smoke.Material = Enum.Material.Neon
		smoke.Transparency = 0.5
	end
    rayignore:FindFirstChild("Smokes").ChildAdded:Connect(function(smoke)
		runService.RenderStepped:Wait()
		if Toggles.cam_smoke.Value then
			smoke.ParticleEmitter.Rate = Options.cam_smokereduce.Value
		end
        smoke.Material = Enum.Material.Neon
        smoke.Transparency = 0.5
        smoke.Color = Options.cam_smokeauracolor.Value
    end)
end
rayignore.ChildAdded:Connect(function(obj) 
	if obj.Name == "Fires" then 
		obj.ChildAdded:Connect(function(fire) 
			if Toggles.misc_molly.Value then 
				fire.Transparency = 0
				fire.Color = Options.misc_mollycolor.Value
			end 
		end) 
	end 
end)

if rayignore:FindFirstChild("Fires") then
	rayignore:FindFirstChild("Fires").ChildAdded:Connect(function(fire)
		if Toggles.misc_molly.Value then
			fire.Transparency = 0
			fire.Color = Options.misc_mollycolor.Value
		end
	end)
end
Library:Notify('Finished Loading! Welcome ' ..localPlayer.Name.. ' to pepsi.club!');
Library:Notify("Took to load "..string.format("%.5f", tick() - LoadingTime).." seconds.");
