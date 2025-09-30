-- Утилиты
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Переменные
local AimbotEnabled = false
local FOV = 50
local Circle = Drawing.new("Circle")
Circle.Visible = false
Circle.Color = Color3.new(1, 0, 0) -- Красный кружок
Circle.Thickness = 2
Circle.NumSides = 100
Circle.Radius = FOV
Circle.Filled = false

-- Функция получения ближайшего игрока в FOV
local function GetClosestPlayer()
    local ClosestPlayer = nil
    local ClosestDistance = math.huge
    local MousePos = UserInputService:GetMouseLocation()

    for _, Player in pairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer and Player.Character and Player.Character:FindFirstChild("Head") then
            local Head = Player.Character.Head
            local HeadPos, OnScreen = Camera:WorldToViewportPoint(Head.Position)
            
            if OnScreen then
                local Distance = (Vector2.new(HeadPos.X, HeadPos.Y) - Vector2.new(MousePos.X, MousePos.Y)).Magnitude
                if Distance <= FOV and Distance < ClosestDistance then
                    ClosestDistance = Distance
                    ClosestPlayer = Player
                end
            end
        end
    end
    return ClosestPlayer
end

-- Функция аимбота
local function AimAt(target)
    if target and target.Character and target.Character:FindFirstChild("Head") then
        local HeadPos = Camera:WorldToViewportPoint(target.Character.Head.Position)
        mousemoverel((HeadPos.X - UserInputService:GetMouseLocation().X), (HeadPos.Y - UserInputService:GetMouseLocation().Y))
    end
end

-- Обновление FOV-кружка
local function UpdateCircle()
    Circle.Radius = FOV
    Circle.Position = UserInputService:GetMouseLocation()
    Circle.Visible = AimbotEnabled
end
