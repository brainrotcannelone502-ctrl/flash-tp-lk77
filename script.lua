local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
sg.Name = "BK_Flash_Steal_Final"
sg.ResetOnSpawn = false

local XrayAtivado = false

-- JANELA PRINCIPAL (IGUAL À IMAGEM)
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 260, 0, 320)
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
UIList.Padding = UDim.new(0, 8)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- FUNÇÃO FLASH TP CORRIGIDA (AGORA MAIS FORTE)
local function ExecutarFlashTP()
    local char = player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hum or not hrp then return end

    local tool = player.Backpack:FindFirstChild("flash teleport") or char:FindFirstChild("flash teleport")
    if not tool then return end

    -- 1. LIMPEZA TOTAL DA MÃO
    hum:UnequipTools()
    task.wait(0.07) -- Delay crucial para destravar o item

    -- 2. EQUIPA O FLASH
    tool.Parent = char
    task.wait(0.03)

    -- 3. BYPASS DE COLISÃO E ATIVAÇÃO
    local connection
    connection = game:GetService("RunService").Stepped:Connect(function()
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end)

    tool:Activate()
    -- Impulso de força bruta para sair da base
    hrp.Velocity = hrp.CFrame.LookVector * 150 
    hrp.CFrame = hrp.CFrame + (hrp.CFrame.LookVector * 10)

    task.delay(0.5, function()
        if connection then connection:Disconnect() end
    end)
end

local function CreateButton(name, callback)
    local btn = Instance.new("TextButton", Content)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(25, 28, 32)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 0, 0)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.MouseButton1Click:Connect(callback)
end

-- BOTÕES
CreateButton("FLASH TP (EXECUTAR)", function()
    ExecutarFlashTP()
end)

CreateButton("X-RAY BASES", function()
    XrayAtivado = not XrayAtivado
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

-- DECORAÇÃO IGUAL À IMAGEM
local function Decor(txt)
    local l = Instance.new("TextLabel", Content)
    l.Size = UDim2.new(0.9, 0, 0, 20)
    l.Text = txt
    l.TextColor3 = Color3.fromRGB(255, 0, 0)
    l.BackgroundTransparency = 1
    l.Font = Enum.Font.GothamBold
    l.TextSize = 10
    l.TextXAlignment = Enum.TextXAlignment.Left
    local b = Instance.new("Frame", Content)
    b.Size = UDim2.new(0.9, 0, 0, 4)
    b.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    b.BorderSizePixel = 0
end

Decor("TRIGGER 90%")
Decor("ALIRGT: [P]")
Decor("BRAINROT V2 90%")

game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.P then Main.Visible = not Main.Visible end
end)
