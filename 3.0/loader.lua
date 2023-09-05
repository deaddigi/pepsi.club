local loader = Instance.new("ScreenGui")
local outline1 = Instance.new("Frame")
local outline2 = Instance.new("Frame")
local inner = Instance.new("Frame")
local up = Instance.new("Frame")
local name = Instance.new("TextLabel")
local divider = Instance.new("Frame")
local blackdivider = Instance.new("Frame")
local outlinegroup1 = Instance.new("Frame")
local outlinegroup2 = Instance.new("Frame")
local innergroup = Instance.new("Frame")
local infolabel = Instance.new("TextLabel")
local cbimage = Instance.new("ImageLabel")
local welcome = Instance.new("TextLabel")
local gamename = Instance.new("TextLabel")
local version = Instance.new("TextLabel")
local updated = Instance.new("TextLabel")
local status = Instance.new("TextLabel")
local divider_2 = Instance.new("Frame")
local outlinegroup2_2 = Instance.new("Frame")
local innergroup_2 = Instance.new("Frame")
local divider_3 = Instance.new("Frame")
local optionslabel = Instance.new("TextLabel")
local load = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local UIGradient = Instance.new("UIGradient")
local togglebutton = Instance.new("TextButton")
local exit = Instance.new("Frame")
local exitbutton = Instance.new("TextButton")
local TextLabel_2 = Instance.new("TextLabel")
local UIGradient_2 = Instance.new("UIGradient")

loader.Name = "loader"
loader.Parent = game.CoreGui
loader.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

outline1.Name = "outline1"
outline1.Parent = loader
outline1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
outline1.BorderColor3 = Color3.fromRGB(0, 0, 0)
outline1.Position = UDim2.new(0.553374231, -200, 0.42504409, -92)
outline1.Size = UDim2.new(0, 313, 0, 268)

outline2.Name = "outline2"
outline2.Parent = outline1
outline2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
outline2.BorderColor3 = Color3.fromRGB(23, 23, 23)
outline2.Position = UDim2.new(0, 1, 0, 1)
outline2.Size = UDim2.new(1, -2, 1, -2)

inner.Name = "inner"
inner.Parent = outline2
inner.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
inner.BorderColor3 = Color3.fromRGB(0, 0, 0)
inner.Position = UDim2.new(0, 1, 0, 1)
inner.Size = UDim2.new(1, -2, 1, -2)

up.Name = "up"
up.Parent = inner
up.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
up.BorderSizePixel = 0
up.Size = UDim2.new(1, 0, 0.125, 0)

name.Name = "name"
name.Parent = up
name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
name.BackgroundTransparency = 1.000
name.Position = UDim2.new(0.0226537213, 0, 0.0303030312, 0)
name.Size = UDim2.new(0.249190941, 0, 1, 0)
name.Font = Enum.Font.Code
name.Text = "pepsi.club"
name.TextColor3 = Color3.fromRGB(174, 174, 174)
name.TextSize = 16.000
name.TextStrokeTransparency = 0.000
name.TextXAlignment = Enum.TextXAlignment.Left

divider.Name = "divider"
divider.Parent = up
divider.BackgroundColor3 = Color3.fromRGB(2, 105, 172)
divider.BorderColor3 = Color3.fromRGB(0, 0, 0)
divider.Size = UDim2.new(1, 0, 0, 1)

blackdivider.Name = "blackdivider"
blackdivider.Parent = up
blackdivider.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
blackdivider.BorderColor3 = Color3.fromRGB(0, 0, 0)
blackdivider.Position = UDim2.new(-4.65661287e-10, 0, 1, 0)
blackdivider.Size = UDim2.new(1, 0, 0, 1)

outlinegroup1.Name = "outlinegroup1"
outlinegroup1.Parent = inner
outlinegroup1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
outlinegroup1.BorderColor3 = Color3.fromRGB(0, 0, 0)
outlinegroup1.Position = UDim2.new(0.0250000004, 0, 0.170000002, 0)
outlinegroup1.Size = UDim2.new(0.949999988, 0, 0.800000012, 0)

outlinegroup2.Name = "outlinegroup2"
outlinegroup2.Parent = outlinegroup1
outlinegroup2.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
outlinegroup2.BorderColor3 = Color3.fromRGB(23, 23, 23)
outlinegroup2.Position = UDim2.new(0, 1, 0, 1)
outlinegroup2.Size = UDim2.new(1, -2, 1, -2)

innergroup.Name = "innergroup"
innergroup.Parent = outlinegroup2
innergroup.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
innergroup.BorderColor3 = Color3.fromRGB(0, 0, 0)
innergroup.Position = UDim2.new(0, 1, 0, 1)
innergroup.Size = UDim2.new(1, -2, 1, -2)

infolabel.Name = "infolabel"
infolabel.Parent = innergroup
infolabel.BackgroundTransparency = 1.000
infolabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
infolabel.BorderSizePixel = 2
infolabel.Position = UDim2.new(0, 11, 0, 6)
infolabel.Size = UDim2.new(0.350716531, -12, 0, 18)
infolabel.Font = Enum.Font.Code
infolabel.Text = "Info"
infolabel.TextColor3 = Color3.fromRGB(174, 174, 174)
infolabel.TextSize = 15.000
infolabel.TextStrokeTransparency = 0.000
infolabel.TextXAlignment = Enum.TextXAlignment.Left

cbimage.Name = "cbimage"
cbimage.Parent = innergroup
cbimage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
cbimage.BorderColor3 = Color3.fromRGB(0, 0, 0)
cbimage.BorderSizePixel = 2
cbimage.Position = UDim2.new(0.0379899889, 0, 0.144787654, 0)
cbimage.Size = UDim2.new(0, 100, 0, 100)
cbimage.Image = "http://www.roblox.com/asset/?id=12164134159"

welcome.Name = "welcome"
welcome.Parent = innergroup
welcome.BackgroundTransparency = 1.000
welcome.Position = UDim2.new(0, 120, 0, 30)
welcome.Size = UDim2.new(0.582110107, -12, 0, 18)
welcome.Font = Enum.Font.Code
welcome.Text = "hi"
welcome.TextColor3 = Color3.fromRGB(174, 174, 174)
welcome.TextSize = 15.000
welcome.TextStrokeTransparency = 0.000
welcome.TextXAlignment = Enum.TextXAlignment.Left

gamename.Name = "gamename"
gamename.Parent = innergroup
gamename.BackgroundTransparency = 1.000
gamename.Position = UDim2.new(0, 120, 0, 48)
gamename.Size = UDim2.new(0.582110107, -12, 0, 18)
gamename.Font = Enum.Font.Code
gamename.Text = "Counter Blox"
gamename.TextColor3 = Color3.fromRGB(174, 174, 174)
gamename.TextSize = 15.000
gamename.TextStrokeTransparency = 0.000
gamename.TextXAlignment = Enum.TextXAlignment.Left

version.Name = "version"
version.Parent = innergroup
version.BackgroundTransparency = 1.000
version.Position = UDim2.new(0, 120, 0, 66)
version.Size = UDim2.new(0.582110107, -12, 0, 18)
version.Font = Enum.Font.Code
version.Text = "Ver: 3.2.0"
version.TextColor3 = Color3.fromRGB(174, 174, 174)
version.TextSize = 15.000
version.TextStrokeTransparency = 0.000
version.TextXAlignment = Enum.TextXAlignment.Left

updated.Name = "updated"
updated.Parent = innergroup
updated.BackgroundTransparency = 1.000
updated.Position = UDim2.new(0, 120, 0, 84)
updated.Size = UDim2.new(0.582110107, -12, 0, 18)
updated.Font = Enum.Font.Code
updated.Text = "Updated: 4/9/23"
updated.TextColor3 = Color3.fromRGB(174, 174, 174)
updated.TextSize = 15.000
updated.TextStrokeTransparency = 0.000
updated.TextXAlignment = Enum.TextXAlignment.Left

status.Name = "status"
status.Parent = innergroup
status.BackgroundTransparency = 1.000
status.Position = UDim2.new(0, 120, 0, 102)
status.Size = UDim2.new(0.582110107, -12, 0, 18)
status.Font = Enum.Font.Code
status.Text = "Status: Working"
status.TextColor3 = Color3.fromRGB(174, 174, 174)
status.TextSize = 15.000
status.TextStrokeTransparency = 0.000
status.TextXAlignment = Enum.TextXAlignment.Left

divider_2.Name = "divider"
divider_2.Parent = innergroup
divider_2.BackgroundColor3 = Color3.fromRGB(2, 105, 172)
divider_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
divider_2.Position = UDim2.new(0, 0, 0, -2)
divider_2.Size = UDim2.new(0.999000013, 0, 0, 1)

outlinegroup2_2.Name = "outlinegroup2"
outlinegroup2_2.Parent = outlinegroup1
outlinegroup2_2.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
outlinegroup2_2.BorderColor3 = Color3.fromRGB(23, 23, 23)
outlinegroup2_2.Position = UDim2.new(0, 13, 0, 142)
outlinegroup2_2.Size = UDim2.new(0.911429048, -2, 0.24737066, -2)

innergroup_2.Name = "innergroup"
innergroup_2.Parent = outlinegroup2_2
innergroup_2.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
innergroup_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
innergroup_2.Position = UDim2.new(-1.14922159e-07, 0, 0, 0)
innergroup_2.Size = UDim2.new(1.00753152, -2, 1.17912352, -2)

divider_3.Name = "divider"
divider_3.Parent = innergroup_2
divider_3.BackgroundColor3 = Color3.fromRGB(2, 105, 172)
divider_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
divider_3.Position = UDim2.new(0, 0, -0.00299979653, 0)
divider_3.Size = UDim2.new(1.00004923, 0, 0, 1)

optionslabel.Name = "optionslabel"
optionslabel.Parent = divider_3
optionslabel.BackgroundTransparency = 1.000
optionslabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
optionslabel.BorderSizePixel = 2
optionslabel.Position = UDim2.new(0, 9, 0, 1)
optionslabel.Size = UDim2.new(0.350716531, -12, 0, 18)
optionslabel.Font = Enum.Font.Code
optionslabel.Text = "Options"
optionslabel.TextColor3 = Color3.fromRGB(174, 174, 174)
optionslabel.TextSize = 15.000
optionslabel.TextStrokeTransparency = 0.000
optionslabel.TextXAlignment = Enum.TextXAlignment.Left

load.Name = "load"
load.Parent = divider_3
load.BackgroundTransparency = 1.000
load.LayoutOrder = 1
load.Position = UDim2.new(0.0338902585, 0, 51, -27)
load.Size = UDim2.new(0.42899999, 0, 0, 26)
load.ZIndex = 0

TextLabel.Parent = load
TextLabel.AnchorPoint = Vector2.new(0.5, 1)
TextLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.Position = UDim2.new(0.499768794, 0, 1, -5)
TextLabel.Size = UDim2.new(1.04346514, -12, 0, 18)
TextLabel.Font = Enum.Font.Code
TextLabel.Text = "Load"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 15.000

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(90, 90, 90))}
UIGradient.Rotation = 90
UIGradient.Parent = TextLabel

togglebutton.Name = "togglebutton"
togglebutton.Parent = load
togglebutton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
togglebutton.BackgroundTransparency = 0.990
togglebutton.BorderSizePixel = 0
togglebutton.Size = UDim2.new(0.992623329, 0, 1, 0)
togglebutton.Font = Enum.Font.SourceSans
togglebutton.Text = ""
togglebutton.TextColor3 = Color3.fromRGB(0, 0, 0)
togglebutton.TextSize = 14.000
togglebutton.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/deaddigi/pepsi.club/main/3.0/main.lua", true))()
	game.CoreGui.loader:Destroy()
end)

exit.Name = "exit"
exit.Parent = divider_3
exit.BackgroundTransparency = 1.000
exit.LayoutOrder = 1
exit.Position = UDim2.new(0.514239669, 0, 51, -27)
exit.Size = UDim2.new(0.429276586, 0, 0, 26)
exit.ZIndex = 0

exitbutton.Name = "exitbutton"
exitbutton.Parent = exit
exitbutton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
exitbutton.BackgroundTransparency = 0.990
exitbutton.BorderSizePixel = 0
exitbutton.Size = UDim2.new(1, 0, 1, 0)
exitbutton.Font = Enum.Font.SourceSans
exitbutton.Text = ""
exitbutton.TextColor3 = Color3.fromRGB(0, 0, 0)
exitbutton.TextSize = 14.000
exitbutton.MouseButton1Click:Connect(function()
	game.CoreGui.loader:Destroy()
end)

TextLabel_2.Parent = exit
TextLabel_2.AnchorPoint = Vector2.new(0.5, 1)
TextLabel_2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_2.Position = UDim2.new(0.503482759, 0, 1, -5)
TextLabel_2.Size = UDim2.new(1.06730533, -12, 0, 18)
TextLabel_2.Font = Enum.Font.Code
TextLabel_2.Text = "Exit"
TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.TextSize = 15.000

UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(90, 90, 90))}
UIGradient_2.Rotation = 90
UIGradient_2.Parent = TextLabel_2

-- Scripts:

local function MMXAOX_fake_script() -- welcome.LocalScript 
	local script = Instance.new('LocalScript', welcome)

	local plr = game.Players.LocalPlayer
	
	script.Parent.Text = "Welcome, "..plr.Name.."!"
end
coroutine.wrap(MMXAOX_fake_script)()
