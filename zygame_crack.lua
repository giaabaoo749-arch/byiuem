-- ========================================================
-- ZYGAME_CRACK - BẢN HOÀN CHỈNH (FULL FEATURES)
-- ========================================================
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

-- Khai báo biến
getgenv().AutoFarm = false; getgenv().AutoSkills = false; getgenv().AutoHaki = false; 
getgenv().BringMobs = false; getgenv().AntiAFK = false; getgenv().AutoAttackEnabled = false;
getgenv().AutoReset = false; getgenv().TweenSpeed = 0.5; getgenv().SelectedWeapon = "Melee"
getgenv().AutoStats = false; getgenv().AutoObservation = false;

local LocalPlayer = game:GetService("Players").LocalPlayer
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- Vòng lặp chính
task.spawn(function()
    while true do task.wait(0.2)
        if getgenv().AutoFarm then
            pcall(function()
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                
                if getgenv().AutoObservation then
                    pcall(function() if not LocalPlayer.Character:FindFirstChild("HasObservation") then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ken") end end)
                end
                
                local enemies = workspace:FindFirstChild("Enemies") or workspace:FindFirstChild("NPCs")
                if getgenv().BringMobs and enemies then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            if (v.HumanoidRootPart.Position - hrp.Position).Magnitude < 150 then
                                v.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 0, -3)
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- Tạo giao diện
local Tabs = {
    Farm = Window:AddTab({Title = "Farm", Icon = "home"}),
    Config = Window:AddTab({Title = "Config", Icon = "settings"})
}

Tabs.Farm:AddToggle("AutoFarm", {Title = "🚀 Auto Farm", Default = false}):OnChanged(function(S) getgenv().AutoFarm = S end)
Tabs.Farm:AddToggle("BringMobs", {Title = "🧲 Gom quái", Default = false}):OnChanged(function(S) getgenv().BringMobs = S end)
Tabs.Farm:AddToggle("AutoObservation", {Title = "👁️ Auto Haki Quan Sát", Default = false}):OnChanged(function(S) getgenv().AutoObservation = S end)

Tabs.Config:AddDropdown("WeaponSelect", {
    Title = "Chọn vũ khí",
    Values = {"Melee", "Fruit", "Sword", "Gun"},
    Default = 1,
}):OnChanged(function(V) getgenv().SelectedWeapon = V end)

Tabs.Config:AddButton({
    Title = "Ẩn/Hiện Menu",
    Description = "Nhấn để thu gọn hoặc mở Menu",
    Callback = function() Window:Minimize() end
})

Tabs.Config:AddSection("Trang trí")
Tabs.Config:AddImage({
    Image = "rbxassetid://114663536419764",
    Size = 100
})

Fluent:Notify({Title = "Zygame_Crack", Content = "Hệ thống đã sẵn sàng!", Duration = 5})
