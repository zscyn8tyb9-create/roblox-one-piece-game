local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

print("[GameBootstrap] Starting game initialization...")

local CombatConfig = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("CombatConfig"))
local WorldBuilder = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("WorldBuilder"))

print("[GameBootstrap] Modules loaded successfully.")

local enemiesFolder = Workspace:FindFirstChild("Enemies") or Instance.new("Folder")
enemiesFolder.Name = "Enemies"
enemiesFolder.Parent = Workspace

local bossFolder = Workspace:FindFirstChild("Bosses") or Instance.new("Folder")
bossFolder.Name = "Bosses"
bossFolder.Parent = Workspace

local fruitsFolder = Workspace:FindFirstChild("DevilFruits") or Instance.new("Folder")
fruitsFolder.Name = "DevilFruits"
fruitsFolder.Parent = Workspace

local function createIsland()
    print("[GameBootstrap] Creating island...")
    local island = Workspace:FindFirstChild("Island") or Instance.new("Model")
    island.Name = "Island"
    island.Parent = Workspace

    local base = island:FindFirstChild("Base") or Instance.new("Part")
    base.Name = "Base"
    base.Size = Vector3.new(260, 6, 260)
    base.Position = Vector3.new(0, -3, 0)
    base.Anchored = true
    base.Material = Enum.Material.Grass
    base.Color = Color3.fromRGB(80, 175, 85)
    base.Parent = island

    local sand = island:FindFirstChild("Sand") or Instance.new("Part")
    sand.Name = "Sand"
    sand.Size = Vector3.new(220, 1, 220)
    sand.Position = Vector3.new(0, 0.5, 0)
    sand.Anchored = true
    sand.Material = Enum.Material.Sand
    sand.Color = Color3.fromRGB(220, 188, 110)
    sand.Parent = island

    local water = island:FindFirstChild("Water") or Instance.new("Part")
    water.Name = "Water"
    water.Size = Vector3.new(300, 3, 300)
    water.Position = Vector3.new(0, -8, 0)
    water.Anchored = true
    water.Material = Enum.Material.Water
    water.Color = Color3.fromRGB(68, 128, 220)
    water.Transparency = 0.2
    water.Parent = island

    local spawnPad = island:FindFirstChild("SpawnPad") or Instance.new("Part")
    spawnPad.Name = "SpawnPad"
    spawnPad.Size = Vector3.new(14, 1, 14)
    spawnPad.Position = Vector3.new(0, 5, 24)
    spawnPad.Anchored = true
    spawnPad.Material = Enum.Material.SmoothPlastic
    spawnPad.Color = Color3.fromRGB(255, 255, 255)
    spawnPad.Parent = island

    local spawn = island:FindFirstChild("PlayerSpawn") or Instance.new("SpawnLocation")
    spawn.Name = "PlayerSpawn"
    spawn.Size = spawnPad.Size
    spawn.Position = spawnPad.Position + Vector3.new(0, 2, 0)
    spawn.Anchored = true
    spawn.Color = Color3.fromRGB(120, 190, 255)
    spawn.Neutral = true
    spawn.Parent = island

    Lighting.TimeOfDay = "14:00:00"
    Lighting.Brightness = 2.2
    Lighting.OutdoorAmbient = Color3.fromRGB(182, 198, 220)

    local sky = Lighting:FindFirstChild("Sky") or Instance.new("Sky")
    sky.Name = "Sky"
    sky.Parent = Lighting

    print("[GameBootstrap] Island created.")
    return island
end

local function setupRemotes()
    print("[GameBootstrap] Setting up remote events...")
    local combatFolder = ReplicatedStorage:FindFirstChild("Combat") or Instance.new("Folder")
    combatFolder.Name = "Combat"
    combatFolder.Parent = ReplicatedStorage

    local attackEvent = combatFolder:FindFirstChild("Attack") or Instance.new("RemoteEvent")
    attackEvent.Name = "Attack"
    attackEvent.Parent = combatFolder

    local adminFolder = ReplicatedStorage:FindFirstChild("Admin") or Instance.new("Folder")
    adminFolder.Name = "Admin"
    adminFolder.Parent = ReplicatedStorage

    local commandEvent = adminFolder:FindFirstChild("RunCommand") or Instance.new("RemoteEvent")
    commandEvent.Name = "RunCommand"
    commandEvent.Parent = adminFolder

    print("[GameBootstrap] Remote events setup complete.")
    return combatFolder, adminFolder
end

local function setupPlayer(player)
    print("[GameBootstrap] Setting up player: " .. player.Name)
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
    player:SetAttribute("DevilFruit", "none")
    player:SetAttribute("PowerLevel", 1)
    player:SetAttribute("FlyMode", false)
    player:SetAttribute("Stamina", CombatConfig.Player.StaminaMax)
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

local function spawnDevilFruits()
    print("[GameBootstrap] Spawning devil fruits...")
    local fruits = {
        {"fire", Vector3.new(-20, 6, -10)},
        {"storm", Vector3.new(25, 6, -30)},
        {"ice", Vector3.new(-30, 6, 30)},
        {"lightning", Vector3.new(35, 6, 18)},
        {"quake", Vector3.new(0, 6, -40)},
    }

    for _, fruitData in ipairs(fruits) do
        local fruitName, pos = fruitData[1], fruitData[2]
        local fruit = WorldBuilder.spawnDevilFruit(fruitName, pos)
        fruit.Parent = fruitsFolder
        fruit.Touched:Connect(function(hit)
            local player = Players:GetPlayerFromCharacter(hit.Parent)
            if not player then
                return
            end

            local name = fruit:GetAttribute("DevilFruit")
            if name then
                player:SetAttribute("DevilFruit", name)
                player:SetAttribute("PowerLevel", (player:GetAttribute("PowerLevel") or 1) + 5)
                print(player.Name .. " picked up " .. name .. " fruit!")
                fruit:Destroy()
            end
        end)
    end
end

local function spawnBosses()
    print("[GameBootstrap] Spawning bosses...")
    local bossSpawns = {
        {"Storm Titan", Vector3.new(-55, 8, -10)},
        {"Sea Wyrm", Vector3.new(55, 8, 10)},
    }

    for _, bossData in ipairs(bossSpawns) do
        local name, pos = bossData[1], bossData[2]
        local boss = WorldBuilder.createBoss(pos, name)
        boss.Parent = bossFolder
    end
end

local function spawnWaveEnemies()
    print("[GameBootstrap] Spawning enemies...")
    for i = 1, CombatConfig.Enemy.SpawnCount do
        local x = math.random(-80, 80)
        local z = math.random(-80, 80)
        local enemy = WorldBuilder.createEnemy(Vector3.new(x, 5, z))
        enemy.Parent = enemiesFolder
    end
end

local function createQuestBoard()
    print("[GameBootstrap] Creating quest board...")
    local board = Workspace:FindFirstChild("QuestBoard") or Instance.new("Part")
    board.Name = "QuestBoard"
    board.Size = Vector3.new(8, 6, 1)
    board.Position = Vector3.new(0, 8, 45)
    board.Anchored = true
    board.Material = Enum.Material.Wood
    board.Color = Color3.fromRGB(130, 90, 40)
    board.Parent = Workspace

    local sign = Instance.new("BillboardGui")
    sign.Name = "QuestSign"
    sign.Size = UDim2.new(0, 220, 0, 80)
    sign.StudsOffset = Vector3.new(0, 4, 0)
    sign.Parent = board

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 1, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.Text = "ISLAND QUESTS\nSlay 3 enemies or defeat a boss"
    title.TextScaled = true
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Parent = sign

    return board
end

print("[GameBootstrap] Initializing game world...")

createIsland()
setupRemotes()
spawnDevilFruits()
spawnBosses()
spawnWaveEnemies()
createQuestBoard()

for _, player in ipairs(Players:GetPlayers()) do
    setupPlayer(player)
    player.CharacterAdded:Connect(function(character)
        applyCharacterStats(character)
    end)

    if player.Character then
        applyCharacterStats(player.Character)
    end
end

Players.PlayerAdded:Connect(function(player)
    setupPlayer(player)
    player.CharacterAdded:Connect(function(character)
        applyCharacterStats(character)
    end)
end)

print("[GameBootstrap] ✅ Game initialized successfully!")
