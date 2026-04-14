--[[
    ╔══════════════════════════════════════════════════════════════╗
    ║                   SynthZXSHub                                ║
    ║        Clean Server Hopper + Brainrot Scanner                ║
    ║                  volt.bz                                     ║
    ╚══════════════════════════════════════════════════════════════╝
]]

-- Services
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")

-- Player
local LocalPlayer = Players.LocalPlayer
local PlaceId = game.PlaceId
local JobId = game.JobId

-- Target list (All Known Brainrots)
local TARGET_BRAINROTS = {
    "67", "eviledon", "esok-sekolah", "la-grande-combinasion", "los-puggies", "los-combinasionas",
    "spaghetti-tualetti", "los-mobilis", "los-burritos", "los-bros", "los-spaghettis",
    "los-spooky-combinasionas", "los-nooo-my-hotspotsitos", "mariachi-corazoni", "los-67",
    "los-primos", "los-cucarachas", "to-to-to-sahur", "horegini-boom", "burrito-bandito",
    "quesadilla-crocodila", "tung-tung-tung-sahur", "pot-hotspot", "los-jobcitos", "graipuss-medussi",
    "la-cucaracha", "pumpkini-spyderini", "cuadramat-and-pakrahmatmamat", "los-quesadillas",
    "guerriro-digitale", "los-tipi-tacos", "zombie-tralala", "las-tralaleritas", "los-tralaleritos",
    "chicleteira-bicicleteira", "job-job-job-sahur", "los-chicleteiras", "los-25",
    "mieteteira-bicicleteira", "tang-tang-keletang", "money-money-puggy", "los-hotspotsitos",
    "brunito-marsito", "bacuru-and-egguru", "noo-my-heart", "los-mi-gatitos", "chicleteira-cupideira",
    "rosetti-tualetti", "dj-panda", "los-sekolahs", "baskito", "churrito-bunnito", "swag-soda",
    "la-secret-combinasion", "gobblino-uniciclino", "cooki-and-milki", "strawberry-elephant",
    "burguro-and-fryuro", "dragon-cannelloni", "garama-and-madundung", "orcaledon", "nuclearo-dinossauro",
    "la-taco-combinasion", "la-spooky-grande", "w-or-l", "tralaledon", "tictac-sahur", "lavadorito-spinito",
    "la-extinct-grande", "ketchuru-and-musturu", "ketupat-kepat", "tacorita-bicicleta", "capitano-moby",
    "chicleteira-noelteira", "la-jolly-grande", "spooky-and-pumpky", "fragrama-and-chocrama",
    "chillin-chili", "chipso-and-queso", "chimnino", "los-candies", "reinito-sleighito", "la-ginger-sekolah",
    "las-sis", "la-casa-boo", "dragon-gingerini", "festive-67", "meowl", "skibidi-toilet", "jolly-jolly-sahur",
    "los-tacoritas", "ginger-gerat", "swaggy-bros", "headless-horseman", "la-supreme-combinasion",
    "money-money-reindeer", "los-jolly-combinasionas", "tuff-toucan", "fishino-clownino", "donkeyturbo-express",
    "cerberus", "hydra-dragon-cannelloni", "ketupat-bros", "popcuru-and-fizzuru", "rosey-and-teddy",
    "la-romantic-grande", "los-amigos", "sammyni-fattini", "la-food-combinasion", "signore-carapace",
    "celestial-pegasus", "antonio", "tirilikalika-tirilikalako", "elefanto-frigo", "griffin", "love-love-bear",
    "dug-dug-dug", "fortunu-and-cashuru", "foxini-lanternini", "gold-gold-gold", "hydra-bunny", "la-lucky-grande",
    "la-easter-grande", "hopilikalika-hopilikalako", "pancake-and-syrup", "boppin-bunny", "bunny-and-eggy",
    "cash-or-card", "arcadragon", "ventoliero-pavonero"
}

-------------------------------------------------
-- CLEANUP OLD GUI
-------------------------------------------------
if CoreGui:FindFirstChild("SynthZXSHub") then
    CoreGui:FindFirstChild("SynthZXSHub"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SynthZXSHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-------------------------------------------------
-- PING BAR & WATERMARK (Top Right)
-------------------------------------------------
local PingBar = Instance.new("Frame")
PingBar.Name = "PingBar"
PingBar.Size = UDim2.new(0, 150, 0, 22)
PingBar.Position = UDim2.new(1, -160, 0, 6)
PingBar.BackgroundColor3 = Color3.fromRGB(15, 20, 30)
PingBar.BackgroundTransparency = 0.2
PingBar.BorderSizePixel = 0
PingBar.Parent = ScreenGui
Instance.new("UICorner", PingBar).CornerRadius = UDim.new(0, 6)
local pStroke = Instance.new("UIStroke", PingBar)
pStroke.Color = Color3.fromRGB(40, 90, 200)

local PingLabel = Instance.new("TextLabel")
PingLabel.Size = UDim2.new(1, 0, 1, 0)
PingLabel.BackgroundTransparency = 1
PingLabel.Text = "📶 0ms  |  0 FPS"
PingLabel.TextColor3 = Color3.fromRGB(100, 180, 255)
PingLabel.TextSize = 10
PingLabel.Font = Enum.Font.GothamBold
PingLabel.Parent = PingBar

local Watermark = Instance.new("TextLabel")
Watermark.Size = UDim2.new(0, 150, 0, 20)
Watermark.Position = UDim2.new(1, -160, 0, 30)
Watermark.BackgroundTransparency = 1
Watermark.Text = "⚡ synthzxshub"
Watermark.TextColor3 = Color3.fromRGB(70, 130, 240)
Watermark.TextSize = 10
Watermark.Font = Enum.Font.GothamBold
Watermark.Parent = ScreenGui

-------------------------------------------------
-- MAIN GUI FRAME
-------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 480)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -240)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 45, 80)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 8)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -40, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "SynthZXSHub - Hopper & Scanner"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 14
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.BackgroundTransparency = 0.5
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TitleBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-------------------------------------------------
-- SERVER HOP CONTROLS
-------------------------------------------------
local HopFrame = Instance.new("Frame")
HopFrame.Size = UDim2.new(1, -20, 0, 90)
HopFrame.Position = UDim2.new(0, 10, 0, 50)
HopFrame.BackgroundColor3 = Color3.fromRGB(25, 30, 45)
HopFrame.BorderSizePixel = 0
HopFrame.Parent = MainFrame
Instance.new("UICorner", HopFrame).CornerRadius = UDim.new(0, 6)

local HopTitle = Instance.new("TextLabel")
HopTitle.Size = UDim2.new(1, -10, 0, 20)
HopTitle.Position = UDim2.new(0, 10, 0, 5)
HopTitle.BackgroundTransparency = 1
HopTitle.Text = "🌐 Server Hopper"
HopTitle.TextColor3 = Color3.fromRGB(150, 180, 255)
HopTitle.TextSize = 12
HopTitle.Font = Enum.Font.GothamSemibold
HopTitle.TextXAlignment = Enum.TextXAlignment.Left
HopTitle.Parent = HopFrame

local HopAscBtn = Instance.new("TextButton")
HopAscBtn.Size = UDim2.new(0.5, -15, 0, 40)
HopAscBtn.Position = UDim2.new(0, 10, 0, 35)
HopAscBtn.BackgroundColor3 = Color3.fromRGB(30, 70, 150)
HopAscBtn.Text = "📉 Smallest\n(Ascending)"
HopAscBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HopAscBtn.TextSize = 12
HopAscBtn.Font = Enum.Font.GothamBold
HopAscBtn.Parent = HopFrame
Instance.new("UICorner", HopAscBtn).CornerRadius = UDim.new(0, 6)

local HopDescBtn = Instance.new("TextButton")
HopDescBtn.Size = UDim2.new(0.5, -15, 0, 40)
HopDescBtn.Position = UDim2.new(0.5, 5, 0, 35)
HopDescBtn.BackgroundColor3 = Color3.fromRGB(30, 70, 150)
HopDescBtn.Text = "📈 Biggest\n(Descending)"
HopDescBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HopDescBtn.TextSize = 12
HopDescBtn.Font = Enum.Font.GothamBold
HopDescBtn.Parent = HopFrame
Instance.new("UICorner", HopDescBtn).CornerRadius = UDim.new(0, 6)

-------------------------------------------------
-- SCANNER CONTROLS
-------------------------------------------------
local ScanFrame = Instance.new("Frame")
ScanFrame.Size = UDim2.new(1, -20, 1, -160)
ScanFrame.Position = UDim2.new(0, 10, 0, 150)
ScanFrame.BackgroundColor3 = Color3.fromRGB(25, 30, 45)
ScanFrame.BorderSizePixel = 0
ScanFrame.Parent = MainFrame
Instance.new("UICorner", ScanFrame).CornerRadius = UDim.new(0, 6)

local ScanBtn = Instance.new("TextButton")
ScanBtn.Size = UDim2.new(1, -20, 0, 35)
ScanBtn.Position = UDim2.new(0, 10, 0, 10)
ScanBtn.BackgroundColor3 = Color3.fromRGB(40, 100, 60)
ScanBtn.Text = "▶ Start Scanning"
ScanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ScanBtn.TextSize = 14
ScanBtn.Font = Enum.Font.GothamBold
ScanBtn.Parent = ScanFrame
Instance.new("UICorner", ScanBtn).CornerRadius = UDim.new(0, 6)

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -20, 0, 20)
StatusLabel.Position = UDim2.new(0, 10, 0, 50)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Status: Idle"
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.TextSize = 12
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = ScanFrame

local ResultsFrame = Instance.new("ScrollingFrame")
ResultsFrame.Size = UDim2.new(1, -20, 1, -85)
ResultsFrame.Position = UDim2.new(0, 10, 0, 75)
ResultsFrame.BackgroundColor3 = Color3.fromRGB(15, 20, 30)
ResultsFrame.BorderSizePixel = 0
ResultsFrame.ScrollBarThickness = 4
ResultsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ResultsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ResultsFrame.Parent = ScanFrame
Instance.new("UICorner", ResultsFrame).CornerRadius = UDim.new(0, 4)

local ResultsLayout = Instance.new("UIListLayout")
ResultsLayout.SortOrder = Enum.SortOrder.LayoutOrder
ResultsLayout.Padding = UDim.new(0, 4)
ResultsLayout.Parent = ResultsFrame

local ResultsPadding = Instance.new("UIPadding")
ResultsPadding.PaddingTop = UDim.new(0, 4)
ResultsPadding.PaddingBottom = UDim.new(0, 4)
ResultsPadding.PaddingLeft = UDim.new(0, 4)
ResultsPadding.PaddingRight = UDim.new(0, 4)
ResultsPadding.Parent = ResultsFrame

-------------------------------------------------
-- SERVER HOP LOGIC
-------------------------------------------------
local function GetServers(sortOrder)
    StatusLabel.Text = "Status: Fetching " .. sortOrder .. " servers..."
    local servers = {}
    local url = "https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=" .. sortOrder .. "&limit=100"
    
    local ok, res = pcall(function() return HttpService:JSONDecode(game:HttpGet(url)) end)
    
    if ok and res and res.data then
        for _, s in ipairs(res.data) do
            if s.id ~= JobId and s.playing and s.playing < s.maxPlayers then
                table.insert(servers, s)
            end
        end
    end
    return servers
end

HopAscBtn.MouseButton1Click:Connect(function()
    local servers = GetServers("Asc")
    if #servers > 0 then
        StatusLabel.Text = "Status: Teleporting to Smallest (" .. servers[1].playing .. " plrs)"
        TeleportService:TeleportToPlaceInstance(PlaceId, servers[1].id, LocalPlayer)
    else
        StatusLabel.Text = "Status: No servers found."
    end
end)

HopDescBtn.MouseButton1Click:Connect(function()
    local servers = GetServers("Desc")
    if #servers > 0 then
        StatusLabel.Text = "Status: Teleporting to Biggest (" .. servers[1].playing .. " plrs)"
        TeleportService:TeleportToPlaceInstance(PlaceId, servers[1].id, LocalPlayer)
    else
        StatusLabel.Text = "Status: No servers found."
    end
end)

-------------------------------------------------
-- SCANNER LOGIC
-------------------------------------------------
local scanning = false
local foundBrainrots = {}

local function AddFoundBrainrot(name, position)
    -- Avoid duplicate entries for exact same location to prevent lag
    local posString = math.floor(position.X)..", "..math.floor(position.Y)..", "..math.floor(position.Z)
    local uniqueKey = name .. "_" .. posString
    
    if foundBrainrots[uniqueKey] then return end
    foundBrainrots[uniqueKey] = true
    
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 40)
    row.BackgroundColor3 = Color3.fromRGB(30, 40, 60)
    row.BorderSizePixel = 0
    row.Parent = ResultsFrame
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 4)
    
    local lblName = Instance.new("TextLabel")
    lblName.Size = UDim2.new(1, -10, 0, 20)
    lblName.Position = UDim2.new(0, 5, 0, 2)
    lblName.BackgroundTransparency = 1
    lblName.Text = "🧠 " .. name
    lblName.TextColor3 = Color3.fromRGB(220, 255, 100)
    lblName.TextSize = 12
    lblName.Font = Enum.Font.GothamBold
    lblName.TextXAlignment = Enum.TextXAlignment.Left
    lblName.Parent = row
    
    local lblPos = Instance.new("TextLabel")
    lblPos.Size = UDim2.new(1, -10, 0, 15)
    lblPos.Position = UDim2.new(0, 5, 0, 22)
    lblPos.BackgroundTransparency = 1
    lblPos.Text = "Pos: " .. posString
    lblPos.TextColor3 = Color3.fromRGB(150, 180, 220)
    lblPos.TextSize = 10
    lblPos.Font = Enum.Font.Gotham
    lblPos.TextXAlignment = Enum.TextXAlignment.Left
    lblPos.Parent = row
    
    -- Play sound
    pcall(function()
        game:GetService("SoundService"):PlayLocalSound(Instance.new("Sound"))
    end)
end

local function ScanInternal()
    local count = 0
    
    -- 1. Scan Workspace for Models/Parts
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj.Name and obj.Name ~= "" then
            local objName = obj.Name:lower()
            for _, target in pairs(TARGET_BRAINROTS) do
                if objName:find(target:lower()) then
                    local pos = (obj:IsA("Model") and (obj.PrimaryPart and obj.PrimaryPart.Position or Vector3.new(0,0,0))) 
                                or (obj:IsA("BasePart") and obj.Position) or Vector3.new(0,0,0)
                    AddFoundBrainrot(obj.Name, pos)
                    count = count + 1
                end
            end
        end
    end
    
    -- 2. Scan Player Backpacks
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then
            local backpack = player:FindFirstChild("Backpack")
            if backpack then
                for _, item in pairs(backpack:GetChildren()) do
                    if item:IsA("Tool") and item.Name then
                        for _, target in pairs(TARGET_BRAINROTS) do
                            if item.Name:lower():find(target:lower()) then
                                local pos = player.Character.PrimaryPart and player.Character.PrimaryPart.Position or Vector3.new(0,0,0)
                                AddFoundBrainrot(item.Name .. " (" .. player.Name .. ")", pos)
                                count = count + 1
                            end
                        end
                    end
                end
            end
        end
    end
    
    return count
end

local scanThread = nil
local function StartScanning()
    if scanning then return end
    scanning = true
    ScanBtn.Text = "⏹ Stop Scanning"
    ScanBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
    
    scanThread = task.spawn(function()
        while scanning do
            StatusLabel.Text = "Status: Scanning..."
            local foundNow = ScanInternal()
            
            local totalFound = 0
            for k,v in pairs(foundBrainrots) do totalFound = totalFound + 1 end
            
            StatusLabel.Text = "Status: Active | Total Found: " .. totalFound
            task.wait(3)
        end
    end)
end

local function StopScanning()
    scanning = false
    ScanBtn.Text = "▶ Start Scanning"
    ScanBtn.BackgroundColor3 = Color3.fromRGB(40, 100, 60)
    StatusLabel.Text = "Status: Idle"
    if scanThread then
        task.cancel(scanThread)
        scanThread = nil
    end
end

ScanBtn.MouseButton1Click:Connect(function()
    if scanning then StopScanning() else StartScanning() end
end)

-------------------------------------------------
-- PING & FPS UPDATER
-------------------------------------------------
task.spawn(function()
    while ScreenGui.Parent do
        local ping = 0; pcall(function() ping = math.floor(LocalPlayer:GetNetworkPing() * 1000) end)
        local fps = 0; pcall(function() fps = math.floor(1 / RunService.RenderStepped:Wait()) end)
        
        local color = ping < 80 and "🟢" or (ping < 150 and "🟡" or "🔴")
        PingLabel.Text = color .. " " .. ping .. "ms  |  " .. fps .. " FPS"
        
        task.wait(1)
    end
end)

print("[SynthZXSHub] Hopper & Scanner Loaded.")
