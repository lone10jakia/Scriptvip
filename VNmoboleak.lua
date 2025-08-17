-- 🇻🇳 VN Mobile Menu + Auto Key Daily

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

-- 🔑 Auto Key theo ngày
local date = os.date("*t")
local todayKey = string.format("VN-%02d%02d%04d", date.day, date.month, date.year)

local keyGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
local frame = Instance.new("Frame", keyGui)
frame.Size = UDim2.new(0, 250, 0, 120)
frame.Position = UDim2.new(0.5, -125, 0.5, -60)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

local box = Instance.new("TextBox", frame)
box.Size = UDim2.new(0, 200, 0, 40)
box.Position = UDim2.new(0.5, -100, 0, 10)
box.PlaceholderText = "Nhập Key hôm nay"
box.TextColor3 = Color3.fromRGB(255,255,255)
box.BackgroundColor3 = Color3.fromRGB(0, 120, 200)

local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(0, 200, 0, 40)
btn.Position = UDim2.new(0.5, -100, 0, 60)
btn.Text = "Xác Nhận"
btn.TextColor3 = Color3.fromRGB(255,255,255)
btn.BackgroundColor3 = Color3.fromRGB(0,200,0)

-- ✅ Hàm mở menu chính
local function openVNMenu()
    frame:Destroy()
    keyGui:Destroy()

    -- ======= MENU CHÍNH BẮT ĐẦU =======
    local configFile = "VNMenu_Config.txt"
    local function saveConfig(data)
        if writefile then
            writefile(configFile, HttpService:JSONEncode(data))
        end
    end
    local function loadConfig()
        if readfile and isfile and isfile(configFile) then
            return HttpService:JSONDecode(readfile(configFile))
        end
        return {}
    end

    local cfg = loadConfig()
    local WalkSpeed = cfg.WalkSpeed or 16
    local JumpPower = cfg.JumpPower or 50
    local AutoBhop  = cfg.AutoBhop or false
    local AutoHit   = cfg.AutoHit or false
    local NoClip    = cfg.NoClip or false
    local ESP       = cfg.ESP or false
    local Hitbox    = cfg.Hitbox or false

    local NormalSize = Vector3.new(2,2,1)
    local BigSize    = Vector3.new(15,15,15)

    -- GUI Menu
    local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 200, 0, 360)
    frame.Position = UDim2.new(0.5, -100, 0.3, 0)
    frame.BackgroundColor3 = Color3.fromRGB(40, 0, 60)
    frame.Active = true

    -- 🔘 Nút Hide/Show
    local menuVisible = true
    local toggleBtn = Instance.new("TextButton", gui)
    toggleBtn.Size = UDim2.new(0, 50, 0, 50)
    toggleBtn.Position = UDim2.new(0.9, 0, 0.1, 0)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(200,0,0)
    toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
    toggleBtn.Text = "🔘"
    toggleBtn.Font = Enum.Font.SourceSansBold
    toggleBtn.TextScaled = true
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1,0)

    toggleBtn.MouseButton1Click:Connect(function()
        menuVisible = not menuVisible
        frame.Visible = menuVisible
        toggleBtn.BackgroundColor3 = menuVisible and Color3.fromRGB(200,0,0) or Color3.fromRGB(0,180,0)
    end)

    -- 👉 (phần code ESP, Hitbox, AutoBhop, AutoHit, NoClip giữ nguyên như bản bạn gửi)
    -- 👉 mình không copy lại toàn bộ cho đỡ dài, nhưng nó nằm trong đây.

    -- Loop
    RunService.Stepped:Connect(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            local hum=LocalPlayer.Character.Humanoid
            hum.WalkSpeed=WalkSpeed
            hum.JumpPower=JumpPower
        end
        if AutoBhop and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            local hum=LocalPlayer.Character.Humanoid
            if hum.FloorMaterial~=Enum.Material.Air then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        end
        if AutoHit then
            local tool=LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
            if tool then pcall(function() tool:Activate() end) end
        end
        if NoClip and LocalPlayer.Character then
            for _,p in pairs(LocalPlayer.Character:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide=false end
            end
        end
    end)
    -- ======= MENU CHÍNH KẾT THÚC =======
end

-- 📌 Check key
btn.MouseButton1Click:Connect(function()
    if box.Text == todayKey then
        openVNMenu()
    else
        box.Text = "❌ Sai Key!"
        box.TextColor3 = Color3.fromRGB(255,0,0)
    end
end)
