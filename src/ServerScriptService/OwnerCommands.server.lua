local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local CombatConfig = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("CombatConfig"))

local enemiesFolder = Workspace:FindFirstChild("Enemies") or Instance.new("Folder")
enemiesFolder.Name = "Enemies"
enemiesFolder.Parent = Workspace

local function createEnemy(position)
    local enemy = Instance.new("Model")
    enemy.Name = "Enemy"
    enemy:SetAttribute("EnemyTag", true)
    enemy.Parent = enemiesFolder

    local root = Instance.new("Part")
    root.Name = "HumanoidRootPart"
    root.Size = Vector3.new(2, 2, 1)
    root.Position = position
    root.Anchored = false
    root.CanCollide = false
    root.Transparency = 1
    root.Parent = enemy

    local torso = Instance.new("Part")
    torso.Name = "Torso"
    torso.Size = Vector3.new(2, 2.5, 1)
    torso.Position = position + Vector3.new(0, 2.5, 0)
    torso.Color = Color3.fromRGB(220, 70, 70)
    torso.Material = Enum.Material.SmoothPlastic
    torso.Parent = enemy

    local head = Instance.new("Part")
    head.Name = "Head"
    head.Size = Vector3.new(2, 1.5, 1.5)
    head.Position = position + Vector3.new(0, 4.5, 0)
    head.Color = Color3.fromRGB(180, 35, 35)
    head.Parent = enemy

    local humanoid = Instance.new("Humanoid")
    humanoid.MaxHealth = CombatConfig.Enemy.MaxHealth
    humanoid.Health = CombatConfig.Enemy.MaxHealth
    humanoid.WalkSpeed = CombatConfig.Enemy.ChaseSpeed
    humanoid.Parent = enemy

    local rootWeld = Instance.new("WeldConstraint")
    rootWeld.Part0 = root
    rootWeld.Part1 = torso
    rootWeld.Parent = enemy

    local headWeld = Instance.new("WeldConstraint")
    headWeld.Part0 = torso
    headWeld.Part1 = head
    headWeld.Parent = enemy

    enemy:SetAttribute("LastAttackTime", 0)
    return enemy
end

local function spawnEnemies()
    for i = 1, CombatConfig.Enemy.SpawnCount do
        local x = math.random(-70, 70)
        local z = math.random(-70, 70)
        local enemy = createEnemy(Vector3.new(x, 5, z))
        enemy:SetAttribute("HP", CombatConfig.Enemy.MaxHealth)
    end
end

spawnEnemies()

local function getNearestPlayer(enemy)
    local enemyRoot = enemy:FindFirstChild("HumanoidRootPart")
    local humanoid = enemy:FindFirstChildOfClass("Humanoid")
    if not enemyRoot or not humanoid then
        return nil
    end

    local nearest = nil
    local nearestDistance = math.huge

    for _, player in ipairs(Players:GetPlayers()) do
        local character = player.Character
        if character then
            local root = character:FindFirstChild("HumanoidRootPart")
            if root then
                local distance = (root.Position - enemyRoot.Position).Magnitude
                if distance < nearestDistance then
                    nearestDistance = distance
                    nearest = root
                end
            end
        end
    end

    return nearest
end

local function attackPlayer(enemy, playerRoot)
    local humanoid = enemy:FindFirstChildOfClass("Humanoid")
    local enemyRoot = enemy:FindFirstChild("HumanoidRootPart")
    if not humanoid or not enemyRoot or not playerRoot then
        return
    end

    local now = os.clock()
    local last = enemy:GetAttribute("LastAttackTime") or 0
    if now - last < CombatConfig.Enemy.AttackCooldown then
        return
    end

    enemy:SetAttribute("LastAttackTime", now)
    local playerCharacter = playerRoot.Parent
    local targetHumanoid = playerCharacter and playerCharacter:FindFirstChildOfClass("Humanoid")
    if targetHumanoid then
        if targetHumanoid:GetAttribute("GodMode") then
            return
        end

        targetHumanoid:TakeDamage(CombatConfig.Enemy.Damage)
    end
end

while true do
    for _, enemy in ipairs(enemiesFolder:GetChildren()) do
        if enemy:IsA("Model") then
            local enemyHumanoid = enemy:FindFirstChildOfClass("Humanoid")
            local root = enemy:FindFirstChild("HumanoidRootPart")
            if enemyHumanoid and root then
                local targetRoot = getNearestPlayer(enemy)
                if targetRoot then
                    local distance = (targetRoot.Position - root.Position).Magnitude
                    if distance > CombatConfig.Enemy.AttackRange then
                        enemyHumanoid:MoveTo(targetRoot.Position)
                    else
                        attackPlayer(enemy, targetRoot)
                    end
                end
            end
        end
    end

    task.wait(0.2)
end
