local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
sg.Name = "BK_AutoSteal_V23"
sg.ResetOnSpawn = false

local AutoSteal = false

-- JANELA PRINCIPAL (Cores claras para garantir visibilidade)
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 250, 0, 180)
Main.Position = UDim2.new(0.5, -125, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(240, 240, 240) -- Fundo Cinza Claro (NÃO FICA PRETO)
Main.BorderSizePixel = 3
Main.BorderColor3 = Color3.fromRGB(255, 0, 0) -- Borda Vermelha
Main.Active = true
Main.Draggable = true

local Title = Instance.new("TextLabel", Main)
Title.Text = "MENU FLASH TP V23"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.fromRGB(200, 0, 0) -- Cabeçalho Vermelho
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

-- FUNÇÃO PARA CRIAR BOTÕES QUE APARECEM DE VERDADE
local function CreateButton(name, pos, callback)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Position = UDim2.new(0.05, 0, 0, pos)
    btn.Text = name .. ": OFF"
    btn.BackgroundColor3 = Color3.fromRGB(200, 200, 200) -- Botão Cinza
    btn.TextColor3 = Color3.fromRGB(0, 0, 0) -- Texto Preto
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = name .. (state and ": ON" or ": OFF")
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(200, 200, 200)
        callback(state)
    end)
end

-- LÓGICA DE ROUBO E TELEPORTE (IGUAL AO VÍDEO)
player.CharacterChildAdded:Connect(function(child)
    if AutoSteal and child:IsA("Tool") and not child.Name:lower():find("flash") then
        local char = player.Character
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local flash = player.Backpack:FindFirstChild("flash teleport") or char:FindFirstChild("flash teleport")

        if flash and hrp then
            task.wait(0.02)
            hum:UnequipTools() -- Larga o Brainrot
            task.wait(0.02)
            flash.Parent = char -- Pega o Flash
            flash:Activate() -- Ativa o TP
            
            -- Pulo de segurança para fora da base
            hrp.CFrame = hrp.CFrame + (hrp.CFrame.LookVector * -30)
            hrp.Velocity = Vector3.new(0, 0, 0)
        end
    end
end)

-- CRIANDO OS BOTÕES EM POSIÇÕES FIXAS
CreateButton("FLASH STEAL", 50, function(v) AutoSteal = v end)
CreateButton("X-RAY BASES", 105, function(v)
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name:find("Wall") or obj.Name:find("Gate")) then
            obj.Transparency = v and 0.8 or 0
        end
    end
end)

-- TECLA P PARA ESCONDER/MOSTRAR
game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.P then Main.Visible = not Main.Visible end
end)
