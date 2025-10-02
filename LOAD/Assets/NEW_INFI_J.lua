local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")

-- Создаем GUI в CoreGui (скрыто от анти-чита)
local sg = Instance.new("ScreenGui")
sg.Name = game:GetService("HttpService"):GenerateGUID(false)
sg.ResetOnSpawn = false
sg.DisplayOrder = 10
sg.IgnoreGuiInset = false
sg.Parent = game:GetService("CoreGui")

-- Основная кнопка (как оригинал Roblox Mobile)
local btn = Instance.new("TextButton")
btn.Name = game:GetService("HttpService"):GenerateGUID(false)
btn.Size = UDim2.new(0, 70, 0, 70)
btn.Position = UDim2.new(1, -100, 1, -165) -- Справа снизу, выше чем предыдущая
btn.AnchorPoint = Vector2.new(0.5, 0.5)
btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
btn.BackgroundTransparency = 0.5
btn.BorderSizePixel = 0
btn.Text = ""
btn.AutoButtonColor = false
btn.Parent = sg

-- Полное округление
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = btn

-- Обводка как у оригинала
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Thickness = 2
stroke.Transparency = 0.7
stroke.Parent = btn

-- Иконка стрелки вверх (простой текст)
local icon = Instance.new("TextLabel")
icon.Size = UDim2.new(1, 0, 1, 0)
icon.BackgroundTransparency = 1
icon.Text = "▲"
icon.TextSize = 28
icon.TextColor3 = Color3.fromRGB(255, 255, 255)
icon.Font = Enum.Font.GothamBold
icon.TextTransparency = 0
icon.Parent = btn

-- Скрытая функция прыжка
local lastJump = 0
local jumpCooldown = 0.1
local isPressed = false

local function stealthJump()
    local now = tick()
    if now - lastJump < jumpCooldown then return end
    lastJump = now
    
    -- Анимация нажатия
    isPressed = true
    btn.BackgroundTransparency = 0.3
    btn.Size = UDim2.new(0, 65, 0, 65)
    icon.TextSize = 26
    
    -- Прыжок через CFrame + импульс
    spawn(function()
        for i = 1, 10 do
            if rootPart and rootPart.Parent then
                rootPart.CFrame = rootPart.CFrame + Vector3.new(0, 0.5, 0)
                RS.RenderStepped:Wait()
            end
        end
    end)
    
    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(0, 4000, 0)
    bv.Velocity = Vector3.new(0, 45, 0)
    bv.Parent = rootPart
    game:GetService("Debris"):AddItem(bv, 0.12)
    
    -- Возврат к обычному виду
    wait(0.1)
    isPressed = false
    btn.BackgroundTransparency = 0.5
    btn.Size = UDim2.new(0, 70, 0, 70)
    icon.TextSize = 28
end

-- Обработка нажатий
btn.MouseButton1Click:Connect(function()
    stealthJump()
end)

btn.TouchTap:Connect(function()
    stealthJump()
end)

-- Поддержка пробела
UIS.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.Space then
        task.wait(0.05)
        stealthJump()
    end
end)

-- Защита от удаления
sg.DescendantRemoving:Connect(function(obj)
    if obj == sg or obj == btn then
        wait(0.5)
        if not sg.Parent then
            sg.Parent = game:GetService("CoreGui")
        end
    end
end)
