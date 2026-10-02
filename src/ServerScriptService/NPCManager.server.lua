local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

print("[NPCManager] Starting NPC manager...")

local NPCDialogue = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("NPCDialogue"))

local npcHub = Workspace:FindFirstChild("NPCHub") or Instance.new("Folder")
npcHub.Name = "NPCHub"
npcHub.Parent = Workspace

local function createNPC(name, position, color)
    local npc = Instance.new("Model")
    npc.Name = name
    npc.Parent = npcHub

    local root = Instance.new("Part")
    root.Name = "HumanoidRootPart"
    root.Size = Vector3.new(2, 2, 1)
    root.Position = position
    root.Anchored = false
    root.CanCollide = false
    root.Transparency = 1
    root.Parent = npc

    local torso = Instance.new("Part")
    torso.Name = "Torso"
    torso.Size = Vector3.new(2, 2.5, 1)
    torso.Position = position + Vector3.new(0, 2.5, 0)
    torso.Color = color
    torso.Material = Enum.Material.SmoothPlastic
    torso.Parent = npc

    local head = Instance.new("Part")
    head.Name = "Head"
    head.Size = Vector3.new(2, 1.5, 1.5)
    head.Position = position + Vector3.new(0, 4.5, 0)
    head.Color = color
    head.Parent = npc

    local humanoid = Instance.new("Humanoid")
    humanoid.MaxHealth = math.huge
    humanoid.Health = math.huge
    humanoid.Parent = npc

    local rootWeld = Instance.new("WeldConstraint")
    rootWeld.Part0 = root
    rootWeld.Part1 = torso
    rootWeld.Parent = npc

    local headWeld = Instance.new("WeldConstraint")
    headWeld.Part0 = torso
    headWeld.Part1 = head
    headWeld.Parent = npc

    -- NPC Label
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 100, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 2.5, 0)
    billboardGui.MaxDistance = 100
    billboardGui.Parent = root

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = name
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextColor3 = color
    nameLabel.TextScaled = true
    nameLabel.Parent = billboardGui

    npc:SetAttribute("NPC", true)
    npc:SetAttribute("NPCName", name)
    
    return npc
end

local function spawnNPCs()
    print("[NPCManager] Spawning NPCs...")
    
    -- Quest Giver
    createNPC("Quen", Vector3.new(0, 5, 0), Color3.fromRGB(0, 180, 255))
    
    -- Shopkeeper
    createNPC("Merchant", Vector3.new(80, 5, 20), Color3.fromRGB(255, 200, 100))
    
    -- Boss NPC
    createNPC("Captain", Vector3.new(-80, 5, -80), Color3.fromRGB(200, 50, 50))
    
    print("[NPCManager] NPCs spawned successfully")
end

spawnNPCs()

print("[NPCManager] ✅ NPC manager loaded.")
