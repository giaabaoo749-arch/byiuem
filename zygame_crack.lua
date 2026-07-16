--  Người Tạo by Zygame_Crack VN
-- THÔNG BÁO KHỞI ĐỘNG HỆ THỐNG
-- ==========================================
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Zygame_Crack",
    Text = "Đang kiểm tra thông tin bản quyền...",
    Duration = 3
})

-- MẬT KHẨU BẢO VỆ
local PASSWORD = "zygame_crack" 
local inputPassword = "zygame_crack" -- Thay đổi logic nếu bạn muốn làm bảng nhập thủ công

if inputPassword == PASSWORD then
    -- Thông báo nạp thư viện GUI
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "GUI Library",
        Text = "Đang kết nối & tải Fluent UI Library...",
        Duration = 3
    })

    -- Tải thư viện Fluent UI
    local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

    -- Thông báo nạp thư viện thành công
    Fluent:Notify({
        Title = "GUI Library Info",
        Content = "Đã nạp thành công thư viện Fluent UI v1.0.0!",
        SubTitle = "System",
        Duration = 5
    })

    -- 1. Tạo Cửa Sổ Chính
    local Window = Fluent:CreateWindow({
        Title = "Zygame_Crack",
        SubTitle = "by Zygame",
        TabWidth = 160,
        Size = UDim2.fromOffset(580, 460),
        Acrylic = true,
        Theme = "Dark",
        MinimizeKey = Enum.KeyCode.RightControl
    })

    -- 2. Tạo Nút Bật/Tắt (Floating Button) hình Mèo con
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    local ToggleButton = Instance.new("ImageButton", ScreenGui)
    ToggleButton.Name = "ZygameCrackButton"
    ToggleButton.Size = UDim2.new(0, 60, 0, 60)
    ToggleButton.Position = UDim2.new(0, 20, 0.5, -30)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ToggleButton.Image = "rbxassetid://114663536419764" -- Ảnh Mèo con của bạn
    ToggleButton.Active = true
    ToggleButton.Draggable = true

    -- Bo tròn nút Mèo con
    local UICorner = Instance.new("UICorner", ToggleButton)
    UICorner.CornerRadius = UDim.new(0.5, 0)
    
    -- Lệnh ẩn/hiện menu khi bấm vào hình Mèo con
    ToggleButton.MouseButton1Click:Connect(function() 
        Window:Minimize() 
    end)

    -- 3. Tạo các Danh mục (Tabs)
    local Tabs = {
        Farm = Window:AddTab({ Title = "Farm", Icon = "home" }),
        Config = Window:AddTab({ Title = "Config", Icon = "settings" }),
        FightingStyle = Window:AddTab({ Title = "Fighting Style", Icon = "swords" }),
        ItemsFarm = Window:AddTab({ Title = "Items Farm", Icon = "box" }),
        SuKienBien = Window:AddTab({ Title = "Sự Kiện Biển", Icon = "anchor" }),
        Mirage = Window:AddTab({ Title = "Mirage + RaceV4", Icon = "moon" }),
        DragoDojo = Window:AddTab({ Title = "Drago Dojo", Icon = "flame" }),
        Prehistoric = Window:AddTab({ Title = "Prehistoric", Icon = "bone" }),
        TapKich = Window:AddTab({ Title = "Tập kích", Icon = "crosshair" }),
        CombatPVP = Window:AddTab({ Title = "Combat PVP", Icon = "shield" })
    }

    -- ==========================================
    -- LOGIC HỆ THỐNG AUTO FARM SIÊU NHANH
    -- ==========================================
    getgenv().AutoFarm = false
    getgenv().TweenSpeed = 350 -- Tốc độ bay (Mặc định: 350)

    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local TweenService = game:GetService("TweenService")
    local VirtualUser = game:GetService("VirtualUser")

    -- Hàm bay nhanh không lo bị kick
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

    -- Hàm đánh quái siêu tốc
    local function AutoAttack()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton1(Vector2.new())
    end

    -- Vòng lặp Farm chạy ngầm
    task.spawn(function()
        while true do
            task.wait()
            if getgenv().AutoFarm then
                pcall(function()
                    -- Giữ nhân vật lơ lửng chống quái đánh trúng
                    local char = LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        char.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                    end
                    
                    -- Kích hoạt đánh siêu tốc
                    AutoAttack()
                    
                    -- [Gợi ý]: Thêm tọa độ quái vật hoặc NPC của bạn vào FastTween() tại đây
                    -- Ví dụ: FastTween(CFrame.new(x, y, z))
                end)
            end
        end
    end)

    -- ==========================================
    -- 4. KÍCH HOẠT SCRIPT TỪ GITHUB CỦA BẠN
    -- ==========================================
    local SectionMain = Tabs.Farm:AddSection("Script Chính")

    Tabs.Farm:AddButton({
        Title = "🚀 Kích Hoạt Zygame Crack",
        Description = "Tải và chạy script từ Github cá nhân",
        Callback = function()
            Window:Dialog({
                Title = "Xác nhận kích hoạt",
                Content = "Bạn có muốn chạy script zygame_crack.lua không?",
                Buttons = {
                    {
                        Title = "Chạy",
                        Callback = function()
                            -- Tải trực tiếp link Github của bạn
                            loadstring(game:HttpGet("https://raw.githubusercontent.com/giaabaoo749-arch/byiuem/refs/heads/main/zygame_crack.lua"))()
                            
                            Fluent:Notify({
                                Title = "Thành công",
                                Content = "Đã kích hoạt Zygame Crack từ GitHub!",
                                Duration = 5
                            })
                        end
                    },
                    {
                        Title = "Hủy",
                        Callback = function()
                            print("Đã hủy chạy script.")
                        end
                    }
                }
            })
        end
    })

    -- ==========================================
    -- 5. CÁC NÚT TÍNH NĂNG FARM
    -- ==========================================
    local SectionFarm = Tabs.Farm:AddSection("Farm")

    -- Nút bật tắt liên kết trực tiếp với Logic Auto Farm siêu nhanh ở trên
    Tabs.Farm:AddToggle("AutoLevel", { Title = "Tự Động Cày Cấp (SIÊU NHANH)", Default = false }):OnChanged(function(State)
        getgenv().AutoFarm = State
        print("Trạng thái Auto Farm siêu nhanh:", State)
    end)

    Tabs.Farm:AddToggle("AutoTravel", { Title = "Tự Động Travel Dressrosa", Default = false }):OnChanged(function(State)
        print("Auto Travel:", State)
    end)

    Tabs.Farm:AddToggle("AutoZou", { Title = "Tự Động Zou Nhiệm Vụ", Default = false }):OnChanged(function(State)
        print("Auto Zou:", State)
    end)

    local SectionMisc = Tabs.Farm:AddSection("Miscellanea / Nhiệm Vụ")
    
    Tabs.Farm:AddToggle("AutoNearest", { Title = "Tự Động Cày Gần Nhất", Default = false }):OnChanged(function(State)
        print("Auto Nearest:", State)
    end)

    Tabs.Farm:AddToggle("AutoFactory", { Title = "Tự Động Factory Raid", Default = false }):OnChanged(function(State)
        print("Auto Factory:", State)
    end)

    -- Hoàn tất thiết lập mở Tab Farm đầu tiên
    Window:SelectTab(1)
    
    -- Thông báo thành công cuối cùng
    Fluent:Notify({
        Title = "ZYGAME_CRACK ACTIVE",
        Content = "Đăng nhập thành công! Nhấn vào nút Mèo con để ẩn/hiện menu.",
        SubTitle = "Zygame Bypass",
        Duration = 7
    })
else
    -- Nếu sai mật khẩu
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "LỖI XÁC THỰC",
        Text = "Mật khẩu không chính xác! Không thể chạy script.",
        Duration = 5
    })
end
