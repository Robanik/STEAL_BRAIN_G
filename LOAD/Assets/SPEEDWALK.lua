local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local BaseSpeed = 16 -- Базовая скорость (стандартная в Roblox)
local ValueSpeed = 16 -- Начальное значение слайдера
local ActiveCFrameSpeedBoost = true -- Автоматически включено
local cframeSpeedConnection = nil

-- Функция для обновления скорости с CFrame Speed Boost
local function updateCFrameSpeed(character)
    if cframeSpeedConnection then
        cframeSpeedConnection:Disconnect()
        cframeSpeedConnection = nil
    end

    if ActiveCFrameSpeedBoost then
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local hrp = character and character:FindFirstChild("HumanoidRootPart")

        if humanoid then
            humanoid.WalkSpeed = ValueSpeed -- Устанавливаем скорость ходьбы
        end

        cframeSpeedConnection = RunService.RenderStepped:Connect(function()
            if character and humanoid and hrp then
                local moveDir = humanoid.MoveDirection
                if moveDir.Magnitude > 0 then
                    -- Масштабируем CFrame Speed относительно базовой скорости
                    local speedMultiplier = math.max(ValueSpeed / BaseSpeed, 1)
                    hrp.CFrame = hrp.CFrame + moveDir * speedMultiplier * 0.080
                end
            end
        end)
    end
end

-- Обработчик появления персонажа
local function onCharacterAdded(character)
    updateCFrameSpeed(character)
end

-- Обработчик удаления персонажа
local function onCharacterRemoving()
    if cframeSpeedConnection then
        cframeSpeedConnection:Disconnect()
        cframeSpeedConnection = nil
    end
end

-- Подключение событий
LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
LocalPlayer.CharacterRemoving:Connect(onCharacterRemoving)

-- Проверка, если персонаж уже существует
if LocalPlayer.Character then
    onCharacterAdded(LocalPlayer.Character)
end
