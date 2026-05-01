local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
sg.Name = "BK_ULTIMATE_V25"
sg.ResetOnSpawn = false

local AutoSteal = false

-- JANELA PRINCIPAL (DESIGN ROBUSTO)
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 240, 0, 210)
Main.Position = UDim2.new(0.5, -120, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.BorderSizePixel = 2
Main.BorderColor3 = Color3.fromRGB(255, 0, 0)
Main.Active = true
Main.Draggable = true

-- TÍTULO
local Title = Instance.new("TextLabel", Main)
Title.Text = "AUTO STEAL V25"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

-- LISTA PARA FORÇAR A APARIÇÃO DOS BOTÕES
local List = Instance.new("UIListLayout", Main)
List.Padding = UDim.new(0, 10)
List.HorizontalAlignment = Enum.HorizontalAlignment.Center
List.SortOrder = Enum.SortOrder.LayoutOrder

-- ESPAÇADOR OBRIGATÓRIO
local Pad = Instance.new("Frame", Main)
Pad.Size = UDim2.new(1, 0, 0, 45)
Pad.BackgroundTransparency = 1
Pad.LayoutOrder = 0

-- FUNÇÃO COM ATRASO PARA GARANTIR RENDERIZAÇÃO
local function CreateButton(text, order, callback)
    task.wait(0.1) -- Tempo para o executador processar
    local btn = Instance.new("TextButton", Main)
    btn.Name = text
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamBold
    btn.Text = text .. ": OFF"
    btn.LayoutOrder = order
    btn.ZIndex = 5 -- Garante que fique na frente do fundo branco
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = text .. (state and ": ON" or ": OFF")
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(40, 40, 40)
        callback(state)
    end)
end

-- LÓGICA DE ROUBO AUTOMÁTICO
player.CharacterChildAdded:Connect(function(child)
    if AutoSteal and child:IsA("Tool") and not child.Name:lower():find("flash") then
        local char = player.Character
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local flash = player.Backpack:FindFirstChild("flash teleport") or char:FindFirstChild("flash teleport")

        if flash and hrp then
            task.wait(0.01)
            hum:UnequipTools()
            task.wait(0.01)
            flash.Parent = char
            flash:Activate()
            hrp.CFrame = hrp.CFrame + (hrp.CFrame.LookVector * -35)
            hrp.Velocity = Vector3.new(0, 0, 0)
        end
    end
end)

-- CRIAÇÃO DOS BOTÕES
CreateButton("FLASH TP AUTO", 1, function(v) AutoSteal = v end)
CreateButton("X-RAY BASES", 2, function(v)
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name:find("Wall") or obj.Name:find("Gate")) then
            obj.Transparency = v and 0.8 or 0
        end
    end
end)

-- TECLA P
game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.P then Main.Visible = not Main.Visible end
end)
