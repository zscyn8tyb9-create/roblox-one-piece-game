local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

print("[CombatClient] Loading combat client...")

local combatConfig = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("CombatConfig"))
local ComboSystem = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("ComboSystem"))
local combatFolder = ReplicatedStorage:WaitForChild("Combat")
local attackEvent = combatFolder:WaitForChild("Attack")

local cooldown = 0
local dashCooldown = 0
local comboCount = 0
local comboResetTime = 0

local function createCombatUI()
    print("[CombatClient] Creating combat UI...")
    local gui = Instance.new("ScreenGui")
    gui.Name = "CombatUI"
    gui.ResetOnSpawn = false
    gui.Parent = playerGui

    local healthFrame = Instance.new("Frame")
    healthFrame.Size = UDim2.new(0, 300, 0, 100)
    healthFrame.Position = UDim2.new(0, 20, 1, -130)
    healthFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    healthFrame.BackgroundTransparency = 0.2
    healthFrame.BorderSizePixel = 0
    healthFrame.Parent = gui

    local healthLabel = Instance.new("TextLabel")
    healthLabel.Size = UDim2.new(1, -20, 0, 18)
    healthLabel.Position = UDim2.new(0, 10, 0, 8)
    healthLabel.Text = "HP: 0 / 0"
    healthLabel.Font = Enum.Font.GothamBold
    healthLabel.TextSize = 14
    healthLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    healthLabel.BackgroundTransparency = 1
    healthLabel.Parent = healthFrame

    local healthBarBG = Instance.new("Frame")
    healthBarBG.Size = UDim2.new(1, -20, 0, 12)
    healthBarBG.Position = UDim2.new(0, 10, 0, 30)
    healthBarBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    healthBarBG.BorderSizePixel = 0
    healthBarBG.Parent = healthFrame

    local healthFill = Instance.new("Frame")
    healthFill.Name = "HealthFill"
    healthFill.Size = UDim2.new(1, 0, 1, 0)
    healthFill.BackgroundColor3 = Color3.fromRGB(80, 220, 95)
    healthFill.BorderSizePixel = 0
    healthFill.Parent = healthBarBG

    local staminaBarBG = Instance.new("Frame")
    staminaBarBG.Size = UDim2.new(1, -20, 0, 10)
    staminaBarBG.Position = UDim2.new(0, 10, 0, 50)
    staminaBarBG.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    staminaBarBG.BorderSizePixel = 0
    staminaBarBG.Parent = healthFrame

    local staminaFill = Instance.new("Frame")
    staminaFill.Name = "StaminaFill"
    staminaFill.Size = UDim2.new(1, 0, 1, 0)
    staminaFill.BackgroundColor3 = Color3.fromRGB(90, 170, 255)
    staminaFill.BorderSizePixel = 0
    staminaFill.Parent = staminaBarBG

    local comboLabel = Instance.new("TextLabel")
    comboLabel.Name = "ComboLabel"
    comboLabel.Size = UDim2.new(1, -20, 0, 16)
    comboLabel.Position = UDim2.new(0, 10, 0, 65)
    comboLabel.Text = "Combo: 0x"
    comboLabel.Font = Enum.Font.GothamBold
    comboLabel.TextSize = 12
    comboLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
    comboLabel.BackgroundTransparency = 1
    comboLabel.Parent = healthFrame

    local bountyLabel = Instance.new("TextLabel")
    bountyLabel.Size = UDim2.new(1, -20, 0, 16)
    bountyLabel.Position = UDim2.new(0, 10, 0, 82)
    bountyLabel.Text = "Bounty: 0"
    bountyLabel.Font = Enum.Font.Gotham
    bountyLabel.TextSize = 11
    bountyLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    bountyLabel.BackgroundTransparency = 1
    bountyLabel.Parent = healthFrame

    local function updateStats()
        local char = player.Character
        if not char then
            return
        end

        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not humanoid then
            return
        end

        local healthRatio = humanoid.Health / humanoid.MaxHealth
        healthFill.Size = UDim2.new(math.max(0, math.min(1, healthRatio)), 0, 1, 0)
        healthLabel.Text = "HP: " .. math.floor(humanoid.Health) .. " / " .. math.floor(humanoid.MaxHealth)

        local stamina = player:GetAttribute("Stamina") or 100
        local staminaRatio = stamina / combatConfig.Player.StaminaMax
        staminaFill.Size = UDim2.new(math.max(0, math.min(1, staminaRatio)), 0, 1, 0)

        -- Combo counter
        local now = os.clock()
        if now > comboResetTime then
            comboCount = 0
        end
        comboLabel.Text = "Combo: " .. comboCount .. "x"

        local stats = player:FindFirstChild("leaderstats")
        local bounty = stats and stats:FindFirstChild("Bounty")
        if bounty then
            bountyLabel.Text = "Bounty: " .. bounty.Value
        end
    end

    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.HealthChanged:Connect(updateStats)
        updateStats()
    end)

    if player.Character then
        pcall(function()
            local humanoid = player.Character:WaitForChild("Humanoid")
            humanoid.HealthChanged:Connect(updateStats)
            updateStats()
        end)
    end

    print("[CombatClient] Combat UI created.")
    return gui
end

local function performAttack()
    if cooldown > 0 then
        return
    end

    local char = player.Character
    if not char then
        return
    end

    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then
        return
    end

    cooldown = combatConfig.Player.AttackCooldown
    comboCount = comboCount + 1
    comboResetTime = os.clock() + combatConfig.Combo.Window
    
    if comboCount > combatConfig.Combo.MaxHits then
        comboCount = 1
    end
    
    attackEvent:FireServer({
        LookVector = root.CFrame.LookVector,
        ComboHit = comboCount,
    })
end

local function dash()
    if dashCooldown > 0 then
        return
    end

    local char = player.Character
    if not char then
        return
    end

    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if humanoid and hrp then
        dashCooldown = 1.8
        local previousSpeed = humanoid.WalkSpeed
        humanoid.WalkSpeed = combatConfig.Player.DashSpeed
        task.delay(combatConfig.Player.DashTime, function()
            if humanoid and humanoid.Parent then
                humanoid.WalkSpeed = previousSpeed
            end
        end)
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then
        return
    end

    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.KeyCode == Enum.KeyCode.F then
        performAttack()
    elseif input.KeyCode == Enum.KeyCode.LeftShift then
        dash()
    elseif input.KeyCode == Enum.KeyCode.Q then
        performAttack()
    end
end)

createCombatUI()

while true do
    if cooldown > 0 then
        cooldown -= 0.05
    end

    if dashCooldown > 0 then
        dashCooldown -= 0.05
    end

    local playerCharacter = player.Character
    if playerCharacter then
        local humanoid = playerCharacter:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.Health > 0 then
            local stamina = player:GetAttribute("Stamina") or combatConfig.Player.StaminaMax
            if stamina < combatConfig.Player.StaminaMax then
                stamina = math.min(combatConfig.Player.StaminaMax, stamina + combatConfig.Player.StaminaRegen * 0.05)
                player:SetAttribute("Stamina", stamina)
            end
        end
    end

    task.wait(0.05)
end
