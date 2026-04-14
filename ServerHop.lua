--[[
    ╔══════════════════════════════════════════════════════════════╗
    ║                   SynthZXSHub                                ║
    ║          Server Hop + Auto Scanner for Steal a Brainrot      ║
    ║                     volt.bz executor                         ║
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

-------------------------------------------------
-- BRAINROT DATABASE (with values)
-- 0 = RARE / HIGH VALUE
-- 1000000000 = COMMON
-- 500000000 = MID-TIER
-------------------------------------------------

local BRAINROT_DB = {
    -- RARE (Value = 0) -- HIGH PRIORITY
    ["eviledon"] = 0,
    ["swag-soda"] = 0,
    ["la-secret-combinasion"] = 0,
    ["gobblino-uniciclino"] = 0,
    ["cooki-and-milki"] = 0,
    ["strawberry-elephant"] = 0,
    ["burguro-and-fryuro"] = 0,
    ["dragon-cannelloni"] = 0,
    ["garama-and-madundung"] = 0,
    ["orcaledon"] = 0,
    ["nuclearo-dinossauro"] = 0,
    ["la-taco-combinasion"] = 0,
    ["la-spooky-grande"] = 0,
    ["w-or-l"] = 0,
    ["tralaledon"] = 0,
    ["tictac-sahur"] = 0,
    ["lavadorito-spinito"] = 0,
    ["la-extinct-grande"] = 0,
    ["ketchuru-and-musturu"] = 0,
    ["ketupat-kepat"] = 0,
    ["tacorita-bicicleta"] = 0,
    ["capitano-moby"] = 0,
    ["chicleteira-noelteira"] = 0,
    ["la-jolly-grande"] = 0,
    ["spooky-and-pumpky"] = 0,
    ["fragrama-and-chocrama"] = 0,
    ["chillin-chili"] = 0,
    ["chipso-and-queso"] = 0,
    ["chimnino"] = 0,
    ["los-candies"] = 0,
    ["reinito-sleighito"] = 0,
    ["la-ginger-sekolah"] = 0,
    ["las-sis"] = 0,
    ["la-casa-boo"] = 0,
    ["dragon-gingerini"] = 0,
    ["festive-67"] = 0,
    ["meowl"] = 0,
    ["skibidi-toilet"] = 0,
    ["jolly-jolly-sahur"] = 0,
    ["los-tacoritas"] = 0,
    ["ginger-gerat"] = 0,
    ["swaggy-bros"] = 0,
    ["headless-horseman"] = 0,
    ["la-supreme-combinasion"] = 0,
    ["money-money-reindeer"] = 0,
    ["los-jolly-combinasionas"] = 0,
    ["tuff-toucan"] = 0,
    ["fishino-clownino"] = 0,
    ["donkeyturbo-express"] = 0,
    ["cerberus"] = 0,
    ["hydra-dragon-cannelloni"] = 0,
    ["ketupat-bros"] = 0,
    ["popcuru-and-fizzuru"] = 0,
    ["rosey-and-teddy"] = 0,
    ["la-romantic-grande"] = 0,
    ["los-amigos"] = 0,
    ["sammyni-fattini"] = 0,
    ["la-food-combinasion"] = 0,
    ["signore-carapace"] = 0,
    ["celestial-pegasus"] = 0,
    ["antonio"] = 0,
    ["tirilikalika-tirilikalako"] = 0,
    ["elefanto-frigo"] = 0,
    ["griffin"] = 0,
    ["love-love-bear"] = 0,
    ["dug-dug-dug"] = 0,
    ["fortunu-and-cashuru"] = 0,
    ["foxini-lanternini"] = 0,
    ["gold-gold-gold"] = 0,
    ["hydra-bunny"] = 0,
    ["la-lucky-grande"] = 0,
    ["la-easter-grande"] = 0,
    ["hopilikalika-hopilikalako"] = 0,
    ["pancake-and-syrup"] = 0,
    ["boppin-bunny"] = 0,
    ["bunny-and-eggy"] = 0,
    ["cash-or-card"] = 0,
    ["arcadragon"] = 0,

    -- MID-TIER (Value = 500M)
    ["ventoliero-pavonero"] = 500000000,

    -- COMMON (Value = 1B)
    ["67"] = 1000000000,
    ["esok-sekolah"] = 1000000000,
    ["la-grande-combinasion"] = 1000000000,
    ["los-puggies"] = 1000000000,
    ["los-combinasionas"] = 1000000000,
    ["spaghetti-tualetti"] = 1000000000,
    ["los-mobilis"] = 1000000000,
    ["los-burritos"] = 1000000000,
    ["los-bros"] = 1000000000,
    ["los-spaghettis"] = 1000000000,
    ["los-spooky-combinasionas"] = 1000000000,
    ["los-nooo-my-hotspotsitos"] = 1000000000,
    ["mariachi-corazoni"] = 1000000000,
    ["los-67"] = 1000000000,
    ["los-primos"] = 1000000000,
    ["los-cucarachas"] = 1000000000,
    ["to-to-to-sahur"] = 1000000000,
    ["horegini-boom"] = 1000000000,
    ["burrito-bandito"] = 1000000000,
    ["quesadilla-crocodila"] = 1000000000,
    ["tung-tung-tung-sahur"] = 1000000000,
    ["pot-hotspot"] = 1000000000,
    ["los-jobcitos"] = 1000000000,
    ["graipuss-medussi"] = 1000000000,
    ["la-cucaracha"] = 1000000000,
    ["pumpkini-spyderini"] = 1000000000,
    ["cuadramat-and-pakrahmatmamat"] = 1000000000,
    ["los-quesadillas"] = 1000000000,
    ["guerriro-digitale"] = 1000000000,
    ["los-tipi-tacos"] = 1000000000,
    ["zombie-tralala"] = 1000000000,
    ["las-tralaleritas"] = 1000000000,
    ["los-tralaleritos"] = 1000000000,
    ["chicleteira-bicicleteira"] = 1000000000,
    ["job-job-job-sahur"] = 1000000000,
    ["los-chicleteiras"] = 1000000000,
    ["los-25"] = 1000000000,
    ["mieteteira-bicicleteira"] = 1000000000,
    ["tang-tang-keletang"] = 1000000000,
    ["money-money-puggy"] = 1000000000,
    ["los-hotspotsitos"] = 1000000000,
    ["brunito-marsito"] = 1000000000,
    ["spinny-hammy"] = 1000000000,
    ["bacuru-and-egguru"] = 1000000000,
    ["noo-my-heart"] = 1000000000,
    ["los-mi-gatitos"] = 1000000000,
    ["chicleteira-cupideira"] = 1000000000,
    ["rosetti-tualetti"] = 1000000000,
    ["dj-panda"] = 1000000000,
    ["los-sekolahs"] = 1000000000,
    ["baskito"] = 1000000000,
    ["churrito-bunnito"] = 1000000000,
}

-- Config
local CONFIG = {
    ScanInterval = 1.5,
    HopDelay = 3,
    MaxServersToFetch = 100,
    SkipDuels = true,
    MinThreshold = 500000000,  -- Only alert for items BELOW this value (rare items)
    ScanMode = "rare",        -- "rare" = only rare items, "all" = all items
    AutoHopEnabled = false,
    ScannerEnabled = false,
}

-------------------------------------------------
-- UI CREATION
-------------------------------------------------

-- Destroy old GUI if it exists
if CoreGui:FindFirstChild("SynthZXSHub") then
    CoreGui:FindFirstChild("SynthZXSHub"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SynthZXSHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local success, err = pcall(function()
    ScreenGui.Parent = CoreGui
end)
if not success then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 330, 0, 480)
MainFrame.Position = UDim2.new(0.5, -165, 0.5, -240)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 15, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(30, 90, 210)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

-- Gradient accent line at top
local AccentLine = Instance.new("Frame")
AccentLine.Name = "AccentLine"
AccentLine.Size = UDim2.new(1, 0, 0, 3)
AccentLine.Position = UDim2.new(0, 0, 0, 0)
AccentLine.BorderSizePixel = 0
AccentLine.BackgroundColor3 = Color3.fromRGB(50, 120, 255)
AccentLine.Parent = MainFrame

local AccentGradient = Instance.new("UIGradient")
AccentGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 80, 220)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(80, 160, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 80, 220)),
}
AccentGradient.Parent = AccentLine

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 42)
TitleBar.Position = UDim2.new(0, 0, 0, 3)
TitleBar.BackgroundColor3 = Color3.fromRGB(15, 25, 60)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

-- Title Text
local TitleText = Instance.new("TextLabel")
TitleText.Name = "TitleText"
TitleText.Size = UDim2.new(1, -80, 1, 0)
TitleText.Position = UDim2.new(0, 12, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "⚡ SynthZXSHub"
TitleText.TextColor3 = Color3.fromRGB(90, 165, 255)
TitleText.TextSize = 18
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

-- Subtitle
local SubTitle = Instance.new("TextLabel")
SubTitle.Name = "SubTitle"
SubTitle.Size = UDim2.new(0, 150, 0, 14)
SubTitle.Position = UDim2.new(0, 12, 1, -16)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Steal a Brainrot"
SubTitle.TextColor3 = Color3.fromRGB(60, 100, 160)
SubTitle.TextSize = 10
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = TitleBar

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -36, 0, 7)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 13
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TitleBar

local CloseBtnCorner = Instance.new("UICorner")
CloseBtnCorner.CornerRadius = UDim.new(0, 6)
CloseBtnCorner.Parent = CloseBtn

-- Minimize Button
local MinBtn = Instance.new("TextButton")
MinBtn.Name = "MinBtn"
MinBtn.Size = UDim2.new(0, 28, 0, 28)
MinBtn.Position = UDim2.new(1, -68, 0, 7)
MinBtn.BackgroundColor3 = Color3.fromRGB(30, 60, 150)
MinBtn.Text = "—"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 13
MinBtn.Font = Enum.Font.GothamBold
MinBtn.BorderSizePixel = 0
MinBtn.Parent = TitleBar

local MinBtnCorner = Instance.new("UICorner")
MinBtnCorner.CornerRadius = UDim.new(0, 6)
MinBtnCorner.Parent = MinBtn

-- Content Frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -20, 1, -55)
ContentFrame.Position = UDim2.new(0, 10, 0, 48)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Padding = UDim.new(0, 6)
ContentLayout.Parent = ContentFrame

-------------------------------------------------
-- UI HELPER FUNCTIONS
-------------------------------------------------

local function CreateButton(name, text, layoutOrder, parent)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(20, 45, 120)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(170, 205, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamSemibold
    btn.BorderSizePixel = 0
    btn.LayoutOrder = layoutOrder
    btn.AutoButtonColor = true
    btn.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(40, 85, 190)
    stroke.Thickness = 1
    stroke.Transparency = 0.4
    stroke.Parent = btn

    return btn
end

local function CreateToggleButton(name, text, layoutOrder, parent)
    local frame = Instance.new("Frame")
    frame.Name = name .. "Frame"
    frame.Size = UDim2.new(1, 0, 0, 36)
    frame.BackgroundColor3 = Color3.fromRGB(20, 45, 120)
    frame.BorderSizePixel = 0
    frame.LayoutOrder = layoutOrder
    frame.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(40, 85, 190)
    stroke.Thickness = 1
    stroke.Transparency = 0.4
    stroke.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -60, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(170, 205, 255)
    label.TextSize = 13
    label.Font = Enum.Font.GothamSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Name = name .. "Toggle"
    toggleBtn.Size = UDim2.new(0, 42, 0, 22)
    toggleBtn.Position = UDim2.new(1, -52, 0.5, -11)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    toggleBtn.Text = "OFF"
    toggleBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    toggleBtn.TextSize = 10
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Parent = frame

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 6)
    toggleCorner.Parent = toggleBtn

    return toggleBtn
end

local function CreateLabel(name, text, layoutOrder, parent)
    local label = Instance.new("TextLabel")
    label.Name = name
    label.Size = UDim2.new(1, 0, 0, 18)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(100, 140, 200)
    label.TextSize = 11
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.LayoutOrder = layoutOrder
    label.Parent = parent
    return label
end

local function CreateSeparator(layoutOrder, parent)
    local sep = Instance.new("Frame")
    sep.Name = "Separator"
    sep.Size = UDim2.new(1, 0, 0, 1)
    sep.BackgroundColor3 = Color3.fromRGB(30, 60, 130)
    sep.BackgroundTransparency = 0.5
    sep.BorderSizePixel = 0
    sep.LayoutOrder = layoutOrder
    sep.Parent = parent
    return sep
end

-------------------------------------------------
-- BUILD UI ELEMENTS
-------------------------------------------------

-- Status Label
local StatusLabel = CreateLabel("StatusLabel", "⏳ Status: Idle", 1, ContentFrame)
StatusLabel.TextColor3 = Color3.fromRGB(80, 190, 255)
StatusLabel.TextSize = 12
StatusLabel.Font = Enum.Font.GothamSemibold
StatusLabel.Size = UDim2.new(1, 0, 0, 20)

-- Server Info
local ServerInfoLabel = CreateLabel("ServerInfo", "🌐 Server: " .. string.sub(JobId, 1, 16) .. "...", 2, ContentFrame)

-- Player Count
local PlayerCountLabel = CreateLabel("PlayerCount", "👥 Players: " .. #Players:GetPlayers() .. "/" .. Players.MaxPlayers, 3, ContentFrame)

-- Scan Mode
local ScanModeLabel = CreateLabel("ScanMode", "🎯 Mode: Rare Items Only (value < 500M)", 4, ContentFrame)
ScanModeLabel.TextColor3 = Color3.fromRGB(255, 200, 80)

CreateSeparator(5, ContentFrame)

-- === BUTTONS ===
local HopBtn = CreateButton("HopBtn", "🔄  Server Hop (Random)", 6, ContentFrame)
local RejoinBtn = CreateButton("RejoinBtn", "🔁  Rejoin Server", 7, ContentFrame)
local SmallHopBtn = CreateButton("SmallHopBtn", "📉  Hop to Smallest Server", 8, ContentFrame)
local BigHopBtn = CreateButton("BigHopBtn", "📈  Hop to Biggest Server", 9, ContentFrame)

CreateSeparator(10, ContentFrame)

-- === TOGGLES ===
local AutoHopToggle = CreateToggleButton("AutoHop", "⚡ Auto Server Hop", 11, ContentFrame)
local ScannerToggle = CreateToggleButton("Scanner", "🔍 Brainrot Auto-Scanner", 12, ContentFrame)
local ScanModeToggle = CreateToggleButton("ScanMode", "🎯 Scan ALL (not just rare)", 13, ContentFrame)

CreateSeparator(14, ContentFrame)

-- Found Items
local FoundLabel = CreateLabel("FoundLabel", "🎯 Found: None yet", 15, ContentFrame)
FoundLabel.TextColor3 = Color3.fromRGB(80, 220, 130)
FoundLabel.TextSize = 12
FoundLabel.Font = Enum.Font.GothamSemibold
FoundLabel.Size = UDim2.new(1, 0, 0, 20)
FoundLabel.TextWrapped = true

-- Found Details
local FoundDetailLabel = CreateLabel("FoundDetail", "", 16, ContentFrame)
FoundDetailLabel.TextColor3 = Color3.fromRGB(120, 200, 160)
FoundDetailLabel.TextWrapped = true
FoundDetailLabel.Size = UDim2.new(1, 0, 0, 30)
FoundDetailLabel.TextYAlignment = Enum.TextYAlignment.Top

-- Scan Count
local ScanCountLabel = CreateLabel("ScanCount", "📊 Servers Scanned: 0", 17, ContentFrame)

-- Total brainrots in DB
local DbCountLabel = CreateLabel("DbCount", "📋 Brainrots in DB: " .. (function() local c = 0 for _ in pairs(BRAINROT_DB) do c = c + 1 end return c end)(), 18, ContentFrame)

-------------------------------------------------
-- WATERMARK (top-right corner)
-------------------------------------------------

local Watermark = Instance.new("TextLabel")
Watermark.Name = "Watermark"
Watermark.Size = UDim2.new(0, 180, 0, 28)
Watermark.Position = UDim2.new(1, -190, 0, 10)
Watermark.BackgroundColor3 = Color3.fromRGB(10, 15, 35)
Watermark.BackgroundTransparency = 0.2
Watermark.Text = "⚡ synthzxshub"
Watermark.TextColor3 = Color3.fromRGB(70, 140, 255)
Watermark.TextSize = 14
Watermark.Font = Enum.Font.GothamBold
Watermark.TextXAlignment = Enum.TextXAlignment.Center
Watermark.BorderSizePixel = 0
Watermark.Parent = ScreenGui

local WatermarkCorner = Instance.new("UICorner")
WatermarkCorner.CornerRadius = UDim.new(0, 8)
WatermarkCorner.Parent = Watermark

local WatermarkStroke = Instance.new("UIStroke")
WatermarkStroke.Color = Color3.fromRGB(30, 80, 200)
WatermarkStroke.Thickness = 1
WatermarkStroke.Parent = Watermark

-- FPS / Ping display next to watermark
local PerfLabel = Instance.new("TextLabel")
PerfLabel.Name = "PerfLabel"
PerfLabel.Size = UDim2.new(0, 180, 0, 16)
PerfLabel.Position = UDim2.new(1, -190, 0, 40)
PerfLabel.BackgroundTransparency = 1
PerfLabel.Text = ""
PerfLabel.TextColor3 = Color3.fromRGB(60, 110, 180)
PerfLabel.TextSize = 10
PerfLabel.Font = Enum.Font.Gotham
PerfLabel.TextXAlignment = Enum.TextXAlignment.Center
PerfLabel.Parent = ScreenGui

-------------------------------------------------
-- CORE FUNCTIONS
-------------------------------------------------

local serversScanned = 0
local isHopping = false
local foundItems = {}

-- Fetch servers from Roblox Games API
local function GetServers(sortOrder)
    local servers = {}
    local url = "https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=" .. (sortOrder or "Asc") .. "&limit=" .. CONFIG.MaxServersToFetch

    local success, result = pcall(function()
        return HttpService:JSONDecode(game:HttpGet(url))
    end)

    if success and result and result.data then
        for _, server in ipairs(result.data) do
            if server.id ~= JobId and server.playing < server.maxPlayers then
                table.insert(servers, server)
            end
        end
    end

    return servers
end

-- Teleport to a specific server
local function TeleportToServer(serverId)
    StatusLabel.Text = "🚀 Status: Teleporting..."

    local success, err = pcall(function()
        TeleportService:TeleportToPlaceInstance(PlaceId, serverId, LocalPlayer)
    end)

    if not success then
        StatusLabel.Text = "❌ Teleport failed: " .. tostring(err):sub(1, 40)
        warn("[SynthZXSHub] Teleport failed: " .. tostring(err))
        return false
    end

    return true
end

-- Server Hop to random server
local function ServerHop()
    if isHopping then return end
    isHopping = true
    StatusLabel.Text = "🔍 Status: Fetching servers..."

    local servers = GetServers("Asc")

    if #servers == 0 then
        StatusLabel.Text = "❌ Status: No servers available"
        isHopping = false
        return
    end

    local randomServer = servers[math.random(1, #servers)]
    StatusLabel.Text = "🔄 Hopping... (" .. randomServer.playing .. " players)"

    task.wait(1)
    TeleportToServer(randomServer.id)
    isHopping = false
end

-- Rejoin current server
local function RejoinServer()
    if isHopping then return end
    isHopping = true
    StatusLabel.Text = "🔁 Status: Rejoining..."

    task.wait(1)

    local success, err = pcall(function()
        TeleportService:TeleportToPlaceInstance(PlaceId, JobId, LocalPlayer)
    end)

    if not success then
        pcall(function()
            TeleportService:Teleport(PlaceId, LocalPlayer)
        end)
    end

    isHopping = false
end

-- Hop to smallest server
local function HopToSmallest()
    if isHopping then return end
    isHopping = true
    StatusLabel.Text = "🔍 Finding smallest server..."

    local servers = GetServers("Asc")

    if #servers == 0 then
        StatusLabel.Text = "❌ No servers found"
        isHopping = false
        return
    end

    table.sort(servers, function(a, b) return a.playing < b.playing end)

    StatusLabel.Text = "📉 Hopping (" .. servers[1].playing .. " players)..."
    task.wait(1)
    TeleportToServer(servers[1].id)
    isHopping = false
end

-- Hop to biggest server
local function HopToBiggest()
    if isHopping then return end
    isHopping = true
    StatusLabel.Text = "🔍 Finding biggest server..."

    local servers = GetServers("Desc")

    if #servers == 0 then
        StatusLabel.Text = "❌ No servers found"
        isHopping = false
        return
    end

    table.sort(servers, function(a, b) return a.playing > b.playing end)

    StatusLabel.Text = "📈 Hopping (" .. servers[1].playing .. " players)..."
    task.wait(1)
    TeleportToServer(servers[1].id)
    isHopping = false
end

-------------------------------------------------
-- BRAINROT SCANNER
-------------------------------------------------

-- Normalize name for matching (lowercase, remove spaces)
local function NormalizeName(name)
    return name:lower():gsub("%s+", "-"):gsub("_", "-")
end

-- Scan workspace for brainrot items
local function ScanCurrentServer()
    local found = {}

    local function CheckObject(obj)
        local objName = NormalizeName(obj.Name)

        for brainrotName, value in pairs(BRAINROT_DB) do
            if objName:find(brainrotName, 1, true) or brainrotName:find(objName, 1, true) then
                -- Filter by scan mode
                if CONFIG.ScanMode == "all" or (CONFIG.ScanMode == "rare" and value < CONFIG.MinThreshold) then
                    local rarity = "COMMON"
                    if value == 0 then
                        rarity = "⭐ RARE"
                    elseif value < CONFIG.MinThreshold then
                        rarity = "💎 MID"
                    end

                    table.insert(found, {
                        Name = obj.Name,
                        BrainrotId = brainrotName,
                        Value = value,
                        Rarity = rarity,
                        ClassName = obj.ClassName,
                        Position = obj:IsA("BasePart") and obj.Position or nil,
                    })
                end
                break
            end
        end
    end

    -- Scan all descendants of Workspace
    pcall(function()
        for _, obj in ipairs(Workspace:GetDescendants()) do
            pcall(function() CheckObject(obj) end)
        end
    end)

    -- Also scan ReplicatedStorage if accessible
    pcall(function()
        local RS = game:GetService("ReplicatedStorage")
        for _, obj in ipairs(RS:GetDescendants()) do
            pcall(function() CheckObject(obj) end)
        end
    end)

    return found
end

-------------------------------------------------
-- AUTO HOP LOOP
-------------------------------------------------

local autoHopThread = nil

local function StartAutoHop()
    if autoHopThread then return end

    CONFIG.AutoHopEnabled = true
    AutoHopToggle.Text = "ON"
    AutoHopToggle.BackgroundColor3 = Color3.fromRGB(25, 120, 60)

    autoHopThread = task.spawn(function()
        while CONFIG.AutoHopEnabled do
            for i = CONFIG.HopDelay, 1, -1 do
                if not CONFIG.AutoHopEnabled then return end
                StatusLabel.Text = "⚡ Auto-hop in " .. i .. "s..."
                task.wait(1)
            end

            if not CONFIG.AutoHopEnabled then return end
            ServerHop()
        end
    end)
end

local function StopAutoHop()
    CONFIG.AutoHopEnabled = false
    AutoHopToggle.Text = "OFF"
    AutoHopToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    autoHopThread = nil
    StatusLabel.Text = "⏳ Status: Idle"
end

-------------------------------------------------
-- SCANNER LOOP
-------------------------------------------------

local scannerThread = nil

local function StartScanner()
    if scannerThread then return end

    CONFIG.ScannerEnabled = true
    ScannerToggle.Text = "ON"
    ScannerToggle.BackgroundColor3 = Color3.fromRGB(25, 120, 60)

    scannerThread = task.spawn(function()
        while CONFIG.ScannerEnabled do
            StatusLabel.Text = "🔍 Scanning this server..."

            local items = ScanCurrentServer()
            serversScanned = serversScanned + 1
            ScanCountLabel.Text = "📊 Servers Scanned: " .. serversScanned

            if #items > 0 then
                -- FOUND brainrots!
                foundItems = items

                local names = {}
                local rareCount = 0
                for i, item in ipairs(items) do
                    if item.Value == 0 then rareCount = rareCount + 1 end
                    if i <= 4 then
                        table.insert(names, item.Rarity .. " " .. item.BrainrotId)
                    end
                end

                if #items > 4 then
                    table.insert(names, "+" .. (#items - 4) .. " more")
                end

                FoundLabel.Text = "🎯 FOUND " .. #items .. " brainrot(s)! (" .. rareCount .. " rare)"
                FoundLabel.TextColor3 = rareCount > 0 and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(50, 255, 100)
                FoundDetailLabel.Text = table.concat(names, " | ")

                StatusLabel.Text = "✅ Brainrot FOUND! Staying here."
                StatusLabel.TextColor3 = Color3.fromRGB(50, 255, 100)

                -- Stop auto-hop
                if CONFIG.AutoHopEnabled then
                    StopAutoHop()
                end

                -- Send notification
                pcall(function()
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "⚡ SynthZXSHub",
                        Text = #items .. " brainrot(s) found! " .. rareCount .. " rare!",
                        Duration = 15,
                    })
                end)

                -- Keep scanning but stay in server
                task.wait(CONFIG.ScanInterval * 3)
            else
                FoundLabel.Text = "🎯 Found: Nothing in this server"
                FoundLabel.TextColor3 = Color3.fromRGB(255, 120, 80)
                FoundDetailLabel.Text = ""
                StatusLabel.Text = "🔍 No brainrots, hopping next..."
                StatusLabel.TextColor3 = Color3.fromRGB(80, 190, 255)

                task.wait(2)

                if CONFIG.ScannerEnabled then
                    ServerHop()
                    task.wait(6)
                end
            end

            task.wait(CONFIG.ScanInterval)
        end
    end)
end

local function StopScanner()
    CONFIG.ScannerEnabled = false
    ScannerToggle.Text = "OFF"
    ScannerToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    scannerThread = nil
    StatusLabel.Text = "⏳ Status: Idle"
    StatusLabel.TextColor3 = Color3.fromRGB(80, 190, 255)
end

-------------------------------------------------
-- BUTTON CONNECTIONS
-------------------------------------------------

HopBtn.MouseButton1Click:Connect(ServerHop)
RejoinBtn.MouseButton1Click:Connect(RejoinServer)
SmallHopBtn.MouseButton1Click:Connect(HopToSmallest)
BigHopBtn.MouseButton1Click:Connect(HopToBiggest)

AutoHopToggle.MouseButton1Click:Connect(function()
    if CONFIG.AutoHopEnabled then StopAutoHop() else StartAutoHop() end
end)

ScannerToggle.MouseButton1Click:Connect(function()
    if CONFIG.ScannerEnabled then StopScanner() else StartScanner() end
end)

ScanModeToggle.MouseButton1Click:Connect(function()
    if CONFIG.ScanMode == "rare" then
        CONFIG.ScanMode = "all"
        ScanModeToggle.Text = "ON"
        ScanModeToggle.BackgroundColor3 = Color3.fromRGB(25, 120, 60)
        ScanModeLabel.Text = "🎯 Mode: ALL Items (rare + common)"
    else
        CONFIG.ScanMode = "rare"
        ScanModeToggle.Text = "OFF"
        ScanModeToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        ScanModeLabel.Text = "🎯 Mode: Rare Items Only (value < 500M)"
    end
end)

-- Close
CloseBtn.MouseButton1Click:Connect(function()
    StopAutoHop()
    StopScanner()
    ScreenGui:Destroy()
end)

-- Minimize
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    ContentFrame.Visible = not minimized
    MainFrame.Size = minimized and UDim2.new(0, 330, 0, 48) or UDim2.new(0, 330, 0, 480)
    MinBtn.Text = minimized and "+" or "—"
end)

-- Hover effects
local function AddHover(button)
    local orig = button.BackgroundColor3
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(
            math.min(orig.R * 255 + 25, 255),
            math.min(orig.G * 255 + 25, 255),
            math.min(orig.B * 255 + 25, 255)
        )
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = orig
    end)
end

AddHover(HopBtn)
AddHover(RejoinBtn)
AddHover(SmallHopBtn)
AddHover(BigHopBtn)
AddHover(CloseBtn)

-------------------------------------------------
-- LIVE UPDATES
-------------------------------------------------

task.spawn(function()
    while ScreenGui.Parent do
        PlayerCountLabel.Text = "👥 Players: " .. #Players:GetPlayers() .. "/" .. Players.MaxPlayers

        -- FPS counter
        local fps = math.floor(1 / RunService.RenderStepped:Wait())
        PerfLabel.Text = "FPS: " .. fps

        task.wait(1)
    end
end)

-------------------------------------------------
-- INIT
-------------------------------------------------

print("[SynthZXSHub] ✅ Loaded successfully!")
print("[SynthZXSHub] Script by synthzxshub")
print("[SynthZXSHub] Server: " .. JobId)
print("[SynthZXSHub] Brainrots in DB: " .. (function() local c = 0 for _ in pairs(BRAINROT_DB) do c = c + 1 end return c end)())

pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "⚡ SynthZXSHub",
        Text = "Server Hop loaded! Ready to scan.",
        Duration = 5,
    })
end)
