local MenuModule = require(script.Parent.MenuModule)
local UserInputService = game:GetService("UserInputService")

local player = game.Players.LocalPlayer
local gui = player.PlayerGui:WaitForChild("Zygame_crack")

-- Khởi tạo với các thành phần UI
local myMenu = MenuModule.new(
    gui.MainFrame, 
    gui.MainFrame.FixLagBtn, 
    gui.MainFrame.PasswordInput, 
    gui.MainFrame.LoginBtn
)

-- Phím tắt bật/tắt
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert then
        myMenu:Toggle()
    end
end)
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local Zygame = {}
Zygame.__index = Zygame

function Zygame.new(mainFrame, fixLagBtn, passwordInput, loginBtn)
    local self = setmetatable({}, Zygame)
    
    self.Visible = false
    self.IsLoggedIn = false
    self.MainFrame = mainFrame
    self.FixLagBtn = fixLagBtn
    
    -- Xử lý đăng nhập
    loginBtn.MouseButton1Click:Connect(function()
        if passwordInput.Text == "zygame_crack" then
            self.IsLoggedIn = true
            passwordInput.Text = "Login Success!"
            loginBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        else
            passwordInput.Text = "Wrong Password!"
        end
    end)

    -- Xử lý Fix Lag
    self.FixLagBtn.MouseButton1Click:Connect(function()
        if self.IsLoggedIn then
            self:ExecuteFixLag()
        else
            warn("Zygame_crack: Vui lòng đăng nhập trước!")
        end
    end)
    
    return self
end

function Zygame:ExecuteFixLag()
    Lighting.GlobalShadows = false
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Fire") or obj:IsA("Smoke") then
            obj.Enabled = false
        end
    end
    print("Zygame_crack: Tối ưu hóa hoàn tất!")
end

function Zygame:Toggle()
    self.Visible = not self.Visible
    self.MainFrame.Visible = self.Visible
    UserInputService.MouseBehavior = self.Visible and Enum.MouseBehavior.Default or Enum.MouseBehavior.LockCenter
end

return Zygame
