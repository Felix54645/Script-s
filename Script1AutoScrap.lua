local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local tutorialCompleted = false

local function CreateUICorner(Parent, CornerRadius)
	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = CornerRadius
	UICorner.Parent = Parent
	return UICorner
end

local function CreateUIStroke(Parent, Color, Thickness, Transparency, ZIndex)
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Parent = Parent
	UIStroke.Color = Color3.fromRGB(Color[1], Color[2], Color[3])
	UIStroke.Thickness = Thickness or 2
	UIStroke.Transparency = Transparency or 0
	UIStroke.LineJoinMode = Enum.LineJoinMode.Round
	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
	UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.FixedSize
	UIStroke.BorderStrokePosition = Enum.BorderStrokePosition.Outer
	UIStroke.ZIndex = ZIndex or 1
	return UIStroke
end

local function CreateUIGradient(Parent, ColorSeq, TransparencySeq, Rotation)
	local UIGradient = Instance.new("UIGradient")
	UIGradient.Color = ColorSeq
	UIGradient.Transparency = TransparencySeq
	UIGradient.Rotation = Rotation or 90
	UIGradient.Parent = Parent
	return UIGradient
end

local UI = Instance.new("ScreenGui")
UI.Name = "UI"
UI.Parent = PlayerGui
UI.ResetOnSpawn = false

-- === PROMPT (main frame) ===
local prompt = Instance.new("Frame")
prompt.Name = "prompt"
prompt.Parent = UI
prompt.Size = UDim2.new(0, 391, 0, 89)
prompt.Position = UDim2.new(0.5, 0, 0.051, 0)
prompt.BackgroundTransparency = 0.5
prompt.BorderColor3 = Color3.fromRGB(27, 42, 53)
prompt.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
prompt.AnchorPoint = Vector2.new(0.5, 0.5)
prompt.ZIndex = 1

-- UICorner
CreateUICorner(prompt, UDim.new(0.05, 0))

-- UIStroke
CreateUIStroke(prompt, {7, 7, 7}, 2, 0.35, 1)

-- UIScale
local promptScale = Instance.new("UIScale")
promptScale.Scale = 1
promptScale.Parent = prompt

-- === HEADER (title text) ===
local header = Instance.new("TextLabel")
header.Name = "header"
header.Parent = prompt
header.ZIndex = 1
header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
header.BorderColor3 = Color3.fromRGB(27, 42, 53)
header.BackgroundTransparency = 1
header.BorderSizePixel = 1
header.BorderMode = Enum.BorderMode.Outline
header.Position = UDim2.new(0.0245, 0, 0, 0)
header.Size = UDim2.new(0.948, 0, 0.173, 0)
header.SizeConstraint = Enum.SizeConstraint.RelativeXY
header.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy)
header.TextSize = 16
header.TextColor3 = Color3.fromRGB(235, 235, 235)
header.TextStrokeTransparency = 0.5
header.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
header.TextXAlignment = Enum.TextXAlignment.Left
header.TextYAlignment = Enum.TextYAlignment.Center
header.Text = "HELPER"

-- === FRAME (dark description background) ===
local descFrame = Instance.new("Frame")
descFrame.Name = "Frame"
descFrame.Parent = prompt
descFrame.ZIndex = 0
descFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
descFrame.BackgroundTransparency = 0.75
descFrame.BorderSizePixel = 0
descFrame.Position = UDim2.new(0.0173, 0, 0.252, 0)
descFrame.Size = UDim2.new(0, 377, 0, 59)

CreateUICorner(descFrame, UDim.new(0.04, 0))
CreateUIStroke(descFrame, {7, 7, 7}, 2, 0.65, 1)

-- === DESC (description text inside Frame) ===
local desc = Instance.new("TextLabel")
desc.Name = "desc"
desc.Parent = descFrame
desc.ZIndex = 1
desc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
desc.BorderColor3 = Color3.fromRGB(27, 42, 53)
desc.BackgroundTransparency = 1
desc.BorderSizePixel = 1
desc.BorderMode = Enum.BorderMode.Outline
desc.Position = UDim2.new(-0.0012, 0, -0.0024, 0)
desc.Size = UDim2.new(0, 377, 0, 59)
desc.SizeConstraint = Enum.SizeConstraint.RelativeXY
desc.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium)
desc.TextSize = 17
desc.TextColor3 = Color3.fromRGB(255, 255, 255)
desc.TextStrokeTransparency = 0.5
desc.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
desc.TextXAlignment = Enum.TextXAlignment.Center
desc.TextYAlignment = Enum.TextYAlignment.Center
desc.TextWrapped = true
desc.Text = "real"

-- ============================================================
-- === FRAME (container with 3 prompts) ===
-- ============================================================
local frame = Instance.new("Frame")
frame.Name = "Frame"
frame.Parent = UI
frame.ZIndex = 1
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.BackgroundTransparency = 1
frame.BorderSizePixel = 0
frame.Position = UDim2.new(0, 0, 0.15, 0)
frame.Size = UDim2.new(0, 100, 0, 100)

-- UIListLayout
local listLayout = Instance.new("UIListLayout")
listLayout.Parent = frame
listLayout.SortOrder = Enum.SortOrder.Name
listLayout.FillDirection = Enum.FillDirection.Vertical
listLayout.Padding = UDim.new(0, 8)
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
listLayout.VerticalAlignment = Enum.VerticalAlignment.Top

-- === Helper function to create a single prompt inside Frame ===
local function CreatePromptInFrame(parent, headerText, discText, buttonText)
	local p = Instance.new("Frame")
	p.Name = "prompt"
	p.Parent = parent
	p.Size = UDim2.new(0, 253, 0, 86)
	p.BackgroundTransparency = 0.5
	p.BorderColor3 = Color3.fromRGB(27, 42, 53)
	p.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	p.AnchorPoint = Vector2.new(0.5, 0.5)
	p.ZIndex = 1

	CreateUICorner(p, UDim.new(0.05, 0))


	CreateUIStroke(p, {7, 7, 7}, 2, 0.35, 1)

	local pScale = Instance.new("UIScale")
	pScale.Scale = 1
	pScale.Parent = p

	-- header
	local h = Instance.new("TextLabel")
	h.Name = "header"
	h.Parent = p
	h.ZIndex = 1
	h.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	h.BorderColor3 = Color3.fromRGB(27, 42, 53)
	h.BackgroundTransparency = 1
	h.BorderSizePixel = 1
	h.BorderMode = Enum.BorderMode.Outline
	h.Position = UDim2.new(0.0228, 0, 0.0465, 0)
	h.Size = UDim2.new(0.948, 0, 0.173, 0)
	h.SizeConstraint = Enum.SizeConstraint.RelativeXY
	h.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy)
	h.TextSize = 12
	h.TextColor3 = Color3.fromRGB(235, 235, 235)
	h.TextStrokeTransparency = 0.5
	h.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	h.TextXAlignment = Enum.TextXAlignment.Left
	h.TextYAlignment = Enum.TextYAlignment.Center
	h.Text = headerText

	-- disc (description)
	local d = Instance.new("TextLabel")
	d.Name = "disc"
	d.Parent = p
	d.ZIndex = 1
	d.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	d.BorderColor3 = Color3.fromRGB(27, 42, 53)
	d.BackgroundTransparency = 1
	d.BorderSizePixel = 1
	d.BorderMode = Enum.BorderMode.Outline
	d.Position = UDim2.new(0.0094, 0, 0.336, 0)
	d.Size = UDim2.new(0, 248, 0, 28)
	d.SizeConstraint = Enum.SizeConstraint.RelativeXY
	d.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium)
	d.TextSize = 14
	d.TextColor3 = Color3.fromRGB(255, 255, 255)
	d.TextStrokeTransparency = 0.5
	d.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	d.TextXAlignment = Enum.TextXAlignment.Center
	d.TextYAlignment = Enum.TextYAlignment.Top
	d.TextWrapped = true
	d.Text = discText

	-- button (Lock)
	local btn = Instance.new("TextButton")
	btn.Name = "button"
	btn.Parent = p
	btn.ZIndex = 2
	btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	btn.BorderColor3 = Color3.fromRGB(27, 42, 53)
	btn.BackgroundTransparency = 0
	btn.BorderSizePixel = 1
	btn.BorderMode = Enum.BorderMode.Outline
	btn.Position = UDim2.new(0.743, 0, 0.221, 0)
	btn.Size = UDim2.new(0.257, 0, 0.328, 0)
	btn.SizeConstraint = Enum.SizeConstraint.RelativeXY
	btn.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold)
	btn.TextSize = 13
	btn.TextColor3 = Color3.fromRGB(235, 235, 235)
	btn.TextStrokeTransparency = 0.5
	btn.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	btn.TextXAlignment = Enum.TextXAlignment.Center
	btn.TextYAlignment = Enum.TextYAlignment.Center
	btn.Text = buttonText
	btn.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
	btn.Active = true
	btn.Selectable = true
	btn.AutoButtonColor = true

	-- Frame (dark description background)
	local df = Instance.new("Frame")
	df.Name = "Frame"
	df.Parent = p
	df.ZIndex = 0
	df.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	df.BackgroundTransparency = 0.75
	df.BorderSizePixel = 0
	df.Position = UDim2.new(0.0094, 0, 0.24, 0)
	df.Size = UDim2.new(0, 248, 0, 60)

	CreateUICorner(df, UDim.new(0.04, 0))
	CreateUIStroke(df, {7, 7, 7}, 2, 0.65, 1)

	-- promptButton1 (action button at bottom)
	local pb1 = Instance.new("Frame")
	pb1.Name = "promptButton1"
	pb1.Parent = p
	pb1.ZIndex = 1
	pb1.BackgroundColor3 = Color3.fromRGB(85, 85, 127)
	pb1.BackgroundTransparency = 1
	pb1.BorderColor3 = Color3.fromRGB(27, 42, 53)
	pb1.BorderSizePixel = 1
	pb1.Position = UDim2.new(0.327, 0, 0.823, 0)
	pb1.Size = UDim2.new(0, 119, 0, 32)

	local pb1Stroke = CreateUIStroke(pb1, {7, 7, 7}, 2, 0.5, 1)
	pb1Stroke.Enabled = false
	pb1Stroke.LineJoinMode = Enum.LineJoinMode.Miter

	local pb1Btn = Instance.new("TextButton")
	pb1Btn.Name = "button"
	pb1Btn.Parent = pb1
	pb1Btn.ZIndex = 2
	pb1Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	pb1Btn.BorderColor3 = Color3.fromRGB(27, 42, 53)
	pb1Btn.BackgroundTransparency = 0
	pb1Btn.BorderSizePixel = 1
	pb1Btn.Position = UDim2.new(-0.134, 0, -0.719, 0)
	pb1Btn.Size = UDim2.new(1, 0, 1, 0)
	pb1Btn.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold)
	pb1Btn.TextSize = 13
	pb1Btn.TextColor3 = Color3.fromRGB(235, 235, 235)
	pb1Btn.TextStrokeTransparency = 0.5
	pb1Btn.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	pb1Btn.TextXAlignment = Enum.TextXAlignment.Center
	pb1Btn.TextYAlignment = Enum.TextYAlignment.Center
	pb1Btn.Text = "USE"
	pb1Btn.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
	pb1Btn.Active = true
	pb1Btn.Selectable = true
	pb1Btn.AutoButtonColor = true

	-- lock (hidden overlay with icon)
	local lk = Instance.new("Frame")
	lk.Name = "lock"
	lk.Parent = p
	lk.ZIndex = 999
	lk.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	lk.BackgroundTransparency = 1
	lk.BorderColor3 = Color3.fromRGB(27, 42, 53)
	lk.BorderSizePixel = 1
	lk.Position = UDim2.new(0.263, 0, 0.556, 0)
	lk.Size = UDim2.new(0.470, 0, 0.372, 0)
	lk.Visible = false

	local lkIcon = Instance.new("ImageLabel")
	lkIcon.Name = "icon"
	lkIcon.Parent = lk
	lkIcon.ZIndex = 999
	lkIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	lkIcon.BackgroundTransparency = 1
	lkIcon.BorderColor3 = Color3.fromRGB(27, 42, 53)
	lkIcon.BorderSizePixel = 1
	lkIcon.AnchorPoint = Vector2.new(0.5, 0.5)
	lkIcon.Position = UDim2.new(0.5, 0, 0.453, 0)
	lkIcon.Size = UDim2.new(0, 32, 0, 25)
	lkIcon.Image = "rbxassetid://10972846193"
	lkIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
	lkIcon.ScaleType = Enum.ScaleType.Stretch

	return p
end

local tutorialAllLocation = Instance.new("Frame")
tutorialAllLocation.Name = "TUTORIALALLLOCATION"
tutorialAllLocation.Parent = UI
tutorialAllLocation.Size = UDim2.new(0, 253, 0, 86)
tutorialAllLocation.Position = UDim2.new(0, 0, 1, 0)
tutorialAllLocation.AnchorPoint = Vector2.new(0, 1)
tutorialAllLocation.BackgroundTransparency = 0.5
tutorialAllLocation.BorderColor3 = Color3.fromRGB(27, 42, 53)
tutorialAllLocation.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
tutorialAllLocation.ZIndex = 1

CreateUICorner(tutorialAllLocation, UDim.new(0.05, 0))
CreateUIStroke(tutorialAllLocation, {7, 7, 7}, 2, 0.35, 1)

local tutorialScale = Instance.new("UIScale")
tutorialScale.Scale = 1
tutorialScale.Parent = tutorialAllLocation

-- header
local tutorialHeader = Instance.new("TextLabel")
tutorialHeader.Name = "header"
tutorialHeader.Parent = tutorialAllLocation
tutorialHeader.ZIndex = 1
tutorialHeader.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tutorialHeader.BorderColor3 = Color3.fromRGB(27, 42, 53)
tutorialHeader.BackgroundTransparency = 1
tutorialHeader.BorderSizePixel = 1
tutorialHeader.BorderMode = Enum.BorderMode.Outline
tutorialHeader.Position = UDim2.new(0.0188718047, 0, 0, 0)
tutorialHeader.Size = UDim2.new(0.947976887, 0, 0.173228353, 0)
tutorialHeader.SizeConstraint = Enum.SizeConstraint.RelativeXY
tutorialHeader.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy)
tutorialHeader.TextSize = 12
tutorialHeader.TextColor3 = Color3.fromRGB(235, 235, 235)
tutorialHeader.TextStrokeTransparency = 0.5
tutorialHeader.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
tutorialHeader.TextXAlignment = Enum.TextXAlignment.Left
tutorialHeader.TextYAlignment = Enum.TextYAlignment.Center
tutorialHeader.Text = "OPEN ALL LOCATION "

-- disc
local tutorialDisc = Instance.new("TextLabel")
tutorialDisc.Name = "disc"
tutorialDisc.Parent = tutorialAllLocation
tutorialDisc.ZIndex = 1
tutorialDisc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tutorialDisc.BorderColor3 = Color3.fromRGB(27, 42, 53)
tutorialDisc.BackgroundTransparency = 1
tutorialDisc.BorderSizePixel = 1
tutorialDisc.BorderMode = Enum.BorderMode.Outline
tutorialDisc.Position = UDim2.new(0.00943584181, 0, 0.231367961, 0)
tutorialDisc.Size = UDim2.new(0, 248, 0, 28)
tutorialDisc.SizeConstraint = Enum.SizeConstraint.RelativeXY
tutorialDisc.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium)
tutorialDisc.TextSize = 14
tutorialDisc.TextColor3 = Color3.fromRGB(255, 255, 255)
tutorialDisc.TextStrokeTransparency = 0.5
tutorialDisc.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
tutorialDisc.TextXAlignment = Enum.TextXAlignment.Center
tutorialDisc.TextYAlignment = Enum.TextYAlignment.Top
tutorialDisc.TextWrapped = true
tutorialDisc.Text = "F"

-- Frame (dark description background)
local tutorialDescFrame = Instance.new("Frame")
tutorialDescFrame.Name = "Frame"
tutorialDescFrame.Parent = tutorialAllLocation
tutorialDescFrame.ZIndex = 0
tutorialDescFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
tutorialDescFrame.BackgroundTransparency = 0.75
tutorialDescFrame.BorderSizePixel = 0
tutorialDescFrame.Position = UDim2.new(0.00943584181, 0, 0.239999995, 0)
tutorialDescFrame.Size = UDim2.new(0, 248, 0, 60)

CreateUICorner(tutorialDescFrame, UDim.new(0.04, 0))
CreateUIStroke(tutorialDescFrame, {7, 7, 7}, 2, 0.65, 1)

-- promptButton1
local tutorialPromptButton1 = Instance.new("Frame")
tutorialPromptButton1.Name = "promptButton1"
tutorialPromptButton1.Parent = tutorialAllLocation
tutorialPromptButton1.ZIndex = 1
tutorialPromptButton1.BackgroundColor3 = Color3.fromRGB(85, 85, 127)
tutorialPromptButton1.BackgroundTransparency = 1
tutorialPromptButton1.BorderColor3 = Color3.fromRGB(27, 42, 53)
tutorialPromptButton1.BorderSizePixel = 1
tutorialPromptButton1.Position = UDim2.new(0.326589584, 0, 0.823190272, 0)
tutorialPromptButton1.Size = UDim2.new(0, 119, 0, 32)

local tutorialPB1Stroke = CreateUIStroke(tutorialPromptButton1, {7, 7, 7}, 2, 0.5, 1)
tutorialPB1Stroke.Enabled = false
tutorialPB1Stroke.LineJoinMode = Enum.LineJoinMode.Miter

CreateUIGradient(tutorialPromptButton1,
	ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 120, 120)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(107, 107, 0))
	}),
	NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(1, 0)
	}),
	90
)

-- startcont (TextButton)
local backbutton = Instance.new("ImageButton")
backbutton.Name = "backbutton"
backbutton.Parent = tutorialAllLocation
backbutton.ZIndex = 2
backbutton.ImageColor3 = Color3.fromRGB(90, 142, 233)
backbutton.BackgroundTransparency = 1
backbutton.Image = "rbxassetid://83972042993874"
backbutton.Position = UDim2.new(0.288, 0, 0.663, 0)
backbutton.Size = UDim2.new(0.083, 0, 0.199, 0)
backbutton.SizeConstraint = Enum.SizeConstraint.RelativeXY

-- startcont (TextButton)
local startcont = Instance.new("TextButton")
startcont.Name = "startcont"
startcont.Parent = tutorialAllLocation
startcont.ZIndex = 2
startcont.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
startcont.BorderColor3 = Color3.fromRGB(27, 42, 53)
startcont.BackgroundTransparency = 0
startcont.BorderSizePixel = 1
startcont.BorderMode = Enum.BorderMode.Outline
startcont.Position = UDim2.new(0.371474922, 0, 0.604651153, 0)
startcont.Size = UDim2.new(0.256983578, 0, 0.327761531, 0)
startcont.SizeConstraint = Enum.SizeConstraint.RelativeXY
startcont.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold)
startcont.TextSize = 13
startcont.TextColor3 = Color3.fromRGB(235, 235, 235)
startcont.TextStrokeTransparency = 0.5
startcont.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
startcont.TextXAlignment = Enum.TextXAlignment.Center
startcont.TextYAlignment = Enum.TextYAlignment.Center
startcont.Text = "NEXT"
startcont.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
startcont.Active = true
startcont.Selectable = true
startcont.AutoButtonColor = true

local originalStepCheck = startcont.MouseButton1Click

-- tutorial (counter label)
local tutorialLabel = Instance.new("TextLabel")
tutorialLabel.Name = "tutorial"
tutorialLabel.Parent = tutorialAllLocation
tutorialLabel.ZIndex = 1
tutorialLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tutorialLabel.BorderColor3 = Color3.fromRGB(27, 42, 53)
tutorialLabel.BackgroundTransparency = 1
tutorialLabel.BorderSizePixel = 1
tutorialLabel.BorderMode = Enum.BorderMode.Outline
tutorialLabel.Position = UDim2.new(0.022824375, 0, 0, 0)
tutorialLabel.Size = UDim2.new(0.947976887, 0, 0.173228353, 0)
tutorialLabel.SizeConstraint = Enum.SizeConstraint.RelativeXY
tutorialLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy)
tutorialLabel.TextSize = 12
tutorialLabel.TextColor3 = Color3.fromRGB(235, 235, 235)
tutorialLabel.TextStrokeTransparency = 0.5
tutorialLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
tutorialLabel.TextXAlignment = Enum.TextXAlignment.Right
tutorialLabel.TextYAlignment = Enum.TextYAlignment.Center
tutorialLabel.Text = "0/6"

-- === button (OPEN ALL LOCATION) ===
local openAllLocationBtn = Instance.new("TextButton")
openAllLocationBtn.Name = "button"
openAllLocationBtn.Parent = UI
openAllLocationBtn.ZIndex = 2
openAllLocationBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
openAllLocationBtn.BorderColor3 = Color3.fromRGB(27, 42, 53)
openAllLocationBtn.BackgroundTransparency = 0
openAllLocationBtn.BorderSizePixel = 1
openAllLocationBtn.BorderMode = Enum.BorderMode.Outline

-- ФИКСИРОВАННЫЙ РАЗМЕР (в пикселях, не зависит от экрана)
local BUTTON_WIDTH = 200  -- ширина в пикселях
local BUTTON_HEIGHT = 30  -- высота в пикселях
local BUTTON_POS_X = 10   -- отступ слева в пикселях
local BUTTON_POS_Y = -40  -- отступ снизу в пикселях (отрицательное значение)

openAllLocationBtn.Size = UDim2.new(0, BUTTON_WIDTH, 0, BUTTON_HEIGHT)
openAllLocationBtn.Position = UDim2.new(0, BUTTON_POS_X, 1, BUTTON_POS_Y) -- 1 = низ экрана

openAllLocationBtn.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold)
openAllLocationBtn.TextSize = 12  -- немного увеличил для читаемости
openAllLocationBtn.TextColor3 = Color3.fromRGB(235, 235, 235)
openAllLocationBtn.TextStrokeTransparency = 0.5
openAllLocationBtn.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
openAllLocationBtn.TextXAlignment = Enum.TextXAlignment.Center
openAllLocationBtn.TextYAlignment = Enum.TextYAlignment.Center
openAllLocationBtn.Text = "OPEN ALL LOCATION"
openAllLocationBtn.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
openAllLocationBtn.Active = true
openAllLocationBtn.Selectable = true
openAllLocationBtn.AutoButtonColor = true

-- === Create 3 prompts inside Frame ===
CreatePromptInFrame(frame, "BUTTON", "Q - TP 1ST Location", "Lock")
CreatePromptInFrame(frame, "BUTTON", "Z - Sell", "Lock")
CreatePromptInFrame(frame, "BUTTON", "R - Search", "Lock")

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- Проверка, можно ли безопасно стоять в точке (не внутри стены, не в воздухе)
local function canStandAt(position, character)
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
	raycastParams.FilterDescendantsInstances = {character}

	-- Проверка 1: есть ли пол под ногами (вниз на 5 studs)
	local floorCheck = workspace:Raycast(position, Vector3.new(0, -5, 0), raycastParams)
	if not floorCheck then
		return false, "no floor beneath"
	end

	-- Проверка 2: есть ли место для головы (вверх на 6 studs)
	local ceilingCheck = workspace:Raycast(position + Vector3.new(0, 0.5, 0), Vector3.new(0, 6, 0), raycastParams)
	if ceilingCheck and (ceilingCheck.Position.Y - position.Y) < 5 then
		return false, "ceiling too low"
	end

	-- Проверка 3: не внутри ли стены (коробка размером с игрока)
	local boxSize = Vector3.new(2, 5, 2)
	local boxCFrame = CFrame.new(position + Vector3.new(0, 2, 0))
	local overlappingParts = workspace:GetPartBoundsInBox(boxCFrame, boxSize, raycastParams)

	for _, part in ipairs(overlappingParts) do
		if part.CanCollide and part.Transparency < 0.9 then
			return false, "inside wall: " .. part.Name
		end
	end

	return true, "safe"
end

-- Расширенный поиск безопасной позиции рядом со скрапом
local function findSafePositionNearScrap(scrapBasePart, character)
	local scrapPos = scrapBasePart.Position
	local searchRadius = 8 -- радиус поиска вокруг скрапа (в студах)

	-- Пробуем разные смещения вокруг скрапа
	local offsets = {
		Vector3.new(0, 0, 0),      -- точно под скрапом
		Vector3.new(2, 0, 0),
		Vector3.new(-2, 0, 0),
		Vector3.new(0, 0, 2),
		Vector3.new(0, 0, -2),
		Vector3.new(1.5, 0, 1.5),
		Vector3.new(-1.5, 0, 1.5),
		Vector3.new(1.5, 0, -1.5),
		Vector3.new(-1.5, 0, -1.5),
		Vector3.new(3, 0, 0),
		Vector3.new(-3, 0, 0),
		Vector3.new(0, 0, 3),
		Vector3.new(0, 0, -3),
	}

	-- Сортируем смещения по расстоянию до скрапа (ближайшие сначала)
	table.sort(offsets, function(a, b)
		return a.Magnitude < b.Magnitude
	end)

	for _, offset in ipairs(offsets) do
		local checkPos = scrapPos + offset

		-- Raycast ВНИЗ от этой позиции, чтобы найти реальную поверхность
		local raycastParams = RaycastParams.new()
		raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
		raycastParams.FilterDescendantsInstances = {character}

		local rayOrigin = checkPos + Vector3.new(0, 5, 0)  -- Начинаем чуть выше
		local rayDirection = Vector3.new(0, -15, 0)       -- Смотрим вниз на 15 studs

		local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)

		if raycastResult then
			local groundPoint = raycastResult.Position + Vector3.new(0, 3, 0) -- Ноги на земле

			-- Проверяем, можно ли здесь стоять
			local canStand, reason = canStandAt(groundPoint, character)
			if canStand then
				-- Доп. проверка: достаточно ли места над головой для прыжка/сбора
				local headCheck = workspace:Raycast(groundPoint + Vector3.new(0, 4, 0), Vector3.new(0, 3, 0), raycastParams)
				if not headCheck or headCheck.Distance > 2.5 then
					print("[SafePos] Found safe position at offset", offset, "reason:", reason)
					return groundPoint
				end
			end
		end
	end

	-- Если ничего не нашли, пробуем найти любую точку на земле в радиусе 20 studs
	local fallbackParams = RaycastParams.new()
	fallbackParams.FilterType = Enum.RaycastFilterType.Blacklist
	fallbackParams.FilterDescendantsInstances = {character}

	for angle = 0, 360, 30 do
		local rad = math.rad(angle)
		local offset = Vector3.new(math.cos(rad) * searchRadius, 0, math.sin(rad) * searchRadius)
		local checkPos = scrapPos + offset

		local raycastResult = workspace:Raycast(checkPos + Vector3.new(0, 10, 0), Vector3.new(0, -20, 0), fallbackParams)
		if raycastResult then
			local groundPoint = raycastResult.Position + Vector3.new(0, 3, 0)
			local canStand, _ = canStandAt(groundPoint, character)
			if canStand then
				print("[SafePos] Fallback found safe position")
				return groundPoint
			end
		end
	end

	return nil
end

-- ======================== FIND EXISTING UI ========================

-- Ждём появления UI ScreenGui (создаётся StarterGui.LocalScript)
local uiScreenGui = PlayerGui:WaitForChild("UI", 15)

local tutorialAllLocation = uiScreenGui:WaitForChild("TUTORIALALLLOCATION", 10)
local button = uiScreenGui:WaitForChild("button", 10)
local startcont = tutorialAllLocation:WaitForChild("startcont", 10)
local tutorialLabel = tutorialAllLocation:WaitForChild("tutorial", 10)
local function getDisc()
	local d = tutorialAllLocation:FindFirstChild("disc")
	if d and d:IsA("TextLabel") then
		d.RichText = true
	end
	return d
end

local backbutton = tutorialAllLocation:WaitForChild("backbutton", 10)

-- Скрыт по умолчанию
tutorialAllLocation.Visible = false

-- ======================== TUTORIAL LOGIC ========================

local currentStep = 0
local currentHighlight = nil
local savedStartPosition = nil
local METERS_TO_STUDS = 3.57
local bigEquipCheckConnection = nil -- Для отслеживания экипировки Big
local bigWasEquipped = false -- Флаг, был ли Big экипирован на 4 шаге

-- Steps table: add more steps here later
local tutorialSteps = {
	{position = Vector3.new(-12, 280, -74),  disc = 'Pick-Up The <font color="rgb(255,0,0)">Level2KeyCard</font>'},
	{position = Vector3.new(-57, 280, -265), disc = 'Use <font color="rgb(255,0,0)">Level2KeyCard</font> to Open Door', useGrandparent = true},
	{position = Vector3.new(-70, 280, 146),  disc = 'Pick-Up The Big (Battery)'},
	{position = Vector3.new(-84, 280, 147),  disc = 'Use Big to Open Door', useGrandparent = true, requireEquip = true, equipItem = "Big"},
	{position = Vector3.new(-426, 316, -26), disc = 'Pick-Up The <font color="rgb(0,255,0)">StorageKeyCard</font>'},
	{position = Vector3.new(189, 280, -260), disc = 'Use <font color="rgb(0,255,0)">StorageKeyCard</font> to Open Door', useGrandparent = true},
	{position = Vector3.new(248, 246, -488), disc = 'Pick-Up The <font color="rgb(0,0,255)">Level3KeyCard</font>'},
	{position = Vector3.new(-205, 316, -483), disc = 'Use <font color="rgb(0,0,255)">Level3KeyCard</font> to Open Door', useGrandparent = true},
}

-- Функция для проверки, экипирован ли предмет (в руках персонажа)
local function isItemEquipped(itemName)
	local character = player.Character
	if not character then return false end

	-- Проверяем прямых детей персонажа (инструменты в руках)
	local heldItem = character:FindFirstChild(itemName)
	if heldItem and heldItem:IsA("Tool") then
		return true
	end

	return false
end

-- Функция для проверки, есть ли предмет в инвентаре (Backpack)
local function isItemInBackpack(itemName)
	local backpack = player:FindFirstChild("Backpack")
	if not backpack then return false end

	local backpackItem = backpack:FindFirstChild(itemName)
	if backpackItem and backpackItem:IsA("Tool") then
		return true
	end

	return false
end

-- Функция для проверки, есть ли предмет у игрока (в руках ИЛИ в инвентаре)
local function hasItem(itemName)
	return isItemEquipped(itemName) or isItemInBackpack(itemName)
end

-- Функция для обновления текста дисклеймера для 4 шага
local function updateBigStepDisc()
	local step = tutorialSteps[4] -- 4 шаг (индекс 4 в таблице)
	if currentStep ~= 4 then return end

	local d = getDisc()
	if not d then return end

	-- Проверяем, был ли Big экипирован ранее и теперь исчез
	if bigWasEquipped and not hasItem("Big") then
		d.Text = "Press CONTINUE"
	elseif isItemEquipped("Big") then
		d.Text = "Use Big to Open Door"
		bigWasEquipped = true
	elseif hasItem("Big") then
		d.Text = "Equip Big"
	else
		d.Text = "Pick-Up The Big (Big Battery)"
	end
end

-- Функция для отслеживания экипировки Big на 4 шаге
local function startBigEquipTracking()
	if bigEquipCheckConnection then
		bigEquipCheckConnection:Disconnect()
		bigEquipCheckConnection = nil
	end

	-- Проверяем каждую секунду
	bigEquipCheckConnection = game:GetService("RunService").Heartbeat:Connect(function()
		if currentStep == 4 then
			updateBigStepDisc()
		else
			-- Если вышли с 4 шага, отключаем проверку
			if bigEquipCheckConnection then
				bigEquipCheckConnection:Disconnect()
				bigEquipCheckConnection = nil
			end
		end
	end)
end

-- Отслеживаем когда игрок экипирует/снимает предмет через ChildAdded/ChildRemoved
local function setupCharacterTracking()
	local function onChildAdded(child)
		if currentStep == 4 and child.Name == "Big" and child:IsA("Tool") then
			updateBigStepDisc()
		end
	end

	local function onChildRemoved(child)
		if currentStep == 4 and child.Name == "Big" and child:IsA("Tool") then
			updateBigStepDisc()
		end
	end

	-- Отслеживаем изменения в Backpack
	local function onBackpackChanged()
		if currentStep == 4 then
			updateBigStepDisc()
		end
	end

	-- Функция для отслеживания Backpack
	local function setupBackpackTracking()
		local backpack = player:FindFirstChild("Backpack")
		if backpack then
			backpack.ChildAdded:Connect(onBackpackChanged)
			backpack.ChildRemoved:Connect(onBackpackChanged)
		end
	end

	-- Отслеживаем появление/исчезновение персонажа
	local function onCharacterAdded(character)
		character.ChildAdded:Connect(onChildAdded)
		character.ChildRemoved:Connect(onChildRemoved)
		setupBackpackTracking()
	end

	-- Отслеживаем появление Backpack
	player.ChildAdded:Connect(function(child)
		if child.Name == "Backpack" then
			setupBackpackTracking()
		end
	end)

	if player.Character then
		onCharacterAdded(player.Character)
	end

	if player:FindFirstChild("Backpack") then
		setupBackpackTracking()
	end

	player.CharacterAdded:Connect(onCharacterAdded)
end

local function clearHighlight()
	if currentHighlight then
		currentHighlight:Destroy()
		currentHighlight = nil
	end
end

local function findPartForPrompt(prompt)
	local current = prompt.Parent
	while current do
		if current:IsA("BasePart") then
			return current
		elseif current:IsA("Model") and current.PrimaryPart then
			return current.PrimaryPart
		end
		current = current.Parent
	end
	return nil
end

local function findProximityPromptInRange(position, radiusMeters)
	local radiusStuds = radiusMeters * METERS_TO_STUDS
	local bestPrompt = nil
	local bestDistance = math.huge

	for _, descendant in workspace:GetDescendants() do
		if descendant:IsA("ProximityPrompt") then
			local objText = descendant.ObjectText or ""
			local actText = descendant.ActionText or ""
			local hasInteract = string.find(string.lower(objText), "interact")
				or string.find(string.lower(actText), "interact")

			if hasInteract then
				local part = findPartForPrompt(descendant)
				if part then
					local distance = (part.Position - position).Magnitude
					if distance <= radiusStuds and distance < bestDistance then
						bestPrompt = descendant
						bestDistance = distance
					end
				end
			end
		end
	end
	return bestPrompt
end

local function addHighlight(prompt, useGrandparent)
	local target = nil
	if useGrandparent then
		local gp = prompt.Parent and prompt.Parent.Parent
		if gp then
			if gp:IsA("Model") or gp:IsA("BasePart") then
				target = gp
			else
				-- Traverse up to find Model or BasePart
				local current = gp
				while current do
					if current:IsA("Model") or current:IsA("BasePart") then
						target = current
						break
					end
					current = current.Parent
				end
			end
		end
	else
		target = findPartForPrompt(prompt)
	end
	if target then
		local highlight = Instance.new("Highlight")
		highlight.Name = "TutorialHighlight"
		highlight.FillTransparency = 1
		highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
		highlight.FillColor = Color3.fromRGB(255, 255, 255)
		highlight.OutlineTransparency = 0
		highlight.Parent = target
		currentHighlight = highlight
	end
end

-- Функция для обновления видимости backbutton
local function updateBackButtonVisibility()
	backbutton.Visible = (currentStep > 0)
end

-- Исправленная функция updateUIForStep
local function updateUIForStep(stepNumber, isStarting)
	-- Обновляем видимость backbutton
	updateBackButtonVisibility()

	-- Обновляем дисклеймер (без задержки)
	local d = getDisc()
	if d then
		if stepNumber == 0 and isStarting then
			d.Text = "Press START to start TUTORIAL"
		elseif stepNumber > 0 and stepNumber <= #tutorialSteps then
			local step = tutorialSteps[stepNumber]

			-- Специальная обработка для 4 шага (Big)
			if stepNumber == 4 and step.requireEquip then
				if bigWasEquipped and not hasItem("Big") then
					d.Text = "Good! Next?"
				elseif isItemEquipped("Big") then
					d.Text = "Use Big to Open Door"
				elseif hasItem("Big") then
					d.Text = "Equip Big (Open your inventory)"
				else
					d.Text = "Pick-Up The Big (Battery)"
				end
			elseif step.disc then
				d.Text = step.disc
			else
				d.Text = ""
			end
		else
			d.Text = ""
		end
	end

	-- Обновляем текст кнопки
	if stepNumber == 0 and isStarting then
		startcont.Text = "START"
	elseif stepNumber == #tutorialSteps then
		startcont.Text = "COMPLETE"
	else
		startcont.Text = "CONTINUE"
	end
end

-- Сброс флагов для 4 шага
local function resetStep4Flags()
	bigWasEquipped = false
end

-- Функция для полного перезапуска туториала
local function restartTutorial()
	print("[Tutorial] ===== RESTARTING TUTORIAL =====")

	-- Останавливаем отслеживание Big
	if bigEquipCheckConnection then
		bigEquipCheckConnection:Disconnect()
		bigEquipCheckConnection = nil
	end

	-- Сбрасываем ВСЕ переменные
	resetStep4Flags()
	tutorialCompleted = false
	currentStep = 0
	bigWasEquipped = false

	-- Очищаем подсветку
	clearHighlight()

	-- Показываем UI туториала
	tutorialAllLocation.Visible = true
	button.Visible = false

	-- Сбрасываем текст кнопки и счётчик
	startcont.Text = "START"
	tutorialLabel.Text = "0/8"

	-- Обновляем дисклеймер
	local d = getDisc()
	if d then
		d.Text = "Press START to start TUTORIAL"
	end

	-- Показываем backbutton (если нужно)
	updateBackButtonVisibility()

	-- Телепортируем на стартовую позицию
	if savedStartPosition then
		local char = player.Character
		if char then
			local hrp = char:FindFirstChild("HumanoidRootPart")
			if hrp then
				char:PivotTo(savedStartPosition)
			end
		end
	end

	print("[Tutorial] Restart complete! Ready for new run. Step: " .. currentStep)
end

-- Исправленный обработчик кнопки "OPEN ALL LOCATION"
button.MouseButton1Click:Connect(function()
	-- ПОЛНЫЙ СБРОС перед запуском туториала
	print("[Tutorial] Starting tutorial...")

	-- Сбрасываем все переменные
	currentStep = 0
	tutorialCompleted = false
	bigWasEquipped = false

	-- Останавливаем отслеживание Big
	if bigEquipCheckConnection then
		bigEquipCheckConnection:Disconnect()
		bigEquipCheckConnection = nil
	end

	-- Очищаем подсветку
	clearHighlight()

	-- Сохраняем позицию перед началом туториала
	local char = player.Character
	if char then
		local hrp = char:FindFirstChild("HumanoidRootPart")
		if hrp then
			savedStartPosition = hrp.CFrame
		end
	end

	-- Показываем UI туториала
	tutorialAllLocation.Visible = true
	button.Visible = false

	-- Сбрасываем счётчик
	tutorialLabel.Text = "0/8"

	-- Сбрасываем текст кнопки на START
	startcont.Text = "START"

	-- Обновляем дисклеймер
	local d = getDisc()
	if d then
		d.Text = "Press START to start TUTORIAL"
	end

	-- Скрываем backbutton
	updateBackButtonVisibility()

	print("[Tutorial] Ready! Current step: " .. currentStep .. "/8")
end)

-- Функция для ручного перезапуска (можно вызвать из консоли или привязать к другой клавише)
local function manualRestart()
	restartTutorial()
end

print("[Tutorial] Restart system initialized. Press 'OPEN ALL LOCATION' after completion to restart!")

local originalBackClick = backbutton.MouseButton1Click
-- Исправленный backbutton
backbutton.MouseButton1Click:Connect(function()
	if currentStep <= 0 then return end

	currentStep -= 1

	-- Clear previous highlight
	clearHighlight()

	-- Останавливаем отслеживание Big если вышли с 4 шага
	if currentStep ~= 4 and bigEquipCheckConnection then
		bigEquipCheckConnection:Disconnect()
		bigEquipCheckConnection = nil
	end

	-- Сбрасываем флаги если вышли с 4 шага
	if currentStep ~= 4 then
		resetStep4Flags()
	end

	-- Update counter
	tutorialLabel.Text = tostring(currentStep) .. "/8"

	if currentStep == 0 then
		-- Back to initial state: teleport to saved position
		if savedStartPosition then
			local char = player.Character
			if char then
				char:PivotTo(savedStartPosition)
			end
		end
		-- Обновляем UI (текст START и дисклеймер)
		updateUIForStep(0, true)
	else
		-- Teleport and highlight the step we went back to
		local step = tutorialSteps[currentStep]

		-- Teleport player
		local char = player.Character
		if char then
			local hrp = char:FindFirstChild("HumanoidRootPart")
			if hrp then
				char:PivotTo(CFrame.new(step.position))
			end
		end

		-- Обновляем UI МГНОВЕННО перед задержкой
		updateUIForStep(currentStep, false)

		-- Запускаем отслеживание Big если перешли на 4 шаг
		if currentStep == 4 then
			startBigEquipTracking()
		end

		-- Small delay after teleport, then find and highlight ProximityPrompt
		task.wait(0.5)
		local prompt = findProximityPromptInRange(step.position, 10)
		if prompt then
			addHighlight(prompt, step.useGrandparent)
		end
	end

	-- Make sure tutorial UI is visible
	tutorialAllLocation.Visible = true
end)

-- Исправленный обработчик startcont
startcont.MouseButton1Click:Connect(function()
	print("[Tutorial] Button clicked. Current step: " .. currentStep .. "/" .. #tutorialSteps)

	-- Если туториал уже завершён, перезапускаем его
	if tutorialCompleted then
		restartTutorial()
		return
	end

	-- Если мы на шаге 0 (START) - начинаем туториал с 1 шага
	if currentStep == 0 then
		currentStep = 1
		tutorialLabel.Text = tostring(currentStep) .. "/8"
		clearHighlight()

		-- Телепортируем на первый шаг
		local step = tutorialSteps[currentStep]
		local char = player.Character
		if char and step then
			local hrp = char:FindFirstChild("HumanoidRootPart")
			if hrp then
				char:PivotTo(CFrame.new(step.position))
			end
		end

		-- Обновляем UI
		updateUIForStep(currentStep, false)

		-- Запускаем подсветку
		task.wait(0.5)
		local step = tutorialSteps[currentStep]
		if step then
			local prompt = findProximityPromptInRange(step.position, 10)
			if prompt then
				addHighlight(prompt, step.useGrandparent)
			end
		end

		-- Меняем текст кнопки
		if currentStep == #tutorialSteps then
			startcont.Text = "COMPLETE"
		else
			startcont.Text = "CONTINUE"
		end
		return
	end

	-- Обычная логика для шагов 1-8
	-- Проверяем, нажали ли мы COMPLETE на последнем шаге
	if currentStep == #tutorialSteps then
		-- ЗАВЕРШЕНИЕ ТУТОРИАЛА
		print("[Tutorial] COMPLETE pressed! Finishing tutorial...")
		tutorialCompleted = true
		tutorialAllLocation.Visible = false
		button.Visible = true
		currentStep = 0
		tutorialLabel.Text = "0/8"
		startcont.Text = "START"

		local d = getDisc()
		if d then
			d.Text = "Tutorial completed! Press 'OPEN ALL LOCATION' to restart"
			task.wait(2)
			d.Text = ""
		end

		clearHighlight()
		return
	end

	-- Переход к следующему шагу (1 -> 2, 2 -> 3, и т.д. до 7 -> 8)
	currentStep = currentStep + 1
	tutorialLabel.Text = tostring(currentStep) .. "/8"
	clearHighlight()

	-- Останавливаем отслеживание Big если вышли с 4 шага
	if currentStep - 1 == 4 and bigEquipCheckConnection then
		bigEquipCheckConnection:Disconnect()
		bigEquipCheckConnection = nil
	end

	-- Сбрасываем флаги если вышли с 4 шага
	if currentStep - 1 == 4 then
		resetStep4Flags()
	end

	-- Телепорт и подсветка для нового шага
	local step = tutorialSteps[currentStep]
	if step then
		local char = player.Character
		if char then
			local hrp = char:FindFirstChild("HumanoidRootPart")
			if hrp then
				char:PivotTo(CFrame.new(step.position))
			end
		end

		updateUIForStep(currentStep, false)

		if currentStep == 4 then
			startBigEquipTracking()
		end

		task.wait(0.5)
		local prompt = findProximityPromptInRange(step.position, 10)
		if prompt then
			addHighlight(prompt, step.useGrandparent)
		end
	end

	-- Меняем текст кнопки
	if currentStep == #tutorialSteps then
		startcont.Text = "COMPLETE"
	else
		startcont.Text = "CONTINUE"
	end
end)

-- Запускаем отслеживание экипировки через Character
setupCharacterTracking()

-- Инициализация: скрываем backbutton при старте
updateBackButtonVisibility()

local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

local startPosition = nil
local isTeleporting = false
local currentRotationConnection = nil
local highlightedObjects = {}
local highlightedNPCs = {} -- Подсветка NPC
local npcDistanceLabels = {} -- Текст дистанции над NPC
local lastTeleportTime = 0
local teleportCooldown = 0.5 -- Задержка между телепортами в секундах (уменьшено)
local NPC_CHECK_RADIUS = 30 -- Радиус проверки NPC (было 30, теперь 10)
local autoTeleportEnabled = true -- Авто-телепорт после сбора
local lastInventoryCount = 0 -- Последнее количество предметов в инвентаре
local teleportToRandomScrap -- Forward declaration
local teleportRetryCount = 0
local MAX_TELEPORT_RETRIES = 10
local totalTeleportAttempts = 0
local MAX_TOTAL_ATTEMPTS = 30 -- Общий лимит попыток за сессию

-- === UI: Подсказка через Helper из StarterGui.UI ===
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ScrapHelperGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Находим Helper UI (ждём загрузки PlayerGui)
local helperFrame = nil
local helperDesc = nil
local playerGui = player:FindFirstChild("PlayerGui")
local uiScreenGui = nil

-- Ждём появления UI в PlayerGui (StarterGui копируется с задержкой)
if playerGui then
	uiScreenGui = playerGui:FindFirstChild("UI")
	if not uiScreenGui then
		-- UI ещё не загрузился — ждём
		local child = playerGui:WaitForChild("UI", 10)
		uiScreenGui = child
	end
end

if uiScreenGui then
	-- Ищем standalone prompt (тот что не внутри Frame) — он используется как Helper
	for _, child in ipairs(uiScreenGui:GetChildren()) do
		if child.Name == "prompt" and child:FindFirstChild("Frame") then
			local descLabel = child.Frame:FindFirstChild("desc")
			if descLabel then
				helperFrame = child
				helperDesc = descLabel
				helperFrame.Visible = false -- Скрыт по умолчанию
				break
			end
		end
	end
end

-- === UI: Позиция, ориентация и стоимость слева сверху ===
local positionLabel = Instance.new("TextLabel")
positionLabel.Name = "PositionLabel"
positionLabel.Size = UDim2.new(0, 250, 0, 80)
positionLabel.Position = UDim2.new(0, 10, 0, 10)
positionLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
positionLabel.BackgroundTransparency = 1
positionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
positionLabel.Text = "Position: 0, 0, 0\nOrientation: 0, 0, 0\nScrap Count: 0"
positionLabel.Font = Enum.Font.Jura
positionLabel.TextSize = 14
positionLabel.TextXAlignment = Enum.TextXAlignment.Left
positionLabel.TextYAlignment = Enum.TextYAlignment.Top
positionLabel.Parent = screenGui

-- === UI: Кнопки из пользовательского UI ===
local searchButton = nil
local searchPromptFrame = nil
local sellButton = nil
local sellPromptFrame = nil
local stopButton = nil
local stopPromptFrame = nil
local autoTeleportEnabled = false
local isSearchLocked = false

-- Lock/UnLock состояние для каждого prompt
local lockedPrompts = {} -- promptFrame -> true/false
local originalUseTexts = {} -- promptFrame -> оригинальный текст USE кнопки

-- Используем уже найденный uiScreenGui (с ожиданием загрузки)
local uiFrame = uiScreenGui and uiScreenGui:FindFirstChild("Frame")

local function setStatus(text)
	if helperFrame and helperDesc then
		helperDesc.Text = text or ""
		helperFrame.Visible = text and text ~= ""
	end
	print("[ScrapHelper] " .. (text or ""))
end

if uiFrame then
	for _, promptFrame in ipairs(uiFrame:GetChildren()) do
		if promptFrame.Name == "prompt" then
			local disc = promptFrame:FindFirstChild("disc")
			local btnFrame = promptFrame:FindFirstChild("promptButton1")
			local btn = btnFrame and btnFrame:FindFirstChild("button")

			if disc and btn then
				local discText = disc.Text
				if string.find(discText, "Search") then
					searchButton = btn
					searchPromptFrame = promptFrame
				elseif string.find(discText, "Sell") then
					sellButton = btn
					sellPromptFrame = promptFrame
				elseif string.find(discText, "Stop") then
					stopButton = btn
					stopPromptFrame = promptFrame
				end
			end

			-- Подключаем Lock/UnLock кнопку
			local lockBtn = promptFrame:FindFirstChild("button") -- TextButton "Lock"
			local lockFrame = promptFrame:FindFirstChild("lock") -- Frame с иконкой
			local useBtn = btnFrame and btnFrame:FindFirstChild("button") -- promptButton1.button (USE)
			if lockBtn and lockFrame then
				lockedPrompts[promptFrame] = false
				lockFrame.Visible = false

				-- Сохраняем оригинальный текст USE кнопки
				if useBtn then
					originalUseTexts[promptFrame] = useBtn.Text
				end

				lockBtn.MouseButton1Click:Connect(function()
					local isLocked = lockedPrompts[promptFrame]
					lockedPrompts[promptFrame] = not isLocked

					if not isLocked then
						lockFrame.Visible = true
						lockBtn.Text = "UnLock"
						if useBtn then useBtn.Text = " " end

						-- Если это Search кнопка - обновляем флаг блокировки
						if disc and string.find(disc.Text, "Search") then
							isSearchLocked = true
							print("[Farmer] Search LOCKED - rescue system DISABLED")
							setStatus("Search LOCKED | Rescue system OFF")
						end
					else
						lockFrame.Visible = false
						lockBtn.Text = "Lock"
						if useBtn then useBtn.Text = originalUseTexts[promptFrame] or "USE" end

						-- Если это Search кнопка - обновляем флаг блокировки
						if disc and string.find(disc.Text, "Search") then
							isSearchLocked = false
							print("[Farmer] Search UNLOCKED - rescue system ENABLED")
							setStatus("Search UNLOCKED | Rescue system ON")
						end
					end
				end)
			end
		end
	end
end

-- Fallback: невидимые заглушки если кнопки не найдены
if not searchButton then
	searchButton = Instance.new("TextButton")
	searchButton.Parent = screenGui
end
if not sellButton then
	sellButton = Instance.new("TextButton")
	sellButton.Visible = false
	sellButton.Parent = screenGui
end
if not stopButton then
	stopButton = Instance.new("TextButton")
	stopButton.Visible = false
	stopButton.Parent = screenGui
end

-- Поиск твердой поверхности НИЖЕ скрапа (raycast вниз от скрапа)
local function findGroundBelow(scrapPosition)
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
	raycastParams.FilterDescendantsInstances = {player.Character}

	-- Пробуем найти землю в нескольких точках вокруг скрапа
	local offsets = {
		Vector3.new(0, 0, 0),      -- Точно под скрапом
		Vector3.new(2, 0, 0),      -- Справа
		Vector3.new(-2, 0, 0),     -- Слева
		Vector3.new(0, 0, 2),      -- Спереди
		Vector3.new(0, 0, -2),     -- Сзади
		Vector3.new(1.5, 0, 1.5),  -- По диагонали
		Vector3.new(-1.5, 0, 1.5),
		Vector3.new(1.5, 0, -1.5),
		Vector3.new(-1.5, 0, -1.5),
	}

	for _, offset in ipairs(offsets) do
		local checkPos = scrapPosition + offset
		-- Raycast ВНИЗ от позиции скрапа (а не сверху)
		local rayOrigin = checkPos + Vector3.new(0, 2, 0)  -- Чуть выше скрапа
		local rayDirection = Vector3.new(0, -200, 0)  -- ВНИЗ на 200 studs

		local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)

		if raycastResult then
			-- Нашли поверхность ниже скрапа
			local groundPoint = raycastResult.Position + Vector3.new(0, 3, 0)
			print("[Farmer] Found ground below at distance: " .. math.floor(scrapPosition.Y - raycastResult.Position.Y) .. " studs")
			return groundPoint
		end
	end

	return nil
end

-- Получить всех живых NPC (исключая игроков)
local function getAllNPCs()
	local npcs = {}
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("Model") then
			-- Пропускаем всех игроков
			local isPlayer = false
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr.Character == obj then
					isPlayer = true
					break
				end
			end
			if isPlayer then continue end

			local humanoid = obj:FindFirstChildWhichIsA("Humanoid")
			if humanoid and humanoid.Health > 0 then
				local hrp = obj:FindFirstChild("HumanoidRootPart")
				if hrp then
					table.insert(npcs, {model = obj, hrp = hrp, humanoid = humanoid})
				end
			end
		end
	end
	return npcs
end

-- Есть ли живой NPC в радиусе? (исключая игроков)
local function hasNPCNearby(position, radius)
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("Model") then
			-- Пропускаем всех игроков
			local isPlayer = false
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr.Character == obj then
					isPlayer = true
					break
				end
			end
			if isPlayer then continue end

			local humanoid = obj:FindFirstChildWhichIsA("Humanoid")
			if humanoid and humanoid.Health > 0 then
				local hrp = obj:FindFirstChild("HumanoidRootPart")
				if hrp and (hrp.Position - position).Magnitude <= radius then
					return true, obj.Name
				end
			end
		end
	end
	return false
end

local function isPositionSafe(position, checkNPC)
	-- Если параметр checkNPC не передан, по умолчанию true
	if checkNPC == nil then
		checkNPC = true
	end

	-- Проверка наличия твердой поверхности
	local safePos = findGroundBelow(position)
	if not safePos then
		return false, "no ground"
	end

	-- Проверка расстояния до земли (не слишком высоко)
	local distanceToGround = (position - safePos).Magnitude
	if distanceToGround > 10 then
		return false, "too high"
	end

	-- Проверка NPC в радиусе NPC_CHECK_RADIUS
	if checkNPC then
		local hasNPC, npcName = hasNPCNearby(position, NPC_CHECK_RADIUS)
		if hasNPC then
			return false, "npc nearby: " .. npcName
		end
	end

	return true, "safe"
end

-- Проверка, находится ли позиция внутри стены
local function isPositionInsideWall(position)
	local character = player.Character
	if not character then return false end

	-- Проверяем коробку размером с персонажа
	local boxSize = Vector3.new(2, 5, 2)
	local boxCFrame = CFrame.new(position + Vector3.new(0, 2.5, 0))

	local overlappingParts = workspace:GetPartBoundsInBox(boxCFrame, boxSize)

	for _, part in ipairs(overlappingParts) do
		if part:IsDescendantOf(character) then continue end
		if not part.CanCollide then continue end
		if part.Transparency >= 1 then continue end
		return true, part.Name
	end

	return false
end

-- Найти все доступные скрапы (ProximityPrompt.Enabled == true, Parent.Transparency < 1)
local function getScrapPrompts()
	local prompts = {}
	for _, desc in ipairs(workspace:GetDescendants()) do
		if desc:IsA("ProximityPrompt") and desc.ObjectText == "Collect scrap" then
			-- Проверяем что ProximityPrompt включён
			if not desc.Enabled then
				continue
			end

			-- Находим родительский BasePart и проверяем Transparency
			local basePart = desc.Parent
			if basePart and basePart:IsA("BasePart") then
				-- Проверяем что объект не прозрачный (не собран)
				if basePart.Transparency >= 1 then
					continue
				end

				table.insert(prompts, { prompt = desc, basePart = basePart })
			end
		end
	end
	return prompts
end

-- Получить все доступные скрапы (без строгих проверок)
local function getSafeScraps()
	return getScrapPrompts()
end

-- Подсветка конкретного объекта
local function highlightObject(obj, color)
	if not obj or not obj:IsA("BasePart") then return end

	local highlight = Instance.new("Highlight")
	highlight.FillColor = color or Color3.fromRGB(255, 255, 0)
	highlight.OutlineColor = Color3.fromRGB(255, 200, 0)
	highlight.FillTransparency = 0.5
	highlight.OutlineTransparency = 0.3
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	highlight.Parent = obj

	table.insert(highlightedObjects, highlight)
	return highlight
end

-- Очистка всех подсветок скрапов
local function clearHighlights()
	for _, highlight in pairs(highlightedObjects) do
		if highlight and highlight.Parent then
			highlight:Destroy()
		end
	end
	highlightedObjects = {}
end

-- Очистка подсветки NPC
local function clearNPCHighlights()
	for _, highlight in pairs(highlightedNPCs) do
		if highlight and highlight.Parent then
			highlight:Destroy()
		end
	end
	highlightedNPCs = {}

	for _, label in pairs(npcDistanceLabels) do
		if label and label.Parent then
			label:Destroy()
		end
	end
	npcDistanceLabels = {}
end

-- Цены за скрапы
local SCRAP_PRICES = {
	Screw = 1,
	Baterry = 2,
	Pipe = 2,
	Cleaner = 1,
	Gear = 7,
	Bucket = 2
}

-- Подсчитать стоимость инвентаря
local function getInventoryValue()
	local totalValue = 0
	local itemCounts = {}

	local backpack = player:FindFirstChild("Backpack")
	if backpack then
		for _, item in ipairs(backpack:GetChildren()) do
			local itemName = item.Name
			if SCRAP_PRICES[itemName] then
				itemCounts[itemName] = (itemCounts[itemName] or 0) + 1
				totalValue = totalValue + SCRAP_PRICES[itemName]
			end
		end
	end

	return totalValue, itemCounts
end

-- Обновить отображение позиции и стоимости
local function updatePositionDisplay()
	local character = player.Character
	if character then
		local hrp = character:FindFirstChild("HumanoidRootPart")
		if hrp then
			local pos = hrp.Position
			local totalValue, itemCounts = getInventoryValue()

			local rot = hrp.Orientation
			local posText = string.format("Position: %.0f, %.0f, %.0f\nOrientation: %.0f, %.0f, %.0f\nScrap Count: %d", pos.X, pos.Y, pos.Z, rot.X, rot.Y, rot.Z, totalValue)
			positionLabel.Text = posText
		end
	end
end

-- Обновить видимость prompt Search
local function updateSearchButtonVisibility()
	if isTeleporting then
		if searchPromptFrame then searchPromptFrame.Visible = false end
		return
	end

	local safeScraps = getSafeScraps()
	if #safeScraps == 0 then
		if searchPromptFrame then searchPromptFrame.Visible = false end
	else
		if searchPromptFrame then searchPromptFrame.Visible = true end
	end
end

-- Подсветка ВСЕХ скрапов (всегда видны)
local function highlightAllScraps()
	-- Очищаем только подсветку скрапов, не трогаем NPC
	clearHighlights()

	local allScraps = getScrapPrompts()
	local highlightedModels = {} -- Чтобы не дублировать подсветку для одной модели

	for _, data in ipairs(allScraps) do
		local basePart = data.basePart
		if basePart and basePart:IsA("BasePart") then
			-- Находим родительскую модель для подсветки
			local modelToHighlight = basePart
			local current = basePart.Parent
			while current and current ~= workspace do
				if current:IsA("Model") then
					modelToHighlight = current
					break
				end
				current = current.Parent
			end

			-- Проверяем, не подсвечивали ли уже эту модель
			if not highlightedModels[modelToHighlight] then
				highlightedModels[modelToHighlight] = true

				local highlight = Instance.new("Highlight")
				highlight.FillColor = Color3.fromRGB(255, 255, 255)
				highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
				highlight.FillTransparency = 1 -- Прозрачная заливка
				highlight.OutlineTransparency = 0 -- Белый outline
				highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				highlight.Parent = modelToHighlight
				table.insert(highlightedObjects, highlight)
			end
		end
	end

	return #allScraps
end

-- Подсветка NPC и показ дистанции над головой
local function highlightNPCs()
	-- Очищаем подсветку NPC
	clearNPCHighlights()

	local character = player.Character
	if not character then return 0 end
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then return 0 end

	local npcs = getAllNPCs()
	for _, npcData in ipairs(npcs) do
		local npc = npcData.model
		local npcHrp = npcData.hrp

		-- Подсветка NPC (красный outline, прозрачная заливка)
		local highlight = Instance.new("Highlight")
		highlight.FillColor = Color3.fromRGB(255, 0, 0)
		highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
		highlight.FillTransparency = 1 -- Прозрачная заливка
		highlight.OutlineTransparency = 0 -- Красный outline
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.Parent = npc
		table.insert(highlightedNPCs, highlight)

		-- Текст дистанции над головой NPC (без фона, маленький)
		local distance = (hrp.Position - npcHrp.Position).Magnitude
		local billboardGui = Instance.new("BillboardGui")
		billboardGui.Name = "DistanceLabel"
		billboardGui.Size = UDim2.new(0, 50, 0, 20)
		billboardGui.StudsOffset = Vector3.new(0, 3, 0)
		billboardGui.AlwaysOnTop = true
		billboardGui.Parent = npcHrp

		local distanceLabel = Instance.new("TextLabel")
		distanceLabel.Size = UDim2.new(1, 0, 1, 0)
		distanceLabel.BackgroundTransparency = 1 -- Без фона
		distanceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		distanceLabel.Text = string.format("%dm", math.floor(distance)) -- Формат: 500m
		distanceLabel.Font = Enum.Font.Code -- Моноширинный шрифт
		distanceLabel.TextSize = 12
		distanceLabel.TextStrokeTransparency = 0.5 -- Лёгкая обводка текста для читаемости
		distanceLabel.Parent = billboardGui

		table.insert(npcDistanceLabels, billboardGui)
	end

	return #npcs
end

-- Обновление подсветки и дистанций (вызывается регулярно)
local function updateHighlights()
	updatePositionDisplay()
	local scrapCount = highlightAllScraps()
	local npcCount = highlightNPCs()
	setStatus("Scraps: " .. scrapCount .. " | NPCs: " .. npcCount .. " | Press R to teleport")
	updateSearchButtonVisibility()
end

-- Плавный поворот камеры к цели
local function rotateCameraTo(targetPosition, callback)
	if currentRotationConnection then
		currentRotationConnection:Disconnect()
		currentRotationConnection = nil
	end

	local camera = workspace.CurrentCamera
	if not camera then 
		if callback then callback() end
		return 
	end

	local character = player.Character
	if not character then 
		if callback then callback() end
		return 
	end

	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then 
		if callback then callback() end
		return 
	end

	local direction = (targetPosition - hrp.Position).unit
	local targetCFrame = CFrame.lookAt(hrp.Position, hrp.Position + direction)

	local startCFrame = camera.CFrame
	local duration = 0.25
	local startTime = tick()

	local connection
	connection = RunService.RenderStepped:Connect(function()
		local elapsed = tick() - startTime
		local alpha = math.min(1, elapsed / duration)
		local easeAlpha = 1 - (1 - alpha)^3

		camera.CFrame = startCFrame:Lerp(targetCFrame, easeAlpha)

		if alpha >= 1 then
			connection:Disconnect()
			if currentRotationConnection == connection then
				currentRotationConnection = nil
			end
			if callback then callback() end
		end
	end)

	currentRotationConnection = connection
end

-- Сохраняем стартовую позицию
local function saveStartPosition()
	local character = player.Character
	if character then
		local hrp = character:FindFirstChild("HumanoidRootPart")
		if hrp then
			startPosition = hrp.CFrame
			setStatus("Start position saved! Press E to search for scraps")
			return true
		end
	end
	return false
end

-- Телепорт на старт
local function teleportToStart()
	if isTeleporting then
		setStatus("Please wait, teleporting...")
		return
	end

	local character = player.Character
	if not character then 
		setStatus("No character found!")
		return 
	end

	local hrp = character:FindFirstChild("HumanoidRootPart")
	if hrp and startPosition then
		isTeleporting = true

		-- Проверяем безопасность стартовой позиции
		local safePos = findGroundBelow(startPosition.Position)
		if safePos then
			hrp.CFrame = CFrame.new(safePos) * CFrame.Angles(0, hrp.Orientation.Y, 0)
		else
			hrp.CFrame = startPosition
		end

		local camera = workspace.CurrentCamera
		if camera then
			rotateCameraTo(hrp.Position)
		end

		setStatus("Returned to start position!")
		task.wait(0.5)
		isTeleporting = false

		-- Обновляем подсветку
		updateHighlights()
	else
		setStatus("Start position not saved! Walk a bit and try again.")
		saveStartPosition()
	end
end

-- Получить количество предметов в инвентаре игрока
local function getInventoryCount()
	local backpack = player:FindFirstChild("Backpack")
	if backpack then
		return #backpack:GetChildren()
	end
	return 0
end

-- Проверка, собран ли скрап (ProximityPrompt.Enabled == false И Parent.Transparency >= 1)
local function isScrapCollected(prompt)
	if not prompt then return false end

	-- Проверяем, что ProximityPrompt существует
	if not prompt.Parent then return true end -- Если prompt удалён, считаем что собран

	-- Проверяем Enabled и Transparency родителя
	local isEnabled = prompt.Enabled
	local parentPart = prompt.Parent
	local transparency = 0

	if parentPart and parentPart:IsA("BasePart") then
		transparency = parentPart.Transparency
	end

	-- Скрап собран если: prompt отключён И родитель прозрачный
	if not isEnabled and transparency >= 1 then
		return true
	end

	-- Также считаем собранным если prompt или родитель удалены
	if not prompt or not prompt.Parent or not parentPart or not parentPart:IsDescendantOf(workspace) then
		return true
	end

	return false
end

-- Forward declarations (исправление ошибки порядка объявления)
local stopSafetyMonitor
local startSafetyMonitor

-- ИЗМЕНИ функцию rescuePlayer (найди её в коде и замени):
local function rescuePlayer(reason)
	-- ПРОВЕРКА: если Search заблокирован - НЕ спасаем
	if isSearchLocked then
		print("[Farmer] Rescue SKIPPED - Search is locked")
		return
	end

	print("[Farmer] RESCUE triggered: " .. (reason or "unknown"))
	stopSafetyMonitor()

	local character = player.Character
	if not character then
		startSafetyMonitor()
		return
	end

	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then
		startSafetyMonitor()
		return
	end

	isTeleporting = true

	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
	raycastParams.FilterDescendantsInstances = {character}

	local rayOrigin = Vector3.new(hrp.Position.X, 1000, hrp.Position.Z)
	local rayDirection = Vector3.new(0, -2000, 0)

	local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)

	if raycastResult then
		local groundPos = raycastResult.Position + Vector3.new(0, 3, 0)
		hrp.CFrame = CFrame.new(groundPos) * CFrame.Angles(0, hrp.Orientation.Y, 0)
		print("[Farmer] Rescued to ground at Y=" .. math.floor(groundPos.Y))
		setStatus("Rescued! Back on solid ground")
	else
		if startPosition then
			local safePos = findGroundBelow(startPosition.Position)
			if safePos then
				hrp.CFrame = CFrame.new(safePos) * CFrame.Angles(0, hrp.Orientation.Y, 0)
			else
				hrp.CFrame = startPosition
			end
			print("[Farmer] Rescued to start position")
			setStatus("Rescued! Back at start")
		else
			print("[Farmer] Cannot rescue - no start position!")
			setStatus("Cannot rescue! No start position saved")
		end
	end

	isTeleporting = false
	startSafetyMonitor()

	if totalTeleportAttempts < MAX_TOTAL_ATTEMPTS then
		task.wait(1)
		task.spawn(teleportToRandomScrap)
	else
		setStatus("Too many rescue attempts. Press R to retry.")
		searchButton.Visible = true
		updateHighlights()
	end
end


-- === Safety Monitor: падение + NPC + здоровье ===
local safetyMonitorConnection = nil
local safetyFallTime = 0
local safetyWasFalling = false
local safetyLastHealth = 100
local safetyNpcCheckTimer = 0
local SAFETY_NPC_CHECK_INTERVAL = 0.3
local SAFETY_FALL_THRESHOLD = 0.3
local SAFETY_Y_MIN = -50

stopSafetyMonitor = function()
	if safetyMonitorConnection then
		safetyMonitorConnection:Disconnect()
		safetyMonitorConnection = nil
	end
end

startSafetyMonitor = function()
	stopSafetyMonitor()

	safetyFallTime = 0
	safetyWasFalling = false
	safetyNpcCheckTimer = 0

	local character = player.Character
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		safetyLastHealth = humanoid.Health
	end

	safetyMonitorConnection = RunService.Heartbeat:Connect(function(deltaTime)
		if isTeleporting then return end

		-- Переполучаем ссылки (персонаж мог измениться)
		local char = player.Character
		if not char then return end
		local h = char:FindFirstChild("HumanoidRootPart")
		local hum = char:FindFirstChildOfClass("Humanoid")
		if not h or not hum or hum.Health <= 0 then return end

		-- Проверка 1: Упал за карту (Y слишком низкий)
		if h.Position.Y < SAFETY_Y_MIN then
			task.spawn(rescuePlayer, "below map")
			return
		end

		-- Проверка 2: Падение
		local velocity = h.AssemblyLinearVelocity
		if velocity.Y < -10 then
			if not safetyWasFalling then
				safetyWasFalling = true
				safetyFallTime = 0
			else
				safetyFallTime = safetyFallTime + deltaTime
			end

			if safetyFallTime > SAFETY_FALL_THRESHOLD then
				task.spawn(rescuePlayer, "falling")
				return
			end
		else
			safetyWasFalling = false
			safetyFallTime = 0
		end

		-- Проверка 3: Здоровье падает (NPC атакует)
		if hum.Health < safetyLastHealth then
			local hasNPC, npcName = hasNPCNearby(h.Position, NPC_CHECK_RADIUS)
			if hasNPC then
				task.spawn(rescuePlayer, "npc damage: " .. npcName)
				return
			end
		end
		safetyLastHealth = hum.Health

		-- Проверка 4: NPC подошёл близко (периодическая проверка каждые 0.3с)
		safetyNpcCheckTimer = safetyNpcCheckTimer + deltaTime
		if safetyNpcCheckTimer >= SAFETY_NPC_CHECK_INTERVAL then
			safetyNpcCheckTimer = 0
			local hasNPC, npcName = hasNPCNearby(h.Position, NPC_CHECK_RADIUS)
			if hasNPC then
				task.spawn(rescuePlayer, "npc nearby: " .. npcName)
				return
			end
		end
	end)
end

-- Проверка, есть ли NPC рядом с позицией
local function isNPCNearbyPosition(position, radius)
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("Model") then
			local isPlayer = false
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr.Character == obj then
					isPlayer = true
					break
				end
			end
			if isPlayer then continue end

			local humanoid = obj:FindFirstChildWhichIsA("Humanoid")
			if humanoid and humanoid.Health > 0 then
				local hrp = obj:FindFirstChild("HumanoidRootPart")
				if hrp and (hrp.Position - position).Magnitude <= radius then
					return true, obj.Name
				end
			end
		end
	end
	return false
end

teleportToRandomScrap = function()
	print("[Farmer] === Teleport to random scrap ===")

	if teleportRetryCount >= MAX_TELEPORT_RETRIES then
		setStatus("No safe scrap found after " .. MAX_TELEPORT_RETRIES .. " attempts")
		teleportRetryCount = 0
		isTeleporting = false
		searchButton.Visible = true
		updateHighlights()
		return
	end

	if isTeleporting then
		print("[Farmer] Already teleporting, skipping...")
		return
	end

	teleportRetryCount = teleportRetryCount + 1
	totalTeleportAttempts = totalTeleportAttempts + 1

	if totalTeleportAttempts > MAX_TOTAL_ATTEMPTS then
		setStatus("Too many teleport attempts. Press R to retry.")
		teleportRetryCount = 0
		totalTeleportAttempts = 0
		isTeleporting = false
		searchButton.Visible = true
		updateHighlights()
		return
	end

	local timeSinceLastTeleport = tick() - lastTeleportTime
	if timeSinceLastTeleport < teleportCooldown then
		setStatus("Please wait " .. (teleportCooldown - timeSinceLastTeleport) .. " seconds")
		return
	end

	local character = player.Character
	if not character then 
		setStatus("No character found!")
		searchButton.Visible = true
		return 
	end

	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then 
		setStatus("HumanoidRootPart not found!")
		searchButton.Visible = true
		return 
	end

	if not startPosition then
		saveStartPosition()
	end

	isTeleporting = true

	lastInventoryCount = getInventoryCount()
	local inventoryItems = {}
	local backpack = player:FindFirstChild("Backpack")
	if backpack then
		for _, item in ipairs(backpack:GetChildren()) do
			inventoryItems[item.Name] = true
		end
	end

	local allScraps = getScrapPrompts()
	print("[Farmer] Total scraps found: " .. #allScraps)

	-- Фильтруем скрапы, у которых есть БЕЗОПАСНАЯ позиция рядом
	local safeScraps = {}
	for _, data in ipairs(allScraps) do
		local safePos = findSafePositionNearScrap(data.basePart, character)
		if safePos then
			-- Доп. проверка: нет ли NPC рядом с этой позицией
			local hasNPC, npcName = hasNPCNearby(safePos, NPC_CHECK_RADIUS)
			if not hasNPC then
				table.insert(safeScraps, {
					prompt = data.prompt,
					basePart = data.basePart,
					safePosition = safePos
				})
			else
				print("[Farmer] Scrap skipped (NPC nearby): " .. npcName)
			end
		else
			print("[Farmer] Scrap skipped (no safe position found)")
		end
	end

	print("[Farmer] Safe scraps with valid positions: " .. #safeScraps)

	if #safeScraps == 0 then
		setStatus("No safe teleport positions found! Total scraps: " .. #allScraps)
		isTeleporting = false
		updateHighlights()
		return
	end

	local randomIndex = math.random(1, #safeScraps)
	local targetData = safeScraps[randomIndex]
	local prompt = targetData.prompt
	local basePart = targetData.basePart
	local teleportPosition = targetData.safePosition

	local scrapName = basePart.Parent and basePart.Parent.Name or basePart.Name
	print("[Farmer] Teleporting to scrap: " .. scrapName)
	print("[Farmer] Safe position: " .. tostring(teleportPosition))

	lastTeleportTime = tick()

	-- Сохраняем текущую высоту перед телепортом для отката
	local oldPosition = hrp.Position

	-- Телепорт
	local success = pcall(function()
		hrp.CFrame = CFrame.new(teleportPosition) * CFrame.Angles(0, hrp.Orientation.Y, 0)
	end)

	if not success then
		print("[Farmer] Teleport failed!")
		isTeleporting = false
		task.wait(0.3)
		task.spawn(teleportToRandomScrap)
		return
	end

	task.wait(0.2)

	-- Финальная проверка после телепорта
	local canStand, reason = canStandAt(hrp.Position, character)
	if not canStand then
		print("[Farmer] Bad teleport! " .. reason .. " - rolling back")
		-- Откат на старую позицию
		hrp.CFrame = CFrame.new(oldPosition)
		isTeleporting = false
		task.wait(0.3)
		task.spawn(teleportToRandomScrap)
		return
	end

	-- Проверка падения
	if hrp.AssemblyLinearVelocity.Y < -20 then
		print("[Farmer] Falling after teleport - rolling back")
		hrp.CFrame = CFrame.new(oldPosition)
		isTeleporting = false
		task.wait(0.3)
		task.spawn(teleportToRandomScrap)
		return
	end

	-- Проверка NPC
	local hasNPC, npcName = hasNPCNearby(hrp.Position, NPC_CHECK_RADIUS)
	if hasNPC then
		print("[Farmer] NPC nearby after teleport: " .. npcName)
		isTeleporting = false
		task.wait(0.3)
		task.spawn(teleportToRandomScrap)
		return
	end

	startSafetyMonitor()

	task.wait(0.1)
	rotateCameraTo(basePart.Position)

	setStatus("Teleported to: " .. basePart.Parent.Name)

	-- Попытка сбора
	task.wait(0.3)
	pcall(function()
		if prompt and prompt.Parent then
			local keyCode = prompt.KeyboardKeyCode
			VirtualInputManager:SendKeyEvent(true, keyCode, false, nil)
			task.wait(0.15)
			VirtualInputManager:SendKeyEvent(false, keyCode, false, nil)
		end
	end)

	task.wait(1.0)

	local collected = isScrapCollected(prompt)
	local newInventoryCount = getInventoryCount()

	if newInventoryCount > lastInventoryCount then
		collected = true
	end

	local newBackpack = player:FindFirstChild("Backpack")
	if newBackpack then
		for _, item in ipairs(newBackpack:GetChildren()) do
			if not inventoryItems[item.Name] then
				if item.Name == scrapName or string.find(item.Name, scrapName) or string.find(scrapName, item.Name) then
					collected = true
					break
				end
			end
		end
	end

	isTeleporting = false
	teleportRetryCount = 0
	totalTeleportAttempts = 0

	if collected then
		setStatus("✓ Scrap collected!")
		updateHighlights()
	else
		setStatus("Scrap not collected | Press R to try again")
	end

	searchButton.Visible = true
	updateHighlights()
end

-- === Телепорт на точку продажи ===
local SELL_POSITION = CFrame.new(85, 280, -446)

local function teleportToSell()
	if isTeleporting then
		setStatus("Please wait, teleporting...")
		return
	end

	local character = player.Character
	if not character then
		setStatus("No character found!")
		return
	end

	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then
		setStatus("HumanoidRootPart not found!")
		return
	end

	isTeleporting = true
	hrp.CFrame = SELL_POSITION * CFrame.Angles(0, hrp.Orientation.Y, 0)

	local camera = workspace.CurrentCamera
	if camera then
		rotateCameraTo(hrp.Position)
	end

	setStatus("Teleported to sell point!")
	task.wait(0.5)
	isTeleporting = false
	updateHighlights()
end

-- Переключатель видимости UI
local uiVisible = true

-- Обработка нажатий клавиш
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end

	if input.KeyCode == Enum.KeyCode.R then
		-- SEARCH - проверяем блокировку
		if searchPromptFrame and lockedPrompts[searchPromptFrame] then return end
		teleportRetryCount = 0
		totalTeleportAttempts = 0
		teleportToRandomScrap()
	elseif input.KeyCode == Enum.KeyCode.Z then
		-- SELL - проверяем блокировку
		if sellPromptFrame and lockedPrompts[sellPromptFrame] then return end
		teleportToSell()
	elseif input.KeyCode == Enum.KeyCode.Q then
		-- STOP - проверяем блокировку
		if stopPromptFrame and lockedPrompts[stopPromptFrame] then return end
		teleportToStart()
	elseif input.KeyCode == Enum.KeyCode.H then
		-- Скрыть/показать UI
		uiVisible = not uiVisible
		if uiScreenGui then uiScreenGui.Enabled = uiVisible end
	end
end)

-- Обработка нажатий кнопок (подключаются после определения функций, см. конец скрипта)

-- === Сортировка инвентаря: скрап в слот 9+ ===
local function isScrapItem(itemName)
	return SCRAP_PRICES[itemName] ~= nil
end

local isReordering = false

local function reorderBackpack()
	if isReordering then return end
	isReordering = true

	local backpack = player:FindFirstChild("Backpack")
	if not backpack then isReordering = false return end

	local children = backpack:GetChildren()
	if #children == 0 then isReordering = false return end

	-- Проверяем нужна ли перестановка
	local needsReorder = false
	local foundScrap = false
	for _, item in ipairs(children) do
		if isScrapItem(item.Name) then
			foundScrap = true
		elseif foundScrap then
			needsReorder = true
			break
		end
	end

	if not needsReorder then isReordering = false return end

	-- Разделяем на скрап и не-скрап
	local nonScrapItems = {}
	local scrapItems = {}
	for _, item in ipairs(children) do
		if isScrapItem(item.Name) then
			table.insert(scrapItems, item)
		else
			table.insert(nonScrapItems, item)
		end
	end

	-- Убираем все предметы временно
	for _, item in ipairs(children) do
		item.Parent = nil
	end

	-- Сначала не-скрап (слоты 1-8), потом скрап (слот 9+)
	for _, item in ipairs(nonScrapItems) do
		item.Parent = backpack
	end
	for _, item in ipairs(scrapItems) do
		item.Parent = backpack
	end

	isReordering = false
end

-- Мониторинг инвентаря для сортировки
task.spawn(function()
	local function setupBackpackMonitor()
		local backpack = player:FindFirstChild("Backpack")
		if not backpack then return end

		backpack.ChildAdded:Connect(function(child)
			task.wait(0.1)
			reorderBackpack()
		end)

		-- Также сортируем при удалении (предмет мог быть экипирован и вернуться)
		backpack.ChildRemoved:Connect(function(child)
			task.wait(0.1)
			reorderBackpack()
		end)

		-- Сортируем сразу при запуске
		reorderBackpack()
	end

	-- Ждём появления Backpack
	local backpack = player:FindFirstChild("Backpack")
	if backpack then
		setupBackpackMonitor()
	else
		player.ChildAdded:Connect(function(child)
			if child.Name == "Backpack" then
				task.wait(0.5)
				setupBackpackMonitor()
			end
		end)
	end

	-- При респавне персонажа пересоздаётся Backpack
	player.CharacterAdded:Connect(function(character)
		task.wait(1)
		-- Backpack пересоздаётся при новом персонаже
		local bp = player:FindFirstChild("Backpack")
		if bp then
			bp.ChildAdded:Connect(function(child)
				task.wait(0.1)
				reorderBackpack()
			end)
			bp.ChildRemoved:Connect(function(child)
				task.wait(0.1)
				reorderBackpack()
			end)
			reorderBackpack()
		end
	end)
end)

-- Обновление подсветки каждые 2 секунды (снижено с 0.5 для производительности)
task.spawn(function()
	while true do
		task.wait(2)
		updateHighlights()
	end
end)

-- Следим за появлением персонажа
player.CharacterAdded:Connect(function(character)
	task.wait(1)
	saveStartPosition()
	updateHighlights()
	startSafetyMonitor()
end)

-- Инициализация
task.wait(2)
saveStartPosition()
updateHighlights()
startSafetyMonitor()
-- Подключаем клики по кнопкам UI (с проверкой блокировки)
if searchButton then
	searchButton.MouseButton1Click:Connect(function()
		if searchPromptFrame and lockedPrompts[searchPromptFrame] then return end
		teleportRetryCount = 0
		totalTeleportAttempts = 0
		teleportToRandomScrap()
	end)
end
if sellButton then
	sellButton.MouseButton1Click:Connect(function()
		if sellPromptFrame and lockedPrompts[sellPromptFrame] then return end
		teleportToSell()
	end)
end
if stopButton then
	stopButton.MouseButton1Click:Connect(function()
		if stopPromptFrame and lockedPrompts[stopPromptFrame] then return end
		teleportToStart()
	end)
end

-- === MODIFICATION FOR CoinsGUI ===
local function modifyCoinsGUI()
	-- Ждём появления PlayerGui
	local playerGui = player:WaitForChild("PlayerGui")

	-- Ждём появления CoinsGUI
	local coinsGUI = playerGui:FindFirstChild("CoinsGUI")
	if not coinsGUI then
		coinsGUI = playerGui:WaitForChild("CoinsGUI", 30)
	end

	-- Ищем quantidade внутри CoinsGUI
	local quantidade = coinsGUI:FindFirstChild("quantidade")
	if not quantidade then
		-- Возможно quantidade глубже, ищем в descendants
		for _, child in ipairs(coinsGUI:GetDescendants()) do
			if child.Name == "quantidade" and child:IsA("TextLabel") then
				quantidade = child
				break
			end
		end
	end

	if not quantidade then
		warn("[CoinsGUI] 'quantidade' not found")
		return false
	end

	-- Ищем coins (TextLabel который нужно изменить)
	local coins = coinsGUI:FindFirstChild("coins")
	if not coins or not coins:IsA("TextLabel") then
		-- Ищем любой TextLabel который может быть coins
		for _, child in ipairs(coinsGUI:GetDescendants()) do
			if child.Name == "coins" and child:IsA("TextLabel") then
				coins = child
				break
			end
		end
	end

	if not coins then
		warn("[CoinsGUI] 'coins' not found")
		return false
	end

	-- Сохраняем оригинальный текст quantidade (если есть)
	local originalQuantidadeText = quantidade.Text

	-- Делаем quantidade невидимым
	quantidade.Visible = false

	-- Изменяем шрифт coins на Jura
	coins.FontFace = Font.new("rbxasset://fonts/families/Jura.json", Enum.FontWeight.Regular)
	coins.TextColor3 = Color3.fromRGB(255, 255, 255) -- Белый цвет
	coins.TextXAlignment = Enum.TextXAlignment.Left -- Выравнивание влево для лучшего вида

	-- Функция для обновления текста coins
	local function updateCoinsText()
		local quantidadeValue = tonumber(originalQuantidadeText)
		if not quantidadeValue then
			-- Пытаемся получить текущее значение из quantidade (даже если скрыт)
			local currentValue = tonumber(quantidade.Text)
			if currentValue then
				quantidadeValue = currentValue
			else
				quantidadeValue = 0
			end
		end

		-- Получаем ScrapCount из нашего инвентаря
		local scrapValue, _ = getInventoryValue()

		-- Формируем текст
		local newText = "Credits: " .. quantidadeValue

		-- Добавляем [+N] только если ScrapCount > 0
		if scrapValue > 0 then
			newText = newText .. " [+" .. scrapValue .. "]"
		end

		coins.Text = newText
	end

	-- Следим за изменениями текста в quantidade
	local quantidadeChangedConnection
	quantidadeChangedConnection = quantidade:GetPropertyChangedSignal("Text"):Connect(function()
		originalQuantidadeText = quantidade.Text
		updateCoinsText()
	end)

	-- Следим за изменениями ScrapCount (через инвентарь)
	local function watchInventoryChanges()
		local lastScrapValue, _ = getInventoryValue()

		-- Периодически проверяем изменения в инвентаре
		local inventoryWatcher = game:GetService("RunService").Heartbeat:Connect(function()
			local newScrapValue, _ = getInventoryValue()
			if newScrapValue ~= lastScrapValue then
				lastScrapValue = newScrapValue
				updateCoinsText()
			end
		end)

		return inventoryWatcher
	end

	local inventoryWatcher = watchInventoryChanges()

	-- Обновляем текст сразу
	updateCoinsText()

	-- Следим за респавном персонажа (после респавна всё восстанавливается автоматически)
	local function onCharacterAdded()
		-- Небольшая задержка для стабилизации
		task.wait(0.5)

		-- Обновляем ссылки (могут измениться)
		local newCoinsGUI = playerGui:FindFirstChild("CoinsGUI")
		if newCoinsGUI and newCoinsGUI ~= coinsGUI then
			-- Если CoinsGUI пересоздался, перенастраиваем всё заново
			modifyCoinsGUI()
		else
			-- Иначе просто обновляем отображение
			updateCoinsText()
		end
	end

	player.CharacterAdded:Connect(onCharacterAdded)

	print("[CoinsGUI] Successfully modified!")
	return true
end

-- Запускаем модификацию CoinsGUI
task.spawn(function()
	-- Ждём немного, чтобы UI успел загрузиться
	task.wait(2)

	local success = modifyCoinsGUI()
	if not success then
		-- Если не удалось с первого раза, пробуем ещё с интервалом
		for i = 1, 5 do
			task.wait(3)
			success = modifyCoinsGUI()
			if success then break end
		end
	end
end)

setStatus("Ready! R=search | Z=sell | Q=home")
