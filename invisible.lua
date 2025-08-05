-- Пример скрипта для Delta Roblox
local Delta = {}

function Delta:Init()
    print("Delta script initialized!")
    
    -- Ваш код здесь
    local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local enabled = false

local function toggle_invisibility()
    enabled = not enabled
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Transparency = enabled and 1 or 0
            part.CanCollide = not enabled
        end
    end
    print("Невидимость:", enabled and "ВКЛ" or "ВЫКЛ")
end

-- Создание кнопки в GUI (пример для эксплойта с поддержкой GUI)
local ScreenGui = Instance.new("ScreenGui")
local Button = Instance.new("TextButton")

Button.Text = "Невидимость (ВКЛ/ВЫКЛ)"
Button.Parent = ScreenGui
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Button.MouseButton1Click:Connect(toggle_invisibility)
