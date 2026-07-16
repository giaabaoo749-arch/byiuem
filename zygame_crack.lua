--Update by Zygame_Crack VN--
-- ========================================================
-- ZYGAME_CRACK - VIETNAM
-- ========================================================
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Zygame_Crack",
    Text = "Đang khởi động hệ thống...",
    Duration = 3
})

local PASSWORD = "zygame_crack" 
local inputPassword = "zygame_crack" 

if inputPassword == PASSWORD then
    local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    local Window = Fluent:CreateWindow({Title = "Zygame_Crack", SubTitle = "by Zygame", TabWidth = 160, Size = UDim2.fromOffset(580, 460), Acrylic = true, Theme = "Dark", MinimizeKey = Enum.KeyCode.RightControl})

    -- CẤU HÌNH BIẾN
    getgenv().AutoFarm = false; getgenv().AutoSkills = false; getgenv().AutoHaki = false; 
    getgenv().WaterWalk = false; getgenv().BringMobs = false; getgenv().SelectedWeaponType = "Melee"
    
    local Players = game:GetService("Players"); local LocalPlayer = Players.LocalPlayer
    local TweenService = game:GetService("TweenService"); local VirtualUser = game:GetService("VirtualUser")
    local RunService = game:GetService("RunService"); local VirtualInputManager = game:GetService("VirtualInputManager")

    -- HÀM HỖ TRỢ CHIẾN ĐẤU
    local function EquipWeapon()
        local char = LocalPlayer.Character
        if not char then return end
        local current = char:FindFirstChildOfClass("Tool")
        if current and current.ToolTip == getgenv().SelectedWeaponType then return end
        for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
            if tool:IsA("Tool") and tool.ToolTip == getgenv().SelectedWeaponType then
                char.Humanoid:EquipTool(tool); return
            end
        end
    end

    local function UseSkills()
        if not getgenv().AutoSkills then return end
        for _, key in pairs({"Z", "X", "C", "V"}) do
            VirtualInputManager:SendKeyEvent(true, key, false, nil); task.wait(0.1)
            VirtualInputManager:SendKeyEvent(false, key, false, nil)
        end
    end

    -- WATER WALK
    local WaterPart = Instance.new("Part", workspace); WaterPart.Name = "WaterPlatform"; WaterPart.Size = Vector3.new(12, 1, 12)
    WaterPart.Transparency = 1; WaterPart.Anchored = true; WaterPart.CanCollide = true; WaterPart.Position = Vector3.new(0, -500, 0)
    RunService.RenderStepped:Connect(function()
        if getgenv().WaterWalk and LocalPlayer.Character then
            local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local hit = workspace:FindPartOnRay(Ray.new(hrp.Position, Vector3.new(0, -10, 0)), LocalPlayer.Character)
                if hit and hit.Name:lower():find("water") then WaterPart.Position = Vector3.new(hrp.Position.X, hit.Position.Y + 0.5, hrp.Position.Z)
                else WaterPart.Position = Vector3.new(0, -500, 0) end
            end
        else WaterPart.Position = Vector3.new(0, -500, 0) end
    end)

    -- VÒNG LẶP AUTO FARM (TÍCH HỢP GOM QUÁI)
    task.spawn(function()
        while true do
            task.wait(0.2)
            if getgenv().AutoFarm then
                pcall(function()
                    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local enemies = workspace:FindFirstChild("Enemies") or workspace:FindFirstChild("NPCs")
                    
                    -- LOGIC GOM QUÁI
                    if getgenv().BringMobs and enemies then
                        for _, v in pairs(enemies:GetChildren()) do
                            if v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                if (v.HumanoidRootPart.Position - hrp.Position).Magnitude < 60 then 
                                    v.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 0, -4) 
                                end
                            end
                        end
                    end

                    -- TÌM QUÁI GẦN NHẤT
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
                            TweenService:Create(hrp, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 7, 0)}):Play()
                        else
                            EquipWeapon(); UseSkills()
                            if getgenv().AutoHaki then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso") end
                            VirtualUser:CaptureController(); VirtualUser:ClickButton1(Vector2.new(0, 0))
                            hrp.CFrame = CFrame.new(hrp.Position, target.HumanoidRootPart.Position)
                        end
                    end
                end)
            end
        end
    end)

    -- TẠO GIAO DIỆN UI
    local Tabs = {Farm = Window:AddTab({Title = "Farm", Icon = "home"}), Config = Window:AddTab({Title = "Config", Icon = "settings"})}
    
    Tabs.Farm:AddToggle("AutoFarm", {Title = "🚀 Auto Farm", Default = false}):OnChanged(function(S) getgenv().AutoFarm = S end)
    Tabs.Farm:AddToggle("BringMobs", {Title = "🧲 Gom quái (Mob Aura)", Default = false}):OnChanged(function(S) getgenv().BringMobs = S end)
    Tabs.Farm:AddToggle("AutoSkills", {Title = "✨ Auto Dùng Chiêu (Z,X,C,V)", Default = false}):OnChanged(function(S) getgenv().AutoSkills = S end)
    Tabs.Farm:AddToggle("AutoHaki", {Title = "🛡️ Auto Haki", Default = false}):OnChanged(function(S) getgenv().AutoHaki = S end)
    Tabs.Farm:AddDropdown("WeaponSelect", {Title = "Chọn vũ khí chính", Values = {"Melee", "Sword", "Gun", "Fruit"}, Default = 1}):OnChanged(function(V) getgenv().SelectedWeaponType = V end)
    
    Tabs.Config:AddToggle("WaterWalk", {Title = "💧 Đi bộ trên nước", Default = false}):OnChanged(function(S) getgenv().WaterWalk = S end)

    Fluent:Notify({Title = "Zygame_Crack", Content = "Hệ thống đã sẵn sàng!", Duration = 5})
else
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Lỗi", Text = "Sai mật khẩu!", Duration = 5})
end
