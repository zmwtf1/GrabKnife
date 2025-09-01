local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Create the ScreenGui (this is what belongs in CoreGui)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KnifeHubV1"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- Create the main frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 280) -- increased height for extra button
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui

-- Rounded corners
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

-- Drop shadow
local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.Parent = MainFrame
Shadow.BackgroundTransparency = 1
Shadow.BorderSizePixel = 0
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.Position = UDim2.new(0.5, 0, 0.5, 4)
Shadow.Size = UDim2.new(1, 20, 1, 20)
Shadow.Image = "rbxassetid://1316045217"
Shadow.ImageColor3 = Color3.new(0, 0, 0)
Shadow.ImageTransparency = 0.5
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(10, 10, 118, 118)

-- Make MainFrame draggable
local dragging, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
	end
end)

MainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Text = "Knife Hub V1"
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20
Title.Parent = MainFrame
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 12)

-- Function to create buttons
local function CreateButton(name, script, yOffset)
	local Button = Instance.new("TextButton")
	Button.Size = UDim2.new(0.8, 0, 0, 30)
	Button.Position = UDim2.new(0.1, 0, 0, yOffset)
	Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	Button.TextColor3 = Color3.new(1, 1, 1)
	Button.Text = name
	Button.Font = Enum.Font.SourceSansBold
	Button.TextSize = 16
	Button.Parent = MainFrame
	Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 8)
	Button.MouseButton1Click:Connect(function()
		loadstring(game:HttpGet(script, true))()
	end)
end

-- Buttons
CreateButton("Grab Knife V1", "https://raw.githubusercontent.com/zmwtf1/GrabKnife/refs/heads/main/GrabKnifeV1.lua", 40)
CreateButton("Grab Knife V2", "https://raw.githubusercontent.com/zmwtf1/GrabKnife/refs/heads/main/GrabKnifeV2.lua", 80)
CreateButton("Grab Knife V3", "https://raw.githubusercontent.com/zmwtf1/GrabKnife/refs/heads/main/GrabKnifeV3.lua", 120)
CreateButton("Grab Knife V4", "https://raw.githubusercontent.com/zmwtf1/GrabKnife/refs/heads/main/GrabKnifeV4.lua", 160)

-- "Get Source Code" button (small)
local SourceButton = Instance.new("TextButton")
SourceButton.Size = UDim2.new(0.6, 0, 0, 25)
SourceButton.Position = UDim2.new(0.2, 0, 0, 200)
SourceButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
SourceButton.TextColor3 = Color3.new(1, 1, 1)
SourceButton.Text = "Get Source Code"
SourceButton.Font = Enum.Font.SourceSansBold
SourceButton.TextSize = 14
SourceButton.Parent = MainFrame
Instance.new("UICorner", SourceButton).CornerRadius = UDim.new(0, 6)

SourceButton.MouseButton1Click:Connect(function()
	setclipboard("https://github.com/zmwtf1/GrabKnife/")
end)

-- Footer
local Footer = Instance.new("TextLabel")
Footer.Size = UDim2.new(1, 0, 0, 20)
Footer.Position = UDim2.new(0, 0, 1, -20)
Footer.BackgroundTransparency = 1
Footer.TextColor3 = Color3.fromRGB(255, 0, 0)
Footer.Text = "Only works on R6!!"
Footer.Font = Enum.Font.SourceSansBold
Footer.TextSize = 14
Footer.Parent = MainFrame

-- Toggle button (always on screen edge)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 30, 0, 60)
ToggleButton.Position = UDim2.new(0, 0, 0.5, -30)
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.Text = "<"
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 20
ToggleButton.Parent = ScreenGui
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 12)

-- Toggle functionality
local isVisible = true
ToggleButton.MouseButton1Click:Connect(function()
	isVisible = not isVisible
	MainFrame.Visible = isVisible
	ToggleButton.Text = isVisible and "<" or ">"
end)