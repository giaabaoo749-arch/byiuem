-- Zygame_Crack VN
-- MẬT KHẨU CỦA BẠN
local PASSWORD = "zygame_crack" 
local inputPassword = "zygame_crack" -- Nếu bạn muốn tạo ô nhập, bạn có thể thay biến này bằng input người dùng

if inputPassword == PASSWORD then
    -- Nếu đúng mật khẩu, bắt đầu tải GUI
    local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

    -- 1. Tạo Cửa Sổ Chính
    local Window = Fluent:CreateWindow({
        Title = "BANANA CAT HUB : Blox Trái Ác Quỷ",
        SubTitle = "by Zygame",
        TabWidth = 160,
        Size = UDim2.fromOffset(580, 460),
        Acrylic = true,
        Theme = "Dark",
        MinimizeKey = Enum.KeyCode.RightControl
    })

    -- 2. Tạo Nút Bật/Tắt (Floating Button) với ảnh Cute Cat
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    local ToggleButton = Instance.new("ImageButton", ScreenGui)
    ToggleButton.Name = "BananaCatButton"
    ToggleButton.Size = UDim2.new(0, 60, 0, 60)
    ToggleButton.Position = UDim2.new(0, 20, 0.5, -30)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ToggleButton.Image = "rbxassetid://114663536419764"
    ToggleButton.Active = true
    ToggleButton.Draggable = true

    local UICorner = Instance.new("UICorner", ToggleButton)
    UICorner.CornerRadius = UDim.new(0.5, 0)
    ToggleButton.MouseButton1Click:Connect(function() Window:Minimize() end)

    -- 3. Tạo các Tabs
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

    -- 4. Thêm Toggle mẫu
    Tabs.Farm:AddToggle("AutoLevel", { Title = "Tự Động Cày Cấp", Default = false }):OnChanged(function(State)
        print("Auto Level:", State)
    end)

    Window:SelectTab(1)
    
    -- Thông báo thành công
    Fluent:Notify({
        Title = "BANANA CAT HUB",
        Content = "Mật khẩu đúng! Đã tải menu.",
        Duration = 5
    })
else
    -- Nếu sai mật khẩu
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Lỗi",
        Text = "Mật khẩu không chính xác!",
        Duration = 5
    })
    warn("Mật khẩu không chính xác! Không thể tải Script.")
end
