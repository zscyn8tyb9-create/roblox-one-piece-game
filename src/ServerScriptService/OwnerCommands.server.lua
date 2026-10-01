local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

print("[OwnerCommands] Starting owner command handler...")

local CombatConfig = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("CombatConfig"))
local WorldBuilder = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("WorldBuilder"))

local adminFolder = ReplicatedStorage:FindFirstChild("Admin") or Instance.new("Folder")
adminFolder.Name = "Admin"
adminFolder.Parent = ReplicatedStorage

local commandEvent = adminFolder:FindFirstChild("RunCommand") or Instance.new("RemoteEvent")
commandEvent.Name = "RunCommand"
commandEvent.Parent = adminFolder

local function isOwner(player)
    return player.UserId == game.CreatorId
end

local function applyFruit(player, fruitName)
    if not fruitName then
        return
    end

    local cleanName = string.lower(fruitName)
    player:SetAttribute("DevilFruit", cleanName)
    local multiplier = CombatConfig.DevilFruit.Boost[cleanName] or 1.5
    player:SetAttribute("PowerLevel", 10 * multiplier)

    local char = player.Character
    local humanoid = char and char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.MaxHealth = CombatConfig.Player.MaxHealth * multiplier
        humanoid.Health = humanoid.MaxHealth
        humanoid.WalkSpeed = CombatConfig.Player.WalkSpeed * multiplier
        humanoid.JumpPower = CombatConfig.Player.JumpPower * multiplier
    end
    print("[OwnerCommands] " .. player.Name .. " equipped " .. cleanName .. " fruit!")
end

local function summonBossNear(player, bossName)
    local char = player.Character
    if not char then
        return
    end

    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then
        return
    end

    local bosses = Workspace:FindFirstChild("Bosses") or Instance.new("Folder")
    bosses.Name = "Bosses"
    bosses.Parent = Workspace

    local finalBossName = bossName or "Astral Tyrant"
    local boss = WorldBuilder.createBoss(root.Position + Vector3.new(12, 2, 0), finalBossName)
    boss.Parent = bosses
    print("[OwnerCommands] Boss spawned: " .. finalBossName)
end

local function killAllEnemies()
    print("[OwnerCommands] Killing all enemies...")
    local enemies = Workspace:FindFirstChild("Enemies")
    if enemies then
        for _, enemy in ipairs(enemies:GetChildren()) do
            if enemy:IsA("Model") then
                local humanoid = enemy:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.Health = 0
                end
            end
        end
    end

    local bosses = Workspace:FindFirstChild("Bosses")
    if bosses then
        for _, boss in ipairs(bosses:GetChildren()) do
            if boss:IsA("Model") then
                local humanoid = boss:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.Health = 0
                end
            end
        end
    end
end

local function spawnWaveEnemies(player, count)
    print("[OwnerCommands] Spawning " .. count .. " enemies...")
    local enemies = Workspace:FindFirstChild("Enemies") or Instance.new("Folder")
    enemies.Name = "Enemies"
    enemies.Parent = Workspace

    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local basePos = root and root.Position or Vector3.new(0, 5, 0)

    for i = 1, count do
        local angle = (i / count) * math.pi * 2
        local distance = 20
        local x = basePos.x + math.cos(angle) * distance
        local z = basePos.z + math.sin(angle) * distance
        local enemy = WorldBuilder.createEnemy(Vector3.new(x, 5, z))
        enemy.Parent = enemies
    end
end

local function healAllPlayers()
    print("[OwnerCommands] Healing all players...")
    for _, player in ipairs(Players:GetPlayers()) do
        local char = player.Character
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Health = humanoid.MaxHealth
        end
    end
end

local function giveAllPlayers(bountyAmount)
    print("[OwnerCommands] Giving all players " .. bountyAmount .. " bounty...")
    for _, player in ipairs(Players:GetPlayers()) do
        local leaderstats = player:FindFirstChild("leaderstats")
        local bounty = leaderstats and leaderstats:FindFirstChild("Bounty")
        if bounty then
            bounty.Value = bounty.Value + bountyAmount
        end
    end
end

local function instaKill(player)
    print("[OwnerCommands] Enabling instakill for " .. player.Name)
    player:SetAttribute("InstaKill", true)
    print("[OwnerCommands] Next attack will be instakill")
end

local function parseCommand(commandText)
    if type(commandText) ~= "string" then
        return nil, {}
    end

    local trimmed = string.gsub(commandText, "^%s+", "")
    trimmed = string.gsub(trimmed, "%s+$", "")
    local args = string.split(trimmed, " ")
    local action = string.lower(args[1] or "")
    table.remove(args, 1)
    return action, args
end

commandEvent.OnServerEvent:Connect(function(player, commandText)
    if not isOwner(player) then
        print("[OwnerCommands] " .. player.Name .. " attempted unauthorized command")
        return
    end

    local action, args = parseCommand(commandText)
    if not action then
        return
    end

    print("[OwnerCommands] Command from " .. player.Name .. ": " .. action)

    if action == "/heal" then
        local char = player.Character
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Health = humanoid.MaxHealth
            print("[OwnerCommands] " .. player.Name .. " healed.")
        end

    elseif action == "/god" then
        local duration = tonumber(args[1]) or 30
        player:SetAttribute("GodMode", true)
        print("[OwnerCommands] God mode enabled for " .. player.Name .. " for " .. duration .. " seconds")
        task.delay(duration, function()
            player:SetAttribute("GodMode", false)
            print("[OwnerCommands] God mode disabled for " .. player.Name)
        end)

    elseif action == "/max" then
        local char = player.Character
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.MaxHealth = 9999
            humanoid.Health = 9999
            humanoid.WalkSpeed = 200
            humanoid.JumpPower = 200
            print("[OwnerCommands] " .. player.Name .. " maxed out.")
        end

    elseif action == "/reset" then
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(0, 8, 24)
            print("[OwnerCommands] " .. player.Name .. " reset to spawn.")
        end

    elseif action == "/tp" then
        local x = tonumber(args[1]) or 0
        local y = tonumber(args[2]) or 0
        local z = tonumber(args[3]) or 0
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(x, y, z)
            print("[OwnerCommands] " .. player.Name .. " teleported to " .. x .. ", " .. y .. ", " .. z)
        end

    elseif action == "/bounty" then
        local amount = tonumber(args[1]) or 0
        local leaderstats = player:FindFirstChild("leaderstats")
        local bounty = leaderstats and leaderstats:FindFirstChild("Bounty")
        if bounty then
            bounty.Value = amount
            print("[OwnerCommands] " .. player.Name .. " bounty set to " .. amount)
        end

    elseif action == "/level" then
        local levelValue = tonumber(args[1]) or 1
        local leaderstats = player:FindFirstChild("leaderstats")
        local level = leaderstats and leaderstats:FindFirstChild("Level")
        if level then
            level.Value = levelValue
        end
        player:SetAttribute("PowerLevel", levelValue)
        print("[OwnerCommands] " .. player.Name .. " level set to " .. levelValue)

    elseif action == "/spawnboss" then
        local bossName = args[1] or "Astral Tyrant"
        summonBossNear(player, bossName)

    elseif action == "/killall" then
        killAllEnemies()

    elseif action == "/spawnfruit" then
        local fruitName = args[1] or "fire"
        local fruitsFolder = Workspace:FindFirstChild("DevilFruits") or Instance.new("Folder")
        fruitsFolder.Name = "DevilFruits"
        fruitsFolder.Parent = Workspace

        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root then
            local fruit = WorldBuilder.spawnDevilFruit(fruitName, root.Position + Vector3.new(8, 4, 0))
            fruit.Parent = fruitsFolder
            print("[OwnerCommands] Spawned " .. fruitName .. " fruit for " .. player.Name)
        end

    elseif action == "/setfruit" then
        local fruitName = args[1] or "fire"
        applyFruit(player, fruitName)

    elseif action == "/speed" then
        local speed = tonumber(args[1]) or 200
        local char = player.Character
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = speed
            print("[OwnerCommands] " .. player.Name .. " speed set to " .. speed)
        end

    elseif action == "/superjump" then
        local char = player.Character
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.JumpPower = 500
            print("[OwnerCommands] " .. player.Name .. " super jump enabled.")
            task.delay(12, function()
                if humanoid and humanoid.Parent then
                    humanoid.JumpPower = CombatConfig.Player.JumpPower
                end
            end)
        end

    elseif action == "/fly" then
        player:SetAttribute("FlyMode", true)
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            local fly = Instance.new("BodyVelocity")
            fly.MaxForce = Vector3.new(0, 50000, 0)
            fly.Velocity = Vector3.new(0, 50, 0)
            fly.Parent = hrp
            print("[OwnerCommands] " .. player.Name .. " flying enabled.")
            task.delay(12, function()
                player:SetAttribute("FlyMode", false)
                if fly and fly.Parent then
                    fly:Destroy()
                end
            end)
        end

    elseif action == "/infinitestamina" then
        player:SetAttribute("InfiniteStamina", true)
        print("[OwnerCommands] Infinite stamina enabled for " .. player.Name)

    elseif action == "/damageup" then
        local multiplier = tonumber(args[1]) or 10
        player:SetAttribute("DamageMultiplier", multiplier)
        print("[OwnerCommands] " .. player.Name .. " damage multiplied by " .. multiplier)

    elseif action == "/scale" then
        local scale = tonumber(args[1]) or 2
        local char = player.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Size = part.Size * scale
                end
            end
            print("[OwnerCommands] " .. player.Name .. " scaled by " .. scale)
        end

    elseif action == "/invisible" then
        local char = player.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0.7
                end
            end
            print("[OwnerCommands] " .. player.Name .. " invisible.")
        end

    elseif action == "/visible" then
        local char = player.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0
                end
            end
            print("[OwnerCommands] " .. player.Name .. " visible.")
        end

    elseif action == "/glow" then
        local char = player.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Material = Enum.Material.Neon
                end
            end
            print("[OwnerCommands] " .. player.Name .. " glowing.")
        end

    elseif action == "/wave" then
        local count = tonumber(args[1]) or 10
        spawnWaveEnemies(player, count)

    elseif action == "/healall" then
        healAllPlayers()

    elseif action == "/giveall" then
        local amount = tonumber(args[1]) or 500
        giveAllPlayers(amount)

    elseif action == "/instakill" then
        instaKill(player)

    elseif action == "/attackspeed" then
        local speed = tonumber(args[1]) or 0.1
        player:SetAttribute("AttackSpeedMultiplier", 1 / (speed or 0.1))
        print("[OwnerCommands] " .. player.Name .. " attack speed set to " .. speed)

    elseif action == "/pushback" then
        local power = tonumber(args[1]) or 100
        player:SetAttribute("PushbackPower", power)
        print("[OwnerCommands] " .. player.Name .. " pushback set to " .. power)

    elseif action == "/lifesteal" then
        player:SetAttribute("LifeSteal", true)
        print("[OwnerCommands] Life steal enabled for " .. player.Name)

    elseif action == "/pierce" then
        player:SetAttribute("PierceArmor", true)
        print("[OwnerCommands] Pierce armor enabled for " .. player.Name)

    elseif action == "/slow" then
        local duration = tonumber(args[1]) or 10
        local char = player.Character
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            local oldSpeed = humanoid.WalkSpeed
            humanoid.WalkSpeed = 5
            task.delay(duration, function()
                if humanoid and humanoid.Parent then
                    humanoid.WalkSpeed = oldSpeed
                end
            end)
            print("[OwnerCommands] " .. player.Name .. " slowed for " .. duration .. " seconds")
        end

    elseif action == "/freeze" then
        local duration = tonumber(args[1]) or 5
        player:SetAttribute("Frozen", true)
        task.delay(duration, function()
            player:SetAttribute("Frozen", false)
        end)
        print("[OwnerCommands] " .. player.Name .. " frozen for " .. duration .. " seconds")

    elseif action == "/noclip" then
        local char = player.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
            print("[OwnerCommands] " .. player.Name .. " noclip enabled.")
        end

    elseif action == "/collision" then
        local char = player.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
            print("[OwnerCommands] " .. player.Name .. " collision enabled.")
        end

    elseif action == "/rainbow" then
        local char = player.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Color = Color3.fromHSV(math.random() / 1, 0.5, 0.9)
                end
            end
            print("[OwnerCommands] " .. player.Name .. " rainbow mode.")
        end

    end
end)

print("[OwnerCommands] ✅ Owner command handler loaded with 40 commands.")
