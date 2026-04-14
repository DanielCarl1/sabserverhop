--[[
    ╔══════════════════════════════════════════════════════════════╗
    ║                   SynthZXSHub                                ║
    ║        Brainrot Scanner + Auto Joiner                        ║
    ║              Steal a Brainrot                                ║
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

-------------------------------------------------
-- BRAINROT DATABASE
-------------------------------------------------
local BRAINROT_DB = {
    ["eviledon"] = 0, ["swag-soda"] = 0, ["la-secret-combinasion"] = 0, ["gobblino-uniciclino"] = 0,
    ["cooki-and-milki"] = 0, ["strawberry-elephant"] = 0, ["burguro-and-fryuro"] = 0, ["dragon-cannelloni"] = 0,
    ["garama-and-madundung"] = 0, ["orcaledon"] = 0, ["nuclearo-dinossauro"] = 0, ["la-taco-combinasion"] = 0,
    ["la-spooky-grande"] = 0, ["w-or-l"] = 0, ["tralaledon"] = 0, ["tictac-sahur"] = 0,
    ["lavadorito-spinito"] = 0, ["la-extinct-grande"] = 0, ["ketchuru-and-musturu"] = 0, ["ketupat-kepat"] = 0,
    ["tacorita-bicicleta"] = 0, ["capitano-moby"] = 0, ["chicleteira-noelteira"] = 0, ["la-jolly-grande"] = 0,
    ["spooky-and-pumpky"] = 0, ["fragrama-and-chocrama"] = 0, ["chillin-chili"] = 0, ["chipso-and-queso"] = 0,
    ["chimnino"] = 0, ["los-candies"] = 0, ["reinito-sleighito"] = 0, ["la-ginger-sekolah"] = 0,
    ["las-sis"] = 0, ["la-casa-boo"] = 0, ["dragon-gingerini"] = 0, ["festive-67"] = 0,
    ["meowl"] = 0, ["skibidi-toilet"] = 0, ["jolly-jolly-sahur"] = 0, ["los-tacoritas"] = 0,
    ["ginger-gerat"] = 0, ["swaggy-bros"] = 0, ["headless-horseman"] = 0, ["la-supreme-combinasion"] = 0,
    ["money-money-reindeer"] = 0, ["los-jolly-combinasionas"] = 0, ["tuff-toucan"] = 0, ["fishino-clownino"] = 0,
    ["donkeyturbo-express"] = 0, ["cerberus"] = 0, ["hydra-dragon-cannelloni"] = 0, ["ketupat-bros"] = 0,
    ["popcuru-and-fizzuru"] = 0, ["rosey-and-teddy"] = 0, ["la-romantic-grande"] = 0, ["los-amigos"] = 0,
    ["sammyni-fattini"] = 0, ["la-food-combinasion"] = 0, ["signore-carapace"] = 0, ["celestial-pegasus"] = 0,
    ["antonio"] = 0, ["tirilikalika-tirilikalako"] = 0, ["elefanto-frigo"] = 0, ["griffin"] = 0,
    ["love-love-bear"] = 0, ["dug-dug-dug"] = 0, ["fortunu-and-cashuru"] = 0, ["foxini-lanternini"] = 0,
    ["gold-gold-gold"] = 0, ["hydra-bunny"] = 0, ["la-lucky-grande"] = 0, ["la-easter-grande"] = 0,
    ["hopilikalika-hopilikalako"] = 0, ["pancake-and-syrup"] = 0, ["boppin-bunny"] = 0, ["bunny-and-eggy"] = 0,
    ["cash-or-card"] = 0, ["arcadragon"] = 0,
    
    ["ventoliero-pavonero"] = 500000000,
    
    ["67"] = 1000000000, ["esok-sekolah"] = 1000000000, ["la-grande-combinasion"] = 1000000000, ["los-puggies"] = 1000000000,
    ["los-combinasionas"] = 1000000000, ["spaghetti-tualetti"] = 1000000000, ["los-mobilis"] = 1000000000, ["los-burritos"] = 1000000000,
    ["los-bros"] = 1000000000, ["los-spaghettis"] = 1000000000, ["los-spooky-combinasionas"] = 1000000000, ["los-nooo-my-hotspotsitos"] = 1000000000,
    ["mariachi-corazoni"] = 1000000000, ["los-67"] = 1000000000, ["los-primos"] = 1000000000, ["los-cucarachas"] = 1000000000,
    ["to-to-to-sahur"] = 1000000000, ["horegini-boom"] = 1000000000, ["burrito-bandito"] = 1000000000, ["quesadilla-crocodila"] = 1000000000,
    ["tung-tung-tung-sahur"] = 1000000000, ["pot-hotspot"] = 1000000000, ["los-jobcitos"] = 1000000000, ["graipuss-medussi"] = 1000000000,
    ["la-cucaracha"] = 1000000000, ["pumpkini-spyderini"] = 1000000000, ["cuadramat-and-pakrahmatmamat"] = 1000000000, ["los-quesadillas"] = 1000000000,
    ["guerriro-digitale"] = 1000000000, ["los-tipi-tacos"] = 1000000000, ["zombie-tralala"] = 1000000000, ["las-tralaleritas"] = 1000000000,
    ["los-tralaleritos"] = 1000000000, ["chicleteira-bicicleteira"] = 1000000000, ["job-job-job-sahur"] = 1000000000, ["los-chicleteiras"] = 1000000000,
    ["los-25"] = 1000000000, ["mieteteira-bicicleteira"] = 1000000000, ["tang-tang-keletang"] = 1000000000, ["money-money-puggy"] = 1000000000,
    ["los-hotspotsitos"] = 1000000000, ["brunito-marsito"] = 1000000000, ["spinny-hammy"] = 1000000000, ["bacuru-and-egguru"] = 1000000000,
    ["noo-my-heart"] = 1000000000, ["los-mi-gatitos"] = 1000000000, ["chicleteira-cupideira"] = 1000000000, ["rosetti-tualetti"] = 1000000000,
    ["dj-panda"] = 1000000000, ["los-sekolahs"] = 1000000000, ["baskito"] = 1000000000, ["churrito-bunnito"] = 1000000000,
}

-------------------------------------------------
-- CONFIG & PERSISTENT STATE SAVING
-------------------------------------------------

local CONFIG = {
    MaxServers = 100,
    FilterMode = "AJ", -- Default
    AutoJoinEnabled = false,
}

-- Load State from executor memory or file
local function LoadState()
    if getgenv().SynthZxsAutoJoin ~= nil then
        CONFIG.AutoJoinEnabled = getgenv().SynthZxsAutoJoin
    end
    if getgenv().SynthZxsFilterMode ~= nil then
        CONFIG.FilterMode = getgenv().SynthZxsFilterMode
    end

    if readfile and isfile and isfile("SynthZXSHubState.json") then
        pcall(function()
            local decoded = HttpService:JSONDecode(readfile("SynthZXSHubState.json"))
            if decoded then
                if getgenv().SynthZxsAutoJoin == nil and decoded.AutoJoin ~= nil then
                    CONFIG.AutoJoinEnabled = decoded.AutoJoin
                end
                if getgenv().SynthZxsFilterMode == nil and decoded.FilterMode ~= nil then
                    CONFIG.FilterMode = decoded.FilterMode
                end
            end
        end)
    end
end
LoadState()

local function SaveState()
    getgenv().SynthZxsAutoJoin = CONFIG.AutoJoinEnabled
    getgenv().SynthZxsFilterMode = CONFIG.FilterMode

    if writefile then
        pcall(function()
            local data = HttpService:JSONEncode({
                AutoJoin = CONFIG.AutoJoinEnabled,
                FilterMode = CONFIG.FilterMode
            })
            writefile("SynthZXSHubState.json", data)
        end)
    end
end

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
-- PING BAR (top-right, small)
-------------------------------------------------

local PingBar = Instance.new("Frame")
PingBar.Name = "PingBar"
PingBar.Size = UDim2.new(0, 150, 0, 22)
PingBar.Position = UDim2.new(1, -160, 0, 6)
PingBar.BackgroundColor3 = Color3.fromRGB(8, 12, 28)
PingBar.BackgroundTransparency = 0.15
PingBar.BorderSizePixel = 0
PingBar.Parent = ScreenGui

local PingBarCorner = Instance.new("UICorner")
PingBarCorner.CornerRadius = UDim.new(0, 6)
PingBarCorner.Parent = PingBar

local PingBarStroke = Instance.new("UIStroke")
PingBarStroke.Color = Color3.fromRGB(25, 65, 170)
PingBarStroke.Thickness = 1
PingBarStroke.Parent = PingBar

local PingLabel = Instance.new("TextLabel")
PingLabel.Name = "PingLabel"
PingLabel.Size = UDim2.new(1, -8, 1, 0)
PingLabel.Position = UDim2.new(0, 4, 0, 0)
PingLabel.BackgroundTransparency = 1
PingLabel.Text = "📶 0ms  |  0 FPS"
PingLabel.TextColor3 = Color3.fromRGB(80, 160, 255)
PingLabel.TextSize = 10
PingLabel.Font = Enum.Font.GothamBold
PingLabel.TextXAlignment = Enum.TextXAlignment.Center
PingLabel.Parent = PingBar

local Watermark = Instance.new("TextLabel")
Watermark.Name = "Watermark"
Watermark.Size = UDim2.new(0, 150, 0, 20)
Watermark.Position = UDim2.new(1, -160, 0, 30)
Watermark.BackgroundTransparency = 1
Watermark.Text = "⚡ synthzxshub"
Watermark.TextColor3 = Color3.fromRGB(50, 110, 220)
Watermark.TextSize = 10
Watermark.Font = Enum.Font.GothamBold
Watermark.TextXAlignment = Enum.TextXAlignment.Center
Watermark.Parent = ScreenGui

-------------------------------------------------
-- MAIN FRAME
-------------------------------------------------

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 340, 0, 440)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -220)
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 12, 28)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(25, 65, 170)
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

local Accent = Instance.new("Frame")
Accent.Size = UDim2.new(1, 0, 0, 2)
Accent.BackgroundColor3 = Color3.fromRGB(40, 100, 255)
Accent.BorderSizePixel = 0
Accent.Parent = MainFrame

local AccentGrad = Instance.new("UIGradient")
AccentGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 60, 200)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(60, 140, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 60, 200)),
}
AccentGrad.Parent = Accent

-- HEADER
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 44)
Header.Position = UDim2.new(0, 0, 0, 2)
Header.BackgroundColor3 = Color3.fromRGB(10, 16, 36)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -80, 0, 24)
Title.Position = UDim2.new(0, 14, 0, 4)
Title.BackgroundTransparency = 1
Title.Text = "SynthZXSHub"
Title.TextColor3 = Color3.fromRGB(220, 230, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, -80, 0, 12)
SubTitle.Position = UDim2.new(0, 14, 0, 28)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "steal a brainrot - auto joiner"
SubTitle.TextColor3 = Color3.fromRGB(50, 90, 160)
SubTitle.TextSize = 9
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -34, 0, 10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(160, 30, 30)
CloseBtn.BackgroundTransparency = 0.6
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(200, 210, 240)
CloseBtn.TextSize = 12
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = Header
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 5)

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 24, 0, 24)
MinBtn.Position = UDim2.new(1, -62, 0, 10)
MinBtn.BackgroundColor3 = Color3.fromRGB(20, 40, 100)
MinBtn.BackgroundTransparency = 0.6
MinBtn.Text = "—"
MinBtn.TextColor3 = Color3.fromRGB(200, 210, 240)
MinBtn.TextSize = 12
MinBtn.Font = Enum.Font.GothamBold
MinBtn.BorderSizePixel = 0
MinBtn.Parent = Header
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 5)

-------------------------------------------------
-- FILTER TABS
-------------------------------------------------

local TabBar = Instance.new("Frame")
TabBar.Name = "TabBar"
TabBar.Size = UDim2.new(1, -20, 0, 32)
TabBar.Position = UDim2.new(0, 10, 0, 50)
TabBar.BackgroundTransparency = 1
TabBar.Parent = MainFrame

local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Padding = UDim.new(0, 6)
TabLayout.Parent = TabBar

local tabButtons = {}

local function CreateTab(name, label, order)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0, 72, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(15, 22, 50)
    btn.Text = "📋 " .. label
    btn.TextColor3 = Color3.fromRGB(100, 140, 200)
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamSemibold
    btn.BorderSizePixel = 0
    btn.LayoutOrder = order
    btn.AutoButtonColor = false
    btn.Parent = TabBar

    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 7)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(25, 55, 140)
    stroke.Thickness = 1
    stroke.Transparency = 0.5

    tabButtons[name] = {Button = btn, Stroke = stroke}
    return btn
end

local tab100m = CreateTab("100m", "100m+", 1)
local tab50m = CreateTab("50m", "50m+", 2)
local tab10m = CreateTab("10m", "10m+", 3)
local tabAJ = CreateTab("AJ", "AJ", 4)

local function SetActiveTab(tabName)
    CONFIG.FilterMode = tabName
    SaveState()
    for name, data in pairs(tabButtons) do
        if name == tabName then
            data.Button.BackgroundColor3 = Color3.fromRGB(30, 70, 200)
            data.Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            data.Stroke.Color = Color3.fromRGB(50, 110, 255)
            data.Stroke.Transparency = 0
        else
            data.Button.BackgroundColor3 = Color3.fromRGB(15, 22, 50)
            data.Button.TextColor3 = Color3.fromRGB(100, 140, 200)
            data.Stroke.Color = Color3.fromRGB(25, 55, 140)
            data.Stroke.Transparency = 0.5
        end
    end
end
SetActiveTab(CONFIG.FilterMode)

tab100m.MouseButton1Click:Connect(function() SetActiveTab("100m") end)
tab50m.MouseButton1Click:Connect(function() SetActiveTab("50m") end)
tab10m.MouseButton1Click:Connect(function() SetActiveTab("10m") end)
tabAJ.MouseButton1Click:Connect(function() SetActiveTab("AJ") end)

-------------------------------------------------
-- RESULTS AREA
-------------------------------------------------

local ResultsFrame = Instance.new("ScrollingFrame")
ResultsFrame.Name = "ResultsFrame"
ResultsFrame.Size = UDim2.new(1, -20, 0, 220)
ResultsFrame.Position = UDim2.new(0, 10, 0, 88)
ResultsFrame.BackgroundColor3 = Color3.fromRGB(6, 10, 22)
ResultsFrame.BorderSizePixel = 0
ResultsFrame.ScrollBarThickness = 3
ResultsFrame.ScrollBarImageColor3 = Color3.fromRGB(40, 80, 200)
ResultsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ResultsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ResultsFrame.Parent = MainFrame

Instance.new("UICorner", ResultsFrame).CornerRadius = UDim.new(0, 8)
local rStroke = Instance.new("UIStroke", ResultsFrame)
rStroke.Color = Color3.fromRGB(20, 45, 110); rStroke.Thickness = 1
local rLayout = Instance.new("UIListLayout", ResultsFrame)
rLayout.SortOrder = Enum.SortOrder.LayoutOrder; rLayout.Padding = UDim.new(0, 2)
local rPad = Instance.new("UIPadding", ResultsFrame)
rPad.PaddingTop = UDim.new(0, 4); rPad.PaddingBottom = UDim.new(0, 4)
rPad.PaddingLeft = UDim.new(0, 4); rPad.PaddingRight = UDim.new(0, 4)

local EmptyLabel = Instance.new("TextLabel")
EmptyLabel.Size = UDim2.new(1, 0, 0, 60)
EmptyLabel.BackgroundTransparency = 1
EmptyLabel.Text = "No brainrots detected yet.\nStart Auto Joiner to scan and hop!"
EmptyLabel.TextColor3 = Color3.fromRGB(50, 70, 120)
EmptyLabel.TextSize = 11
EmptyLabel.Font = Enum.Font.Gotham
EmptyLabel.Parent = ResultsFrame

-------------------------------------------------
-- BOTTOM CONTROLS
-------------------------------------------------

local BottomFrame = Instance.new("Frame")
BottomFrame.Size = UDim2.new(1, -20, 0, 100)
BottomFrame.Position = UDim2.new(0, 10, 0, 315)
BottomFrame.BackgroundTransparency = 1
BottomFrame.Parent = MainFrame
local bLay = Instance.new("UIListLayout", BottomFrame)
bLay.SortOrder = Enum.SortOrder.LayoutOrder; bLay.Padding = UDim.new(0, 5)

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 16)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "⏳ Idle"
StatusLabel.TextColor3 = Color3.fromRGB(60, 110, 190)
StatusLabel.TextSize = 10
StatusLabel.Font = Enum.Font.GothamSemibold
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.LayoutOrder = 1
StatusLabel.Parent = BottomFrame

local HopButton = Instance.new("TextButton")
HopButton.Size = UDim2.new(1, 0, 0, 34)
HopButton.BackgroundColor3 = Color3.fromRGB(20, 50, 140)
HopButton.Text = "🔄  Manual Server Hop"
HopButton.TextColor3 = Color3.fromRGB(160, 200, 255)
HopButton.TextSize = 13
HopButton.Font = Enum.Font.GothamSemibold
HopButton.BorderSizePixel = 0
HopButton.LayoutOrder = 2
HopButton.Parent = BottomFrame
Instance.new("UICorner", HopButton).CornerRadius = UDim.new(0, 7)
local HopStroke = Instance.new("UIStroke", HopButton)
HopStroke.Color = Color3.fromRGB(35, 80, 200); HopStroke.Thickness = 1

local AutoJoinBtn = Instance.new("TextButton")
AutoJoinBtn.Size = UDim2.new(1, 0, 0, 34)
AutoJoinBtn.BackgroundColor3 = Color3.fromRGB(15, 22, 50)
AutoJoinBtn.Text = "▷  Auto Joiner"
AutoJoinBtn.TextColor3 = Color3.fromRGB(100, 140, 220)
AutoJoinBtn.TextSize = 13
AutoJoinBtn.Font = Enum.Font.GothamSemibold
AutoJoinBtn.BorderSizePixel = 0
AutoJoinBtn.LayoutOrder = 3
AutoJoinBtn.Parent = BottomFrame
Instance.new("UICorner", AutoJoinBtn).CornerRadius = UDim.new(0, 7)
local AJStroke = Instance.new("UIStroke", AutoJoinBtn)
AJStroke.Color = Color3.fromRGB(30, 55, 130); AJStroke.Thickness = 1

-------------------------------------------------
-- CORE LOGIC
-------------------------------------------------

local detectedBrainrots = {}

local function Normalize(name) return name:lower():gsub("%s+", "-"):gsub("_", "-") end
local function PrettyName(id)
    local words = {}
    for word in id:gmatch("[^%-]+") do table.insert(words, word:sub(1,1):upper() .. word:sub(2)) end
    return table.concat(words, " ")
end
local function FormatValue(val)
    if val >= 1000000000 then return string.format("$%.1fB", val / 1000000000)
    elseif val >= 1000000 then return string.format("$%.0fM", val / 1000000)
    elseif val >= 1000 then return string.format("$%.0fK", val / 1000)
    elseif val == 0 then return "RARE" else return "$" .. tostring(val) end
end

local function GetFilterThreshold()
    if CONFIG.FilterMode == "100m" then return 100000000
    elseif CONFIG.FilterMode == "50m" then return 50000000
    elseif CONFIG.FilterMode == "10m" then return 10000000
    else return math.huge end
end

local function GetServers()
    local servers = {}
    local url = "https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=" .. CONFIG.MaxServers
    pcall(function()
        local res = HttpService:JSONDecode(game:HttpGet(url))
        for _, s in ipairs(res.data) do
            if s.id ~= JobId and s.playing and s.playing < s.maxPlayers then table.insert(servers, s) end
        end
    end)
    return servers
end

local function ScanCurrentServer()
    local found = {}
    local threshold = GetFilterThreshold()
    local function CheckObj(obj)
        local norm = Normalize(obj.Name)
        for bId, val in pairs(BRAINROT_DB) do
            if norm:find(bId, 1, true) or bId:find(norm, 1, true) then
                if CONFIG.FilterMode == "AJ" or val <= threshold then
                    found[bId] = {id=bId, value=val, players=#Players:GetPlayers()}
                end
                break
            end
        end
    end
    pcall(function() for _, obj in ipairs(Workspace:GetDescendants()) do pcall(function() CheckObj(obj) end) end end)
    pcall(function() for _, obj in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do pcall(function() CheckObj(obj) end) end end)
    return found
end

local function CreateResultRow(data, index)
    local row = Instance.new("Frame")
    row.Name = "Row_" .. data.id; row.Size = UDim2.new(1, -4, 0, 42)
    row.BackgroundColor3 = Color3.fromRGB(12, 18, 40); row.BorderSizePixel = 0
    row.LayoutOrder = index; row.Parent = ResultsFrame
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)

    local dot = Instance.new("Frame", row)
    dot.Size = UDim2.new(0, 6, 0, 6); dot.Position = UDim2.new(0, 8, 0.5, -3); dot.BorderSizePixel = 0
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
    dot.BackgroundColor3 = data.value == 0 and Color3.fromRGB(255,200,50) or (data.value<=500000000 and Color3.fromRGB(150,80,255) or Color3.fromRGB(60,160,255))

    local nameLbl = Instance.new("TextLabel", row)
    nameLbl.Size = UDim2.new(0, 180, 0, 18); nameLbl.Position = UDim2.new(0, 20, 0, 4)
    nameLbl.BackgroundTransparency = 1; nameLbl.Text = "🧠 " .. PrettyName(data.id)
    nameLbl.TextColor3 = Color3.fromRGB(200, 215, 255); nameLbl.TextSize = 11
    nameLbl.Font = Enum.Font.GothamSemibold; nameLbl.TextXAlignment = Enum.TextXAlignment.Left

    local valLbl = Instance.new("TextLabel", row)
    valLbl.Size = UDim2.new(0, 180, 0, 14); valLbl.Position = UDim2.new(0, 20, 0, 22)
    valLbl.BackgroundTransparency = 1; valLbl.Text = FormatValue(data.value) .. "  •  " .. data.players .. " players"
    valLbl.TextColor3 = data.value == 0 and Color3.fromRGB(255, 200, 50) or Color3.fromRGB(80, 130, 200)
    valLbl.TextSize = 9; valLbl.Font = Enum.Font.Gotham; valLbl.TextXAlignment = Enum.TextXAlignment.Left

    local joinBtn = Instance.new("TextButton", row)
    joinBtn.Size = UDim2.new(0, 60, 0, 26); joinBtn.Position = UDim2.new(1, -70, 0.5, -13)
    joinBtn.BackgroundColor3 = Color3.fromRGB(20, 60, 100); joinBtn.Text = "HERE"
    joinBtn.TextColor3 = Color3.fromRGB(100, 180, 255); joinBtn.TextSize = 11
    joinBtn.Font = Enum.Font.GothamBold; joinBtn.BorderSizePixel = 0
    Instance.new("UICorner", joinBtn).CornerRadius = UDim.new(0, 5)
end

local function RenderResults()
    for _, child in ipairs(ResultsFrame:GetChildren()) do
        if child:IsA("Frame") and child.Name:find("Row_") then child:Destroy() end
    end
    if #detectedBrainrots == 0 then EmptyLabel.Visible = true; return end
    EmptyLabel.Visible = false
    table.sort(detectedBrainrots, function(a, b) return a.value < b.value end)
    for i, data in ipairs(detectedBrainrots) do CreateResultRow(data, i) end
end

-- Persist Script to Next Server
local function ServerHop()
    if isHopping then return end
    isHopping = true
    StatusLabel.Text = "🔍 Fetching servers to hop..."

    local servers = GetServers()
    if #servers == 0 then StatusLabel.Text = "❌ No servers available!"; isHopping = false; return end
    local target = servers[math.random(1, #servers)]
    
    StatusLabel.Text = "🔄 Teleporting to server... (" .. target.playing .. " plrs)"

    -- Queue On Teleport (Preserves Auto Joiner across hops)
    local qot = queue_on_teleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport)
    if qot then
        local code = [[
            getgenv().SynthZxsAutoJoin = ]] .. tostring(CONFIG.AutoJoinEnabled) .. [[;
            getgenv().SynthZxsFilterMode = "]] .. tostring(CONFIG.FilterMode) .. [[";
            loadstring(game:HttpGet("https://raw.githubusercontent.com/DanielCarl1/sabserverhop/refs/heads/main/ServerHop.lua"))();
        ]]
        pcall(function() qot(code) end)
    end

    task.wait(0.5)
    pcall(function() TeleportService:TeleportToPlaceInstance(PlaceId, target.id, LocalPlayer) end)
    isHopping = false
end

-------------------------------------------------
-- AUTO JOINER SYSTEM (Hops endlessly until brainrot found)
-------------------------------------------------
local autoJoinThread = nil

local function StopAutoJoiner()
    CONFIG.AutoJoinEnabled = false
    SaveState()
    AutoJoinBtn.Text = "▷  Auto Joiner"
    AutoJoinBtn.BackgroundColor3 = Color3.fromRGB(15, 22, 50)
    AutoJoinBtn.TextColor3 = Color3.fromRGB(100, 140, 220)
    AJStroke.Color = Color3.fromRGB(30, 55, 130)
    autoJoinThread = nil
    StatusLabel.Text = "⏳ Auto Joiner Stopped"
    StatusLabel.TextColor3 = Color3.fromRGB(60, 110, 190)
end

local function StartAutoJoiner()
    if autoJoinThread then return end
    CONFIG.AutoJoinEnabled = true
    SaveState()

    AutoJoinBtn.Text = "■  Auto Joiner (ON)"
    AutoJoinBtn.BackgroundColor3 = Color3.fromRGB(20, 90, 50)
    AutoJoinBtn.TextColor3 = Color3.fromRGB(100, 255, 150)
    AJStroke.Color = Color3.fromRGB(30, 140, 70)

    autoJoinThread = task.spawn(function()
        task.wait(2) -- Wait for game to stream parts
        while CONFIG.AutoJoinEnabled do
            StatusLabel.Text = "🔍 Scanning server for brainrots..."

            local foundMap = ScanCurrentServer()
            local foundList = {}
            for _, d in pairs(foundMap) do table.insert(foundList, d) end

            if #foundList > 0 then
                -- Brainrot matches filter! STOP HOPPING.
                detectedBrainrots = foundList
                RenderResults()

                StatusLabel.Text = "✅ FOUND " .. #foundList .. " brainrot(s)! Auto-Hop stopped."
                StatusLabel.TextColor3 = Color3.fromRGB(80, 255, 130)

                pcall(function()
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "⚡ SynthZXSHub",
                        Text = "Brainrot matched filter! Staying in server.",
                        Duration = 10,
                    })
                end)

                StopAutoJoiner()
                break -- Exit thread
            else
                -- Nothing found or nothing matching filter, HOP!
                StatusLabel.Text = "❌ No matches found. Hopping to next server..."
                StatusLabel.TextColor3 = Color3.fromRGB(255, 120, 80)
                
                task.wait(1)
                if CONFIG.AutoJoinEnabled then
                    ServerHop()
                    task.wait(10) -- Wait for teleport to take effect, otherwise loops
                end
            end
        end
    end)
end

-------------------------------------------------
-- CONTROLS
-------------------------------------------------
HopButton.MouseButton1Click:Connect(ServerHop)

AutoJoinBtn.MouseButton1Click:Connect(function()
    if CONFIG.AutoJoinEnabled then StopAutoJoiner() else StartAutoJoiner() end
end)

CloseBtn.MouseButton1Click:Connect(function()
    StopAutoJoiner()
    ScreenGui:Destroy()
end)

local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    ResultsFrame.Visible = not minimized; BottomFrame.Visible = not minimized; TabBar.Visible = not minimized
    MainFrame.Size = minimized and UDim2.new(0, 340, 0, 50) or UDim2.new(0, 340, 0, 440)
    MinBtn.Text = minimized and "+" or "—"
end)

local function AddHover(btn)
    local orig = btn.BackgroundColor3
    btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(math.min(orig.R*255+20, 255), math.min(orig.G*255+20, 255), math.min(orig.B*255+20, 255)) end)
    btn.MouseLeave:Connect(function() btn.BackgroundColor3 = orig end)
end
AddHover(HopButton); AddHover(CloseBtn)

-------------------------------------------------
-- STARTUP
-------------------------------------------------
task.spawn(function()
    task.wait(1)
    local found = ScanCurrentServer()
    for _, d in pairs(found) do table.insert(detectedBrainrots, d) end
    if #detectedBrainrots > 0 then RenderResults() end

    -- Resume auto join if we were hopping
    if CONFIG.AutoJoinEnabled then
        StartAutoJoiner()
    end
end)

task.spawn(function()
    while ScreenGui.Parent do
        local ping = 0; pcall(function() ping = math.floor(LocalPlayer:GetNetworkPing() * 1000) end)
        local fps = 0; pcall(function() fps = math.floor(1 / RunService.RenderStepped:Wait()) end)
        PingLabel.Text = (ping<80 and"🟢"or(ping<150 and"🟡"or"🔴")) .. " " .. ping .. "ms  |  " .. fps .. " FPS"
        task.wait(0.5)
    end
end)
