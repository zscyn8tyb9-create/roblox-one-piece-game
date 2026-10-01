local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

print("[AdminClient] Loading...")

local adminFolder = ReplicatedStorage:WaitForChild("Admin")
local commandEvent = adminFolder:WaitForChild("RunCommand")

local function createAdminPanel()
    print("[AdminClient] Creating admin panel...")
    local gui = Instance.new("ScreenGui")
    gui.Name = "AdminPanel"
    gui.ResetOnSpawn = false
    gui.Parent = playerGui

    local panel = Instance.new("Frame")
    panel.Name = "CommandPanel"
    panel.Size = UDim2.new(0, 300, 0, 150)
    panel.Position = UDim2.new(0, 20, 0, 20)
    panel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    panel.BackgroundTransparency = 0.25
    panel.BorderSizePixel = 0
    panel.Parent = gui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -20, 0, 24)
    title.Position = UDim2.new(0, 10, 0, 10)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.Text = "Owner Commands"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 18
    title.Parent = panel

    local helpText = Instance.new("TextLabel")
    helpText.Size = UDim2.new(1, -20, 0, 32)
    helpText.Position = UDim2.new(0, 10, 0, 38)
    helpText.BackgroundTransparency = 1
    helpText.Font = Enum.Font.Gotham
    helpText.Text = "Examples: /heal, /max, /tp 0 10 50, /setfruit fire"
    helpText.TextColor3 = Color3.fromRGB(200, 200, 200)
    helpText.TextSize = 11
    helpText.TextWrapped = true
    helpText.Parent = panel

    local box = Instance.new("TextBox")
    box.Size = UDim2.new(1, -20, 0, 28)
    box.Position = UDim2.new(0, 10, 0, 75)
    box.PlaceholderText = "Type command here..."
    box.ClearTextOnFocus = false
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    box.BorderSizePixel = 0
    box.Font = Enum.Font.Gotham
    box.TextSize = 14
    box.Parent = panel

    local runButton = Instance.new("TextButton")
    runButton.Size = UDim2.new(0, 120, 0, 26)
    runButton.Position = UDim2.new(0, 10, 1, -34)
    runButton.Text = "Run Command"
    runButton.Font = Enum.Font.GothamBold
    runButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    runButton.BackgroundColor3 = Color3.fromRGB(60, 150, 255)
    runButton.BorderSizePixel = 0
    runButton.Parent = panel

    local function runCommand()
        local text = box.Text
        if text ~= "" then
            print("[AdminClient] Sending command: " .. text)
            commandEvent:FireServer(text)
            box.Text = ""
        end
    end

    runButton.MouseButton1Click:Connect(runCommand)

    box.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            runCommand()
        end
    end)

    print("[AdminClient] Admin panel created.")
end

creatAdminPanel()

print("[AdminClient] ✅ Admin client loaded.")
