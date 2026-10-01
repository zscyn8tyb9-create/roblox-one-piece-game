local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local CombatConfig = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("CombatConfig"))

local function createIsland()
    local island = Workspace:FindFirstChild("Island") or Instance.new("Model")
    island.Name = "Island"
    island.Parent = Workspace

    local base = island:FindFirstChild("Base") or Instance.new("Part")
    base.Name = "Base"
    base.Size = Vector3.new(220, 6, 220)
    base.Position = Vector3.new(0, -3, 0)
    base.Anchored = true
    base.Material = Enum.Material.Grass
    base.Color = Color3.fromRGB(85, 170, 90)
    base.Parent = island

    local sand = island:FindFirstChild("Sand") or Instance.new("Part")
    sand.Name = "Sand"
    sand.Size = Vector3.new(190, 1, 190)
    sand.Position = Vector3.new(0, 0.5, 0)
    sand.Anchored = true
    sand.Material = Enum.Material.Sand
    sand.Color = Color3.fromRGB(220, 188, 110)
    sand.Parent = island

    local water = island:FindFirstChild("Water") or Instance.new("Part")
    water.Name = "Water"
    water.Size = Vector3.new(240, 3, 240)
    water.Position = Vector3.new(0, -8, 0)
    water.Anchored = true
    water.Material = Enum.Material.Water
    water.Color = Color3.fromRGB(70, 130, 220)
    water.Transparency = 0.2
    water.Parent = island

    local spawnPart = island:FindFirstChild("SpawnPad") or Instance.new("Part")
    spawnPart.Name = "SpawnPad"
    spawnPart.Size = Vector3.new(12, 1, 12)
    spawnPart.Position = Vector3.new(0, 5, 20)
    spawnPart.Anchored = true
    spawnPart.Material = Enum.Material.SmoothPlastic
    spawnPart.Color = Color3.fromRGB(255, 255, 255)
    spawnPart.Parent = island

    local spawn = island:FindFirstChild("PlayerSpawn") or Instance.new("SpawnLocation")
    spawn.Name = "PlayerSpawn"
    spawn.Size = spawnPart.Size
    spawn.Position = spawnPart.Position + Vector3.new(0, 2, 0)
    spawn.Anchored = true
    spawn.Color = Color3.fromRGB(120, 200, 255)
    spawn.Neutral = true
    spawn.Parent = island

    for i = 1, 32 do
        local tree = Instance.new("Model")
        tree.Name = "Tree" .. i
        tree.Parent = island

        local trunk = Instance.new("Part")
        trunk.Name = "Trunk"
        trunk.Size = Vector3.new(1.5, 8, 1.5)
        trunk.Position = Vector3.new(math.random(-90, 90), 4, math.random(-90, 90))
        trunk.Anchored = true
        trunk.Material = Enum.Material.Wood
        trunk.Color = Color3.fromRGB(115, 76, 38)
        trunk.Parent = tree

        local leaves = Instance.new("Part")
        leaves.Name = "Leaves"
        leaves.Size = Vector3.new(6, 6, 6)
        leaves.Position = trunk.Position + Vector3.new(0, 4.5, 0)
        leaves.Anchored = true
        leaves.Material = Enum.Material.Grass
        leaves.Color = Color3.fromRGB(40, 180, 65)
        leaves.Parent = tree
    end

    Lighting.TimeOfDay = "14:00:00"
    Lighting.Brightness = 2
    Lighting.OutdoorAmbient = Color3.fromRGB(180, 200, 220)

    local sky = Lighting:FindFirstChild("Sky") or Instance.new("Sky")
    sky.Name = "Sky"
    sky.Parent = Lighting

    return island
end

local function createRemoteFolders()
    local remotesFolder = ReplicatedStorage:FindFirstChild("Combat") or Instance.new("Folder")
    remotesFolder.Name = "Combat"
    remotesFolder.Parent = ReplicatedStorage

    local attackEvent = remotesFolder:FindFirstChild("Attack") or Instance.new("RemoteEvent")
    attackEvent.Name = "Attack"
    attackEvent.Parent = remotesFolder

    local adminFolder = ReplicatedStorage:FindFirstChild("Admin") or Instance.new("Folder")
    adminFolder.Name = "Admin"
    adminFolder.Parent = ReplicatedStorage

    local runCommand = adminFolder:FindFirstChild("RunCommand") or Instance.new("RemoteEvent")
    runCommand.Name = "RunCommand"
    runCommand.Parent = adminFolder

    return remotesFolder, attackEvent, adminFolder, runCommand
end

local function setupStats(player)
    local leaderstats = player:FindFirstChild("leaderstats") or Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local bounty = leaderstats:FindFirstChild("Bounty") or Instance.new("IntValue")
    bounty.Name = "Bounty"
    bounty.Value = 0
    bounty.Parent = leaderstats

    local level = leaderstats:FindFirstChild("Level") or Instance.new("IntValue")
    level.Name = "Level"
    level.Value = 1
    level.Parent = leaderstats

    player:SetAttribute("LastAttackTime", 0)
    player:SetAttribute("DashCooldown", 0)
    player:SetAttribute("GodMode", false)
end

local function applyCharacterStats(character)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        return
    end

    humanoid.MaxHealth = CombatConfig.Player.MaxHealth
    humanoid.Health = CombatConfig.Player.MaxHealth
    humanoid.WalkSpeed = CombatConfig.Player.WalkSpeed
    humanoid.JumpPower = CombatConfig.Player.JumpPower
end

createIsland()
createRemoteFolders()

for _, player in ipairs(Players:GetPlayers()) do
    setupStats(player)
    player.CharacterAdded:Connect(function(character)
        applyCharacterStats(character)
    end)

    if player.Character then
        applyCharacterStats(player.Character)
    end
end

Players.PlayerAdded:Connect(function(player)
    setupStats(player)
    player.CharacterAdded:Connect(function(character)
        applyCharacterStats(character)
    end)
end)
