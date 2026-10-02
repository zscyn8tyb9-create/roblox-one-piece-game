local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

print("[CombatHandler] Starting combat handler...")

local CombatConfig = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("CombatConfig"))
local ComboSystem = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("ComboSystem"))

local combatFolder = ReplicatedStorage:FindFirstChild("Combat") or Instance.new("Folder")
combatFolder.Name = "Combat"
combatFolder.Parent = ReplicatedStorage

local attackEvent = combatFolder:FindFirstChild("Attack") or Instance.new("RemoteEvent")
attackEvent.Name = "Attack"
attackEvent.Parent = combatFolder

local function damageEnemy(enemyModel, player, damageAmount)
    local humanoid = enemyModel:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        return
    end

    humanoid:TakeDamage(damageAmount)

    if humanoid.Health <= 0 then
        local bounty = player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("Bounty")
        if bounty then
            local reward = CombatConfig.Enemy.Reward
            if enemyModel:GetAttribute("Boss") then
                reward = CombatConfig.Boss.Reward
            end
            bounty.Value += reward
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
    if now - lastAttack < CombatConfig.Player.AttackCooldown then
        return
    end
    player:SetAttribute("LastAttackTime", now)

    -- Combo system
    local comboCount = ComboSystem.addComboHit(player)
    local damageMultiplier = ComboSystem.getComboMultiplier(comboCount)
    local knockbackAmount = ComboSystem.getComboKnockback(comboCount)
    
    local finalDamage = CombatConfig.Player.AttackDamage * damageMultiplier
    
    -- Check for devil fruit multiplier
    local fruitBoost = player:GetAttribute("DevilFruit") and CombatConfig.DevilFruit.Boost[player:GetAttribute("DevilFruit")] or 1
    finalDamage = finalDamage * fruitBoost

    local origin = root.Position
    local lookVector = attackData and attackData.LookVector or root.CFrame.LookVector

    for _, model in ipairs(Workspace:GetDescendants()) do
        if model:IsA("Model") and model ~= character then
            local enemyHumanoid = model:FindFirstChildOfClass("Humanoid")
            if enemyHumanoid and (model:GetAttribute("EnemyTag") or model:GetAttribute("Boss")) then
                local enemyRoot = model:FindFirstChild("HumanoidRootPart")
                if enemyRoot then
                    local distance = (enemyRoot.Position - origin).Magnitude
                    local direction = (enemyRoot.Position - origin)
                    local angle = math.deg(math.acos(math.clamp(direction.Unit:Dot(lookVector.Unit), -1, 1)))

                    if distance <= CombatConfig.Player.AttackRange and angle <= 60 then
                        damageEnemy(model, player, finalDamage)
                        
                        -- Apply knockback on combo hit 3
                        if knockbackAmount > 0 and enemyRoot then
                            local knockDir = (enemyRoot.Position - root.Position).Unit
                            enemyRoot.Velocity = enemyRoot.Velocity + (knockDir * knockbackAmount)
                        end
                    end
                end
            end
        end
    end
end)

print("[CombatHandler] ✅ Combat handler loaded with combo system.")
