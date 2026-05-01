local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
sg.Name = "BK_AutoSteal_V22"
sg.ResetOnSpawn = false

local AutoSteal = false
local DistanciaSaida = 25 -- Quantos studs ele te joga para fora

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 260, 0, 200)
Main.Position = UDim2.new(0.8, 0, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.BorderSizePixel = 2
Main.BorderColor3 = Color3.fromRGB(255, 0, 0)
Main.Active = true
Main.Draggable = true

local Title = Instance.new("TextLabel", Main)
Title.Text = "FLASH STEAL V22 - AUTO"
Title.Size = UDim2.new(1, 0, 0, 35)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14

local function CreateToggle(name, callback)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Position = UDim2.new(0.05, 0, 0, 50 + (#Main:GetChildren() - 1) * 55)
    btn.Text = name .. ": OFF"
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamMedium
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = name .. (state and ": ON" or ": OFF")
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(40, 40, 40)
        callback(state)
    end)
end

-- LÓGICA DE DETECÇÃO E FUGA (O "PULO" PARA FORA)
player.CharacterChildAdded:Connect(function(child)
    if AutoSteal and child:IsA("Tool") and not child.Name:lower():find("flash") then
        local char = player.Character
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local flash = player.Backpack:FindFirstChild("flash teleport") or char:FindFirstChild("flash teleport")

        if flash and hrp then
            -- 1. Troca instantânea para o Flash
            task.wait(0.01)
            hum:UnequipTools()
            flash.Parent = char
            
            -- 2. Ativa o teleporte do item
            flash:Activate()
            
            -- 3. Bypass de Anticheat: Move a posição e cancela a velocidade pra não voltar
            local direcaoFuga = hrp.CFrame.LookVector * -DistanciaSaida
            hrp.CFrame = hrp.CFrame + direcaoFuga
            hrp.Velocity = Vector3.new(0,0,0)
        end
    end
end)

CreateToggle("FLASH STEAL (AUTO)", function(v) 
    AutoSteal = v 
end)

CreateToggle("X-RAY BASES", function(v)
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name:find("Wall") or obj.Name:find("Gate")) then
            obj.Transparency = v and 0.8 or 0
            obj.CanCollide = not v
        end
    end
end)

game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.P then Main.Visible = not Main.Visible end
end)
