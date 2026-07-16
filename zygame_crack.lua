--Update by Zygame_Crack VN--
-- ==========================================
-- ZYGAME_CRACK - HOÀN CHỈNH
-- ==========================================
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Zygame_Crack",
    Text = "Đang khởi động hệ thống...",
    Duration = 3
})

local PASSWORD = "zygame_crack" 
local inputPassword = "zygame_crack" 

if inputPassword == PASSWORD then
    local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

    local Window = Fluent:CreateWindow({
        Title = "Zygame_Crack",
        SubTitle = "by Zygame",
        TabWidth = 160,
        Size = UDim2.fromOffset(580, 460),
        Acrylic = true,
        Theme = "Dark",
        MinimizeKey = Enum.KeyCode.RightControl
    })

    -- UI NÚT MÈO CON
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    local ToggleButton = Instance.new("ImageButton", ScreenGui)
    ToggleButton.Size = UDim2.new(0, 60, 0, 60)
    ToggleButton.Position = UDim2.new(0, 20, 0.5, -30)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ToggleButton.Image = "rbxassetid://114663536419764"
    ToggleButton.Draggable = true
    Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0.5, 0)
    ToggleButton.MouseButton1Click:Connect(function() Window:Minimize() end)

    -- CÁC TABS
    local Tabs = {
        Farm = Window:AddTab({ Title = "Farm", Icon = "home" }),
        Config = Window:AddTab({ Title = "Config", Icon = "settings" })
    }

    -- CẤU HÌNH BIẾN
    getgenv().AutoFarm = false
    getgenv().FlashMode = false
    getgenv().WaterWalk = false
    getgenv().TweenSpeed = 350
    
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local TweenService = game:GetService("TweenService")
    local VirtualUser = game:GetService("VirtualUser")
    local RunService = game:GetService("RunService")

    -- WATER WALK LOGIC
    local WaterPart = Instance.new("Part", workspace)
    WaterPart.Name = "WaterPlatform"
    WaterPart.Size = Vector3.new(12, 1, 12)
    WaterPart.Transparency = 1
    WaterPart.Anchored = true
    WaterPart.CanCollide = true
    WaterPart.Position = Vector3.new(0, -500, 0)

    RunService.RenderStepped:Connect(function()
        if getgenv().WaterWalk then
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local ray = Ray.new(hrp.Position, Vector3.new(0, -10, 0))
                local hit, pos = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character, WaterPart})
                if hit and (hit.Name:lower():find("water") or hit.Transparency > 0.5) then
                    WaterPart.Position = Vector3.new(hrp.Position.X, pos.Y + 0.5, hrp.Position.Z)
                else
                    WaterPart.Position = Vector3.new(0, -500, 0)
                end
            end
        else
            WaterPart.Position = Vector3.new(0, -500, 0)
        end
    end)

    -- AUTO FARM & COMBAT LOGIC
    local function EquipMelee()
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("Humanoid") then return end
        local MeleeNames = {"Combat", "Black Leg", "Electro", "Fishman", "Dragon", "Superhuman", "Death Step", "Sharkman", "Electric Claw", "Godhuman", "Sanguine"}
        for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
            if tool:IsA("Tool") then
                for _, name in pairs(MeleeNames) do
                    if tool.Name:find(name) or tool.ToolTip == "Melee" then
                        char.Humanoid:EquipTool(tool)
                        return
                    end
                end
            end
        end
    end

    task.spawn(function()
        while true do
            task.wait(0.2)
            if getgenv().AutoFarm then
                pcall(function()
                    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local enemies = workspace:FindFirstChild("Enemies") or workspace:FindFirstChild("NPCs")
                    local target, dist = nil, math.huge
                    
                    if enemies then
                        for _, v in pairs(enemies:GetChildren()) do
                            if v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                local d = (v.HumanoidRootPart.Position - hrp.Position).Magnitude
                                if d < dist then dist = d; target = v end
                            end
                        end
                    end

                    if target and hrp then
                        if dist > 15 then
                            local info = TweenInfo.new((dist / getgenv().TweenSpeed), Enum.EasingStyle.Linear)
                            TweenService:Create(hrp, info, {CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 7, 0)}):Play()
                        else
                            EquipMelee()
                            if Window.Minimized == true then
                                VirtualUser:CaptureController()
                                VirtualUser:ClickButton1(Vector2.new(0, 0))
                            end
                            hrp.CFrame = CFrame.new(hrp.Position, target.HumanoidRootPart.Position)
                        end
                    end
                end)
            end
        end
    end)

    -- UI CONTROLS
    Tabs.Farm:AddToggle("AutoLevel", { Title = "🚀 Tự Động Cày Cấp", Default = false }):OnChanged(function(S) getgenv().AutoFarm = S end)
    
    Tabs.Config:AddSection("Tiện Ích")
    Tabs.Config:AddToggle("WaterWalk", { Title = "💧 Đi bộ trên nước", Default = false }):OnChanged(function(S) getgenv().WaterWalk = S end)
    Tabs.Config:AddToggle("FlashMode", { Title = "⚡ Flash Mode (Siêu Tốc)", Default = false }):OnChanged(function(S) 
        getgenv().TweenSpeed = S and 700 or 350 
    end)

    Fluent:Notify({ Title = "Zygame_Crack", Content = "Đã tải xong mọi tính năng!", Duration = 5 })
else
    game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Lỗi", Text = "Sai mật khẩu!", Duration = 5 })
end
