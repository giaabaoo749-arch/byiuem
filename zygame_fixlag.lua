-- Zygame_crack: All-in-one script
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Player = game.Players.LocalPlayer
local Gui = Player.PlayerGui:WaitForChild("Zygame_crack")

local MainFrame = Gui.MainFrame
local FixLagBtn = MainFrame.FixLagBtn
local PassInput = MainFrame.PasswordInput
local LoginBtn = MainFrame.LoginBtn

local IsLoggedIn = false
local IsVisible = false

-- Logic Fix Lag
local function ExecuteFixLag()
    Lighting.GlobalShadows = false
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Fire") or obj:IsA("Smoke") then
            obj.Enabled = false
        end
    end
    print("Zygame_crack: Optimization Done!")
end

-- Login
LoginBtn.MouseButton1Click:Connect(function()
    if PassInput.Text == "zygame_crack" then
        IsLoggedIn = true
        PassInput.Text = "Login Success!"
    else
        PassInput.Text = "Wrong Password!"
    end
end)

-- Execute
FixLagBtn.MouseButton1Click:Connect(function()
    if IsLoggedIn then ExecuteFixLag() else warn("Vui lòng đăng nhập!") end
end)

-- Toggle Menu
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.Insert then
        IsVisible = not IsVisible
        MainFrame.Visible = IsVisible
        UserInputService.MouseBehavior = IsVisible and Enum.MouseBehavior.Default or Enum.MouseBehavior.LockCenter
    end
end)
