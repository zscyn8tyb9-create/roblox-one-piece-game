local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local combatConfig = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("CombatConfig"))
local adminFolder = ReplicatedStorage:WaitForChild("Admin")
local runCommandEvent = adminFolder:WaitForChild("RunCommand")

local function isOwner(player)
    local allowed = {
        [game.CreatorId] = true,
    }
    return allowed[player.UserId] == true
end

local function findPlayerByName(name)
    for _, player in ipairs(Players:GetPlayers()) do
        if string.lower(player.Name):find(string.lower(name), 1, true) then
            return player
        end
    end
    return nil
end

local function teleportPlayer(player, args)
    local target = player
    if #args >= 2 then
        local x = tonumber(args[1]) or 0
        local y = tonumber(args[2]) or 0
        local z = tonumber(args[3]) or 0

        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
        end
        return
    end
end

local function setBounty(player, value)
    local leaderstats = player:FindFirstChild("leaderstats")
    local bounty = leaderstats and leaderstats:FindFirstChild("Bounty")
    if bounty then
        bounty.Value = value
    end
end

local function spawnEnemyNear(player)
    local character = player.Character
    if not character then
        return
    end

    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then
        return
    end

    local enemyFolder = Workspace:FindFirstChild("Enemies") or Instance.new("Folder")
    enemyFolder.Name = "Enemies"
    enemyFolder.Parent = Workspace

    local enemy = Instance.new("Model")
    enemy.Name = "Enemy"
    enemy.Parent = enemyFolder
    enemy:SetAttribute("EnemyTag", true)

    local body = Instance.new("Part")
    body.Name = "HumanoidRootPart"
    body.Size = Vector3.new(2, 2, 1)
    body.Position = root.Position + Vector3.new(8, 5, 0)
    body.Anchored = false
    body.CanCollide = false
    body.Transparency = 1
    body.Parent = enemy

    local torso = Instance.new("Part")
    torso.Name = "Torso"
    torso.Size = Vector3.new(2, 2.5, 1)
    torso.Position = body.Position + Vector3.new(0, 2.5, 0)
    torso.Color = Color3.fromRGB(220, 80, 80)
    torso.Parent = enemy

    local head = Instance.new("Part")
    head.Name = "Head"
    head.Size = Vector3.new(2, 1.5, 1.5)
    head.Position = torso.Position + Vector3.new(0, 2.2, 0)
    head.Color = Color3.fromRGB(170, 40, 40)
    head.Parent = enemy

    local humanoid = Instance.new("Humanoid")
    humanoid.MaxHealth = 80
    humanoid.Health = 80
    humanoid.WalkSpeed = 8
    humanoid.Parent = enemy

    local rootWeld = Instance.new("WeldConstraint")
    rootWeld.Part0 = body
    rootWeld.Part1 = torso
    rootWeld.Parent = enemy

    local headWeld = Instance.new("WeldConstraint")
    headWeld.Part0 = torso
    headWeld.Part1 = head
    headWeld.Parent = enemy
end

runCommandEvent.OnServerEvent:Connect(function(player, commandText)
    if not isOwner(player) then
        return
    end

    if not commandText or type(commandText) ~= "string" then
        return
    end

    local command = string.lower(commandText)
    local args = string.split(command, " ")
    local action = args[1]

    if action == "/heal" then
        local char = player.Character
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Health = humanoid.MaxHealth
        end
    elseif action == "/god" then
        local char = player.Character
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:SetAttribute("GodMode", true)
            task.delay(15, function()
                humanoid:SetAttribute("GodMode", false)
            end)
        end
    elseif action == "/reset" then
        local char = player.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = CFrame.new(0, 5, 20)
            end
            if humanoid then
                humanoid.Health = humanoid.MaxHealth
            end
        end
    elseif action == "/spawnenemy" then
        spawnEnemyNear(player)
    elseif action == "/tp" then
        local numbers = {}
        for _, value in ipairs(args) do
            if value ~= "/tp" then
                table.insert(numbers, value)
            end
        end

        if #numbers >= 3 then
            local x = tonumber(numbers[1]) or 0
            local y = tonumber(numbers[2]) or 0
            local z = tonumber(numbers[3]) or 0
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = CFrame.new(x, y, z)
            end
        end
    elseif action == "/bounty" then
        local amount = tonumber(args[2]) or 0
        setBounty(player, amount)
    end
end)
