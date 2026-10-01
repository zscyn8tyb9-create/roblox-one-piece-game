local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local CombatConfig = require(script.Parent:WaitForChild("CombatConfig"))

local WorldBuilder = {}

function WorldBuilder.createEnemy(position)
    local enemy = Instance.new("Model")
    enemy.Name = "Enemy"
    enemy:SetAttribute("EnemyTag", true)

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
    torso.Color = Color3.fromRGB(220, 80, 80)
    torso.Material = Enum.Material.SmoothPlastic
    torso.Parent = enemy

    local head = Instance.new("Part")
    head.Name = "Head"
    head.Size = Vector3.new(2, 1.5, 1.5)
    head.Position = position + Vector3.new(0, 4.5, 0)
    head.Color = Color3.fromRGB(195, 40, 40)
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

function WorldBuilder.createBoss(position, name)
    local boss = Instance.new("Model")
    boss.Name = name or "Boss"
    boss:SetAttribute("Boss", true)
    boss:SetAttribute("BossName", boss.Name)

    local root = Instance.new("Part")
    root.Name = "HumanoidRootPart"
    root.Size = Vector3.new(2.5, 2.5, 1.4)
    root.Position = position
    root.Anchored = false
    root.CanCollide = false
    root.Transparency = 1
    root.Parent = boss

    local torso = Instance.new("Part")
    torso.Name = "Torso"
    torso.Size = Vector3.new(3, 3.5, 1.5)
    torso.Position = position + Vector3.new(0, 3.2, 0)
    torso.Color = Color3.fromRGB(90, 90, 140)
    torso.Material = Enum.Material.SmoothPlastic
    torso.Parent = boss

    local aura = Instance.new("Part")
    aura.Name = "Aura"
    aura.Size = Vector3.new(6, 6, 6)
    aura.Position = position + Vector3.new(0, 3.2, 0)
    aura.Material = Enum.Material.Neon
    aura.Color = Color3.fromRGB(255, 180, 65)
    aura.Transparency = 0.45
    aura.CanCollide = false
    aura.Parent = boss

    local head = Instance.new("Part")
    head.Name = "Head"
    head.Size = Vector3.new(2.5, 2, 2)
    head.Position = position + Vector3.new(0, 6, 0)
    head.Color = Color3.fromRGB(70, 70, 110)
    head.Parent = boss

    local humanoid = Instance.new("Humanoid")
    humanoid.MaxHealth = CombatConfig.Boss.MaxHealth
    humanoid.Health = CombatConfig.Boss.MaxHealth
    humanoid.WalkSpeed = CombatConfig.Boss.ChaseSpeed
    humanoid.Parent = boss

    local rootWeld = Instance.new("WeldConstraint")
    rootWeld.Part0 = root
    rootWeld.Part1 = torso
    rootWeld.Parent = boss

    local auraWeld = Instance.new("WeldConstraint")
    auraWeld.Part0 = torso
    auraWeld.Part1 = aura
    auraWeld.Parent = boss

    local headWeld = Instance.new("WeldConstraint")
    headWeld.Part0 = torso
    headWeld.Part1 = head
    headWeld.Parent = boss

    boss:SetAttribute("LastAttackTime", 0)
    boss:SetAttribute("BossReward", CombatConfig.Boss.Reward)
    return boss
end

function WorldBuilder.spawnDevilFruit(name, position)
    local fruit = Instance.new("Part")
    fruit.Name = name .. "Fruit"
    fruit.Shape = Enum.PartType.Cylinder
    fruit.Size = Vector3.new(1.7, 2.5, 1.7)
    fruit.Material = Enum.Material.Neon
    fruit.Color = CombatConfig.DevilFruit.Colors[name] or Color3.fromRGB(255, 255, 255)
    fruit.Position = position
    fruit.CanCollide = false
    fruit.Anchored = true
    fruit:SetAttribute("DevilFruit", name)
    fruit:SetAttribute("FruitValue", CombatConfig.DevilFruit.Boost[name] or 1.5)
    return fruit
end

return WorldBuilder
