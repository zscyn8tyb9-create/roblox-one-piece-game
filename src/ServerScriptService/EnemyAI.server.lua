local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

print("[EnemyAI] Starting enemy AI handler...")

local CombatConfig = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("CombatConfig"))
local WorldBuilder = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("WorldBuilder"))

local enemiesFolder = Workspace:FindFirstChild("Enemies") or Instance.new("Folder")
enemiesFolder.Name = "Enemies"
enemiesFolder.Parent = Workspace

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
            if enemyHumanoid and root and enemyHumanoid.Health > 0 then
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
