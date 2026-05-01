local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
sg.Name = "BK_Flash_Steal_V28"
sg.ResetOnSpawn = false

local XrayAtivado = false
local AlirgtAtivado = false
local BrainrotAuto = false

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 260, 0, 360) -- Aumentado levemente para caber os novos botões
Main.Position = UDim2.new(0.5, -130, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 18, 22)
Main.BorderSizePixel = 2
Main.BorderColor3 = Color3.fromRGB(255, 0, 0)
Main.Active = true
Main.Draggable = true

local Title = Instance.new("TextLabel", Main)
Title.Text = "BK'S Flash Steal 🩸"
Title.Size = UDim2.new(1, -10, 0, 40)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1

local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, 0, 1, -45)
Content.Position = UDim2.new(0, 0, 0, 45)
Content.BackgroundTransparency = 1

local UIList = Instance.new("UIListLayout", Content)
UIList.Padding = UDim.new(0, 5)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- FUNÇÃO FLASH TP (MELHORADA)
local function ExecutarFlashTP()
    local char = player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hum or not hrp then return end

    local tool = player.Backpack:FindFirstChild("flash teleport") or char:FindFirstChild("flash teleport")
    if not tool then return end

    hum:UnequipTools()
    task.wait(0.05)
    tool.Parent = char
    task.wait(0.02)
    tool:Activate()
    hrp.CFrame = hrp.CFrame + (hrp.CFrame.LookVector * 12)
end

-- LOGICA AUTOMÁTICA (VIDEO)
player.CharacterChildAdded:Connect(function(child)
    if BrainrotAuto and child:IsA("Tool") and not child.Name:lower():find("flash") then
        task.wait(0.01)
        ExecutarFlashTP()
    end
end)

-- LOGICA ALIRGT (Pressionar E)
game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.E and AlirgtAtivado then
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = hrp.CFrame + Vector3.new(0, 15, 0) -- Teleporte para cima
        end
    end
end)

local function CreateToggle(name, callback)
    local btn = Instance.new("TextButton", Content)
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(25, 28, 32)
    btn.Text = name .. ": OFF"
    btn.TextColor3 = Color3.fromRGB(255, 0, 0)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = name .. (state and ": ON" or ": OFF")
        btn.TextColor3 = state and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        callback(state)
    end)
end

-- BOTÕES DO VÍDEO
CreateToggle("FLASH TP", function(v) end) -- Botão visual para o vídeo
CreateToggle("ALIRGT [E]", function(v) AlirgtAtivado = v end)
CreateToggle("BRAINROT AUTO", function(v) BrainrotAuto = v end)
CreateToggle("X-RAY BASES", function(v)
    XrayAtivado = v
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj:IsDescendantOf(player.Character) then
            if XrayAtivado then
                if obj.Transparency < 0.5 then obj.Transparency = 0.7 obj.Material = Enum.Material.ForceField end
            else
                obj.Transparency = 0 obj.Material = Enum.Material.Plastic
            end
        end
    end
end)

-- BOTÃO DE EXECUÇÃO MANUAL
local Manual = Instance.new("TextButton", Content)
Manual.Size = UDim2.new(0.9, 0, 0, 35)
Manual.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
Manual.Text = "EXECUTAR FLASH AGORA"
Manual.TextColor3 = Color3.new(1, 1, 1)
Manual.Font = Enum.Font.GothamBold
Manual.TextSize = 12
Manual.MouseButton1Click:Connect(ExecutarFlashTP)

-- DECORAÇÃO SLIDERS (VISUAL)
local function Decor(txt)
    local l = Instance.new("TextLabel", Content)
    l.Size = UDim2.new(0.9, 0, 0, 15)
    l.Text = txt
    l.TextColor3 = Color3.fromRGB(255, 0, 0)
    l.BackgroundTransparency = 1
    l.Font = Enum.Font.GothamBold
    l.TextSize = 9
    l.TextXAlignment = Enum.TextXAlignment.Left
    local b = Instance.new("Frame", Content)
    b.Size = UDim2.new(0.9, 0, 0, 3)
    b.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    b.BorderSizePixel = 0
end

Decor("TRIGGER 90%")
Decor("BRAINROT V2 90%")

game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.P then Main.Visible = not Main.Visible end
end)
