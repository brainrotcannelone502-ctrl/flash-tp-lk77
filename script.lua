local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
sg.Name = "BK_Flash_Steal_V29"
sg.ResetOnSpawn = false

local AlirgtAtivado = false
local BrainrotAuto = false

-- JANELA PRINCIPAL (ESTILO image_b931fe.png)
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 260, 0, 380)
Main.Position = UDim2.new(0.5, -130, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 18, 22)
Main.BorderSizePixel = 2
Main.BorderColor3 = Color3.fromRGB(255, 0, 0)
Main.Active = true
Main.Draggable = true
Main.ZIndex = 1

local Title = Instance.new("TextLabel", Main)
Title.Text = "BK'S Flash Steal 🩸"
Title.Size = UDim2.new(1, -10, 0, 40)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.ZIndex = 2

local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, 0, 1, -45)
Content.Position = UDim2.new(0, 0, 0, 45)
Content.BackgroundTransparency = 1
Content.ZIndex = 1

local UIList = Instance.new("UIListLayout", Content)
UIList.Padding = UDim.new(0, 5)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- FUNÇÃO FLASH TP (RESOLVE O PROBLEMA DE VOLTAR PARA TRÁS)
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

-- LOGICA AUTOMÁTICA DO VÍDEO
player.CharacterChildAdded:Connect(function(child)
    if BrainrotAuto and child:IsA("Tool") and not child.Name:lower():find("flash") then
        task.wait(0.01)
        ExecutarFlashTP()
    end
end)

-- LOGICA ALIRGT (TELEPORTE PARA CIMA AO APERTAR E)
game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.E and AlirgtAtivado then
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = hrp.CFrame + Vector3.new(0, 18, 0)
        end
    end
end)

-- FUNÇÃO DE BOTÃO COM ZINDEX ALTO PARA NÃO FICAR PRETO
local function CreateToggle(name, callback)
    local btn = Instance.new("TextButton", Content)
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(30, 33, 38)
    btn.Text = name .. ": OFF"
    btn.TextColor3 = Color3.fromRGB(255, 0, 0)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.ZIndex = 10 -- Garante que o botão apareça na frente
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = name .. (state and ": ON" or ": OFF")
        btn.TextColor3 = state and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        callback(state)
    end)
end

-- BOTÕES CONFORME O VÍDEO E IMAGEM
CreateToggle("FLASH TP", function(v) end)
CreateToggle("ALIRGT [E]", function(v) AlirgtAtivado = v end)
CreateToggle("BRAINROT AUTO", function(v) BrainrotAuto = v end)
CreateToggle("X-RAY BASES", function(v)
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj:IsDescendantOf(player.Character) then
            if v then
                if obj.Transparency < 0.5 then obj.Transparency = 0.7 obj.Material = Enum.Material.ForceField end
            else
                obj.Transparency = 0 obj.Material = Enum.Material.Plastic
            end
        end
    end
end)

-- DECORAÇÃO SLIDERS
local function Decor(txt)
    local l = Instance.new("TextLabel", Content)
    l.Size = UDim2.new(0.9, 0, 0, 15)
    l.Text = txt
    l.TextColor3 = Color3.fromRGB(255, 0, 0)
    l.BackgroundTransparency = 1
    l.Font = Enum.Font.GothamBold
    l.TextSize = 9
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 5

    local b = Instance.new("Frame", Content)
    b.Size = UDim2.new(0.9, 0, 0, 4)
    b.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    b.BorderSizePixel = 0
    b.ZIndex = 5
end

Decor("TRIGGER 90%")
Decor("BRAINROT V2 90%")

-- TECLA P PARA ESCONDER/MOSTRAR
game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.P then Main.Visible = not Main.Visible end
end)
