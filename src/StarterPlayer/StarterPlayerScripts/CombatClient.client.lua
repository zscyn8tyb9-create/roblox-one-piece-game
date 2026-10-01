local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local combatFolder = ReplicatedStorage:WaitForChild("Combat")
local attackEvent = combatFolder:WaitForChild("Attack")

local currentCooldown = 0
local attackKeyDown = false

local function createCombatUI()
    local gui = Instance.new("ScreenGui")
    gui.Name = "CombatUI"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 220, 0, 70)
    mainFrame.Position = UDim2.new(0, 20, 1, -100)
    mainFrame.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
    mainFrame.BackgroundTransparency = 0.25
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = gui

    local healthLabel = Instance.new("TextLabel")
    healthLabel.Name = "HealthLabel"
    healthLabel.Size = UDim2.new(1, -20, 0, 20)
    healthLabel.Position = UDim2.new(0, 10, 0, 8)
    healthLabel.BackgroundTransparency = 1
    healthLabel.Font = Enum.Font.GothamBold
    healthLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    healthLabel.Text = "HP: 100 / 100"
    healthLabel.TextSize = 14
    healthLabel.Parent = mainFrame

    local healthBarBackground = Instance.new("Frame")
    healthBarBackground.Size = UDim2.new(1, -20, 0, 12)
    healthBarBackground.Position = UDim2.new(0, 10, 0, 30)
    healthBarBackground.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    healthBarBackground.BorderSizePixel = 0
    healthBarBackground.Parent = mainFrame

    local healthBarFill = Instance.new("Frame")
    healthBarFill.Name = "HealthFill"
    healthBarFill.Size = UDim2.new(1, 0, 1, 0)
    healthBarFill.BackgroundColor3 = Color3.fromRGB(75, 220, 95)
    healthBarFill.BorderSizePixel = 0
    healthBarFill.Parent = healthBarBackground

    local attackText = Instance.new("TextLabel")
    attackText.Name = "AttackText"
    attackText.Size = UDim2.new(1, -20, 0, 18)
    attackText.Position = UDim2.new(0, 10, 0, 46)
    attackText.BackgroundTransparency = 1
    attackText.Font = Enum.Font.Gotham
    attackText.TextColor3 = Color3.fromRGB(200, 200, 200)
    attackText.Text = "Click or press F to attack"
    attackText.TextSize = 12
    attackText.Parent = mainFrame

    local function updateHealth()
        local character = player.Character
        if not character then
            return
        end

        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then
            return
        end

        local ratio = humanoid.Health / humanoid.MaxHealth
        healthBarFill.Size = UDim2.new(ratio, 0, 1, 0)
        healthLabel.Text = string.format("HP: %d / %d", humanoid.Health, humanoid.MaxHealth)
    end

    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.HealthChanged:Connect(updateHealth)
        updateHealth()
    end)

    if player.Character then
        local humanoid = player.Character:WaitForChild("Humanoid")
        humanoid.HealthChanged:Connect(updateHealth)
        updateHealth()
    end

    return gui
end

local function performAttack()
    if currentCooldown > 0 then
        return
    end

    local character = player.Character
    if not character then
        return
    end

    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then
        return
    end

    local data = {
        LookVector = root.CFrame.LookVector,
    }

    attackEvent:FireServer(data)
    currentCooldown = 0.6
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then
        return
    end

    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.KeyCode == Enum.KeyCode.F then
        performAttack()
    end
end)

createCombatUI()

while true do
    if currentCooldown > 0 then
        currentCooldown -= 0.05
    end
    task.wait(0.05)
end
