-- ========================================================
-- ZYGAME_CRACK - HOÀN CHỈNH (FULL FEATURES: FARM, QUEST, TELEPORT)
-- ========================================================
local PASSWORD = "zygame_crack" 
local inputPassword = "zygame_crack" -- Nhập mật khẩu ở đây

if inputPassword == PASSWORD then
    local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    local Window = Fluent:CreateWindow({
        Title = "Zygame_Crack", SubTitle = "by Zygame", TabWidth = 160, 
        Size = UDim2.fromOffset(580, 460), Acrylic = true, Theme = "Dark", MinimizeKey = Enum.KeyCode.RightControl
    })

    local Players = game:GetService("Players"); local LocalPlayer = Players.LocalPlayer
    local TweenService = game:GetService("TweenService"); local ReplicatedStorage = game:GetService("ReplicatedStorage")

    -- CẤU HÌNH BIẾN
    getgenv().AutoFarm = false; getgenv().FastAttack = false; getgenv().AutoSelectIsland = false; getgenv().AutoQuest = false
    
    -- DỮ LIỆU ĐẢO & NPC (THAY TỌA ĐỘ VÀ NPC TẠI ĐÂY)
    local IslandData = {
        {Name = "Đảo Khởi Đầu", Min = 1, Max = 10, Pos = CFrame.new(100, 50, 100), NPC = "Bandit NPC"},
        {Name = "Đảo Rừng Xanh", Min = 11, Max = 30, Pos = CFrame.new(-1200, 50, 4500), NPC = "Monkey NPC"}
    }

    -- CÁC HÀM XỬ LÝ
    local function TeleportTo(cf)
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then TweenService:Create(hrp, TweenInfo.new(2), {CFrame = cf}):Play() end
    end

    local function GetOptimalIsland()
        local stats = LocalPlayer:FindFirstChild("leaderstats")
        local currentLevel = (stats and stats:FindFirstChild("Level")) and stats.Level.Value or 1
        for _, data in pairs(IslandData) do
            if currentLevel >= data.Min and currentLevel <= data.Max then return data end
        end
        return IslandData[1]
    end

    local function AcceptQuest(npcName)
        if not getgenv().AutoQuest then return end
        -- THAY ĐỔI ĐƯỜNG DẪN REMOTE DƯỚI ĐÂY NẾU CẦN
        pcall(function() ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", npcName) end)
    end

    -- LOGIC NÚT NỔI
    local FloatButton = Instance.new("ImageButton", Instance.new("ScreenGui", game:GetService("CoreGui")))
    FloatButton.Size = UDim2.new(0, 50, 0, 50); FloatButton.Position = UDim2.new(0.05, 0, 0.5, 0)
    FloatButton.Image = "rbxassetid://114663536419764"; FloatButton.Draggable = true; FloatButton.Active = true
    Instance.new("UICorner", FloatButton).CornerRadius = UDim.new(0.5, 0)
    FloatButton.MouseButton1Click:Connect(function() Window:Minimize() end)

    -- VÒNG LẶP CHÍNH
    task.spawn(function()
        while task.wait(0.40) do
            if getgenv().AutoFarm and getgenv().FastAttack then
                local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if tool then tool:Activate() end
            end
        end
    end)

    task.spawn(function()
        while task.wait(10) do
            if getgenv().AutoFarm and getgenv().AutoSelectIsland then
                local best = GetOptimalIsland()
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp and (hrp.Position - best.Pos.Position).Magnitude > 300 then
                    TeleportTo(best.Pos); task.wait(2); AcceptQuest(best.NPC)
                end
            end
        end
    end)

    -- GIAO DIỆN UI
    local Tabs = {
        Farm = Window:AddTab({Title = "Farm", Icon = "home"}),
        Teleport = Window:AddTab({Title = "Teleport", Icon = "map"}),
        Config = Window:AddTab({Title = "Config", Icon = "settings"})
    }
    
    Tabs.Farm:AddToggle("AutoFarm", {Title = "🚀 Auto Farm", Default = false}):OnChanged(function(S) getgenv().AutoFarm = S end)
    Tabs.Farm:AddToggle("FastAttack", {Title = "⚡ Đánh nhanh (0.40s)", Default = false}):OnChanged(function(S) getgenv().FastAttack = S end)
    Tabs.Farm:AddToggle("AutoSelectIsland", {Title = "📍 Auto Chọn Đảo", Default = false}):OnChanged(function(S) getgenv().AutoSelectIsland = S end)
    Tabs.Farm:AddToggle("AutoQuest", {Title = "📜 Auto Nhận Quest", Default = false}):OnChanged(function(S) getgenv().AutoQuest = S end)
    
    Tabs.Teleport:AddDropdown("IslandDropdown", {
        Title = "Chọn đảo", Values = {"Đảo Khởi Đầu", "Đảo Rừng Xanh"}, Default = 1
    }):OnChanged(function(V)
        for _, v in pairs(IslandData) do if v.Name == V then TeleportTo(v.Pos) end end
    end)

    Fluent:Notify({Title = "Zygame_Crack", Content = "Đã khởi động thành công!", Duration = 5})
else
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Lỗi", Text = "Sai mật khẩu!", Duration = 5})
end
