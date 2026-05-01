local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
sg.Name = "BK_FIX_V24"
sg.ResetOnSpawn = false

local AutoSteal = false

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 240, 0, 200)
Main.Position = UDim2.new(0.5, -120, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.BorderSizePixel = 2
Main.BorderColor3 = Color3.fromRGB(0, 255, 0)
Main.Active = true
Main.Draggable = true

local Title = Instance.new("TextLabel", Main)
Title.Text = "AUTO STEAL V24"
Title.Size = UDim2.new(1, 0, 0, 35)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14

local List = Instance.new("UIListLayout", Main)
List.Padding = UDim.new(0, 10)
List.HorizontalAlignment = Enum.HorizontalAlignment.Center
List.SortOrder = Enum.SortOrder.LayoutOrder

local Pad = Instance.new("Frame", Main)
Pad.Size = UDim2.new(1, 0, 0, 40)
Pad.BackgroundTransparency = 1
Pad.LayoutOrder = 0

local function CreateButton(text, order, callback)
    local btn = Instance.new("TextButton", Main)
    btn.Name = text
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamBold
    btn.Text = text .. ": OFF"
    btn.LayoutOrder = order
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = text .. (state and ": ON" or ": OFF")
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 45, 45)
        callback(state)
    end)
end

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
            hrp.CFrame = hrp.CFrame + (hrp.CFrame.LookVector * -30)
            hrp.Velocity = Vector3.new(0, 0, 0)
        end
    end
end)

CreateButton("FLASH TP AUTO", 1, function(v) AutoSteal = v end)
CreateButton("X-RAY BASES", 2, function(v)
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name:find("Wall") or obj.Name:find("Gate")) then
            obj.Transparency = v and 0.8 or 0
        end
    end
end)

game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.P then Main.Visible = not Main.Visible end
end)
