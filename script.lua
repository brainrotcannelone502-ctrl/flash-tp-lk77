local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
sg.Name = "Flash_Steal_V20"
sg.ResetOnSpawn = false

local FlashAtivado = false
local XrayAtivado = false

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 300, 0, 250)
Main.Position = UDim2.new(0.8, 0, 0.5, -125)
Main.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
Main.BorderSizePixel = 2
Main.Active = true
Main.Draggable = true

local Title = Instance.new("TextLabel", Main)
Title.Text = "BK's Flash Steal (V20)"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.TextColor3 = Color3.new(1, 0, 0)
Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1

local function CreateToggle(name, startState, callback)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, 40 + (#Main:GetChildren() * 45))
    btn.Text = name .. (startState and ": ON" or ": OFF")
    btn.BackgroundColor3 = startState and Color3.fromRGB(100, 0, 0) or Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.new(1, 1, 1)
    
    local state = startState
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = name .. (state and ": ON" or ": OFF")
        btn.BackgroundColor3 = state and Color3.fromRGB(100, 0, 0) or Color3.fromRGB(40, 40, 40)
        callback(state)
    end)
end

-- Lógica de Roubo Automático (Igual ao vídeo)
player.CharacterChildAdded:Connect(function(child)
    if FlashAtivado and child:IsA("Tool") and child.Name:lower():find("brainrot") then
        local char = player.Character
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        
        -- Busca o item de teleporte
        local flash = player.Backpack:FindFirstChild("flash teleport") or char:FindFirstChild("flash teleport")
        
        if flash and hrp then
            -- 1. Força a troca instantânea (Exploit de animação)
            hum:UnequipTools()
            task.wait()
            flash.Parent = char
            
            -- 2. Teleporte por Velocidade (Não puxa de volta)
            local targetPos = hrp.CFrame + (hrp.CFrame.LookVector * -15) -- Pula para trás saindo da base
            hrp.Velocity = hrp.CFrame.LookVector * -100
            
            -- 3. Ativa o flash
            flash:Activate()
            
            -- 4. Trava a posição final por meio segundo para o anticheat aceitar
            task.wait(0.1)
            hrp.CFrame = targetPos
        end
    end
end)

CreateToggle("FLASH TP", false, function(v) FlashAtivado = v end)

CreateToggle("BASES X-RAY", false, function(v)
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name == "Wall" then
            obj.Transparency = v and 0.7 or 0
        end
    end
end)

-- Tecla P para esconder o menu
game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.P then Main.Visible = not Main.Visible end
end)
