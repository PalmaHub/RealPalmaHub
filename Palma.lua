local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Создание текста версии в правом углу
local versionText = Instance.new("TextLabel")
versionText.Name = "VersionText"
versionText.Size = UDim2.new(0, 200, 0, 20)
versionText.Position = UDim2.new(1, -210, 1, -30)
versionText.AnchorPoint = Vector2.new(0, 1)
versionText.BackgroundTransparency = 1
versionText.Text = "TikTok @palmastealscript V 1.1"
versionText.TextColor3 = Color3.new(1, 1, 1)
versionText.Font = Enum.Font.Code
versionText.TextSize = 14
versionText.TextXAlignment = Enum.TextXAlignment.Right

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
mainFrame.Size = UDim2.new(0, 300, 0, 500) -- Увеличил высоту для новой кнопки
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(144, 238, 144)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Visible = false

-- Создание скругленных углов
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- Обводка
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(0, 0, 0)
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
local button1 = createButton("BrainrotEspButton", "BrainrotEsp", UDim2.new(0, 0, 0, 0))
local button2 = createButton("ESPButton", "esp", UDim2.new(0, 0, 0, 50))
local button3 = createButton("FloatButton", "float", UDim2.new(0, 0, 0, 100))
local button4 = createButton("StealerPlusButton", "STEALER++", UDim2.new(0, 0, 0, 150))
local button5 = createButton("SkyWalkButton", "SkyWalk", UDim2.new(0, 0, 0, 200))
local button6 = createButton("ServerHopButton", "ServerHop", UDim2.new(0, 0, 0, 250))
local button7 = createButton("GodModeButton", "GodMode", UDim2.new(0, 0, 0, 300))
local button8 = createButton("KickButton", "Kick", UDim2.new(0, 0, 0, 350)) -- Новая кнопка Kick

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

-- Функционал GodMode (бессмертие)
local godModeEnabled = false
local godModeConnections = {}

local function toggleGodMode()
    godModeEnabled = not godModeEnabled
    
    if godModeEnabled then
        button7.Text = "GODMODE: ON"
        button7.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        
        -- Защита от смерти
        if player.Character then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                -- Сохраняем оригинальное здоровье
                humanoid.MaxHealth = math.huge
                humanoid.Health = math.huge
                
                -- Защита от получения урона
                local connection = humanoid.HealthChanged:Connect(function()
                    if humanoid.Health < math.huge then
                        humanoid.Health = math.huge
                    end
                end)
                
                table.insert(godModeConnections, connection)
                
                -- Защита от смерти
                local diedConnection = humanoid.Died:Connect(function()
                    if godModeEnabled then
                        -- Предотвращаем смерть
                        humanoid:ChangeState(Enum.HumanoidStateType.Running)
                        humanoid.Health = math.huge
                    end
                end)
                
                table.insert(godModeConnections, diedConnection)
            end
        end
        
        -- Обработка нового персонажа
        local characterAddedConnection = player.CharacterAdded:Connect(function(character)
            wait(0.5) -- Ждем загрузки персонажа
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.MaxHealth = math.huge
                humanoid.Health = math.huge
                
                local connection = humanoid.HealthChanged:Connect(function()
                    if humanoid.Health < math.huge then
                        humanoid.Health = math.huge
                    end
                end)
                
                table.insert(godModeConnections, connection)
                
                local diedConnection = humanoid.Died:Connect(function()
                    if godModeEnabled then
                        humanoid:ChangeState(Enum.HumanoidStateType.Running)
                        humanoid.Health = math.huge
                    end
                end)
                
                table.insert(godModeConnections, diedConnection)
            end
        end)
        
        table.insert(godModeConnections, characterAddedConnection)
        
    else
        button7.Text = "GodMode"
        button7.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
        
        -- Отключаем все соединения GodMode
        for _, connection in ipairs(godModeConnections) do
            connection:Disconnect()
        end
        godModeConnections = {}
        
        -- Восстанавливаем нормальное здоровье
        if player.Character then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.MaxHealth = 100
                humanoid.Health = 100
            end
        end
    end
end

-- Функционал плавания
local isFloating = false
local floatConnection = nil
local autoStopTimer = nil

local function startFloating()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local humanoidRootPart = player.Character.HumanoidRootPart
        
        if floatConnection then
            floatConnection:Disconnect()
        end
        
        if autoStopTimer then
            autoStopTimer:Disconnect()
        end
        
        isFloating = true
        button3.Text = "FLOATING..."
        button3.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        
        floatConnection = RunService.Heartbeat:Connect(function()
            if not isFloating or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
                if floatConnection then
                    floatConnection:Disconnect()
                end
                return
            end
            
            local camera = workspace.CurrentCamera
            local cameraCFrame = camera.CFrame
            local direction = cameraCFrame.LookVector
            
            humanoidRootPart.Velocity = direction * 25
        end)
        
        autoStopTimer = game:GetService("RunService").Heartbeat:Connect(function()
            wait(10)
            
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
    local position = hrp.Position - Vector3.new(0, 5, 0)
    
    if not skyWalkPart then
        skyWalkPart = Instance.new("Part")
        skyWalkPart.Name = "SkyWalkPlatform"
        skyWalkPart.Size = Vector3.new(10, 1, 10)
        skyWalkPart.Anchored = true
        skyWalkPart.CanCollide = true
        skyWalkPart.Transparency = 0.7
        skyWalkPart.Color = Color3.fromRGB(100, 200, 255)
        skyWalkPart.Parent = workspace
    end
    
    skyWalkPart.Position = position
end

local function toggleSkyWalk()
    skyWalkEnabled = not skyWalkEnabled
    
    if skyWalkEnabled then
        button5.Text = "SkyWalk: ON"
        button5.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        
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

-- Функционал ServerHop
local function serverHop()
    button6.Text = "JOINING..."
    button6.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    
    local settings = {
        espEnabled = espEnabled,
        skyWalkEnabled = skyWalkEnabled,
        brainrotEspEnabled = brainrotEspEnabled,
        godModeEnabled = godModeEnabled
    }
    
    local jsonSettings = HttpService:JSONEncode(settings)
    
    if not player:FindFirstChild("PalmaHUBSettings") then
        local folder = Instance.new("Folder")
        folder.Name = "PalmaHUBSettings"
        folder.Parent = player
    end
    
    local value = Instance.new("StringValue")
    value.Name = "Settings"
    value.Value = jsonSettings
    value.Parent = player.PalmaHUBSettings
    
    local gameId = game.PlaceId
    local servers = {}
    
    local success, result = pcall(function()
        return game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. gameId .. "/servers/Public?sortOrder=Asc&limit=100"))
    end)
    
    if success and result and result.data then
        for _, server in ipairs(result.data) do
            if server.playing < server.maxPlayers and server.id ~= game.JobId then
                table.insert(servers, server.id)
            end
        end
        
        if #servers > 0 then
            local randomServer = servers[math.random(1, #servers)]
            TeleportService:TeleportToPlaceInstance(gameId, randomServer, player)
        else
            TeleportService:Teleport(gameId, player)
        end
    else
        TeleportService:Teleport(gameId, player)
    end
end

-- Функция для автоматической загрузки настроек после телепортации
local function loadSettingsAfterTeleport()
    if player:FindFirstChild("PalmaHUBSettings") then
        local settingsValue = player.PalmaHUBSettings:FindFirstChild("Settings")
        if settingsValue then
            local success, settings = pcall(function()
                return HttpService:JSONDecode(settingsValue.Value)
            end)
            
            if success and settings then
                -- Восстанавливаем настройки ESP
                if settings.espEnabled then
                    toggleESP(true)
                end
                
                -- Восстанавливаем настройки SkyWalk
                if settings.skyWalkEnabled then
                    toggleSkyWalk()
                end
                
                -- Восстанавливаем настройки BrainrotESP
                if settings.brainrotEspEnabled then
                    toggleBrainrotEsp(true)
                end
                
                -- Восстанавливаем настройки GodMode
                if settings.godModeEnabled then
                    toggleGodMode()
                end
                
                settingsValue:Destroy()
            end
        end
    end
end

-- Запускаем загрузку настроек при загрузке персонажа
player.CharacterAdded:Connect(function(character)
    wait(2)
    loadSettingsAfterTeleport()
end)

-- Улучшенный ESP с линиями и именами
local espEnabled = false
local espObjects = {}
local espLines = {}
local nameLabels = {}
local espUpdateConnection = nil

local function createESPLine(toCharacter)
    local line = Drawing.new("Line")
    line.Thickness = 2
    line.Color = Color3.fromRGB(255, 0, 0)
    line.Visible = false
    return line
end

local function createNameLabel(toCharacter)
    local label = Drawing.new("Text")
    label.Text = toCharacter.Name
    label.Size = 18
    label.Color = Color3.fromRGB(255, 255, 255)
    label.Outline = true
    label.OutlineColor = Color3.fromRGB(0, 0, 0)
    label.Visible = false
    return label
end

local function updateESP()
    if not espEnabled then return end
    
    local camera = workspace.CurrentCamera
    if not camera then return end
    
    local screenCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = otherPlayer.Character.HumanoidRootPart
            local head = otherPlayer.Character:FindFirstChild("Head")
            
            if hrp then
                local position, visible = camera:WorldToViewportPoint(hrp.Position)
                
                if visible then
                    if not espLines[otherPlayer] then
                        espLines[otherPlayer] = createESPLine(otherPlayer.Character)
                    end
                    
                    local line = espLines[otherPlayer]
                    line.From = screenCenter
                    line.To = Vector2.new(position.X, position.Y)
                    line.Visible = true
                    
                    if not nameLabels[otherPlayer] then
                        nameLabels[otherPlayer] = createNameLabel(otherPlayer.Character)
                    end
                    
                    local label = nameLabels[otherPlayer]
                    label.Position = Vector2.new(position.X, position.Y - 30)
                    label.Visible = true
                    label.Text = otherPlayer.Name .. " (" .. math.floor((hrp.Position - camera.CFrame.Position).Magnitude) .. " studs)"
                else
                    if espLines[otherPlayer] then
                        espLines[otherPlayer].Visible = false
                    end
                    if nameLabels[otherPlayer] then
                        nameLabels[otherPlayer].Visible = false
                    end
                end
            end
        else
            if espLines[otherPlayer] then
                espLines[otherPlayer]:Remove()
                espLines[otherPlayer] = nil
            end
            if nameLabels[otherPlayer] then
                nameLabels[otherPlayer]:Remove()
                nameLabels[otherPlayer] = nil
            end
        end
    end
end

local function toggleESP(forceState)
    if forceState ~= nil then
        espEnabled = forceState
    else
        espEnabled = not espEnabled
    end
    
    if espEnabled then
        for _, otherPlayer in pairs(Players:GetPlayers()) do
            if otherPlayer.Character then
                local highlight = Instance.new("Highlight")
                highlight.Name = "PalmaESP"
                highlight.FillColor = otherPlayer == player and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.FillTransparency = 0.5
                highlight.Parent = otherPlayer.Character
                espObjects[otherPlayer] = highlight
            end
        end
        
        if not espUpdateConnection then
            espUpdateConnection = RunService.RenderStepped:Connect(updateESP)
        end
        
        Players.PlayerAdded:Connect(function(newPlayer)
            if espEnabled then
                newPlayer.CharacterAdded:Connect(function(character)
                    if espEnabled then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "PalmaESP"
                        highlight.FillColor = newPlayer == player and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
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
        for _, highlight in pairs(espObjects) do
            highlight:Destroy()
        end
        espObjects = {}
        
        for _, line in pairs(espLines) do
            line:Remove()
        end
        espLines = {}
        
        for _, label in pairs(nameLabels) do
            label:Remove()
        end
        nameLabels = {}
        
        if espUpdateConnection then
            espUpdateConnection:Disconnect()
            espUpdateConnection = nil
        end
        
        button2.Text = "esp"
        button2.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
    end
end

-- BrainrotESP функционал - делает все объекты полупрозрачными
local brainrotEspEnabled = false
local brainrotEspConnection = nil
local originalTransparency = {}
local brainrotEspObjects = {}

local function toggleBrainrotEsp(forceState)
    if forceState ~= nil then
        brainrotEspEnabled = forceState
    else
        brainrotEspEnabled = not brainrotEspEnabled
    end
    
    if brainrotEspEnabled then
        button1.Text = "BrainrotEsp: ON"
        button1.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        
        -- Делаем все объекты в workspace полупрозрачными
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and not obj:IsA("Terrain") then
                -- Сохраняем оригинальную прозрачность
                originalTransparency[obj] = obj.Transparency
                
                -- Устанавливаем полупрозрачность
                obj.Transparency = 0.7
                
                -- Сохраняем объект для последуючного восстановления
                table.insert(brainrotEspObjects, obj)
            end
        end
        
        -- Обрабатываем новые объекты
        if brainrotEspConnection then
            brainrotEspConnection:Disconnect()
        end
        
        brainrotEspConnection = workspace.DescendantAdded:Connect(function(obj)
            if brainrotEspEnabled and obj:IsA("BasePart") and not obj:IsA("Terrain") then
                originalTransparency[obj] = obj.Transparency
                obj.Transparency = 0.7
                table.insert(brainrotEspObjects, obj)
            end
        end)
    else
        button1.Text = "BrainrotEsp"
        button1.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
        
        -- Восстанавливаем оригинальную прозрачность всех объектов
        for _, obj in pairs(brainrotEspObjects) do
            if obj and obj.Parent then
                local original = originalTransparency[obj]
                if original then
                    obj.Transparency = original
                end
            end
        end
        
        -- Очищаем таблицы
        brainrotEspObjects = {}
        originalTransparency = {}
        
        if brainrotEspConnection then
            brainrotEspConnection:Disconnect()
            brainrotEspConnection = nil
        end
    end
end

-- Функционал кнопки Kick
local function kickPlayer()
    button8.Text = "KICKING..."
    button8.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    
    -- Создаем сообщение о кике
    local kickMessage = Instance.new("Message")
    kickMessage.Text = "YOU PRESS BUTTON KICK"
    kickMessage.Parent = workspace
    
    -- Ждем немного, чтобы игрок увидел сообщение
    wait(2)
    
    -- Кикаем игрока из игры
    player:Kick("YOU PRESS BUTTON KICK")
    
    -- Удаляем сообщение (на случай если кик не сработает сразу)
    kickMessage:Destroy()
end

-- Функционал кнопок
button1.MouseButton1Click:Connect(function()
    toggleBrainrotEsp()
end)

button2.MouseButton1Click:Connect(function()
    toggleESP()
end)

button3.MouseButton1Click:Connect(function()
    if isFloating then
        stopFloating()
    else
        startFloating()
    end
end)

button4.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet('https://pastefy.app/CLu1GH4y/raw'))()
end)

button5.MouseButton1Click:Connect(function()
    toggleSkyWalk()
end)

button6.MouseButton1Click:Connect(serverHop)

button7.MouseButton1Click:Connect(function()
    toggleGodMode()
end)

button8.MouseButton1Click:Connect(function()
    kickPlayer()
end)

-- Добавляем основной фрейм на экран
mainFrame.Parent = screenGui
toggleButton.Parent = screenGui
versionText.Parent = screenGui

-- Функция переключения видимости интерфейса
local function toggleInterface()
    if mainFrame.Visible then
        mainFrame.Visible = false
        toggleButton.Text = "Open"
    else
        mainFrame.Visible = true
        toggleButton.Text = "Close"
        
        mainFrame.Size = UDim2.new(0, 0, 0, 0)
        
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(mainFrame, tweenInfo, {Size = UDim2.new(0, 300, 0, 500)})
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

-- Автоматическая загрузка настроек при запуске
wait(2)
loadSettingsAfterTeleport()
