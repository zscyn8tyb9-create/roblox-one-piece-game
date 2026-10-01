local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")

local function createIsland()
    local island = Instance.new("Model")
    island.Name = "Island"
    island.Parent = workspace

    local base = Instance.new("Part")
    base.Name = "Base"
    base.Size = Vector3.new(200, 6, 200)
    base.Position = Vector3.new(0, -3, 0)
    base.Anchored = true
    base.Material = Enum.Material.Grass
    base.Color = Color3.fromRGB(90, 170, 90)
    base.Parent = island

    local sand = Instance.new("Part")
    sand.Name = "Sand"
    sand.Size = Vector3.new(180, 1, 180)
    sand.Position = Vector3.new(0, 0.5, 0)
    sand.Anchored = true
    sand.Material = Enum.Material.Sand
    sand.Color = Color3.fromRGB(214, 188, 104)
    sand.Parent = island

    local water = Instance.new("Part")
    water.Name = "Water"
    water.Size = Vector3.new(220, 3, 220)
    water.Position = Vector3.new(0, -8, 0)
    water.Anchored = true
    water.Material = Enum.Material.Water
    water.Color = Color3.fromRGB(77, 137, 220)
    water.Transparency = 0.2
    water.Parent = island

    for i = 1, 24 do
        local tree = Instance.new("Model")
        tree.Name = "Tree"
        tree.Parent = island

        local trunk = Instance.new("Part")
        trunk.Name = "Trunk"
        trunk.Size = Vector3.new(1, 7, 1)
        trunk.Position = Vector3.new((math.random() * 140) - 70, 3.5, (math.random() * 140) - 70)
        trunk.Anchored = true
        trunk.Material = Enum.Material.Wood
        trunk.Color = Color3.fromRGB(110, 74, 35)
        trunk.Parent = tree

        local leaves = Instance.new("Part")
        leaves.Name = "Leaves"
        leaves.Size = Vector3.new(6, 6, 6)
        leaves.Position = trunk.Position + Vector3.new(0, 4, 0)
        leaves.Anchored = true
        leaves.Material = Enum.Material.Grass
        leaves.Color = Color3.fromRGB(0, 180, 60)
        leaves.Parent = tree
    end

    local spawnPart = Instance.new("Part")
    spawnPart.Name = "SpawnLocation"
    spawnPart.Size = Vector3.new(12, 1, 12)
    spawnPart.Position = Vector3.new(0, 5, 20)
    spawnPart.Anchored = true
    spawnPart.Material = Enum.Material.SmoothPlastic
    spawnPart.Color = Color3.fromRGB(255, 255, 255)
    spawnPart.Parent = island

    local spawn = Instance.new("SpawnLocation")
    spawn.Name = "PlayerSpawn"
    spawn.Size = spawnPart.Size
    spawn.Position = spawnPart.Position + Vector3.new(0, 2, 0)
    spawn.Anchored = true
    spawn.Color = Color3.fromRGB(120, 190, 255)
    spawn.Neutral = true
    spawn.Parent = island

    local sky = Lighting:FindFirstChild("Sky")
    if not sky then
        sky = Instance.new("Sky")
        sky.Name = "Sky"
        sky.Parent = Lighting
    end

    Lighting.TimeOfDay = "14:00:00"
    Lighting.Brightness = 2
    Lighting.OutdoorAmbient = Color3.fromRGB(185, 200, 220)

    return island
end

createIsland()

local function setupPlayer(player)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local bounty = Instance.new("IntValue")
    bounty.Name = "Bounty"
    bounty.Value = 0
    bounty.Parent = leaderstats
end

for _, player in ipairs(Players:GetPlayers()) do
    setupPlayer(player)
end

Players.PlayerAdded:Connect(setupPlayer)
