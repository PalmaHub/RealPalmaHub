local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Определяем платформу
local isMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled
local uiScale = isMobile and 0.7 or 1  -- Масштаб для мобильных устройств

-- Создание текста версии в правом углу
local versionText = Instance.new("TextLabel")
versionText.Name = "VersionText"
versionText.Size = UDim2.new(0, 200 * uiScale, 0, 20 * uiScale)
versionText.Position = UDim2.new(1, -210 * uiScale, 1, -30 * uiScale)
versionText.AnchorPoint = Vector2.new(0, 1)
versionText.BackgroundTransparency = 1
versionText.Text = "TikTok @palmastealscript V 1.2"
versionText.TextColor3 = Color3.new(1, 1, 1)
versionText.Font = Enum.Font.Code
versionText.TextSize = 14 * uiScale
versionText.TextXAlignment = Enum.TextXAlignment.Right

-- Создание кнопки открытия/закрытия
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 100 * uiScale, 0, 30 * uiScale)
toggleButton.Position = UDim2.new(0, 10 * uiScale, 0, 10 * uiScale)
toggleButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
toggleButton.Text = "Open"
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.Font = Enum.Font.Code
toggleButton.TextSize = 14 * uiScale
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

-- Основной фрейм (первая страница)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300 * uiScale, 0, 500 * uiScale)
mainFrame.Position = UDim2.new(0.5, -150 * uiScale, 0.5, -250 * uiScale)
mainFrame.BackgroundColor3 = Color3.fromRGB(144, 238, 144)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Visible = false

-- Вторая страница
local secondFrame = Instance.new("Frame")
secondFrame.Name = "SecondFrame"
secondFrame.Size = UDim2.new(0, 300 * uiScale, 0, 500 * uiScale)
secondFrame.Position = UDim2.new(0.5, -150 * uiScale, 0.5, -250 * uiScale)
secondFrame.BackgroundColor3 = Color3.fromRGB(144, 238, 144)
secondFrame.BorderSizePixel = 0
secondFrame.ClipsDescendants = true
secondFrame.Visible = false

-- Создание скругленных углов
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame
corner:Clone().Parent = secondFrame

-- Обводка
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(0, 0, 0)
stroke.Thickness = 2
stroke.Parent = mainFrame
stroke:Clone().Parent = secondFrame

-- Заголовок для первой страницы
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 40 * uiScale)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
title.Text = "PalmaHUB - Page 1"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.Code
title.TextSize = 20 * uiScale
title.BorderSizePixel = 0

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = title
title.Parent = mainFrame

-- Заголовок для второй страницы
local secondTitle = title:Clone()
secondTitle.Text = "PalmaHUB - Page 2"
secondTitle.Parent = secondFrame

-- Контейнер для кнопок первой страницы
local buttonsContainer = Instance.new("Frame")
buttonsContainer.Name = "ButtonsContainer"
buttonsContainer.Size = UDim2.new(1, -20 * uiScale, 1, -60 * uiScale)
buttonsContainer.Position = UDim2.new(0, 10 * uiScale, 0, 50 * uiScale)
buttonsContainer.BackgroundTransparency = 1
buttonsContainer.Parent = mainFrame

-- Контейнер для кнопок второй страницы
local secondButtonsContainer = buttonsContainer:Clone()
secondButtonsContainer.Parent = secondFrame

-- Функция для создания кнопок
local function createButton(name, text, position, parent)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(1, 0, 0, 40 * uiScale)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
    button.Text = text
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.Code
    button.TextSize = 16 * uiScale
    button.BorderSizePixel = 0
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Color = Color3.fromRGB(0, 100, 0)
    buttonStroke.Thickness = 1
    buttonStroke.Parent = button
    
    button.Parent = parent
    
    return button
end

-- Создание кнопок первой страницы
local button1 = createButton("ESPButton", "esp", UDim2.new(0, 0, 0, 0), buttonsContainer)
local button2 = createButton("StealerPlusButton", "STEALER++", UDim2.new(0, 0, 0, 50 * uiScale), buttonsContainer)
local button3 = createButton("SkyWalkButton", "SkyWalk", UDim2.new(0, 0, 0, 100 * uiScale), buttonsContainer)
local button4 = createButton("ServerHopButton", "ServerHop", UDim2.new(0, 0, 0, 150 * uiScale), buttonsContainer)
local button5 = createButton("GodModeButton", "GodMode", UDim2.new(0, 0, 0, 200 * uiScale), buttonsContainer)
local button6 = createButton("LennonHubButton", "Lennon Hub v5", UDim2.new(0, 0, 0, 250 * uiScale), buttonsContainer)
local nextPageButton = createButton("NextPageButton", "Next Page", UDim2.new(0, 0, 0, 300 * uiScale), buttonsContainer)

-- Создание кнопок второй страницы
local backPageButton = createButton("BackPageButton", "Back", UDim2.new(0, 0, 0, 0), secondButtonsContainer)
local kickButton = createButton("KickButton", "Kick", UDim2.new(0, 0, 0, 50 * uiScale), secondButtonsContainer)
local palmaFuckerButton = createButton("PalmaFuckerButton", "Palma F@CK3R", UDim2.new(0, 0, 0, 100 * uiScale), secondButtonsContainer)
local walkerButton = createButton("WalkerButton", "Walker", UDim2.new(0, 0, 0, 150 * uiScale), secondButtonsContainer)

-- Функционал перетаскивания
local function setupDragging(frame)
    local dragging = false
    local dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

setupDragging(mainFrame)
setupDragging(secondFrame)

-- Функционал GodMode (бессмертие)
local godModeEnabled = false
local godModeConnections = {}

local function toggleGodMode()
    godModeEnabled = not godModeEnabled
    
    if godModeEnabled then
        button5.Text = "GODMODE: ON"
        button5.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        
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
        button5.Text = "GodMode"
        button5.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
        
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
        button3.Text = "SkyWalk: ON"
        button3.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        
        if skyWalkConnection then
            skyWalkConnection:Disconnect()
        end
        
        skyWalkConnection = RunService.Heartbeat:Connect(function()
            updateSkyWalk()
        end)
    else
        button3.Text = "SkyWalk"
        button3.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
        
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
    button4.Text = "JOINING..."
    button4.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    
    local settings = {
        espEnabled = espEnabled,
        skyWalkEnabled = skyWalkEnabled,
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
        
        button1.Text = "ESP: ON"
        button1.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
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
        
        button1.Text = "esp"
        button1.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
    end
end

-- Функционал кнопки Kick
local function kickPlayer()
    kickButton.Text = "KICKING..."
    kickButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    
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

-- Функционал кнопки Palma F@CK3R
local function runPalmaFucker()
    palmaFuckerButton.Text = "LOADING..."
    palmaFuckerButton.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
    
    -- Запускаем внешний скрипт
    local success, errorMessage = pcall(function()
        loadstring(game:HttpGet("https://pastefy.app/oCF131NE/raw"))()
    end)
    
    if success then
        palmaFuckerButton.Text = "LOADED!"
        wait(2)
        palmaFuckerButton.Text = "Palma F@CK3R"
        palmaFuckerButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
    else
        palmaFuckerButton.Text = "ERROR!"
        warn("Failed to load Palma F@CK3R script: " .. errorMessage)
        wait(2)
        palmaFuckerButton.Text = "Palma F@CK3R"
        palmaFuckerButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
    end
end

-- Функционал Lennon Hub v5
local function runLennonHub()
    button6.Text = "LOADING..."
    button6.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
    
    -- Запускаем внешний скрипт
    local success, errorMessage = pcall(function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Steal-a-Brainrot-Lennon-hub-v5-52358"))()
    end)
    
    if success then
        button6.Text = "LOADED!"
        wait(2)
        button6.Text = "Lennon Hub v5"
        button6.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
    else
        button6.Text = "ERROR!"
        warn("Failed to load Lennon Hub v5 script: " .. errorMessage)
        wait(2)
        button6.Text = "Lennon Hub v5"
        button6.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
    end
end

-- Функционал Walker (ходит по небу)
local walkerEnabled = false
local walkerConnection = nil
local walkerPlatform = nil

local function toggleWalker()
    walkerEnabled = not walkerEnabled
    
    if walkerEnabled then
        walkerButton.Text = "WALKER: ON"
        walkerButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        
        -- Создаем платформу под ногами
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            
            if not walkerPlatform then
                walkerPlatform = Instance.new("Part")
                walkerPlatform.Name = "WalkerPlatform"
                walkerPlatform.Size = Vector3.new(20, 1, 20)
                walkerPlatform.Anchored = true
                walkerPlatform.CanCollide = true
                walkerPlatform.Transparency = 0.8
                walkerPlatform.Color = Color3.fromRGB(200, 200, 200)
                walkerPlatform.Parent = workspace
            end
            
            -- Обновляем позицию платформы
            if walkerConnection then
                walkerConnection:Disconnect()
            end
            
            walkerConnection = RunService.Heartbeat:Connect(function()
                if not walkerEnabled or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
                    if walkerConnection then
                        walkerConnection:Disconnect()
                    end
                    if walkerPlatform then
                        walkerPlatform:Destroy()
                        walkerPlatform = nil
                    end
                    return
                end
                
                local hrp = player.Character.HumanoidRootPart
                local position = hrp.Position - Vector3.new(0, 3, 0)
                walkerPlatform.Position = position
            end)
        end
        
        -- Обрабатываем появление нового персонажа
        player.CharacterAdded:Connect(function(character)
            wait(0.5) -- Ждем загрузки персонажа
            if walkerEnabled then
                if not walkerPlatform then
                    walkerPlatform = Instance.new("Part")
                    walkerPlatform.Name = "WalkerPlatform"
                    walkerPlatform.Size = Vector3.new(20, 1, 20)
                    walkerPlatform.Anchored = true
                    walkerPlatform.CanCollide = true
                    walkerPlatform.Transparency = 0.8
                    walkerPlatform.Color = Color3.fromRGB(200, 200, 200)
                    walkerPlatform.Parent = workspace
                end
                
                if walkerConnection then
                    walkerConnection:Disconnect()
                end
                
                walkerConnection = RunService.Heartbeat:Connect(function()
                    if not walkerEnabled or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
                        if walkerConnection then
                            walkerConnection:Disconnect()
                        end
                        if walkerPlatform then
                            walkerPlatform:Destroy()
                            walkerPlatform = nil
                        end
                        return
                    end
                    
                    local hrp = player.Character.HumanoidRootPart
                    local position = hrp.Position - Vector3.new(0, 3, 0)
                    walkerPlatform.Position = position
                end)
            end
        end)
    else
        walkerButton.Text = "Walker"
        walkerButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
        
        if walkerConnection then
            walkerConnection:Disconnect()
            walkerConnection = nil
        end
        
        if walkerPlatform then
            walkerPlatform:Destroy()
            walkerPlatform = nil
        end
    end
end

-- Функционал переключения страниц
local function goToSecondPage()
    mainFrame.Visible = false
    secondFrame.Visible = true
end

local function goToFirstPage()
    secondFrame.Visible = false
    mainFrame.Visible = true
end

-- Функционал кнопок первой страницы
button1.MouseButton1Click:Connect(function()
    toggleESP()
end)

button2.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet('https://pastefy.app/CLu1GH4y/raw'))()
end)

button3.MouseButton1Click:Connect(function()
    toggleSkyWalk()
end)

button4.MouseButton1Click:Connect(serverHop)

button5.MouseButton1Click:Connect(function()
    toggleGodMode()
end)

button6.MouseButton1Click:Connect(runLennonHub)

nextPageButton.MouseButton1Click:Connect(goToSecondPage)

-- Функционал кнопок второй страницы
backPageButton.MouseButton1Click:Connect(goToFirstPage)
kickButton.MouseButton1Click:Connect(kickPlayer)
palmaFuckerButton.MouseButton1Click:Connect(runPalmaFucker)
walkerButton.MouseButton1Click:Connect(toggleWalker)

-- Добавляем фреймы на экран
mainFrame.Parent = screenGui
secondFrame.Parent = screenGui
toggleButton.Parent = screenGui
versionText.Parent = screenGui

-- Функция переключения видимости интерфейса
local function toggleInterface()
    if mainFrame.Visible or secondFrame.Visible then
        mainFrame.Visible = false
        secondFrame.Visible = false
        toggleButton.Text = "Open"
    else
        mainFrame.Visible = true
        toggleButton.Text = "Close"
        
        mainFrame.Size = UDim2.new(0, 0, 0, 0)
        
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(mainFrame, tweenInfo, {Size = UDim2.new(0, 300 * uiScale, 0, 500 * uiScale)})
        tween:Play()
    end
end

-- Обработка нажатия на кнопку переключения
toggleButton.MouseButton1Click:Connect(toggleInterface)

-- Автоматическая загрузка настроек при запуске
wait(2)
loadSettingsAfterTeleport()
