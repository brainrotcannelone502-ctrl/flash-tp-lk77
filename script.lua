local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
sg.Name = "Flash_TP_LK7_V9"
sg.ResetOnSpawn = false

local TECLA_TOGGLE = Enum.KeyCode.P
local XrayAtivado = false

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 550, 0, 380)
Main.Position = UDim2.new(0.5, -275, 0.5, -190)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", TopBar)
Title.Text = "FLASH TP LK7 - PREMIUM"
Title.Size = UDim2.new(0, 300, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.TextColor3 = Color3.fromRGB(255, 200, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1

local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -20, 1, -70)
Content.Position = UDim2.new(0, 10, 0, 60)
Content.BackgroundColor3 = Color3.fromRGB(20, 21, 28)
Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 8)

local ContentLayout = Instance.new("UIGridLayout", Content)
ContentLayout.CellSize = UDim2.new(0.48, 0, 0, 45)
ContentLayout.CellPadding = UDim2.new(0.02, 0, 0.02, 0)
ContentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function CreateAction(name, callback)
    local btn = Instance.new("TextButton", Content)
    btn.BackgroundColor3 = Color3.fromRGB(35, 36, 45)
    btn.Text = name
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 13
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
    btn.MouseButton1Click:Connect(callback)
end

CreateAction("Visual: Bases X-Ray", function()
    XrayAtivado = not XrayAtivado
    local workspace = game:GetService("Workspace")
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj:IsDescendantOf(player.Character) then
            if XrayAtivado then
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

CreateAction("Flash Instantâneo", function()
    local character = player.Character
    local flashItem = player.Backpack:FindFirstChild("Flash") or character:FindFirstChild("Flash")
    if flashItem then
        player.Character.Humanoid:EquipTool(flashItem)
        task.wait(0.1)
        flashItem:Activate()
    end
end)

game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == TECLA_TOGGLE then Main.Visible = not Main.Visible end
end)
