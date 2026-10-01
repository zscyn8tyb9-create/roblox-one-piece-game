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

local function setPower(player, value)
    local char = player.Character
    local humanoid = char and char:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        return
    end

    humanoid.MaxHealth = value
    humanoid.Health = value
    humanoid.WalkSpeed = value / 2
    humanoid.JumpPower = value / 1.4
end

local function summonBossNear(player)
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

    local bossName = "Astral Tyrant"
    local boss = WorldBuilder.createBoss(root.Position + Vector3.new(12, 2, 0), bossName)
    boss.Parent = bosses
    print("[OwnerCommands] Boss spawned: " .. bossName)
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

local function setLevel(player, levelValue)
    local leaderstats = player:FindFirstChild("leaderstats")
    local level = leaderstats and leaderstats:FindFirstChild("Level")
    if level then
        level.Value = levelValue
    end

    player:SetAttribute("PowerLevel", levelValue)
    print("[OwnerCommands] " .. player.Name .. " level set to " .. levelValue)
end

local function spawnFruitNearPlayer(player, fruitName)
    local char = player.Character
    if not char then
        return
    end

    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then
        return
    end

    local fruitsFolder = Workspace:FindFirstChild("DevilFruits") or Instance.new("Folder")
    fruitsFolder.Name = "DevilFruits"
    fruitsFolder.Parent = Workspace

    local fruit = WorldBuilder.spawnDevilFruit(fruitName, root.Position + Vector3.new(8, 4, 0))
    fruit.Parent = fruitsFolder

    fruit.Touched:Connect(function(hit)
        local target = Players:GetPlayerFromCharacter(hit.Parent)
        if target and target == player then
            applyFruit(player, fruitName)
            fruit:Destroy()
        end
    end)
    print("[OwnerCommands] Spawned " .. fruitName .. " fruit for " .. player.Name)
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
        setLevel(player, levelValue)

    elseif action == "/spawnboss" then
        summonBossNear(player)

    elseif action == "/killall" then
        killAllEnemies()

    elseif action == "/spawnfruit" then
        local fruitName = args[1] or "fire"
        spawnFruitNearPlayer(player, fruitName)

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
                humanoid.JumpPower = CombatConfig.Player.JumpPower
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
    end
end)

print("[OwnerCommands] ✅ Owner command handler loaded.")
