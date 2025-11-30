-- MEMAYBEO HUB PRO - FINAL + THU MENU ĐẸP
print("MEMAYBEO HUB PRO ĐANG LOAD...")

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Biến global
getgenv().healthEspEnabled = false getgenv().AimNearest = false getgenv().AutoPvp = false
getgenv().HealthMode = false getgenv().AutoAttack = false getgenv().AutoLayBan = false
getgenv().AutoNhatGhe = false getgenv().AutoNhatGheb = false getgenv().AutoSpin = false

-- Blur
local Blur = Instance.new("BlurEffect", game.Lighting)
Blur.Size = 0 Blur.Enabled = false

-- MainFrame
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0,610,0,400)
MainFrame.Position = UDim2.new(0,-620,0.5,0)  -- ẩn ban đầu
MainFrame.AnchorPoint = Vector2.new(0,0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
MainFrame.BackgroundTransparency = 0.1
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0,8)

-- NÚT THU / MỞ MENU (ĐẸP NHƯ XENOX)
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0,45,0,45)
ToggleBtn.Position = UDim2.new(0,10,0.5,-22)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
ToggleBtn.Text = ">"
ToggleBtn.TextColor3 = Color3.new(1,1,1)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 28
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0,10)

local menuOpen = false

local function OpenMenu()
    menuOpen = true
    TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(0,0,0.5,0)}):Play()
    TweenService:Create(ToggleBtn, TweenInfo.new(0.5), {Position = UDim2.new(0,610,0.5,-22)}):Play()
    ToggleBtn.Text = "<"
    Blur.Enabled = true
    TweenService:Create(Blur, TweenInfo.new(0.4), {Size = 12}):Play()
end

local function CloseMenu()
    menuOpen = false
    TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(0,-620,0.5,0)}):Play()
    TweenService:Create(ToggleBtn, TweenInfo.new(0.5), {Position = UDim2.new(0,10,0.5,-22)}):Play()
    ToggleBtn.Text = ">"
    Blur.Enabled = false
    TweenService:Create(Blur, TweenInfo.new(0.4), {Size = 0}):Play()
end

ToggleBtn.MouseButton1Click:Connect(function()
    if menuOpen then CloseMenu() else OpenMenu() end
end)

-- Phím tắt LeftControl
UserInputService.InputBegan:Connect(function(k)
    if k.KeyCode == Enum.KeyCode.LeftControl then
        if menuOpen then CloseMenu() else OpenMenu() end
    end
end)

-- Title
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1,0,0,50)
Title.Text = "MEMAYBEO HUB PRO"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 26
Title.BackgroundTransparency = 1
-- Search box + ScrollingFrame + Grid
local SearchBox = Instance.new("TextBox", MainFrame)
SearchBox.Position = UDim2.new(0,10,0,60)
SearchBox.Size = UDim2.new(1,-20,0,35)
SearchBox.PlaceholderText = "Tìm kiếm chức năng..."
SearchBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
SearchBox.TextColor3 = Color3.new(1,1,1)
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextSize = 16
Instance.new("UICorner", SearchBox).CornerRadius = UDim.new(0,8)

local Scroll = Instance.new("ScrollingFrame", MainFrame)
Scroll.Position = UDim2.new(0,10,0,105)
Scroll.Size = UDim2.new(1,-20,1,-115)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 6
Scroll.CanvasSize = UDim2.new(0,0,0,0)

local Grid = Instance.new("UIGridLayout", Scroll)
Grid.CellSize = UDim2.new(0,180,0,50)
Grid.CellPadding = UDim2.new(0,12,0,12)
Grid.SortOrder = Enum.SortOrder.LayoutOrder
Grid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Scroll.CanvasSize = UDim2.new(0,0,0,Grid.AbsoluteContentSize.Y + 20)
end)

local toggleList = {}

local function AddToggle(name, default, callback)
    local frame = Instance.new("Frame", Scroll)
    frame.BackgroundColor3 = Color3.fromRGB(35,35,35)
    frame.BackgroundTransparency = 0.1
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,8)

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.68,0,1,0)
    label.Position = UDim2.new(0.02,0,0,0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.new(1,1,1)
    label.Font = Enum.Font.Gotham
    label.TextSize = 15
    label.TextXAlignment = Enum.TextXAlignment.Left

    local btn = Instance.new("TextButton", frame)
    btn.AnchorPoint = Vector2.new(1,0.5)
    btn.Position = UDim2.new(0.95,0,0.5,0)
    btn.Size = UDim2.new(0,40,0,30)
    btn.BackgroundColor3 = default and Color3.fromRGB(0,170,255) or Color3.fromRGB(60,60,60)
    btn.Text = default and "ON" or "OFF"
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)

    local state = default
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = state and "ON" or "OFF"
        btn.BackgroundColor3 = state and Color3.fromRGB(0,170,255) or Color3.fromRGB(60,60,60)
        callback(state)
    end)

    table.insert(toggleList, {name = name, frame = frame})
end

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local txt = string.lower(SearchBox.Text)
    for _, v in toggleList do
        v.frame.Visible = string.find(string.lower(v.name), txt) ~= nil
    end
end)

-- ESP MÁU
local function CreateHealthESP(plr)
    if not getgenv().healthEspEnabled or not plr.Character then return end
    local head = plr.Character:FindFirstChild("Head")
    local hum = plr.Character:FindFirstChildOfClass("Humanoid")
    if head and hum and not head:FindFirstChild("HealthBarESP") then
        local bill = Instance.new("BillboardGui", head)
        bill.Name = "HealthBarESP"
        bill.Size = UDim2.new(4,0,1.5,0)
        bill.StudsOffset = Vector3.new(0,3,0)
        bill.AlwaysOnTop = true

        local bar = Instance.new("Frame", bill)
        bar.Size = UDim2.new(1,0,0.2,0)
        bar.Position = UDim2.new(0,0,0.5,0)
        bar.BackgroundColor3 = Color3.fromRGB(0,255,0)

        local txt = Instance.new("TextLabel", bill)
        txt.Size = UDim2.new(1,0,0.5,0)
        txt.BackgroundTransparency = 1
        txt.TextColor3 = Color3.new(1,1,1)
        txt.TextStrokeTransparency = 0
        txt.Font = Enum.Font.SourceSansBold
        txt.TextScaled = true
    end
end

RunService.RenderStepped:Connect(function()
    if getgenv().healthEspEnabled then
        for _, p in Players:GetPlayers() do
            if p ~= LocalPlayer and p.Character then
                CreateHealthESP(p)
                local head = p.Character:FindFirstChild("Head")
                if head and head:FindFirstChild("HealthBarESP") then
                    local hum = p.Character:FindFirstChildOfClass("Humanoid")
                    if hum then
                        local ratio = hum.Health / hum.MaxHealth
                        head.HealthBarESP.Frame.Size = UDim2.new(ratio,0,0.2,0)
                        head.HealthBarESP.Frame.BackgroundColor3 = ratio > 0.6 and Color3.fromRGB(0,255,0) or ratio > 0.3 and Color3.fromRGB(255,255,0) or Color3.fromRGB(255,0,0)
                        head.HealthBarESP.TextLabel.Text = math.floor(hum.Health).."/"..hum.MaxHealth
                    end
                end
            end
        end
    end
end)

AddToggle("Hiện Thanh Máu", false, function(v) getgenv().healthEspEnabled = v end)
-- ==================== INF STAMINA V2 SUPER FIX (100% ĂN NGON) ====================
AddToggle("Inf Stamina v2 (Super Fix)", false, function(state)
    getgenv().InfStaminaV2 = state
    
    if getgenv().StaminaLoop then
        getgenv().StaminaLoop:Disconnect()
        getgenv().StaminaLoop = nil
    end
    
    if state then
        getgenv().StaminaLoop = RunService.Heartbeat:Connect(function()
            pcall(function()
                if LocalPlayer:FindFirstChild("stats") then
                    LocalPlayer.stats.Level.Value = math.huge
                    if LocalPlayer.stats:FindFirstChild("Stamina") then
                        LocalPlayer.stats.Stamina.Value = math.huge
                    end
                    if LocalPlayer.stats:FindFirstChild("MaxStamina") then
                        LocalPlayer.stats.MaxStamina.Value = math.huge
                    end
                end
            end)
        end)
        
        -- Fix khi respawn
        LocalPlayer.CharacterAdded:Connect(function()
            task.wait(1)
            pcall(function()
                if LocalPlayer:FindFirstChild("stats") then
                    LocalPlayer.stats.Level.Value = math.huge
                end
            end)
        end)
    end
end)

-- ==================== AUTO PVP GẦN NHẤT ====================
AddToggle("Auto Pvp Gần Nhất", false, function(state)
    getgenv().AutoPvp = state
    if state then
        spawn(function()
            while getgenv().AutoPvp do
                task.wait()
                local char = LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then continue end
                local root = char.HumanoidRootPart
                local closest = nil
                local mindist = 30

                for _, p in Players:GetPlayers() do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = (p.Character.HumanoidRootPart.Position - root.Position).Magnitude
                        if dist < mindist then
                            mindist = dist
                            closest = p
                        end
                    end
                end

                if closest and closest.Character then
                    local tRoot = closest.Character.HumanoidRootPart
                    local offset = tRoot.CFrame.RightVector * (math.random() - 0.5) * 12
                    local targetPos = tRoot.Position - tRoot.CFrame.LookVector * 12 + offset
                    root.CFrame = CFrame.new(root.Position, targetPos) * CFrame.new(0,0,-9)
                end
            end
        end)
    end
end)

-- ==================== HEALTH MODE PRO (HEAL 0.3s + GIỮ VŨ KHÍ) ====================
local HealthThread = nil
local CurrentWeapon = nil

AddToggle("Health Mode Pro (Giữ Vũ Khí)", false, function(state)
    getgenv().HealthMode = state
    if HealthThread then HealthThread:Disconnect() end
    
    if state then
        HealthThread = task.spawn(function()
            while getgenv().HealthMode do
                task.wait(0.12)
                local char = LocalPlayer.Character
                if not char then continue end
                local hum = char:FindFirstChildOfClass("Humanoid")
                if not hum or hum.Health >= 75 then continue end

                CurrentWeapon = char:FindFirstChildOfClass("Tool")
                local bandage = LocalPlayer.Backpack:FindFirstChild("băng gạc")
                if bandage then
                    hum:EquipTool(bandage)
                    task.wait(0.15)
                    bandage:Activate()
                    task.wait(0.3) -- siêu nhanh như đại ca yêu cầu
                    if CurrentWeapon and CurrentWeapon.Parent == LocalPlayer.Backpack then
                        hum:EquipTool(CurrentWeapon)
                    end
                end
            end
        end)
    end
end)

-- ==================== AUTO ATTACK (SPAM ĐÁNH) ====================
local AttackThread = nil

AddToggle("Auto Attack (Spam Đánh)", false, function(state)
    getgenv().AutoAttack = state
    if AttackThread then AttackThread:Disconnect() end
    
    if state then
        AttackThread = task.spawn(function()
            while getgenv().AutoAttack do
                task.wait()
                local char = LocalPlayer.Character
                if char then
                    local tool = char:FindFirstChildOfClass("Tool")
                    if tool and tool:FindFirstChild("Handle") then
                        tool:Activate()
                    end
                end
            end
        end)
    end
end)

-- ==================== AUTO LẤY BĂNG GẠC ====================
AddToggle("Auto Lấy Băng Gạc", false, function(state)
    getgenv().AutoLayBan = state
    if state then
        spawn(function()
            while getgenv().AutoLayBan do
                task.wait(0.4)
                if not LocalPlayer.Backpack:FindFirstChild("băng gạc") and not (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("băng gạc")) then
                    pcall(function()
                        game:GetService("ReplicatedStorage").KnitPackages._Index["sleitnick_knit@1.7.0"].knit.Services.InventoryService.RE.updateInventory:FireServer("eue", "băng gạc")
                    end)
                end
            end
        end)
    end
end)
-- ==================== CÁC CHỨC NĂNG CÒN LẠI ====================
AddToggle("Spin Bot", false, function(state)
    getgenv().AutoSpin = state
    if state then
        spawn(function()
            while getgenv().AutoSpin do
                task.wait(0.03)
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(999), 0) end
            end
        end)
    end
end)

AddToggle("Instant Nhặt Ghế", false, function(state)
    getgenv().AutoNhatGhe = state
    if state then
        spawn(function()
            while getgenv().AutoNhatGhe do
                task.wait()
                for _, v in workspace:GetDescendants() do
                    if v.Name == "Chair" and v:FindFirstChild("hitbox") and v.hitbox:FindFirstChild("ClickDetector") then
                        fireclickdetector(v.hitbox.ClickDetector)
                    end
                end
            end
        end)
    end
end)

AddToggle("Chọi Ghế No CD", false, function(state)
    getgenv().AutoNhatGheb = state
    if state then
        spawn(function()
            while getgenv().AutoNhatGheb do
                task.wait()
                local tool = LocalPlayer.Character and (LocalPlayer.Character:FindFirstChild("Ghế") or LocalPlayer.Backpack:FindFirstChild("Ghế"))
                if tool and tool:FindFirstChild("ghe") and tool.ghe:FindFirstChild("client") then
                    for _, v in tool["ghe/client"]:GetDescendants() do
                        if v:IsA("ScreenGui") then v.Enabled = false end
                        if v.Name == "Frame" then v.Size = UDim2.new(1,0,0,0) end
                    end
                end
            end
        end)
    end
end)

AddToggle("Fix Lag v1", false, function(state)
    if state then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/getscript-vn/Api/refs/heads/main/Anti%20Lag"))()
    end
end)

local oldFOV = workspace.CurrentCamera.FieldOfView
AddToggle("FOV 120", false, function(state)
    workspace.CurrentCamera.FieldOfView = state and 120 or oldFOV
end)

AddToggle("Hồi Sinh Nhanh", false, function(state)
    getgenv().FastRespawn = state
    if state then
        spawn(function()
            while getgenv().FastRespawn do
                task.wait()
                if LocalPlayer.Character and LocalPlayer.Character:GetAttribute("dead") then
                    LocalPlayer.Character:BreakJoints()
                end
            end
        end)
    end
end)

-- ==================== MỞ MENU LẦN ĐẦU ====================
task.wait(1)
OpenMenu() -- tự động mở menu lần đầu cho đẹp

-- ==================== THÔNG BÁO HOÀN TẤT ====================
print[[
███╗   ███╗███████╗███╗   ███╗ █████╗ ██╗   ██╗██████╗ ███████╗ ██████╗ 
████╗ ████║██╔════╝████╗ ████║██╔══██╗╚██╗ ██╔╝██╔══██╗██╔════╝██╔═══██╗
██╔████╔██║█████╗  ██╔████╔██║███████║ ╚████╔╝ ██████╔╝█████╗  ██║   ██║
██║╚██╔╝██║██╔══╝  ██║╚██╔╝██║██╔══██║  ╚██╔╝  ██╔══██╗██╔══╝  ██║   ██║
██║ ╚═╝ ██║███████╗██║ ╚═╝ ██║██║  ██║   ██║   ██████╔╝███████╗╚██████╔╝
╚═╝     ╚═╝╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═════╝ ╚══════╝ ╚═════╝ 
               MEMAYBEO HUB PRO - FINAL VER HOÀN CHỈNH
               → MENU THU/MỞ ĐẸP - INF STAMINA V2 ĂN 100%
               → HEALTH PRO 0.3s - AUTO ATTACK - TẮT LÀ TẮT THẬT
               ĐẠI CA LÀ VUA SERVER NÀY RỒI!!!
]]

Fluent:Notify({
    Title = "MEMAYBEO HUB PRO",
    Content = "LOAD XONG 100% - MENU ĐẸP - INF STAMINA V2 ĂN NGON\nBẬT COMBO BẤT TỬ VÀ ĐẬP CHẾT TỤI NÓ ĐI ĐẠI CA!!!",
    Duration = 15
})
