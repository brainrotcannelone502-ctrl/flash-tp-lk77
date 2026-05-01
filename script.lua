local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
sg.Name = "BK_Flash_Steal_UI"
sg.ResetOnSpawn = false

local XrayAtivado = false
local FlashAtivado = false

-- JANELA PRINCIPAL (ESTILO DARK/RED DA IMAGEM)
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 260, 0, 320)
Main.Position = UDim2.new(0.5, -130, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 18, 22) -- Fundo quase preto
Main.BorderSizePixel = 2
Main.BorderColor3 = Color3.fromRGB(255, 0, 0) -- Borda vermelha
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

local Line = Instance.new("Frame", Main)
Line.Size = UDim2.new(1, 0, 0, 1)
Line.Position = UDim2.new(0, 0, 0, 40)
Line.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Line.BorderSizePixel = 0

-- CONTAINER DOS BOTÕES
local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, 0, 1, -45)
Content.Position = UDim2.new(0, 0, 0, 45)
Content.BackgroundTransparency = 1

local UIList = Instance.new("UIListLayout", Content)
UIList.Padding = UDim.new(0, 8)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- FUNÇÃO PARA CRIAR BOTÃO IGUAL DA IMAGEM
local function CreateButton(name, callback)
    local btn = Instance.new("TextButton", Content)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(25, 28, 32)
    btn.BorderSizePixel = 0
    btn.Text = name .. ": OFF"
    btn.TextColor3 = Color3.fromRGB(255, 0, 0)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = name .. (state and ": ON" or ": OFF")
        btn.TextColor3 = state and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        callback(state)
    end)
end

-- LÓGICA DE TELEPORTE (V17 FIX)
local function ExecutarFlash()
    local char = player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hum or not hrp then return end

    local tool = player.Backpack:FindFirstChild("flash teleport") or char:FindFirstChild("flash teleport")
    if not tool then return end

    hum:UnequipTools()
    task.wait(0.05)
    
    local connection
    connection = game:GetService("RunService").Stepped:Connect(function()
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end)

    tool.Parent = char
    task.wait(0.1)
    tool:Activate()
    hrp.CFrame = hrp.CFrame + (hrp.CFrame.LookVector * 7)
    
    task.delay(1, function()
        if connection then connection:Disconnect() end
    end)
end

-- CRIAÇÃO DOS ELEMENTOS DA UI
CreateButton("FLASH TP", function(v) 
    FlashAtivado = v 
    if v then ExecutarFlash() end 
end)

CreateButton("X-RAY BASES", function(v)
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj:IsDescendantOf(player.Character) then
            if v then
                if obj.Transparency < 0.5 then
                    obj.Transparency = 0.7
                    obj.Material = Enum.Material.ForceField
                end
            else
                obj.Transparency = 0
                obj.Material = Enum.Material.Plastic
            end
        end
    end
end)

-- DECORAÇÃO (SLIDERS FALSOS PARA FICAR IGUAL A IMAGEM)
local function CreateFakeSlider(txt)
    local label = Instance.new("TextLabel", Content)
    label.Size = UDim2.new(0.9, 0, 0, 20)
    label.Text = txt
    label.TextColor3 = Color3.fromRGB(255, 0, 0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.TextSize = 10
    label.TextXAlignment = Enum.TextXAlignment.Left

    local bar = Instance.new("Frame", Content)
    bar.Size = UDim2.new(0.9, 0, 0, 5)
    bar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    bar.BorderSizePixel = 0
end

CreateFakeSlider("TRIGGER 90%")
CreateFakeSlider("BRAINROT V2 50%")

-- TECLA P PARA TOGGLE
game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.P then Main.Visible = not Main.Visible end
end)
