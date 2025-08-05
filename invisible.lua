local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local transparencyValue = 0.8 -- Уровень прозрачности (0 = видимый, 1 = полностью невидимый)

-- Создаем интерфейс
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "InvisibilityGUI"
screenGui.Parent = game.CoreGui -- Помещаем в CoreGui, чтобы античит не удалил

local frame = Instance.new("Frame")
frame.Name = "ControlFrame"
frame.Parent = screenGui
frame.Size = UDim2.new(0.15, 0, 0.06, 0) -- Ширина 15%, высота 6% экрана
frame.Position = UDim2.new(0.83, 0, 0.47, 0) -- Правая сторона (83% по X), центр по Y (47%)
frame.AnchorPoint = Vector2.new(0.5, 0.5) -- Центрируем относительно Position
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Темный фон
frame.BackgroundTransparency = 0.3 -- Полупрозрачность
frame.BorderSizePixel = 0 -- Убираем границу

local button = Instance.new("TextButton")
button.Name = "ToggleButton"
button.Parent = frame
button.Size = UDim2.new(0.9, 0, 0.8, 0) -- Занимает 90% ширины и 80% высоты Frame
button.Position = UDim2.new(0.05, 0, 0.1, 0) -- Смещение от краев Frame
button.Text = "Невидимость: ВКЛ"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
button.BorderSizePixel = 0
button.TextSize = 14

local isInvisible = true

-- Функция применения прозрачности
local function setTransparency(value)
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.LocalTransparencyModifier = value
        end
    end
end

-- Включаем невидимость сразу при запуске
setTransparency(transparencyValue)

-- Обработчик нажатия кнопки
button.MouseButton1Click:Connect(function()
    isInvisible = not isInvisible
    if isInvisible then
        button.Text = "Невидимость: ВКЛ"
        setTransparency(transparencyValue)
    else
        button.Text = "Невидимость: ВЫКЛ"
        setTransparency(0) -- Возвращаем видимость
    end
end)

-- Обновляем при респавне
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    setTransparency(isInvisible and transparencyValue or 0)
end)
