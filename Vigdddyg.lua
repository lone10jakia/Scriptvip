-- MEMAYBEO HUB - Giang Ho 2 (Full No Key - 30/11/2025)

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "MEMAYBEO HUB",
    SubTitle = "By MEMAYBEO",
    TabWidth = 160,
    Size = UDim2.fromOffset(560, 360),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer
local Tabs = {
    Main      = Window:AddTab({ Title = "Auto Băng Gạc", Icon = "package" }),
    Boss      = Window:AddTab({ Title = "Farm Boss", Icon = "sword" }),
    PvP       = Window:AddTab({ Title = "PvP", Icon = "swords" }),
    Money     = Window:AddTab({ Title = "Fram Tiền", Icon = "dollar-sign" }),
    Webhook   = Window:AddTab({ Title = "Webhook", Icon = "link" }),
    FixLag    = Window:AddTab({ Title = "Fix Lag", Icon = "cpu" }),
    Settings  = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- Biến Auto Băng Gạc
local AutoBandage = false
local AutoBuyBandage = false
local CanUseBandage = true

Tabs.Main:AddToggle("AutoBandage", {
    Title = "Auto Băng Gạc (HP < 80)",
    Default = false,
    Callback = function(v) AutoBandage = v end
})

Tabs.Main:AddToggle("AutoBuy", {
    Title = "Auto Mua Băng Gạc (5s/lần)",
    Default = false,
    Callback = function(v) AutoBuyBandage = v end
})

-- Auto mua băng gạc
task.spawn(function()
    while task.wait(5) do
        if AutoBuyBandage then
            pcall(function()
                ReplicatedStorage.KnitPackages._Index["sleitnick_knit@1.7.0"].knit.Services.ShopService.RE.buyItem:FireServer("băng gạc", 5)
            end)
        end
    end
end)

-- Auto dùng băng gạc
task.spawn(function()
    while task.wait(1) do
        if AutoBandage and CanUseBandage and LocalPlayer.Character then
            local Hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if Hum and Hum.Health < 80 then
                CanUseBandage = false
                local Backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
                if Backpack and not Backpack:FindFirstChild("băng gạc") then
                    pcall(function()
                        ReplicatedStorage.KnitPackages._Index["sleitnick_knit@1.7.0"].knit.Services.InventoryService.RE.updateInventory:FireServer("eue", "băng gạc")
                    end)
                    task.wait(1.5)
                end

                local Tool = Backpack:FindFirstChild("băng gạc") or LocalPlayer.Character:FindFirstChild("băng gạc")
                if Tool then
                    Hum:EquipTool(Tool)
                    task.wait(0.4)
                    Tool:Activate()
                    repeat task.wait(0.8) until Hum.Health >= 100 or not AutoBandage
                    task.wait(1)
                end
                CanUseBandage = true
            end
        end
    end
end)
-- Farm Boss
local SelectedWeapon = nil
local AutoFarm = false
local AutoLoot = false
local Radius = 17
local SpinSpeed = 35

local WeaponBtn = Tabs.Boss:AddButton({
    Title = "Chọn Vũ Khí",
    Description = "Hiện tại: None",
    Callback = function()
        local buttons = {}
        for _, tool in ipairs(LocalPlayer.Backpack:GetChildren()) do
            if tool:IsA("Tool") then
                table.insert(buttons, {Title = tool.Name, Callback = function()
                    SelectedWeapon = tool.Name
                    WeaponBtn:SetDesc("Hiện tại: "..tool.Name)
                    Fluent:Notify({Title="Vũ khí", Content="Đã chọn: "..tool.Name})
                end})
            end
        end
        for _, tool in ipairs(LocalPlayer.Character:GetChildren()) do
            if tool:IsA("Tool") then
                table.insert(buttons, {Title = tool.Name, Callback = function()
                    SelectedWeapon = tool.Name
                    WeaponBtn:SetDesc("Hiện tại: "..tool.Name)
                    Fluent:Notify({Title="Vũ khí", Content="Đã chọn: "..tool.Name})
                end})
            end
        end
        Fluent:Dialog({Title = "Chọn vũ khí farm boss", Buttons = buttons})
    end
})

Tabs.Boss:AddToggle("AutoFarmBoss", {Title = "Auto Farm Boss", Default = false, Callback = function(v) AutoFarm = v end})
Tabs.Boss:AddToggle("AutoLoot", {Title = "Auto Loot (500 studs)", Default = false, Callback = function(v) AutoLoot = v end})

Tabs.Boss:AddInput("RadiusInput", {Title = "Bán kính quay", Default = "17", Numeric = true, Callback = function(v) Radius = tonumber(v) or 17 end})
Tabs.Boss:AddInput("SpeedInput", {Title = "Tốc độ quay", Default = "35", Numeric = true, Callback = function(v) SpinSpeed = tonumber(v) or 35 end})

-- Equip vũ khí tự động
task.spawn(function()
    while task.wait(1) do
        if AutoFarm and SelectedWeapon then
            local tool = LocalPlayer.Backpack:FindFirstChild(SelectedWeapon) or LocalPlayer.Character:FindFirstChild(SelectedWeapon)
            if tool and tool.Parent == LocalPlayer.Backpack then
                tool.Parent = LocalPlayer.Character
            end
        end
    end
end)

-- Auto Farm Boss
task.spawn(function()
    while task.wait() do
        if AutoFarm and SelectedWeapon then
            for _, npc in pairs(workspace.GiangHo2.NPCs:GetChildren()) do
                if npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 and npc:FindFirstChild("HumanoidRootPart") then
                    local root = npc.HumanoidRootPart
                    local angle = 0
                    repeat
                        angle += SpinSpeed * task.wait()
                        local pos = root.Position + Vector3.new(math.cos(angle) * Radius, 0, math.sin(angle) * Radius)
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.lookAt(pos + Vector3.new(0,2,0), root.Position)
                        VirtualUser:CaptureController()
                        VirtualUser:Button1Down(Vector2.new())
                        task.wait()
                    until not AutoFarm or not npc.Parent or npc.Humanoid.Health <= 0
                end
            end
        end
    end
end)

-- Auto Loot
task.spawn(function()
    while task.wait(0.5) do
        if AutoLoot and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            for _, drop in pairs(workspace.GiangHo2.Drop:GetChildren()) do
                local pp = drop:FindFirstChildOfClass("ProximityPrompt")
                if pp and (drop.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 500 then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = drop.CFrame
                    fireproximityprompt(pp)
                    task.wait(0.1)
                end
            end
        end
    end
end)

Tabs.Boss:AddButton({Title = "Tele đến Boss", Callback = function()
    LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-2572.62, 279.99, -1368.59)
end})
-- Webhook Detector
local WebhookURL = ""
local DetectorOn = false
local Detected = {}

Tabs.Webhook:AddInput("Webhook", {Title = "Dán Webhook URL", Placeholder = "https://discord.com/api/webhooks/...",
    Callback = function(url) WebhookURL = url end})

Tabs.Webhook:AddToggle("Detector", {Title = "Bật Detector Cash/Chest", Default = false,
    Callback = function(v)
        DetectorOn = v
        if v then Fluent:Notify({Title="Detector", Content="Đang theo dõi Cash & Chest!"}) end
    end})

RunService.Heartbeat:Connect(function()
    if not DetectorOn then return end
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    local myPos = LocalPlayer.Character.HumanoidRootPart.Position

    for _, obj in ipairs(workspace:GetDescendants()) do
        if (obj.Name == "Cash" or obj.Name == "Chest") and not Detected[obj] then
            local pos = obj:IsA("BasePart") and obj.Position or (obj:FindFirstChildWhichIsA("BasePart") and obj:FindFirstChildWhichIsA("BasePart").Position)
            if pos and (pos - myPos).Magnitude <= 80 then
                Detected[obj] = true
                if WebhookURL ~= "" then
                    request({
                        Url = WebhookURL,
                        Method = "POST",
                        Headers = {["Content-Type"] = "application/json"},
                        Body = game:GetService("HttpService"):JSONEncode({
                            embeds = {{title = "Item Phát Hiện!", description = "Phát hiện **"..obj.Name.."** gần bạn!", color = 65280,
                                fields = {
                                    {name = "Thời gian", value = os.date("%H:%M:%S"), inline = true},
                                    {name = "Người chơi", value = LocalPlayer.Name, inline = true}
                                }
                            }}
                        })
                    })
                end
            end
        end
    end
end)

-- Fix Lag
local function FixLag(level)
    local L = game:GetService("Lighting")
    if level >= 10 then L.GlobalShadows = false; L.FogEnd = 9e9 end
    if level >= 30 then for _, e in ipairs(L:GetChildren()) do if e:IsA("PostEffect") then e.Enabled = false end end end
    if level >= 50 then for _, p in ipairs(workspace:GetDescendants()) do if p:IsA("ParticleEmitter") or p:IsA("Trail") then p.Enabled = false end end end
    Fluent:Notify({Title="Fix Lag", Content="Đã tối ưu "..level.."%"})
end

for _, p in {10,30,50,70,90} do
    Tabs.FixLag:AddButton({Title = "Fix Lag "..p.."%", Callback = function() FixLag(p) end})
end
-- PvP Features
local SpinOn = false
local SpinSpeedVal = 5
local ESPOn = false
local AimOn = false
local Target = nil

Tabs.PvP:AddSlider("SpinSpeed", {Title = "Tốc độ Spin", Min = 1, Max = 100, Default = 5, Callback = function(v) SpinSpeedVal = v end})

Tabs.PvP:AddToggle("Spin", {Title = "PvP Spin", Default = false, Callback = function(v)
    SpinOn = v
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.AutoRotate = not v
    end
end})

RunService.RenderStepped:Connect(function()
    if SpinOn and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame *= CFrame.Angles(0, math.rad(SpinSpeedVal), 0)
    end
end)

Tabs.PvP:AddToggle("ESP", {Title = "ESP Tên + Line", Default = false, Callback = function(v) ESPOn = v end})

-- ESP đơn giản
task.spawn(function()
    while task.wait(1) do
        if ESPOn then
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
                    if not plr.Character.Head:FindFirstChild("ESPBillboard") then
                        local bill = Instance.new("BillboardGui", plr.Character.Head)
                        bill.Name = "ESPBillboard"
                        bill.Size = UDim2.new(0,200,0,50)
                        bill.Adornee = plr.Character.Head
                        bill.AlwaysOnTop = true
                        local text = Instance.new("TextLabel", bill)
                        text.Text = plr.Name
                        text.BackgroundTransparency = 1
                        text.TextColor3 = Color3.new(1,0,0)
                        text.TextScaled = true
                    end
                end
            end
        else
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr.Character and plr.Character:FindFirstChild("Head") and plr.Character.Head:FindFirstChild("ESPBillboard") then
                    plr.Character.Head.ESPBillboard:Destroy()
                end
            end
        end
    end
end)

-- Aim
Tabs.PvP:AddButton({Title = "Chọn Target Aim", Callback = function()
    local list = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            table.insert(list, {Title = p.Name, Callback = function() Target = p.Name end})
        end
    end
    Fluent:Dialog({Title = "Chọn người aim", Buttons = list})
end})

RunService.RenderStepped:Connect(function()
    if AimOn and Target then
        local tar = Players:FindFirstChild(Target)
        if tar and tar.Character and tar.Character:FindFirstChild("Head") and LocalPlayer.Character then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.Position, tar.Character.Head.Position)
        end
    end
end)

Tabs.PvP:AddToggle("AimToggle", {Title = "Bật Aim", Default = false, Callback = function(v) AimOn = v end})
-- Anti AFK
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- Money Tracker
local MoneyPara = Tabs.Money:AddParagraph({Title = "Đã farm", Content = "0 VND"})
local TotalPara = Tabs.Money:AddParagraph({Title = "Tổng tiền", Content = "0 VND"})
local old = LocalPlayer.leaderstats.VND.Value
LocalPlayer.leaderstats.VND:GetPropertyChangedSignal("Value"):Connect(function()
    local new = LocalPlayer.leaderstats.VND.Value
    if new > old then
        local earned = new - old
        MoneyPara:SetDesc("Đã farm: "..string.format("%.,d", earned).." VND")
        TotalPara:SetDesc("Tổng tiền: "..string.format("%.,d", new).." VND")
        old = new
    end
end)

-- Settings + Save
InterfaceManager:SetLibrary(Fluent)
SaveManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetFolder("MEMAYBEOHUB")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)
Fluent:Notify({Title = "MEMAYBEO HUB", Content = "Đã load xong – Chúc farm boss ngon lành!", Duration = 8})
