-- Tải thư viện Fluent UI
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- 1. Tạo Cửa Sổ Chính (Window)
local Window = Fluent:CreateWindow({
    Title = "BANANA CAT HUB : Blox Trái Ác Quỷ",
    SubTitle = "",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- Bật hiệu ứng kính mờ giống trong ảnh
    Theme = "Dark", -- Giao diện tối
    MinimizeKey = Enum.KeyCode.LeftControl -- Phím thu nhỏ giao diện
})

-- 2. Tạo các danh mục bên trái (Tabs) giống hệt thanh Sidebar
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

-- 3. Thêm nội dung vào Tab "Farm"

-- Khu vực 1: Farm
local SectionFarm = Tabs.Farm:AddSection("Farm")

Tabs.Farm:AddToggle("AutoLevel", {
    Title = "Tự Động Cày Cấp", 
    Default = false 
}):OnChanged(function(State)
    -- Chèn code Auto Level vào đây
    print("Tự Động Cày Cấp:", State)
end)

Tabs.Farm:AddToggle("AutoTravel", {
    Title = "Tự Động Travel Dressrosa", 
    Default = false 
}):OnChanged(function(State)
    print("Tự Động Travel Dressrosa:", State)
end)

Tabs.Farm:AddToggle("AutoZou", {
    Title = "Tự Động Zou Nhiệm Vụ", 
    Default = false 
}):OnChanged(function(State)
    print("Tự Động Zou Nhiệm Vụ:", State)
end)


-- Khu vực 2: Miscellanea / Nhiệm Vụ
local SectionMisc = Tabs.Farm:AddSection("Miscellanea / Nhiệm Vụ")

Tabs.Farm:AddToggle("AutoNearest", {
    Title = "Tự Động Cày Gần Nhất", 
    Default = false 
}):OnChanged(function(State)
    print("Tự Động Cày Gần Nhất:", State)
end)

Tabs.Farm:AddToggle("AutoFactory", {
    Title = "Tự Động Factory Raid", 
    Default = false 
}):OnChanged(function(State)
    print("Tự Động Factory Raid:", State)
end)

-- 4. Hoàn tất khởi tạo và tự động mở Tab đầu tiên
Window:SelectTab(1)
Fluent:Notify({
    Title = "BANANA CAT HUB",
    Content = "Đã tải giao diện thành công!",
    Duration = 5
})
