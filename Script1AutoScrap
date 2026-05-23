local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local Selection = game:GetService("Selection")
local player = Players.LocalPlayer

local startPosition = nil
local isTeleporting = false
local collectedCount = 0
local isRunning = false
local currentRotationConnection = nil -- для отслеживания активного поворота
local highlightedObjects = {} -- для хранения подсвеченных объектов

-- === UI: Подсказка сверху экрана ===
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ScrapHelperGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local infoLabel = Instance.new("TextLabel")
infoLabel.Name = "InfoLabel"
infoLabel.Size = UDim2.new(0, 500, 0, 50)
infoLabel.Position = UDim2.new(0.5, -250, 0, 10)
infoLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
infoLabel.BackgroundTransparency = 0.4
infoLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
infoLabel.Text = ""
infoLabel.Font = Enum.Font.GothamBold
infoLabel.TextSize = 16
infoLabel.Parent = screenGui

local infoCorner = Instance.new("UICorner")
infoCorner.CornerRadius = UDim.new(0, 8)
infoCorner.Parent = infoLabel

-- === UI: Кнопка START / STOP ===
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 140, 0, 45)
toggleButton.Position = UDim2.new(0, 20, 0.5, -25)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Text = "START"
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 18
toggleButton.AutoButtonColor = true
toggleButton.Parent = screenGui

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = toggleButton

local btnStroke = Instance.new("UIStroke")
btnStroke.Color = Color3.fromRGB(100, 100, 100)
btnStroke.Thickness = 1
btnStroke.Parent = toggleButton

-- Есть ли живой NPC (не игрок) в радиусе?
local function hasNPCNearby(position, radius)
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("Model") and obj ~= player.Character then
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
-- Найти все ProximityPrompt с ActionText "Collect scrap"
local function getScrapPrompts()
	local prompts = {}
	for _, desc in ipairs(workspace:GetDescendants()) do
		if desc:IsA("ProximityPrompt") and desc.ActionText == "Collect scrap" then
			local basePart = desc.Parent
			-- Поднимаемся до корневой модели/парты
			local current = desc
			while current and current ~= workspace do
				if current:IsA("Model") then
					basePart = current:FindFirstChildWhichIsA("BasePart") or current:FindFirstChild("HumanoidRootPart") or basePart
					break
				end
				current = current.Parent
			end
			if basePart and basePart:IsA("BasePart") then
				table.insert(prompts, { prompt = desc, basePart = basePart })
			end
		end
	end
	return prompts
end

local function setStatus(text)
	infoLabel.Text = text
	print("[ScrapHelper] " .. text)
end

-- Очистка всех подсветок
local function clearHighlights()
	for _, highlight in pairs(highlightedObjects) do
		if highlight and highlight.Parent then
			highlight:Destroy()
		end
	end
	highlightedObjects = {}
end

-- Подсветка конкретного объекта
local function highlightObject(obj, color)
	if not obj or not obj:IsA("BasePart") then return end

	local highlight = Instance.new("Highlight")
	highlight.FillColor = color or Color3.fromRGB(255, 255, 0) -- жёлтый по умолчанию
	highlight.OutlineColor = Color3.fromRGB(255, 200, 0)
	highlight.FillTransparency = 0.5
	highlight.OutlineTransparency = 0.3
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	highlight.Parent = obj

	table.insert(highlightedObjects, highlight)
	return highlight
end

-- Подсветка всех доступных скрапов
local function highlightAllScraps()
	clearHighlights()

	local prompts = getScrapPrompts()
	for _, data in ipairs(prompts) do
		local basePart = data.basePart
		if basePart and basePart:IsA("BasePart") then
			-- Зелёный для безопасных (без NPC), красный для опасных
			local hasNPC = hasNPCNearby(basePart.Position, 50)
			local color = hasNPC and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(50, 255, 50)
			highlightObject(basePart, color)
		end
	end

	setStatus("Highlighted " .. #prompts .. " scraps | " .. (#prompts - #highlightedObjects) .. " visible")
end

toggleButton.MouseButton1Click:Connect(function()
	isRunning = not isRunning
	if isRunning then
		toggleButton.Text = "STOP"
		toggleButton.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
		setStatus("Auto-teleport ON | Searching for scrap...")
		highlightAllScraps() -- Подсветить все скрапы при старте
	else
		toggleButton.Text = "START"
		toggleButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
		setStatus("Auto-teleport OFF | Paused")
		clearHighlights() -- Убрать подсветку при остановке
	end
end)

-- Плавный поворот камеры к цели
local function rotateCameraTo(targetPosition, callback)
	-- Отключаем предыдущий поворот если есть
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

	-- Вычисляем направление от игрока к цели
	local direction = (targetPosition - hrp.Position).unit
	local targetCFrame = CFrame.lookAt(hrp.Position, hrp.Position + direction)

	-- Сохраняем начальный CFrame камеры
	local startCFrame = camera.CFrame
	local duration = 0.25
	local startTime = tick()

	-- Создаём новый поворот
	local connection
	connection = RunService.RenderStepped:Connect(function()
		local elapsed = tick() - startTime
		local alpha = math.min(1, elapsed / duration)

		-- Плавная интерполяция (ease out cubic)
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
		if hrp and not startPosition then
			startPosition = hrp.CFrame
		end
	end
end

player.CharacterAdded:Connect(function(character)
	task.wait(0.5)
	saveStartPosition()
end)

-- Телепорт на старт
local function teleportToStart()
	local character = player.Character
	if not character then return end
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if hrp and startPosition then
		hrp.CFrame = startPosition
		-- Поворачиваем камеру туда же
		local camera = workspace.CurrentCamera
		if camera then
			rotateCameraTo(startPosition.Position)
		end
	end
end

-- Телепорт к следующему промпту
local function teleportToNext()
	if isTeleporting then return end
	isTeleporting = true

	local character = player.Character
	if not character then isTeleporting = false return end
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then isTeleporting = false return end

	local prompts = getScrapPrompts()

	if #prompts == 0 then
		setStatus("No scrap found | Collected: " .. collectedCount)
		teleportToStart()
		isTeleporting = false
		return
	end

	-- Обновляем подсветку актуальных скрапов
	highlightAllScraps()

	setStatus("Found " .. #prompts .. " scrap | Collected: " .. collectedCount)

	-- Ищем промпт без NPC в радиусе 50
	local targetData = nil
	for i, data in ipairs(prompts) do
		local pos = data.basePart.Position
		local hasNPC, npcName = hasNPCNearby(pos, 50)
		if not hasNPC then
			targetData = data
			break
		end
	end

	-- Если все с NPC — телепорт на старт
	if not targetData then
		setStatus("All " .. #prompts .. " scrap have NPC nearby! | Returning to start")
		teleportToStart()
		isTeleporting = false
		return
	end

	local prompt = targetData.prompt
	local basePart = targetData.basePart

	-- Позиция для телепорта (чуть выше и спереди от скрапа)
	local teleportPosition = basePart.CFrame + basePart.CFrame.LookVector * 3 + Vector3.new(0, 3, 0)

	-- Телепорт
	hrp.CFrame = teleportPosition

	-- Ждём немного перед поворотом камеры
	task.wait(0.1)

	-- ПОВОРОТ КАМЕРЫ К СКРАПУ
	rotateCameraTo(basePart.Position, function()
		-- Этот код выполнится после завершения поворота камеры
		setStatus("Camera rotated to scrap | Press E to collect")
	end)

	setStatus("Teleported to " .. basePart.Parent.Name .. " | Remaining: " .. #prompts)

	-- Ждём появления промпта на экране
	task.wait(0.5)

	-- Эмулируем зажатие клавиши E (или нужной клавиши)
	pcall(function()
		if prompt and prompt.Parent then
			local keyCode = prompt.KeyboardKeyCode
			-- Зажимаем клавишу
			VirtualInputManager:SendKeyEvent(true, keyCode, false, nil)
			-- Держим зажатой 0.2 секунды для гарантии сбора
			task.wait(0.2)
			-- Отпускаем
			VirtualInputManager:SendKeyEvent(false, keyCode, false, nil)
		end
	end)

	-- Ждём исчезновения промпта (скрап собран)
	local waitTime = 0
	for i = 1, 30 do
		task.wait(0.5)
		waitTime = waitTime + 0.5

		local promptExists = false
		pcall(function()
			promptExists = prompt and prompt.Parent and prompt.Parent:IsDescendantOf(workspace)
		end)

		if not promptExists then
			collectedCount = collectedCount + 1
			setStatus("✓ Scrap collected! | Total: " .. collectedCount)
			-- Убираем подсветку собранного скрапа
			if basePart and basePart.Parent then
				for i, highlight in pairs(highlightedObjects) do
					if highlight.Parent == basePart then
						highlight:Destroy()
						table.remove(highlightedObjects, i)
						break
					end
				end
			end
			isTeleporting = false
			teleportToNext()
			return
		end

		-- Проверка NPC рядом с игроком (радиус 30 - поменьше для безопасности)
		local hasNPC, npcName = hasNPCNearby(hrp.Position, 30)
		if hasNPC then
			setStatus("⚠ NPC detected: " .. npcName .. " | Returning to start!")
			teleportToStart()
			isTeleporting = false
			return
		end

		-- Если слишком долго не собирается - пробуем ещё раз нажать
		if waitTime >= 3 and waitTime % 2 == 0 then
			pcall(function()
				if prompt and prompt.Parent then
					local keyCode = prompt.KeyboardKeyCode
					VirtualInputManager:SendKeyEvent(true, keyCode, false, nil)
					task.wait(0.15)
					VirtualInputManager:SendKeyEvent(false, keyCode, false, nil)
				end
			end)
		end
	end

	-- Таймаут - скрап не собрался
	setStatus("⚠ Timeout - moving to next")
	isTeleporting = false
	teleportToNext()
end

-- Периодическое обновление подсветки (каждые 5 секунд, только если запущено)
task.spawn(function()
	while true do
		task.wait(5)
		if isRunning then
			highlightAllScraps()
		end
	end
end)

-- Старт
task.wait(2)
saveStartPosition()
setStatus("Press START to begin | Position saved")

-- Основной цикл: телепортирует только когда включено
while true do
	task.wait(1)
	if isRunning and not isTeleporting then
		teleportToNext()
	end
end
