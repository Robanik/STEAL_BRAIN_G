local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Настройки ключа
local KEY_SYSTEM_ENABLED = true -- Изменить на false, чтобы отключить ключ
local COPY_LINK = "https://discord.gg/3mVUh2RWsp" -- Ссылка для копирования

-- Проверка ключа (FREE_ + 16 цифр)
local function IsValidKey(key)
    if #key == 21 and string.sub(key, 1, 5) == "FREE_" then
        local digits = string.sub(key, 6)
        return digits:match("^%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d$") ~= nil
    end
    return false
end

-- Создаем ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ROBANIKCheatMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Окно для ввода ключа
local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 300, 0, 180)
KeyFrame.Position = UDim2.new(0.5, -150, 0.5, -90)
KeyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
KeyFrame.BackgroundTransparency = 0.3
KeyFrame.Parent = ScreenGui
KeyFrame.Visible = KEY_SYSTEM_ENABLED

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 12)
KeyCorner.Parent = KeyFrame

local KeyGradient = Instance.new("UIGradient")
KeyGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 25)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 50))
})
KeyGradient.Rotation = 45
KeyGradient.Parent = KeyFrame

local KeyLabel = Instance.new("TextLabel")
KeyLabel.Size = UDim2.new(0, 280, 0, 30)
KeyLabel.Position = UDim2.new(0, 10, 0, 10)
KeyLabel.BackgroundTransparency = 1
KeyLabel.Text = "KeySystem"
KeyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyLabel.TextSize = 16
KeyLabel.Font = Enum.Font.GothamBold
KeyLabel.Parent = KeyFrame

local KeyTextBox = Instance.new("TextBox")
KeyTextBox.Size = UDim2.new(0, 260, 0, 40)
KeyTextBox.Position = UDim2.new(0, 20, 0, 50)
KeyTextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
KeyTextBox.Text = ""
KeyTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTextBox.TextSize = 14
KeyTextBox.Font = Enum.Font.Gotham
KeyTextBox.Parent = KeyFrame

local KeyTextBoxCorner = Instance.new("UICorner")
KeyTextBoxCorner.CornerRadius = UDim.new(0, 8)
KeyTextBoxCorner.Parent = KeyTextBox

local KeySubmit = Instance.new("TextButton")
KeySubmit.Size = UDim2.new(0, 120, 0, 40)
KeySubmit.Position = UDim2.new(0, 20, 0, 100)
KeySubmit.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
KeySubmit.Text = "Submit"
KeySubmit.TextColor3 = Color3.fromRGB(255, 255, 255)
KeySubmit.TextSize = 14
KeySubmit.Font = Enum.Font.Gotham
KeySubmit.Parent = KeyFrame

local KeySubmitCorner = Instance.new("UICorner")
KeySubmitCorner.CornerRadius = UDim.new(0, 8)
KeySubmitCorner.Parent = KeySubmit

local KeyCopy = Instance.new("TextButton")
KeyCopy.Size = UDim2.new(0, 120, 0, 40)
KeyCopy.Position = UDim2.new(0, 160, 0, 100)
KeyCopy.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
KeyCopy.Text = "Copy Link"
KeyCopy.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTextBox.TextSize = 14
KeyTextBox.Font = Enum.Font.Gotham
KeyCopy.Parent = KeyFrame

local KeyCopyCorner = Instance.new("UICorner")
KeyCopyCorner.CornerRadius = UDim.new(0, 8)
KeyCopyCorner.Parent = KeyCopy

-- Основной фрейм меню
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 300)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BackgroundTransparency = 0.3
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Visible = not KEY_SYSTEM_ENABLED
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 25)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 50))
})
MainGradient.Rotation = 45
MainGradient.Parent = MainFrame

-- Водяной знак
local Watermark = Instance.new("TextLabel")
Watermark.Size = UDim2.new(0, 200, 0, 30)
Watermark.Position = UDim2.new(0, 10, 0, 10)
Watermark.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
Watermark.BackgroundTransparency = 0.3
Watermark.Text = "ROBANIK | UNIVERSAL"
Watermark.TextColor3 = Color3.fromRGB(255, 255, 255)
Watermark.TextSize = 16
Watermark.Font = Enum.Font.GothamBold
Watermark.Parent = ScreenGui

local WatermarkCorner = Instance.new("UICorner")
WatermarkCorner.CornerRadius = UDim.new(0, 8)
WatermarkCorner.Parent = Watermark

-- Радужная анимация
local function RainbowEffect(element)
    while true do
        for hue = 0, 1, 0.01 do
            local color = Color3.fromHSV(hue, 0.8, 1)
            TweenService:Create(element, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {TextColor3 = color}):Play()
            wait(0.05)
        end
    end
end
coroutine.wrap(RainbowEffect)(Watermark)

-- Кнопка открытия/закрытия
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 10, 0, 50)
ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
ToggleButton.Text = "☰"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 20
ToggleButton.Font = Enum.Font.Gotham
ToggleButton.Parent = ScreenGui
ToggleButton.Visible = not KEY_SYSTEM_ENABLED

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 10)
ToggleCorner.Parent = ToggleButton

ToggleButton.MouseEnter:Connect(function()
    TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 70)}):Play()
end)
ToggleButton.MouseLeave:Connect(function()
    TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 45)}):Play()
end)

-- Анимация открытия/закрытия
ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    if MainFrame.Visible then
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 350, 0, 300),
            BackgroundTransparency = 0.3
        }):Play()
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1
        }):Play()
    end
end)

-- Панель вкладок (слева)
local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(0, 100, 0, 280)
TabFrame.Position = UDim2.new(0, 10, 0, 10)
TabFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
TabFrame.BackgroundTransparency = 0.4
TabFrame.Parent = MainFrame

local TabCorner = Instance.new("UICorner")
TabCorner.CornerRadius = UDim.new(0, 8)
TabCorner.Parent = TabFrame

local TabLayout = Instance.new("UIListLayout")
TabLayout.Padding = UDim.new(0, 5)
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Parent = TabFrame

-- Ник в левой панели
local CreatorLabel = Instance.new("TextLabel")
CreatorLabel.Size = UDim2.new(0, 100, 0, 20)
CreatorLabel.Position = UDim2.new(0, 0, 1, -30)
CreatorLabel.BackgroundTransparency = 1
CreatorLabel.Text = "BY ROBANIK"
CreatorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CreatorLabel.TextSize = 12
CreatorLabel.Font = Enum.Font.Gotham
CreatorLabel.Parent = TabFrame
coroutine.wrap(RainbowEffect)(CreatorLabel)

-- Контент вкладок (справа)
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(0, 220, 0, 280)
ContentFrame.Position = UDim2.new(0, 120, 0, 10)
ContentFrame.BackgroundTransparency = 1
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentFrame.ScrollBarThickness = 4
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 255)
ContentFrame.Parent = MainFrame

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 10)
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Parent = ContentFrame

ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 20)
end)

-- Функции для создания элементов
local Tabs = {}
local CurrentTab = nil

local function CreateTab(name)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(0, 90, 0, 40)
    TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    TabButton.Text = name
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.TextSize = 14
    TabButton.Font = Enum.Font.Gotham
    TabButton.Parent = TabFrame

    local TabButtonCorner = Instance.new("UICorner")
    TabButtonCorner.CornerRadius = UDim.new(0, 6)
    TabButtonCorner.Parent = TabButton

    local TabContent = Instance.new("ScrollingFrame")
    TabContent.Size = UDim2.new(0, 220, 0, 280)
    TabContent.Position = UDim2.new(0, 120, 0, 10)
    TabContent.BackgroundTransparency = 1
    TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabContent.ScrollBarThickness = 4
    TabContent.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 255)
    TabContent.Visible = false
    TabContent.Parent = MainFrame

    local TabContentLayout = Instance.new("UIListLayout")
    TabContentLayout.Padding = UDim.new(0, 10)
    TabContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabContentLayout.Parent = TabContent

    TabContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabContent.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y + 20)
    end)

    TabButton.MouseButton1Click:Connect(function()
        if CurrentTab then
            CurrentTab.Visible = false
            for _, tab in ipairs(Tabs) do
                TweenService:Create(tab.Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 45)}):Play()
            end
        end
        TabContent.Visible = true
        CurrentTab = TabContent
        TweenService:Create(TabButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 70)}):Play()
    end)

    table.insert(Tabs, {Button = TabButton, Content = TabContent})
    return TabContent
end

local function CreateButton(parent, text, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 200, 0, 40)
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 14
    Button.Font = Enum.Font.Gotham
    Button.Parent = parent

    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 8)
    ButtonCorner.Parent = Button

    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 70)}):Play()
    end)
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 45)}):Play()
    end)
    Button.MouseButton1Click:Connect(callback)

    return Button
end

local function CreateToggle(parent, text, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(0, 200, 0, 40)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Parent = parent

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0, 140, 0, 40)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 14
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame

    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0, 40, 0, 20)
    ToggleButton.Position = UDim2.new(0, 150, 0, 10)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    ToggleButton.Text = "OFF"
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.TextSize = 12
    ToggleButton.Font = Enum.Font.Gotham
    ToggleButton.Parent = ToggleFrame

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 10)
    ToggleCorner.Parent = ToggleButton

    local isOn = false
    ToggleButton.MouseButton1Click:Connect(function()
        isOn = not isOn
        ToggleButton.Text = isOn and "ON" or "OFF"
        ToggleButton.BackgroundColor3 = isOn and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(80, 80, 80)
        callback(isOn)
    end)

    return ToggleFrame
end

local function CreateSlider(parent, text, min, max, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(0, 200, 0, 60)
    SliderFrame.BackgroundTransparency = 1
    SliderFrame.Parent = parent

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0, 140, 0, 20)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 14
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = SliderFrame

    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0, 60, 0, 20)
    ValueLabel.Position = UDim2.new(0, 140, 0, 0)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(min)
    ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ValueLabel.TextSize = 14
    ValueLabel.Font = Enum.Font.Gotham
    ValueLabel.Parent = SliderFrame

    local SliderBar = Instance.new("Frame")
    SliderBar.Size = UDim2.new(0, 180, 0, 10)
    SliderBar.Position = UDim2.new(0, 10, 0, 30)
    SliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    SliderBar.Parent = SliderFrame

    local SliderFill = Instance.new("Frame")
    SliderFill.Size = UDim2.new(0, 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
    SliderFill.Parent = SliderBar

    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(0, 5)
    SliderCorner.Parent = SliderBar
    SliderCorner:Clone().Parent = SliderFill

    local SliderValue = min
    local Dragging = false

    local SliderButton = Instance.new("TextButton")
    SliderButton.Size = UDim2.new(1, 0, 1, 0)
    SliderButton.BackgroundTransparency = 1
    SliderButton.Text = ""
    SliderButton.Parent = SliderBar

    SliderButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            local mouseX = input.Position.X
            local barX = SliderBar.AbsolutePosition.X
            local barWidth = SliderBar.AbsoluteSize.X
            local relativeX = math.clamp((mouseX - barX) / barWidth, 0, 1)
            SliderValue = math.floor(min + (max - min) * relativeX)
            TweenService:Create(SliderFill, TweenInfo.new(0.1), {Size = UDim2.new(relativeX, 0, 1, 0)}):Play()
            ValueLabel.Text = tostring(SliderValue)
            callback(SliderValue)
        end
    end)

    SliderButton.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local mouseX = input.Position.X
            local barX = SliderBar.AbsolutePosition.X
            local barWidth = SliderBar.AbsoluteSize.X
            local relativeX = math.clamp((mouseX - barX) / barWidth, 0, 1)
            SliderValue = math.floor(min + (max - min) * relativeX)
            TweenService:Create(SliderFill, TweenInfo.new(0.1), {Size = UDim2.new(relativeX, 0, 1, 0)}):Play()
            ValueLabel.Text = tostring(SliderValue)
            callback(SliderValue)
        end
    end)

    return SliderFrame
end

local function CreateTextBox(parent, text, callback)
    local TextBoxFrame = Instance.new("Frame")
    TextBoxFrame.Size = UDim2.new(0, 200, 0, 40)
    TextBoxFrame.BackgroundTransparency = 1
    TextBoxFrame.Parent = parent

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0, 80, 0, 40)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 14
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = TextBoxFrame

    local TextBox = Instance.new("TextBox")
    TextBox.Size = UDim2.new(0, 110, 0, 30)
    TextBox.Position = UDim2.new(0, 80, 0, 5)
    TextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    TextBox.Text = ""
    TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextBox.TextSize = 14
    TextBox.Font = Enum.Font.Gotham
    TextBox.Parent = TextBoxFrame

    local TextBoxCorner = Instance.new("UICorner")
    TextBoxCorner.CornerRadius = UDim.new(0, 8)
    TextBoxCorner.Parent = TextBox

    TextBox.FocusLost:Connect(function()
        callback(TextBox.Text)
    end)

    return TextBoxFrame
end

local function CreateDropdown(parent, text, options, callback)
    local DropdownFrame = Instance.new("Frame")
    DropdownFrame.Size = UDim2.new(0, 200, 0, 40)
    DropdownFrame.BackgroundTransparency = 1
    DropdownFrame.Parent = parent

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0, 80, 0, 40)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 14
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = DropdownFrame

    local DropdownButton = Instance.new("TextButton")
    DropdownButton.Size = UDim2.new(0, 110, 0, 30)
    DropdownButton.Position = UDim2.new(0, 80, 0, 5)
    DropdownButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    DropdownButton.Text = options[1]
    DropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DropdownButton.TextSize = 14
    DropdownButton.Font = Enum.Font.Gotham
    DropdownButton.Parent = DropdownFrame

    local DropdownCorner = Instance.new("UICorner")
    DropdownCorner.CornerRadius = UDim.new(0, 8)
    DropdownCorner.Parent = DropdownButton

    local DropdownList = Instance.new("Frame")
    DropdownList.Size = UDim2.new(0, 110, 0, 0)
    DropdownList.Position = UDim2.new(0, 80, 0, 40)
    DropdownList.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    DropdownList.BackgroundTransparency = 0.2
    DropdownList.ClipsDescendants = true
    DropdownList.Visible = false
    DropdownList.Parent = DropdownFrame

    local DropdownListLayout = Instance.new("UIListLayout")
    DropdownListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    DropdownListLayout.Parent = DropdownList

    for i, option in ipairs(options) do
        local OptionButton = Instance.new("TextButton")
        OptionButton.Size = UDim2.new(1, 0, 0, 30)
        OptionButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        OptionButton.Text = option
        OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        OptionButton.TextSize = 14
        OptionButton.Font = Enum.Font.Gotham
        OptionButton.Parent = DropdownList

        OptionButton.MouseButton1Click:Connect(function()
            DropdownButton.Text = option
            DropdownList.Visible = false
            TweenService:Create(DropdownList, TweenInfo.new(0.2), {Size = UDim2.new(0, 110, 0, 0)}):Play()
            callback(option)
        end)
    end

    DropdownButton.MouseButton1Click:Connect(function()
        DropdownList.Visible = not DropdownList.Visible
        TweenService:Create(DropdownList, TweenInfo.new(0.2), {Size = DropdownList.Visible and UDim2.new(0, 110, 0, #options * 30) or UDim2.new(0, 110, 0, 0)}):Play()
    end)

    return DropdownFrame
end

local function CreateColorPicker(parent, text, callback)
    local ColorPickerFrame = Instance.new("Frame")
    ColorPickerFrame.Size = UDim2.new(0, 200, 0, 100)
    ColorPickerFrame.BackgroundTransparency = 1
    ColorPickerFrame.Parent = parent

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0, 80, 0, 40)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 14
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ColorPickerFrame

    local Preview = Instance.new("Frame")
    Preview.Size = UDim2.new(0, 30, 0, 30)
    Preview.Position = UDim2.new(0, 160, 0, 5)
    Preview.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Preview.Parent = ColorPickerFrame

    local PreviewCorner = Instance.new("UICorner")
    PreviewCorner.CornerRadius = UDim.new(0, 8)
    PreviewCorner.Parent = Preview

    local ColorSliderR = CreateSlider(ColorPickerFrame, "Red", 0, 255, function(value)
        local color = Color3.fromRGB(value, ColorPickerFrame.Green or 255, ColorPickerFrame.Blue or 255)
        Preview.BackgroundColor3 = color
        callback(color)
    end)
    ColorSliderR.Position = UDim2.new(0, 0, 0, 40)
    ColorPickerFrame.Red = 255

    local ColorSliderG = CreateSlider(ColorPickerFrame, "Green", 0, 255, function(value)
        ColorPickerFrame.Green = value
        local color = Color3.fromRGB(ColorPickerFrame.Red or 255, value, ColorPickerFrame.Blue or 255)
        Preview.BackgroundColor3 = color
        callback(color)
    end)
    ColorSliderG.Position = UDim2.new(0, 0, 0, 100)
    ColorPickerFrame.Green = 255

    local ColorSliderB = CreateSlider(ColorPickerFrame, "Blue", 0, 255, function(value)
        ColorPickerFrame.Blue = value
        local color = Color3.fromRGB(ColorPickerFrame.Red or 255, ColorPickerFrame.Green or 255, value)
        Preview.BackgroundColor3 = color
        callback(color)
    end)
    ColorSliderB.Position = UDim2.new(0, 0, 0, 160)
    ColorPickerFrame.Blue = 255

    return ColorPickerFrame
end

-- Логика ключа
KeySubmit.MouseButton1Click:Connect(function()
    if IsValidKey(KeyTextBox.Text) then
        KeyFrame.Visible = false
        MainFrame.Visible = true
        ToggleButton.Visible = true
        print("Key accepted!")
    else
        KeyTextBox.Text = "Invalid Key"
        wait(1)
        KeyTextBox.Text = ""
    end
end)

KeyCopy.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(COPY_LINK)
        KeyCopy.Text = "Copied!"
        wait(1)
        KeyCopy.Text = "Copy Link"
    else
        print("Clipboard not supported")
    end
end)

-- Создаем вкладки
local MainTab = CreateTab("Main")
local PlayerTab = CreateTab("Misc")
local PremTab = CreateTab("Premium")
local SettingsTab = CreateTab("Settings")

-- Добавляем элементы в MainTab
CreateButton(MainTab, "Enable Speed Hack", function()
    print("Speed Hack Enabled!")
end)

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
    local ScreenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, Player in pairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer and Player.Character and Player.Character:FindFirstChild("Head") then
            local Head = Player.Character.Head
            local HeadPos, OnScreen = Camera:WorldToViewportPoint(Head.Position)
            
            if OnScreen then
                local Distance = (Vector2.new(HeadPos.X, HeadPos.Y) - ScreenCenter).Magnitude
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
        local ScreenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        mousemoverel((HeadPos.X - ScreenCenter.X), (HeadPos.Y - ScreenCenter.Y))
    end
end

-- Обновление FOV-кружка
local function UpdateCircle()
    Circle.Radius = FOV
    Circle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2) -- Центр экрана
    Circle.Visible = AimbotEnabled
end

-- Тоггл аимбота
CreateToggle(MainTab, "aimbot", function(state)
    AimbotEnabled = state
    Circle.Visible = state
end)

-- Слайдер для FOV
CreateSlider(PlayerTab, "fov", 50, 150, function(value)
    FOV = value
end)

-- Основной цикл аимбота
RunService.RenderStepped:Connect(function()
    UpdateCircle()
    if AimbotEnabled and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local Target = GetClosestPlayer()
        if Target then
            AimAt(Target)
        end
    end
end)

-- Добавляем элементы в SettingsTab

CreateButton(SettingsTab, "Save Config", function()
    local config = {
        WalkSpeed = 16,
        JumpEnabled = false,
        Theme = "Dark",
        Color = {R = 255, G = 255, B = 255}
    }
    DataStoreService:GetDataStore("ROBANIKCheatConfig"):SetAsync(LocalPlayer.UserId, config)
    print("Config saved!")
end)

CreateButton(SettingsTab, "Load Config", function()
    local config = DataStoreService:GetDataStore("ROBANIKCheatConfig"):GetAsync(LocalPlayer.UserId)
    if config then
        print("Config loaded:", config)
    end
end)

-- Устанавливаем MainTab как активную по умолчанию
Tabs[1].Content.Visible = true
CurrentTab = Tabs[1].Content
TweenService:Create(Tabs[1].Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 70)}):Play()
