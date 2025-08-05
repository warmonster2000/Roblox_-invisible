-- Delta Invisibility Script (FE Bypass)
loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() -- Для защиты от детекта (опционально)

if not game:IsLoaded() then game.Loaded:Wait() end
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

local TransparentValue = 0 -- Уровень прозрачности (0.9 = почти невидимый)

-- Основная функция прозрачности
local function ApplyInvisibility()
    for _, part in ipairs(Character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.LocalTransparencyModifier = TransparentValue
            if not part:FindFirstChild("OriginalTransparency") then
                local Value = Instance.new("NumberValue")
                Value.Name = "OriginalTransparency"
                Value.Value = part.Transparency
                Value.Parent = part
            end
        end
    end
end

-- Авто-обновление при респавне
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    repeat task.wait() until Character:FindFirstChild("Humanoid")
    ApplyInvisibility()
end)

-- Применяем сразу
ApplyInvisibility()

-- GUI для управления (скрытое от античитов)
local GUI = Instance.new("ScreenGui")
GUI.Name = "DeltaHUD"
GUI.Parent = game.CoreGui

local Toggle = Instance.new("TextButton")
Toggle.Name = "InvisToggle"
Toggle.Parent = GUI
Toggle.Size = UDim2.new(0.12, 0, 0.05, 0)
Toggle.Position = UDim2.new(0.83, 0, 0.92, 0)
Toggle.Text = "INVIS [ON]"
Toggle.TextColor3 = Color3.new(0, 1, 0)
Toggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local InvisEnabled = true
Toggle.MouseButton1Click:Connect(function()
    InvisEnabled = not InvisEnabled
    Toggle.Text = InvisEnabled and "INVIS [ON]" or "INVIS [OFF]"
    Toggle.TextColor3 = InvisEnabled and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
    
    for _, part in ipairs(Character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.LocalTransparencyModifier = InvisEnabled and TransparentValue or 0
        end
    end
end)

-- Анти-детект функции
spawn(function()
    while task.wait(5) do
        if not GUI.Parent then
            GUI.Parent = game.CoreGui
        end
    end
end)
