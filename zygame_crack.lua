--Update by Zygame_Crack VN--
-- ========================================================
-- ZYGAME_CRACK - UPPDATE NEW
-- ========================================================
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local CorrectKey = "zygame_crack" -- Mật khẩu của bạn

-- HÀM KHỞI TẠO MENU CHÍNH
local function InitMenu()
    local Window = Fluent:CreateWindow({
        Title = "Zygame_Crack", 
        SubTitle = "by Zygame", 
        TabWidth = 160, 
        Size = UDim2.fromOffset(580, 460), 
        Acrylic = true, 
        Theme = "Dark", 
        MinimizeKey = Enum.KeyCode.RightControl
    })

    -- CẤU HÌNH BIẾN
    getgenv().AutoFarm = false; getgenv().AutoSkills = false; getgenv().AutoHaki = false; 
    getgenv().WaterWalk = false; getgenv().BringMobs = false; getgenv().AntiAFK = false;
    getgenv().AutoAttackEnabled = false; getgenv().AutoReset = false; getgenv().TweenSpeed = 0.5;
    getgenv().SelectedWeaponType = "Melee"
    
    local Players = game:GetService("Players"); local LocalPlayer = Players.LocalPlayer
    local TweenService = game:GetService("TweenService"); local VirtualUser = game:GetService("VirtualUser")
    local RunService = game:GetService("RunService"); local VirtualInputManager = game:GetService("VirtualInputManager")

    -- LOGIC HỖ TRỢ (GIỮ NGUYÊN NHƯ CŨ)
    LocalPlayer.Idled:Connect(function()
        if getgenv().AntiAFK then VirtualUser:CaptureController(); VirtualUser:ClickButton1(Vector2.new(0, 0)) end
    end)

    local LastPos = Vector3.new(0,0,0)
    task.spawn(function()
        while task.wait(5) do
            if getgenv().AutoFarm and getgenv().AutoReset and LocalPlayer.Character then
                local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp and (hrp.Position - LastPos).Magnitude < 2 then LocalPlayer.Character.Humanoid.Health = 0 end
                if hrp then LastPos = hrp.Position end
            end
        end
    end)

    -- VÒNG LẶP AUTO FARM CHÍNH
    task.spawn(function()
        while true do
            task.wait(0.2)
            if getgenv().AutoFarm then
                pcall(function()
                    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local enemies = workspace:FindFirstChild("Enemies") or workspace:FindFirstChild("NPCs")
                    
                    if getgenv().AutoHaki and not LocalPlayer.Character:FindFirstChild("HasBuso") then 
                        pcall(function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso") end)
                    end

                    if getgenv().BringMobs and enemies then
                        for _, v in pairs(enemies:GetChildren()) do
                            if v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - hrp.Position).Magnitude < 60 then 
                                v.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 0, -4) 
                            end
                        end
                    end

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
                            TweenService:Create(hrp, TweenInfo.new(getgenv().TweenSpeed, Enum.EasingStyle.Linear), {CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 7, 0)}):Play()
                        else
                            -- EquipWeapon logic, AutoSkills, AutoAttack...
                            if getgenv().AutoSkills then 
                                for _, k in pairs({"Z","X","C","V"}) do VirtualInputManager:SendKeyEvent(true, k, false, nil); task.wait(0.1); VirtualInputManager:SendKeyEvent(false, k, false, nil) end 
                            end
                            if getgenv().AutoAttackEnabled then VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, LocalPlayer, false); task.wait(0.05); VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, LocalPlayer, false) end
                            hrp.CFrame = CFrame.new(hrp.Position, target.HumanoidRootPart.Position)
                        end
                    end
                end)
            end
        end
    end)

    -- TẠO GIAO DIỆN UI
    local Tabs = {
        Farm = Window:AddTab({Title = "Farm", Icon = "home"}),
        Config = Window:AddTab({Title = "Config", Icon = "settings"})
    }
    Tabs.Farm:AddToggle("AutoFarm", {Title = "🚀 Auto Farm", Default = false}):OnChanged(function(S) getgenv().AutoFarm = S end)
    Tabs.Config:AddSlider("TweenSpeed", {Title = "Tốc độ bay", Default = 0.5, Min = 0.1, Max = 1.0, Rounding = 1}):OnChanged(function(V) getgenv().TweenSpeed = V end)

    Fluent:Notify({Title = "Zygame_Crack", Content = "Hệ thống đã sẵn sàng!", Duration = 5})
end

-- BẢNG NHẬP KEY
local KeyWindow = Fluent:CreateWindow({Title = "Zygame_Crack | Security", SubTitle = "Nhập Key", Size = UDim2.fromOffset(300, 200), Theme = "Dark"})
KeyWindow:AddInput("KeyInput", {
    Title = "Nhập Key:",
    Default = "",
    Placeholder = "Nhập mã tại đây...",
    Callback = function(Value)
        if Value == CorrectKey then
            Fluent:Notify({Title = "Thành công", Content = "Key chính xác!", Duration = 3})
            KeyWindow:Destroy() -- Xóa bảng nhập key
            InitMenu() -- Khởi chạy menu chính
        else
            Fluent:Notify({Title = "Lỗi", Content = "Sai Key!", Duration = 3})
        end
    end
})
