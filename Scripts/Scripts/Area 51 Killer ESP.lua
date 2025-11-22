--// Killer ESP GUI by Mizzy
--// LocalScript — includes GUI animation, ESP toggles, safe teleport, draggable window

--// Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local KillersFolder = Workspace:WaitForChild("Killers")

--// Settings
local SAFE_DISTANCE = 15
local ESP_ENABLED = true
local NAME_ENABLED = true

--// GUI Creation
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KillerESP_GUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 270) -- slightly taller
Frame.Position = UDim2.new(0.5, -150, 0.5, -135)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0
Frame.BackgroundTransparency = 1
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local corner = Instance.new("UICorner", Frame)
corner.CornerRadius = UDim.new(0, 12)

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "Killer ESP"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.Parent = Frame

-- Subtitle
local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, 0, 0, 20)
Subtitle.Position = UDim2.new(0, 0, 0, 35)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "made by mizzy"
Subtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
Subtitle.Font = Enum.Font.GothamSemibold
Subtitle.TextScaled = true
Subtitle.Parent = Frame

-- Button creator
local function createButton(text, yPos)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0.9, 0, 0, 35)
	button.Position = UDim2.new(0.05, 0, 0, yPos)
	button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Text = text
	button.Font = Enum.Font.GothamBold
	button.TextScaled = true
	local btnCorner = Instance.new("UICorner", button)
	btnCorner.CornerRadius = UDim.new(0, 8)
	button.Parent = Frame
	return button
end

-- Buttons
local ESPButton = createButton("Toggle ESP: ON", 60)
local NameButton = createButton("Toggle Names: ON", 105)
local TeleportButton = createButton("Teleport to Killer ▼", 150)

-- Killer List (slightly bigger)
local KillerList = Instance.new("ScrollingFrame")
KillerList.Size = UDim2.new(0.9, 0, 0, 110) -- was 80 → now 110
KillerList.Position = UDim2.new(0.05, 0, 0, 195)
KillerList.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
KillerList.BorderSizePixel = 0
KillerList.ScrollBarThickness = 6
KillerList.CanvasSize = UDim2.new(0, 0, 0, 0)
KillerList.Visible = false
KillerList.BackgroundTransparency = 1
KillerList.Parent = Frame

local listCorner = Instance.new("UICorner", KillerList)
listCorner.CornerRadius = UDim.new(0, 8)

local UIListLayout = Instance.new("UIListLayout", KillerList)
UIListLayout.Padding = UDim.new(0, 3)
UIListLayout.FillDirection = Enum.FillDirection.Vertical
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	KillerList.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 5)
end)

-- Pop-up animation
Frame.BackgroundTransparency = 1
Frame.Size = UDim2.new(0, 0, 0, 0)
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)

task.wait(0.4)
TweenService:Create(Frame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
	Size = UDim2.new(0, 300, 0, 270),
	BackgroundTransparency = 0,
	Position = UDim2.new(0.5, -150, 0.5, -135)
}):Play()

--// ESP Core
local FILL_TRANSPARENCY = 0.5
local OUTLINE_TRANSPARENCY = 0.2
local TEXT_COLOR = Color3.fromRGB(255, 255, 255)
local BOLD_FONT = Enum.Font.SourceSansBold

local function rainbowColor(speed)
	local t = tick() * speed
	return Color3.fromHSV((t % 5) / 5, 1, 1)
end

local function isNPC(model)
	if not model or not model:IsA("Model") then return false end
	if not model:IsDescendantOf(KillersFolder) then return false end
	return model:FindFirstChildOfClass("Humanoid") ~= nil
end

local function addNameTag(model)
	if model:FindFirstChild("Local_NPC_NameTag") then return end
	local head = model:FindFirstChild("Head") or model:FindFirstChildWhichIsA("BasePart")
	if not head then return end
	local billboard = Instance.new("BillboardGui")
	billboard.Name = "Local_NPC_NameTag"
	billboard.Size = UDim2.new(0, 100, 0, 25)
	billboard.AlwaysOnTop = true
	billboard.StudsOffset = Vector3.new(0, 3, 0)
	billboard.Adornee = head
	billboard.Parent = model

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.TextColor3 = TEXT_COLOR
	label.TextScaled = true
	label.Font = BOLD_FONT
	label.Text = model.Name
	label.Parent = billboard
end

local function addHighlight(model)
	if not model or model:FindFirstChild("Local_NPC_Highlight") then return end
	local highlight = Instance.new("Highlight")
	highlight.Name = "Local_NPC_Highlight"
	highlight.FillTransparency = FILL_TRANSPARENCY
	highlight.OutlineTransparency = OUTLINE_TRANSPARENCY
	highlight.Adornee = model
	highlight.Parent = model
	addNameTag(model)
end

local function removeHighlight(model)
	if not model then return end
	local h = model:FindFirstChild("Local_NPC_Highlight")
	if h then h:Destroy() end
	local n = model:FindFirstChild("Local_NPC_NameTag")
	if n then n:Destroy() end
end

local function trackNPC(model)
	if not isNPC(model) then return end
	local humanoid = model:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end
	addHighlight(model)
	humanoid.Died:Connect(function()
		removeHighlight(model)
	end)
	model.ChildAdded:Connect(function(child)
		if child:IsA("Humanoid") then
			task.wait(0.5)
			addHighlight(model)
		end
	end)
end

-- ESP loop
RunService.RenderStepped:Connect(function()
	local rainbow = rainbowColor(0.5)
	for _, obj in pairs(KillersFolder:GetChildren()) do
		if isNPC(obj) and ESP_ENABLED then
			addHighlight(obj)
			local h = obj:FindFirstChild("Local_NPC_Highlight")
			if h then
				h.FillColor = rainbow
				h.OutlineColor = rainbow
			end
		else
			removeHighlight(obj)
		end

		local tag = obj:FindFirstChild("Local_NPC_NameTag")
		if tag then tag.Enabled = NAME_ENABLED end
	end
end)

KillersFolder.ChildAdded:Connect(trackNPC)
for _, killer in pairs(KillersFolder:GetChildren()) do
	if isNPC(killer) then
		trackNPC(killer)
	end
end

--// Button Actions
ESPButton.MouseButton1Click:Connect(function()
	ESP_ENABLED = not ESP_ENABLED
	ESPButton.Text = "Toggle ESP: " .. (ESP_ENABLED and "ON" or "OFF")
end)

NameButton.MouseButton1Click:Connect(function()
	NAME_ENABLED = not NAME_ENABLED
	NameButton.Text = "Toggle Names: " .. (NAME_ENABLED and "ON" or "OFF")
end)

-- Populate killer list dynamically
local function refreshKillerList()
	for _, child in pairs(KillerList:GetChildren()) do
		if child:IsA("TextButton") then child:Destroy() end
	end

	for _, killer in pairs(KillersFolder:GetChildren()) do
		if isNPC(killer) then
			local btn = Instance.new("TextButton")
			btn.Size = UDim2.new(1, -6, 0, 25)
			btn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
			btn.TextColor3 = Color3.fromRGB(255, 255, 255)
			btn.Font = Enum.Font.GothamBold
			btn.TextScaled = true
			btn.Text = killer.Name
			local bcorner = Instance.new("UICorner", btn)
			bcorner.CornerRadius = UDim.new(0, 6)
			btn.Parent = KillerList

			btn.MouseButton1Click:Connect(function()
				local char = player.Character or player.CharacterAdded:Wait()
				local hrp = char:FindFirstChild("HumanoidRootPart")
				local killerRoot = killer:FindFirstChild("HumanoidRootPart")
				if not hrp or not killerRoot then return end

				-- Teleport to the side of the killer (right side)
				local rightVec = killerRoot.CFrame.RightVector
				local newPos = killerRoot.Position + (rightVec * SAFE_DISTANCE)
				hrp.CFrame = CFrame.new(newPos, killerRoot.Position)

				-- Fade out killer list
				TweenService:Create(KillerList, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
				for _, b in ipairs(KillerList:GetChildren()) do
					if b:IsA("TextButton") then
						TweenService:Create(b, TweenInfo.new(0.3), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
					end
				end
				task.wait(0.3)
				KillerList.Visible = false
				TeleportButton.Text = "Teleport to Killer ▼"
			end)
		end
	end
end

TeleportButton.MouseButton1Click:Connect(function()
	if KillerList.Visible then
		-- Fade out
		TweenService:Create(KillerList, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
		for _, b in ipairs(KillerList:GetChildren()) do
			if b:IsA("TextButton") then
				TweenService:Create(b, TweenInfo.new(0.3), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
			end
		end
		task.wait(0.3)
		KillerList.Visible = false
		TeleportButton.Text = "Teleport to Killer ▼"
	else
		refreshKillerList()
		KillerList.Visible = true
		KillerList.BackgroundTransparency = 1
		for _, b in ipairs(KillerList:GetChildren()) do
			if b:IsA("TextButton") then
				b.TextTransparency = 1
				b.BackgroundTransparency = 1
			end
		end
		TweenService:Create(KillerList, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
		for _, b in ipairs(KillerList:GetChildren()) do
			if b:IsA("TextButton") then
				TweenService:Create(b, TweenInfo.new(0.3), {TextTransparency = 0, BackgroundTransparency = 0}):Play()
			end
		end
		TeleportButton.Text = "Teleport to Killer ▲"
	end
end)

--// Toggle GUI visibility with "End" key
local guiVisible = true
UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.KeyCode == Enum.KeyCode.End then
		guiVisible = not guiVisible
		Frame.Visible = guiVisible
	end
end)
