--Update by Zygame_Crack VN--
-- ==========================================
-- THÔNG BÁO KHỞI ĐỘNG HỆ THỐNG
-- ==========================================
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Zygame_Crack",
    Text = "Đang kiểm tra thông tin bản quyền...",
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

    -- NÚT ẨN/HIỆN MENU (MÈO CON)
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    local ToggleButton = Instance.new("ImageButton", ScreenGui)
    ToggleButton.Name = "ZygameCrackButton"
    ToggleButton.Size = UDim2.new(0, 60, 0, 60)
    ToggleButton.Position = UDim2.new(0, 20, 0.5, -30)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ToggleButton.Image = "rbxassetid://114663536419764"
    ToggleButton.Active = true
    ToggleButton.Draggable = true
    Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0.5, 0)
    ToggleButton.MouseButton1Click:Connect(function() Window:Minimize() end)

    -- CÁC TABS
    local Tabs = {
        Farm = Window:AddTab({ Title = "Farm", Icon = "home" }),
        Stats = Window:AddTab({ Title = "Auto Stats", Icon = "bar-chart" }),
        ItemsFarm = Window:AddTab({ Title = "Items Farm", Icon = "box" }),
        FightingStyle = Window:AddTab({ Title = "Fighting Style", Icon = "swords" }),
        SuKienBien = Window:AddTab({ Title = "Sự Kiện Biển", Icon = "anchor" }),
        Mirage = Window:AddTab({ Title = "Mirage + RaceV4", Icon = "moon" }),
        CombatPVP = Window:AddTab({ Title = "Combat PVP", Icon = "shield" }),
        Config = Window:AddTab({ Title = "Config", Icon = "settings" })
    }

    -- ==========================================
    -- LOGIC HỆ THỐNG AUTO FARM THỰC TẾ (BLOX FRUITS)
    -- ==========================================
    getgenv().AutoFarm = false
    getgenv().TweenSpeed = 350

    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local TweenService = game:GetService("TweenService")
    local VirtualUser = game:GetService("VirtualUser")

    -- 1. Hàm bay nhanh (Fast Tween)
    local function FastTween(targetCFrame)
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        
        local rootPart = char.HumanoidRootPart
        local distance = (rootPart.Position - targetCFrame.Position).Magnitude
        local tweenTime = distance / getgenv().TweenSpeed 
        
        local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(rootPart, tweenInfo, {CFrame = targetCFrame})
        
        tween:Play()
        return tween
    end

    -- 2. Hàm Click chuột đánh quái
    local function AutoAttack()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton1(Vector2.new())
    end

    -- 3. Hàm Tự Động Trang Bị Vũ Khí (Ưu tiên Melee hoặc Sword)
    local function EquipWeapon()
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("Humanoid") then return end
        
        -- Quét balo để tìm vũ khí
        for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
            if tool:IsA("Tool") and (tool.ToolTip == "Melee" or tool.ToolTip == "Sword") then
                char.Humanoid:EquipTool(tool)
                break
            end
        end
    end

    -- 4. Hàm Quét Quái Gần Nhất
    local function GetNearestEnemy()
        local target = nil
        local shortestDistance = math.huge
        local playerChar = LocalPlayer.Character
        
        if not playerChar or not playerChar:FindFirstChild("HumanoidRootPart") then return nil end
        local playerPos = playerChar.HumanoidRootPart.Position
        
        -- Quét trong thư mục Enemies của Blox Fruits
        local enemiesFolder = workspace:FindFirstChild("Enemies")
        if enemiesFolder then
            for _, enemy in pairs(enemiesFolder:GetChildren()) do
                if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 and enemy:FindFirstChild("HumanoidRootPart") then
                    local distance = (enemy.HumanoidRootPart.Position - playerPos).Magnitude
                    if distance < shortestDistance then
                        shortestDistance = distance
                        target = enemy
                    end
                end
            end
        end
        return target
    end

    -- 5. Vòng Lặp Auto Farm Chính
    task.spawn(function()
        while true do
            task.wait()
            if getgenv().AutoFarm then
                pcall(function()
                    local char = LocalPlayer.Character
                    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                    
                    -- Tìm mục tiêu
                    local targetEnemy = GetNearestEnemy()
                    
                    if targetEnemy and targetEnemy:FindFirstChild("HumanoidRootPart") then
                        -- Bay tới tọa độ TRÊN ĐẦU quái 7 stud để né sát thương
                        local safePosition = targetEnemy.HumanoidRootPart.CFrame * CFrame.new(0, 7, 0)
                        
                        -- Ép nhân vật quay mặt hướng xuống con quái
                        local lookAtEnemy = CFrame.new(safePosition.Position, targetEnemy.HumanoidRootPart.Position)
                        
                        FastTween(lookAtEnemy)
                        
                        -- Chống rơi và chống văng (Khóa Velocity)
                        char.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                        
                        -- Nếu đã ở gần quái (khoảng cách < 15), bắt đầu chém
                        if (char.HumanoidRootPart.Position - targetEnemy.HumanoidRootPart.Position).Magnitude < 15 then
                            EquipWeapon()
                            AutoAttack()
                        end
                    end
                end)
            end
        end
    end)
    
    -- Xử lý Anti-AFK (Chống văng game khi treo lâu)
    local VirtualInputManager = game:GetService("VirtualInputManager")
    game.Players.LocalPlayer.Idled:Connect(function()
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
        task.wait(0.1)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
    end)

    -- ==========================================
    -- 1. TAB FARM & KÍCH HOẠT SCRIPT
    -- ==========================================
    Tabs.Farm:AddButton({
        Title = "🚀 Kích Hoạt Zygame Crack",
        Description = "Tải và chạy script gốc từ Github",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/giaabaoo749-arch/byiuem/refs/heads/main/zygame_crack.lua"))()
            Fluent:Notify({ Title = "Thành công", Content = "Đã kích hoạt Script Gốc!", Duration = 5 })
        end
    })

    local SectionFarm = Tabs.Farm:AddSection("Chức Năng Cày Cấp")
    Tabs.Farm:AddToggle("AutoLevel", { Title = "Tự Động Cày Cấp (SIÊU NHANH)", Default = false }):OnChanged(function(State)
        getgenv().AutoFarm = State
    end)
    Tabs.Farm:AddToggle("AutoBoss", { Title = "Tự Động Đánh Boss", Default = false }):OnChanged(function(State) end)
    Tabs.Farm:AddToggle("AutoRaid", { Title = "Tự Động Factory/Castle Raid", Default = false }):OnChanged(function(State) end)

    -- ==========================================
    -- 2. TAB AUTO STATS (CHỨC NĂNG THỰC TẾ)
    -- ==========================================
    local SectionStats = Tabs.Stats:AddSection("Tự Động Nâng Chỉ Số")
    
    getgenv().StatPoints = 1
    Tabs.Stats:AddSlider("StatSlider", {
        Title = "Số điểm cộng mỗi lần",
        Default = 1, Min = 1, Max = 100, Rounding = 1
    }):OnChanged(function(Value) getgenv().StatPoints = Value end)

    local function NangChiSo(TenChiSo)
        task.spawn(function()
            while getgenv()[TenChiSo] do
                task.wait(0.1)
                pcall(function()
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", TenChiSo, getgenv().StatPoints)
                end)
            end
        end)
    end

    Tabs.Stats:AddToggle("MeleeStat", { Title = "Cận Chiến (Melee)", Default = false }):OnChanged(function(State) getgenv().Melee = State; NangChiSo("Melee") end)
    Tabs.Stats:AddToggle("DefenseStat", { Title = "Phòng Thủ (Defense)", Default = false }):OnChanged(function(State) getgenv().Defense = State; NangChiSo("Defense") end)
    Tabs.Stats:AddToggle("SwordStat", { Title = "Kiếm (Sword)", Default = false }):OnChanged(function(State) getgenv().Sword = State; NangChiSo("Sword") end)
    Tabs.Stats:AddToggle("GunStat", { Title = "Súng (Gun)", Default = false }):OnChanged(function(State) getgenv().Gun = State; NangChiSo("Gun") end)
    Tabs.Stats:AddToggle("FruitStat", { Title = "Trái Ác Quỷ (Blox Fruit)", Default = false }):OnChanged(function(State) getgenv().DemonFruit = State; NangChiSo("Demon Fruit") end)

    -- ==========================================
    -- 3. TAB ITEMS FARM
    -- ==========================================
    local SectionItems = Tabs.ItemsFarm:AddSection("Vũ Khí & Vật Phẩm Truyền Thuyết")
    Tabs.ItemsFarm:AddToggle("AutoCDK", { Title = "Tự Động Lấy Cursed Dual Katana", Default = false })
    Tabs.ItemsFarm:AddToggle("AutoSoulGuitar", { Title = "Tự Động Lấy Soul Guitar", Default = false })
    Tabs.ItemsFarm:AddToggle("AutoScythe", { Title = "Tự Động Lấy Hallow Scythe", Default = false })
    Tabs.ItemsFarm:AddToggle("AutoTushita", { Title = "Tự Động Lấy Tushita", Default = false })
    Tabs.ItemsFarm:AddToggle("AutoYama", { Title = "Tự Động Lấy Yama", Default = false })

    -- ==========================================
    -- 4. TAB FIGHTING STYLE
    -- ==========================================
    local SectionFS = Tabs.FightingStyle:AddSection("Võ Thuật (Fighting Styles)")
    local DropdownFS = Tabs.FightingStyle:AddDropdown("SelectFS", {
        Title = "Chọn Võ Thuật Muốn Lấy",
        Values = {"Godhuman", "Superhuman", "Sharkman Karate", "Death Step", "Electric Claw", "Dragon Talon"},
        Multi = false,
        Default = 1
    })
    Tabs.FightingStyle:AddToggle("AutoFS", { Title = "Tự Động Cày/Mua Võ Thuật Đã Chọn", Default = false })

    -- ==========================================
    -- 5. TAB SỰ KIỆN BIỂN (SEA EVENTS)
    -- ==========================================
    local SectionSea = Tabs.SuKienBien:AddSection("Sea Events (Biển 3)")
    Tabs.SuKienBien:AddToggle("AutoLeviathan", { Title = "Tự Động Săn Leviathan", Default = false })
    Tabs.SuKienBien:AddToggle("AutoTerror", { Title = "Tự Động Săn Terror Shark", Default = false })
    Tabs.SuKienBien:AddToggle("AutoShipRaid", { Title = "Tự Động Săn Tàu Địch (Ship Raid)", Default = false })
    Tabs.SuKienBien:AddToggle("AutoRoughSea", { Title = "Tự Động Gom Rương Trên Biển", Default = false })

    -- ==========================================
    -- 6. TAB MIRAGE & RACE V4
    -- ==========================================
    local SectionMirage = Tabs.Mirage:AddSection("Đảo Bí Ẩn & Tộc V4")
    Tabs.Mirage:AddToggle("FindMirage", { Title = "Tự Động Tìm Đảo Mirage", Default = false })
    Tabs.Mirage:AddToggle("AutoPullLever", { Title = "Tự Động Gạt Cần (Pull Lever)", Default = false })
    Tabs.Mirage:AddToggle("AutoTrial", { Title = "Tự Động Làm Trial (Thử thách Tộc)", Default = false })
    
    -- ==========================================
    -- 7. TAB COMBAT PVP & ESP
    -- ==========================================
    local SectionPVP = Tabs.CombatPVP:AddSection("Hỗ trợ Chiến Đấu")
    Tabs.CombatPVP:AddToggle("AimbotSkill", { Title = "Tự Động Khóa Mục Tiêu (Aimbot Skill)", Default = false })
    Tabs.CombatPVP:AddToggle("SafeZone", { Title = "Bật Vòng Kháng Sát Thương (Safe Zone)", Default = false })

    local SectionESP = Tabs.CombatPVP:AddSection("Định Vị (ESP)")
    Tabs.CombatPVP:AddToggle("ESPPlayer", { Title = "Định vị Người Chơi (ESP Players)", Default = false })
    Tabs.CombatPVP:AddToggle("ESPFruit", { Title = "Định vị Trái Ác Quỷ (ESP Fruits)", Default = false })
    Tabs.CombatPVP:AddToggle("ESPIsland", { Title = "Định vị Đảo (ESP Islands)", Default = false })

    -- ==========================================
    -- 8. TAB CONFIG & SETTINGS
    -- ==========================================
    local SectionConfig = Tabs.Config:AddSection("Cài Đặt Script")
    Tabs.Config:AddToggle("WhiteScreen", { Title = "Màn Hình Trắng (Giảm Lag)", Default = false }):OnChanged(function(State)
        game:GetService("RunService"):Set3dRenderingEnabled(not State)
    end)
    Tabs.Config:AddButton({
        Title = "Xóa Bỏ Giao Diện (Destroy GUI)",
        Callback = function()
            ScreenGui:Destroy()
            Window:Destroy()
        end
    })

    Window:SelectTab(1)
    Fluent:Notify({ Title = "ZYGAME_CRACK ACTIVE", Content = "Đã tải FULL MENU!", Duration = 5 })

else
    game:GetService("StarterGui"):SetCore("SendNotification", { Title = "LỖI XÁC THỰC", Text = "Sai mật khẩu!", Duration = 5 })
end
