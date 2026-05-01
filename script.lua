local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
sg.Name = "BK_FINAL_FIX"
sg.ResetOnSpawn = false

local AutoSteal = false

-- JANELA PRINCIPAL
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 250, 0, 220)
Main.Position = UDim2.new(0.5, -125, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.BorderSizePixel = 4
Main.BorderColor3 = Color3.fromRGB(255, 0, 0)
Main.Active = true
Main.Draggable = true
Main.ZIndex = 1

-- TÍTULO (FORÇADO NO TOPO)
local Title = Instance.new("TextLabel", Main)
Title.Text = "AUTO STEAL V26"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.ZIndex = 10

-- FUNÇÃO DE CRIAR BOTÃO COM CAMADA FORÇADA (ZINDEX)
local function CreateButton(text, yPos, callback)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0.9, 0, 0, 50)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamBold
    btn.Text = text .. ": OFF"
    btn.ZIndex = 20 -- Isso joga o botão para a frente de TUDO
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = text .. (state and ": ON" or ": OFF")
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(60, 60, 60)
        callback(state)
    end)
end

-- LÓGICA DE ROUBO IGUAL AO VÍDEO
player.CharacterChildAdded:Connect(function(child)
    if AutoSteal and child:IsA("Tool") and not child.Name:lower():find("flash") then
        local char = player.Character
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local flash = player.Backpack:FindFirstChild("flash teleport") or char:FindFirstChild("flash teleport")

        if flash and hrp then
            task.wait(0.02)
            hum:UnequipTools()
            task.wait(0.02)
            flash.Parent = char
            flash:Activate()
            hrp.CFrame = hrp.CFrame + (hrp.CFrame.LookVector * -35)
            hrp.Velocity = Vector3.new(0, 0, 0)
        end
    end
end)

-- CRIANDO OS BOTÕES EM POSIÇÕES EXATAS
CreateButton("FLASH TP AUTO", 60, function(v) AutoSteal = v end)
CreateButton("X-RAY BASES", 120, function(v)
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name:find("Wall") or obj.Name:find("Gate")) then
            obj.Transparency = v and 0.8 or 0
        end
    end
end)

-- TECLA P PARA ESCONDER
game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.P then Main.Visible = not Main.Visible end
end)
