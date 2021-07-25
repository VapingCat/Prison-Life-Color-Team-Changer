local ColorPicker = Instance.new("ScreenGui")
local TopBar = Instance.new("Frame")
local ColorPicker_2 = Instance.new("Frame")
local UIPadding = Instance.new("UIPadding")
local Value = Instance.new("Frame")
local UIGradient = Instance.new("UIGradient")
local Frame = Instance.new("Frame")
local Bottom = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local ColorPreview = Instance.new("Frame")
local OK = Instance.new("TextButton")
local HueSaturation = Instance.new("ImageLabel")
local Frame_2 = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")

ColorPicker.Name = "ColorPicker"
ColorPicker.Parent = game.CoreGui
ColorPicker.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

TopBar.Name = "TopBar"
TopBar.Parent = ColorPicker
TopBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
TopBar.BorderSizePixel = 0
TopBar.Position = UDim2.new(0.369488537, 0, 0.458181828, 0)
TopBar.Size = UDim2.new(0, 288, 0, 21)

local UserInputService = game:GetService("UserInputService")

local gui = TopBar

local dragging
local dragInput
local dragStart
local startPos

local function update(input)
	local delta = input.Position - dragStart
	gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

gui.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = gui.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

gui.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

ColorPicker_2.Name = "ColorPicker"
ColorPicker_2.Parent = TopBar
ColorPicker_2.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
ColorPicker_2.BorderSizePixel = 0
ColorPicker_2.Position = UDim2.new(0, 0, 1, 0)
ColorPicker_2.Size = UDim2.new(0, 288, 0, 273)

UIPadding.Parent = ColorPicker_2
UIPadding.PaddingBottom = UDim.new(0, 5)
UIPadding.PaddingLeft = UDim.new(0, 5)
UIPadding.PaddingRight = UDim.new(0, 5)
UIPadding.PaddingTop = UDim.new(0, 5)

Value.Name = "Value"
Value.Parent = ColorPicker_2
Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Value.BorderSizePixel = 0
Value.Position = UDim2.new(1, -20, 0, 0)
Value.Size = UDim2.new(0, 20, 1, -45)

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0))}
UIGradient.Rotation = 90
UIGradient.Parent = Value

Frame.Parent = Value
Frame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0, -2, 0, 0)
Frame.Size = UDim2.new(1, 4, 0, 5)

Bottom.Name = "Bottom"
Bottom.Parent = ColorPicker_2
Bottom.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Bottom.BackgroundTransparency = 1.000
Bottom.Position = UDim2.new(0, 0, 1, -40)
Bottom.Size = UDim2.new(1, 0, 0, 40)

UIListLayout.Parent = Bottom
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

ColorPreview.Name = "ColorPreview"
ColorPreview.Parent = Bottom
ColorPreview.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ColorPreview.BorderSizePixel = 0
ColorPreview.Size = UDim2.new(0.5, -2, 1, 0)

OK.Name = "OK"
OK.Parent = Bottom
OK.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
OK.BorderSizePixel = 0
OK.Size = UDim2.new(0.5, -2, 1, 0)
OK.Font = Enum.Font.ArialBold
OK.Text = "OK"
OK.TextColor3 = Color3.fromRGB(255, 255, 255)
OK.TextSize = 16.000

HueSaturation.Name = "HueSaturation"
HueSaturation.Parent = ColorPicker_2
HueSaturation.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
HueSaturation.BorderSizePixel = 0
HueSaturation.Size = UDim2.new(1, -25, 1, -45)
HueSaturation.Image = "http://www.roblox.com/asset/?id=328298876"

Frame_2.Parent = HueSaturation
Frame_2.AnchorPoint = Vector2.new(0.5, 0.5)
Frame_2.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Frame_2.BorderSizePixel = 0
Frame_2.Size = UDim2.new(0, 5, 0, 5)

TextLabel.Parent = TopBar
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Size = UDim2.new(1, 0, 1, 0)
TextLabel.Font = Enum.Font.ArialBold
TextLabel.Text = "Team Color Picker"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 16.000

local Button1Down = false
local currentColor = {h=0,s=1,v=1}

function calculateLocalMousePosition(object)
	local positionX,positionY = object.AbsolutePosition.X,object.AbsolutePosition.Y
	local mouseX, mouseY = game.Players.LocalPlayer:GetMouse().X,game.Players.LocalPlayer:GetMouse().Y

	return Vector2.new(mouseX-positionX, mouseY-positionY)
end

function isHoveringOver(object)
	local position = object.AbsolutePosition
	local size = object.AbsoluteSize
	local mouse = game.Players.LocalPlayer:GetMouse()
	local localMouse = calculateLocalMousePosition(object)

	if (mouse.X >= position.X and mouse.Y >= position.Y) and (localMouse.X <= size.X and localMouse.Y <= size.Y) then
		return true
	else
		return false
	end
end

function updatePreview()
	ColorPreview.BackgroundColor3 = Color3.fromHSV(currentColor.h,currentColor.s,currentColor.v)
end

function hueSaturationCheck() -- script made by Vapin' Cat#5497
	if isHoveringOver(HueSaturation) then
		local LocalOffset = calculateLocalMousePosition(HueSaturation)
		local LocalScaleX, LocalScaleY = LocalOffset.X/HueSaturation.AbsoluteSize.X,LocalOffset.Y/HueSaturation.AbsoluteSize.Y

		HueSaturation.Frame.Position = UDim2.new(LocalScaleX, 0, LocalScaleY, 0)
		currentColor.h = 1-LocalScaleX
		currentColor.s = 1-LocalScaleY

		UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromHSV(currentColor.h,currentColor.s,1)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0))}

		updatePreview()
	end
end

function valueCheck()
	if isHoveringOver(Value) then
		local LocalOffset = calculateLocalMousePosition(Value)
		local LocalScaleY = LocalOffset.Y/HueSaturation.AbsoluteSize.Y

		Value.Frame.Position = UDim2.new(0, 0, LocalScaleY, 0)
		currentColor.v = 1-LocalScaleY

		updatePreview()
	end
end

function refresh(color)
	local position = workspace:FindFirstChild(game.Players.LocalPlayer.Name).HumanoidRootPart.CFrame
	local _, RY, _ = position:ToOrientation()
	position = CFrame.new(position.p) * CFrame.fromOrientation(0, RY, 0)

	local camera = workspace.CurrentCamera.CFrame

	if tostring(game.Players.LocalPlayer.TeamColor) == 'Medium stone grey' and color == nil then
		workspace.Remote.TeamEvent:FireServer("Bright orange")

		wait()

		workspace.Remote.loadchar:InvokeServer()

		workspace.Remote.TeamEvent:FireServer("Medium stone grey")
	else
		workspace.Remote.loadchar:InvokeServer(nil,color)
	end

	local HumanoidRootPart = workspace:FindFirstChild(game.Players.LocalPlayer.Name):WaitForChild('HumanoidRootPart',0.3)

	HumanoidRootPart.CFrame = position

	workspace.CurrentCamera.CFrame = camera
	workspace.CurrentCamera.Changed:Wait()
	workspace.CurrentCamera.CFrame = camera

	game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
end

game.Players.LocalPlayer:GetMouse().Button1Down:Connect(function()
	Button1Down = true
	hueSaturationCheck()
	valueCheck()
end)

game.Players.LocalPlayer:GetMouse().Button1Up:Connect(function()
	Button1Down = false
end)

game.Players.LocalPlayer:GetMouse().Move:Connect(function()
	if Button1Down then
		hueSaturationCheck()
		valueCheck()
	end
end)

OK.MouseButton1Down:Connect(function()
	refresh(Color3.fromHSV(currentColor.h,currentColor.s,currentColor.v))
end)
