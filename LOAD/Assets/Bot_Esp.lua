-- ESP для Nextbots в Evade (из evade.lua)
local Esp = loadstring(game:HttpGet("https://raw.githubusercontent.com/9Strew/roblox/main/proc/kiriotesp"))()

-- Настройки ESP
Esp.Enabled = true
Esp.Tracers = true  -- Трасеры к ботам
Esp.Boxes = true    -- Боксы вокруг ботов

-- Функция для nextbots (AI в workspace.Game.Players)
Esp:AddObjectListener(game:GetService("Workspace").Game.Players, {
    Validator = function(obj)
        return not game.Players:GetPlayerFromCharacter(obj)  -- Только не-игроки (nextbots)
    end,
    CustomName = function(obj)
        return '[NextBot] ' .. obj.Name  -- Имя с префиксом
    end,
    IsEnabled = true,
    Color = Color3.fromRGB(255, 0, 0),  -- Красный цвет для ботов
    RenderInFirstPerson = true
})

-- Обновление дистанции (опционально, в цикле)
local Players = game:GetService("Players")
local localplayer = Players.LocalPlayer
game:GetService("RunService").RenderStepped:Connect(function()
    for _, obj in pairs(game:GetService("Workspace").Game.Players:GetChildren()) do
        if not game.Players:GetPlayerFromCharacter(obj) and obj:FindFirstChild("HumanoidRootPart") then
            local distance = (obj.HumanoidRootPart.Position - localplayer.Character.HumanoidRootPart.Position).Magnitude
            -- Здесь можно добавить текст с дистанцией, если ESP поддерживает (расширение)
        end
    end
end)
