-- AFK Кнопка для Roblox (Улучшенная версия)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Создаем ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AFKGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

-- Создаем Frame для кнопки
local buttonFrame = Instance.new("Frame")
buttonFrame.Size = UDim2.new(0, 200, 0, 80)
buttonFrame.Position = UDim2.new(0.5, -100, 0.1, 0)
buttonFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
buttonFrame.BorderSizePixel = 0
buttonFrame.Active = true
buttonFrame.Draggable = true
buttonFrame.Parent = screenGui

-- Скругление углов
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = buttonFrame

-- Градиент фона
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 25)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 15, 15)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 5, 5))
}
gradient.Rotation = 135
gradient.Parent = buttonFrame

-- Внешняя обводка
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(80, 80, 80)
stroke.Thickness = 3
stroke.Transparency = 0.3
stroke.Parent = buttonFrame

-- Внутреннее свечение (второй frame)
local glowFrame = Instance.new("Frame")
glowFrame.Size = UDim2.new(1, -4, 1, -4)
glowFrame.Position = UDim2.new(0, 2, 0, 2)
glowFrame.BackgroundTransparency = 1
glowFrame.Parent = buttonFrame

local innerStroke = Instance.new("UIStroke")
innerStroke.Color = Color3.fromRGB(120, 120, 120)
innerStroke.Thickness = 1
innerStroke.Transparency = 0.7
innerStroke.Parent = glowFrame

local innerCorner = Instance.new("UICorner")
innerCorner.CornerRadius = UDim.new(0, 14)
innerCorner.Parent = glowFrame

-- Текстовая кнопка
local button = Instance.new("TextButton")
button.Size = UDim2.new(1, 0, 1, -20)
button.Position = UDim2.new(0, 0, 0, 0)
button.BackgroundTransparency = 1
button.Text = "AFK"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextSize = 32
button.Font = Enum.Font.GothamBold
button.Parent = buttonFrame

-- Эффект тени для текста
local textShadow = Instance.new("TextLabel")
textShadow.Size = button.Size
textShadow.Position = UDim2.new(0, 2, 0, 2)
textShadow.BackgroundTransparency = 1
textShadow.Text = button.Text
textShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
textShadow.TextSize = button.TextSize
textShadow.Font = button.Font
textShadow.TextTransparency = 0.5
textShadow.ZIndex = button.ZIndex - 1
textShadow.Parent = buttonFrame

-- Подпись ROBANIK снизу
local signature = Instance.new("TextLabel")
signature.Size = UDim2.new(1, 0, 0, 18)
signature.Position = UDim2.new(0, 0, 1, -20)
signature.BackgroundTransparency = 1
signature.Text = "ROBANIK"
signature.TextColor3 = Color3.fromRGB(100, 100, 100)
signature.TextSize = 10
signature.Font = Enum.Font.GothamBold
signature.TextTransparency = 0.4
signature.Parent = buttonFrame

-- Иконка для перетаскивания
local dragIcon = Instance.new("TextLabel")
dragIcon.Size = UDim2.new(0, 40, 0, 25)
dragIcon.Position = UDim2.new(1, -45, 0, 5)
dragIcon.BackgroundTransparency = 1
dragIcon.Text = "⋮⋮"
dragIcon.TextColor3 = Color3.fromRGB(120, 120, 120)
dragIcon.TextSize = 18
dragIcon.Font = Enum.Font.GothamBold
dragIcon.TextTransparency = 0.5
dragIcon.Parent = buttonFrame

-- Декоративные точки по углам
local function createCornerDot(position)
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 4, 0, 4)
    dot.Position = position
    dot.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
    dot.BorderSizePixel = 0
    dot.BackgroundTransparency = 0.6
    dot.Parent = buttonFrame
    
    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = dot
    
    return dot
end

createCornerDot(UDim2.new(0, 8, 0, 8))
createCornerDot(UDim2.new(1, -12, 0, 8))
createCornerDot(UDim2.new(0, 8, 1, -12))
createCornerDot(UDim2.new(1, -12, 1, -12))

-- Переменные для AFK
local isAFK = false
local savedPosition = nil
local afkPlatform = nil
local afkHeight = 500

-- Функция создания улучшенной платформы
local function createPlatform(position)
    local platform = Instance.new("Part")
    platform.Size = Vector3.new(25, 1, 25)
    platform.Position = position
    platform.Anchored = true
    platform.Material = Enum.Material.Neon
    platform.BrickColor = BrickColor.new("Really black")
    platform.Transparency = 0.2
    platform.Parent = workspace
    
    -- Добавляем текстуру
    local texture = Instance.new("SurfaceGui")
    texture.Face = Enum.NormalId.Top
    texture.Parent = platform
    
    local pattern = Instance.new("Frame")
    pattern.Size = UDim2.new(1, 0, 1, 0)
    pattern.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    pattern.BackgroundTransparency = 0.9
    pattern.BorderSizePixel = 0
    pattern.Parent = texture
    
    local grid = Instance.new("UIGridLayout")
    grid.CellSize = UDim2.new(0, 50, 0, 50)
    grid.CellPadding = UDim2.new(0, 5, 0, 5)
    grid.Parent = pattern
    
    -- Центральное свечение
    local pointLight = Instance.new("PointLight")
    pointLight.Color = Color3.fromRGB(80, 120, 255)
    pointLight.Brightness = 3
    pointLight.Range = 40
    pointLight.Parent = platform
    
    -- Барьеры по краям
    for i = 1, 4 do
        local barrier = Instance.new("Part")
        barrier.Size = Vector3.new(i % 2 == 0 and 25 or 2, 5, i % 2 == 0 and 2 or 25)
        barrier.Material = Enum.Material.ForceField
        barrier.BrickColor = BrickColor.new("Deep blue")
        barrier.Transparency = 0.7
        barrier.Anchored = true
        barrier.CanCollide = false
        
        if i == 1 then
            barrier.Position = position + Vector3.new(0, 3, 12.5)
        elseif i == 2 then
            barrier.Position = position + Vector3.new(12.5, 3, 0)
        elseif i == 3 then
            barrier.Position = position + Vector3.new(0, 3, -12.5)
        else
            barrier.Position = position + Vector3.new(-12.5, 3, 0)
        end
        
        barrier.Parent = workspace
    end
    
    return platform
end

-- Функция телепортации вверх (AFK включен)
local function goAFK()
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    savedPosition = humanoidRootPart.CFrame
    
    local newPosition = humanoidRootPart.Position + Vector3.new(0, afkHeight, 0)
    afkPlatform = createPlatform(newPosition - Vector3.new(0, 3, 0))
    humanoidRootPart.CFrame = CFrame.new(newPosition)
    
    -- Улучшенная анимация кнопки
    button.Text = "AFK ON"
    textShadow.Text = "AFK ON"
    button.TextColor3 = Color3.fromRGB(100, 255, 150)
    stroke.Color = Color3.fromRGB(100, 255, 150)
    innerStroke.Color = Color3.fromRGB(150, 255, 180)
    signature.TextColor3 = Color3.fromRGB(100, 255, 150)
    
    local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
    local tween = TweenService:Create(buttonFrame, tweenInfo, {Size = UDim2.new(0, 220, 0, 90)})
    tween:Play()
    
    -- Пульсация обводки
    spawn(function()
        while isAFK do
            local pulse = TweenService:Create(stroke, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0})
            pulse:Play()
            wait(1)
            local pulse2 = TweenService:Create(stroke, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.3})
            pulse2:Play()
            wait(1)
        end
    end)
end

-- Функция возврата (AFK выключен)
local function returnFromAFK()
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart or not savedPosition then return end
    
    humanoidRootPart.CFrame = savedPosition
    
    if afkPlatform then
        afkPlatform:Destroy()
        afkPlatform = nil
    end
    
    savedPosition = nil
    
    button.Text = "AFK"
    textShadow.Text = "AFK"
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    stroke.Color = Color3.fromRGB(80, 80, 80)
    innerStroke.Color = Color3.fromRGB(120, 120, 120)
    signature.TextColor3 = Color3.fromRGB(100, 100, 100)
    
    local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
    local tween = TweenService:Create(buttonFrame, tweenInfo, {Size = UDim2.new(0, 200, 0, 80)})
    tween:Play()
end

-- Обработчик нажатия кнопки
button.MouseButton1Click:Connect(function()
    isAFK = not isAFK
    
    if isAFK then
        goAFK()
    else
        returnFromAFK()
    end
    
    -- Эффект нажатия с bounce
    local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.In)
    local currentSize = buttonFrame.Size
    local tween = TweenService:Create(buttonFrame, tweenInfo, {
        Size = UDim2.new(currentSize.X.Scale, currentSize.X.Offset - 10, currentSize.Y.Scale, currentSize.Y.Offset - 5)
    })
    tween:Play()
    wait(0.15)
    local tweenBack = TweenService:Create(buttonFrame, TweenInfo.new(0.3, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
        Size = currentSize
    })
    tweenBack:Play()
end)

-- Эффект hover
button.MouseEnter:Connect(function()
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad)
    TweenService:Create(stroke, tweenInfo, {Transparency = 0, Thickness = 4}):Play()
    TweenService:Create(innerStroke, tweenInfo, {Transparency = 0.4}):Play()
    TweenService:Create(signature, tweenInfo, {TextTransparency = 0.2}):Play()
    TweenService:Create(dragIcon, tweenInfo, {TextTransparency = 0.2}):Play()
end)

button.MouseLeave:Connect(function()
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad)
    TweenService:Create(stroke, tweenInfo, {Transparency = 0.3, Thickness = 3}):Play()
    TweenService:Create(innerStroke, tweenInfo, {Transparency = 0.7}):Play()
    TweenService:Create(signature, tweenInfo, {TextTransparency = 0.4}):Play()
    TweenService:Create(dragIcon, tweenInfo, {TextTransparency = 0.5}):Play()
end)

print("✨ AFK кнопка загружена! By ROBANIK")
