local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CombatConfig = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("CombatConfig"))

local remotesFolder = ReplicatedStorage:FindFirstChild("Combat") or Instance.new("Folder")
remotesFolder.Name = "Combat"
remotesFolder.Parent = ReplicatedStorage

local attackEvent = remotesFolder:FindFirstChild("Attack") or Instance.new("RemoteEvent")
attackEvent.Name = "Attack"
attackEvent.Parent = remotesFolder

local function setupCharacter(player, character)
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.MaxHealth = CombatConfig.MaxHealth
    humanoid.Health = CombatConfig.MaxHealth

    local root = character:WaitForChild("HumanoidRootPart")
    root:SetNetworkOwner(player)

    local sword = Instance.new("Tool")
    sword.Name = "StarterSword"
    sword.RequiresHandle = false
    sword.Parent = player.Backpack

    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.5, 1.2, 0.5)
    handle.Material = Enum.Material.Metal
    handle.Color = Color3.fromRGB(102, 102, 102)
    handle.Parent = sword
end

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(function(character)
        setupCharacter(player, character)
    end)
end

for _, player in ipairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

Players.PlayerAdded:Connect(onPlayerAdded)

local function damageEnemy(enemyModel, player)
    local humanoid = enemyModel:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        return
    end

    humanoid:TakeDamage(CombatConfig.AttackDamage)

    if humanoid.Health <= 0 then
        local bounty = player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("Bounty")
        if bounty then
            bounty.Value += CombatConfig.BountyReward
        end

        enemyModel:Destroy()
    end
end

attackEvent.OnServerEvent:Connect(function(player, attackData)
    if not player.Character then
        return
    end

    local character = player.Character
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not root then
        return
    end

    local now = os.clock()
    local lastAttack = player:GetAttribute("LastAttackTime") or 0
    if now - lastAttack < CombatConfig.AttackCooldown then
        return
    end
    player:SetAttribute("LastAttackTime", now)

    local origin = root.Position
    local lookVector = attackData and attackData.LookVector or root.CFrame.LookVector

    for _, model in ipairs(workspace:GetDescendants()) do
        if model:IsA("Model") and model ~= character then
            local enemyHumanoid = model:FindFirstChildOfClass("Humanoid")
            if enemyHumanoid and model:GetAttribute("EnemyTag") then
                local enemyRoot = model:FindFirstChild("HumanoidRootPart")
                if enemyRoot then
                    local distance = (enemyRoot.Position - origin).Magnitude
                    local direction = (enemyRoot.Position - origin)
                    local angle = math.deg(math.acos(math.clamp(direction.Unit:Dot(lookVector.Unit), -1, 1)))

                    if distance <= CombatConfig.SlashRange and angle <= CombatConfig.SlashAngle then
                        damageEnemy(model, player)
                    end
                end
            end
        end
    end
end)
