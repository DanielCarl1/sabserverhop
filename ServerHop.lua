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
local Stats = game:GetService("Stats")
local Workspace = game:GetService("Workspace")

-- Player
local LocalPlayer = Players.LocalPlayer
local PlaceId = game.PlaceId
local JobId = game.JobId

-------------------------------------------------
-- BRAINROT DATABASE
-- value 0 = RARE    |   value 1B = COMMON
-------------------------------------------------

local BRAINROT_DB = {
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
    ["ventoliero-pavonero"] = 500000000,
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

-------------------------------------------------
-- CONFIG
-------------------------------------------------

local CONFIG = {
    MaxServers = 100,
    ScanDelay = 1.5,
    HopDelay = 2,
    SkipDuels = true,
    FilterMode = "AJ",  -- "100m", "50m", "10m", "AJ"
    AutoJoinEnabled = false,
    IsScanning = false,
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
if not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

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

-------------------------------------------------
-- WATERMARK (below ping bar)
-------------------------------------------------

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

-- Top accent line
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

-------------------------------------------------
-- HEADER
-------------------------------------------------

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
SubTitle.Text = "steal a brainrot scanner"
SubTitle.TextColor3 = Color3.fromRGB(50, 90, 160)
SubTitle.TextSize = 9
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = Header

-- Header buttons (settings icon, minimize, close)
local function MakeHeaderBtn(text, posX, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 24, 0, 24)
    btn.Position = UDim2.new(1, posX, 0, 10)
    btn.BackgroundColor3 = color
    btn.BackgroundTransparency = 0.6
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(200, 210, 240)
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = Header
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 5)
    c.Parent = btn
    return btn
end

local CloseBtn = MakeHeaderBtn("✕", -34, Color3.fromRGB(160, 30, 30))
local MinBtn = MakeHeaderBtn("—", -62, Color3.fromRGB(20, 40, 100))

-------------------------------------------------
-- FILTER TABS (like Moby: 100m+, 50m+, 10m+, AJ)
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

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 7)
    corner.Parent = btn

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(25, 55, 140)
    stroke.Thickness = 1
    stroke.Transparency = 0.5
    stroke.Parent = btn

    tabButtons[name] = {Button = btn, Stroke = stroke}
    return btn
end

local tab100m = CreateTab("100m", "100m+", 1)
local tab50m = CreateTab("50m", "50m+", 2)
local tab10m = CreateTab("10m", "10m+", 3)
local tabAJ = CreateTab("AJ", "AJ", 4)

local function SetActiveTab(tabName)
    CONFIG.FilterMode = tabName
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

SetActiveTab("AJ")

tab100m.MouseButton1Click:Connect(function() SetActiveTab("100m") end)
tab50m.MouseButton1Click:Connect(function() SetActiveTab("50m") end)
tab10m.MouseButton1Click:Connect(function() SetActiveTab("10m") end)
tabAJ.MouseButton1Click:Connect(function() SetActiveTab("AJ") end)

-------------------------------------------------
-- RESULTS AREA (scrolling list of found brainrots)
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

local ResultsCorner = Instance.new("UICorner")
ResultsCorner.CornerRadius = UDim.new(0, 8)
ResultsCorner.Parent = ResultsFrame

local ResultsStroke = Instance.new("UIStroke")
ResultsStroke.Color = Color3.fromRGB(20, 45, 110)
ResultsStroke.Thickness = 1
ResultsStroke.Parent = ResultsFrame

local ResultsLayout = Instance.new("UIListLayout")
ResultsLayout.SortOrder = Enum.SortOrder.LayoutOrder
ResultsLayout.Padding = UDim.new(0, 2)
ResultsLayout.Parent = ResultsFrame

local ResultsPadding = Instance.new("UIPadding")
ResultsPadding.PaddingTop = UDim.new(0, 4)
ResultsPadding.PaddingBottom = UDim.new(0, 4)
ResultsPadding.PaddingLeft = UDim.new(0, 4)
ResultsPadding.PaddingRight = UDim.new(0, 4)
ResultsPadding.Parent = ResultsFrame

-- Empty state label
local EmptyLabel = Instance.new("TextLabel")
EmptyLabel.Name = "EmptyLabel"
EmptyLabel.Size = UDim2.new(1, 0, 0, 60)
EmptyLabel.BackgroundTransparency = 1
EmptyLabel.Text = "No brainrots detected yet.\nStart scanning to find brainrots!"
EmptyLabel.TextColor3 = Color3.fromRGB(50, 70, 120)
EmptyLabel.TextSize = 11
EmptyLabel.Font = Enum.Font.Gotham
EmptyLabel.Parent = ResultsFrame

-------------------------------------------------
-- RESULT ROW BUILDER
-------------------------------------------------

local function FormatValue(val)
    if val >= 1000000000 then
        return string.format("$%.1fB", val / 1000000000)
    elseif val >= 1000000 then
        return string.format("$%.0fM", val / 1000000)
    elseif val >= 1000 then
        return string.format("$%.0fK", val / 1000)
    elseif val == 0 then
        return "RARE"
    else
        return "$" .. tostring(val)
    end
end

local function PrettyName(id)
    -- Convert "burguro-and-fryuro" to "Burguro And Fryuro"
    local words = {}
    for word in id:gmatch("[^%-]+") do
        table.insert(words, word:sub(1,1):upper() .. word:sub(2))
    end
    return table.concat(words, " ")
end

local function CreateResultRow(brainrotId, value, serverId, serverPlayers, layoutOrder)
    local row = Instance.new("Frame")
    row.Name = "Row_" .. brainrotId
    row.Size = UDim2.new(1, -4, 0, 42)
    row.BackgroundColor3 = Color3.fromRGB(12, 18, 40)
    row.BorderSizePixel = 0
    row.LayoutOrder = layoutOrder
    row.Parent = ResultsFrame

    local rowCorner = Instance.new("UICorner")
    rowCorner.CornerRadius = UDim.new(0, 6)
    rowCorner.Parent = row

    -- Rarity indicator dot
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 6, 0, 6)
    dot.Position = UDim2.new(0, 8, 0.5, -3)
    dot.BorderSizePixel = 0
    dot.Parent = row

    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = dot

    if value == 0 then
        dot.BackgroundColor3 = Color3.fromRGB(255, 200, 50) -- Gold for rare
    elseif value <= 500000000 then
        dot.BackgroundColor3 = Color3.fromRGB(150, 80, 255) -- Purple for mid
    else
        dot.BackgroundColor3 = Color3.fromRGB(60, 160, 255) -- Blue for common
    end

    -- Brainrot name
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(0, 150, 0, 18)
    nameLabel.Position = UDim2.new(0, 20, 0, 4)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "🧠 " .. PrettyName(brainrotId)
    nameLabel.TextColor3 = Color3.fromRGB(200, 215, 255)
    nameLabel.TextSize = 11
    nameLabel.Font = Enum.Font.GothamSemibold
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.TextTruncate = Enum.TextTruncate.AtEnd
    nameLabel.Parent = row

    -- Value label
    local valLabel = Instance.new("TextLabel")
    valLabel.Size = UDim2.new(0, 150, 0, 14)
    valLabel.Position = UDim2.new(0, 20, 0, 22)
    valLabel.BackgroundTransparency = 1
    valLabel.Text = FormatValue(value) .. "  •  " .. (serverPlayers or "?") .. " players"
    valLabel.TextColor3 = value == 0 and Color3.fromRGB(255, 200, 50) or Color3.fromRGB(80, 130, 200)
    valLabel.TextSize = 9
    valLabel.Font = Enum.Font.Gotham
    valLabel.TextXAlignment = Enum.TextXAlignment.Left
    valLabel.Parent = row

    -- JOIN button
    local joinBtn = Instance.new("TextButton")
    joinBtn.Name = "JoinBtn"
    joinBtn.Size = UDim2.new(0, 48, 0, 26)
    joinBtn.Position = UDim2.new(1, -110, 0.5, -13)
    joinBtn.BackgroundColor3 = Color3.fromRGB(30, 90, 230)
    joinBtn.Text = "JOIN"
    joinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    joinBtn.TextSize = 11
    joinBtn.Font = Enum.Font.GothamBold
    joinBtn.BorderSizePixel = 0
    joinBtn.Parent = row

    local joinCorner = Instance.new("UICorner")
    joinCorner.CornerRadius = UDim.new(0, 5)
    joinCorner.Parent = joinBtn

    -- HOP button (spam hop to that server)
    local hopBtn = Instance.new("TextButton")
    hopBtn.Name = "HopBtn"
    hopBtn.Size = UDim2.new(0, 48, 0, 26)
    hopBtn.Position = UDim2.new(1, -56, 0.5, -13)
    hopBtn.BackgroundColor3 = Color3.fromRGB(30, 90, 230)
    hopBtn.Text = "HOP"
    hopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    hopBtn.TextSize = 11
    hopBtn.Font = Enum.Font.GothamBold
    hopBtn.BorderSizePixel = 0
    hopBtn.Parent = row

    local hopCorner = Instance.new("UICorner")
    hopCorner.CornerRadius = UDim.new(0, 5)
    hopCorner.Parent = hopBtn

    -- Button actions
    if serverId then
        joinBtn.MouseButton1Click:Connect(function()
            joinBtn.Text = "..."
            pcall(function()
                TeleportService:TeleportToPlaceInstance(PlaceId, serverId, LocalPlayer)
            end)
        end)

        hopBtn.MouseButton1Click:Connect(function()
            hopBtn.Text = "..."
            -- Keep trying to join
            task.spawn(function()
                for i = 1, 5 do
                    pcall(function()
                        TeleportService:TeleportToPlaceInstance(PlaceId, serverId, LocalPlayer)
                    end)
                    task.wait(2)
                end
            end)
        end)
    else
        -- If current server, disable join
        joinBtn.BackgroundColor3 = Color3.fromRGB(20, 60, 100)
        joinBtn.Text = "HERE"
        joinBtn.TextColor3 = Color3.fromRGB(100, 180, 255)

        hopBtn.Visible = false
    end

    return row
end

-------------------------------------------------
-- BOTTOM CONTROLS
-------------------------------------------------

local BottomFrame = Instance.new("Frame")
BottomFrame.Size = UDim2.new(1, -20, 0, 100)
BottomFrame.Position = UDim2.new(0, 10, 0, 315)
BottomFrame.BackgroundTransparency = 1
BottomFrame.Parent = MainFrame

local BottomLayout = Instance.new("UIListLayout")
BottomLayout.SortOrder = Enum.SortOrder.LayoutOrder
BottomLayout.Padding = UDim.new(0, 5)
BottomLayout.Parent = BottomFrame

-- Status
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Size = UDim2.new(1, 0, 0, 16)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "⏳ Idle  •  0 servers scanned"
StatusLabel.TextColor3 = Color3.fromRGB(60, 110, 190)
StatusLabel.TextSize = 10
StatusLabel.Font = Enum.Font.GothamSemibold
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.LayoutOrder = 1
StatusLabel.Parent = BottomFrame

-- Server Hop Button
local HopButton = Instance.new("TextButton")
HopButton.Name = "HopButton"
HopButton.Size = UDim2.new(1, 0, 0, 34)
HopButton.BackgroundColor3 = Color3.fromRGB(20, 50, 140)
HopButton.Text = "🔄  Server Hop"
HopButton.TextColor3 = Color3.fromRGB(160, 200, 255)
HopButton.TextSize = 13
HopButton.Font = Enum.Font.GothamSemibold
HopButton.BorderSizePixel = 0
HopButton.LayoutOrder = 2
HopButton.Parent = BottomFrame

local HopCorner = Instance.new("UICorner")
HopCorner.CornerRadius = UDim.new(0, 7)
HopCorner.Parent = HopButton

local HopStroke = Instance.new("UIStroke")
HopStroke.Color = Color3.fromRGB(35, 80, 200)
HopStroke.Thickness = 1
HopStroke.Parent = HopButton

-- Auto Joiner Button (toggle)
local AutoJoinBtn = Instance.new("TextButton")
AutoJoinBtn.Name = "AutoJoinBtn"
AutoJoinBtn.Size = UDim2.new(1, 0, 0, 34)
AutoJoinBtn.BackgroundColor3 = Color3.fromRGB(15, 22, 50)
AutoJoinBtn.Text = "▷  Auto Joiner"
AutoJoinBtn.TextColor3 = Color3.fromRGB(100, 140, 220)
AutoJoinBtn.TextSize = 13
AutoJoinBtn.Font = Enum.Font.GothamSemibold
AutoJoinBtn.BorderSizePixel = 0
AutoJoinBtn.LayoutOrder = 3
AutoJoinBtn.Parent = BottomFrame

local AJCorner = Instance.new("UICorner")
AJCorner.CornerRadius = UDim.new(0, 7)
AJCorner.Parent = AutoJoinBtn

local AJStroke = Instance.new("UIStroke")
AJStroke.Color = Color3.fromRGB(30, 55, 130)
AJStroke.Thickness = 1
AJStroke.Parent = AutoJoinBtn

-------------------------------------------------
-- CORE LOGIC
-------------------------------------------------

local serversScanned = 0
local isHopping = false
local detectedBrainrots = {} -- array of {id, value, serverId, players}

-- Normalize name for matching
local function Normalize(name)
    return name:lower():gsub("%s+", "-"):gsub("_", "-")
end

-- Get filter threshold based on active tab
local function GetFilterThreshold()
    if CONFIG.FilterMode == "100m" then return 100000000
    elseif CONFIG.FilterMode == "50m" then return 50000000
    elseif CONFIG.FilterMode == "10m" then return 10000000
    else return math.huge -- AJ = show all
    end
end

-- Fetch servers from API
local function GetServers()
    local servers = {}
    local url = "https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=" .. CONFIG.MaxServers

    local ok, result = pcall(function()
        return HttpService:JSONDecode(game:HttpGet(url))
    end)

    if ok and result and result.data then
        for _, s in ipairs(result.data) do
            if s.id ~= JobId and s.playing and s.maxPlayers and s.playing < s.maxPlayers then
                table.insert(servers, s)
            end
        end
    end

    return servers
end

-- Scan current server workspace for brainrots
local function ScanCurrentServer()
    local found = {}
    local threshold = GetFilterThreshold()

    local function CheckObj(obj)
        local normalized = Normalize(obj.Name)
        for brainrotId, value in pairs(BRAINROT_DB) do
            -- Match if object name contains brainrot name or vice versa
            if normalized:find(brainrotId, 1, true) or brainrotId:find(normalized, 1, true) then
                if CONFIG.FilterMode == "AJ" or value <= threshold then
                    found[brainrotId] = {
                        id = brainrotId,
                        value = value,
                        serverId = nil, -- current server
                        players = #Players:GetPlayers(),
                        object = obj,
                    }
                end
                break
            end
        end
    end

    -- Scan Workspace
    pcall(function()
        for _, obj in ipairs(Workspace:GetDescendants()) do
            pcall(function() CheckObj(obj) end)
        end
    end)

    -- Scan ReplicatedStorage
    pcall(function()
        local RS = game:GetService("ReplicatedStorage")
        for _, obj in ipairs(RS:GetDescendants()) do
            pcall(function() CheckObj(obj) end)
        end
    end)

    return found
end

-- Clear result rows
local function ClearResults()
    for _, child in ipairs(ResultsFrame:GetChildren()) do
        if child:IsA("Frame") and child.Name:find("Row_") then
            child:Destroy()
        end
    end
end

-- Render detected brainrots to the results list
local function RenderResults()
    ClearResults()

    if #detectedBrainrots == 0 then
        EmptyLabel.Visible = true
        return
    end

    EmptyLabel.Visible = false

    -- Sort: rare first (value ascending)
    table.sort(detectedBrainrots, function(a, b) return a.value < b.value end)

    for i, data in ipairs(detectedBrainrots) do
        CreateResultRow(data.id, data.value, data.serverId, data.players, i)
    end
end

-- Teleport to random server
local function ServerHop()
    if isHopping then return end
    isHopping = true
    StatusLabel.Text = "🔍 Fetching servers..."

    local servers = GetServers()

    if #servers == 0 then
        StatusLabel.Text = "❌ No servers available"
        isHopping = false
        return
    end

    local target = servers[math.random(1, #servers)]
    StatusLabel.Text = "🔄 Hopping... (" .. target.playing .. " players)"

    task.wait(0.5)
    pcall(function()
        TeleportService:TeleportToPlaceInstance(PlaceId, target.id, LocalPlayer)
    end)

    isHopping = false
end

-------------------------------------------------
-- AUTO JOINER (scan current → if nothing, hop → repeat)
-------------------------------------------------

local autoJoinThread = nil

local function StartAutoJoiner()
    if autoJoinThread then return end

    CONFIG.AutoJoinEnabled = true
    AutoJoinBtn.Text = "■  Auto Joiner (ON)"
    AutoJoinBtn.BackgroundColor3 = Color3.fromRGB(20, 90, 50)
    AutoJoinBtn.TextColor3 = Color3.fromRGB(100, 255, 150)
    AJStroke.Color = Color3.fromRGB(30, 140, 70)

    autoJoinThread = task.spawn(function()
        while CONFIG.AutoJoinEnabled do
            StatusLabel.Text = "🔍 Scanning server... (" .. serversScanned .. " scanned)"

            -- Scan this server
            local found = ScanCurrentServer()
            serversScanned = serversScanned + 1

            -- Convert found map to list
            local foundList = {}
            for _, data in pairs(found) do
                table.insert(foundList, data)
            end

            if #foundList > 0 then
                -- Add to detected list (avoid duplicates)
                for _, newItem in ipairs(foundList) do
                    local exists = false
                    for _, existing in ipairs(detectedBrainrots) do
                        if existing.id == newItem.id then
                            exists = true
                            break
                        end
                    end
                    if not exists then
                        table.insert(detectedBrainrots, newItem)
                    end
                end

                RenderResults()

                local rareCount = 0
                for _, item in ipairs(foundList) do
                    if item.value == 0 then rareCount = rareCount + 1 end
                end

                StatusLabel.Text = "✅ FOUND " .. #foundList .. " brainrot(s)! (" .. rareCount .. " rare) • " .. serversScanned .. " scanned"
                StatusLabel.TextColor3 = Color3.fromRGB(80, 255, 130)

                -- Notify
                pcall(function()
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "⚡ SynthZXSHub",
                        Text = #foundList .. " brainrot(s) found! " .. rareCount .. " rare!",
                        Duration = 10,
                    })
                end)

                -- Stay in server, keep scanning periodically
                task.wait(5)

            else
                -- Nothing found — hop to next
                StatusLabel.Text = "❌ Nothing found • Hopping... (" .. serversScanned .. " scanned)"
                StatusLabel.TextColor3 = Color3.fromRGB(60, 110, 190)

                task.wait(CONFIG.HopDelay)

                if CONFIG.AutoJoinEnabled then
                    ServerHop()
                    -- Wait for teleport (script re-executes on new server)
                    task.wait(8)
                end
            end

            task.wait(CONFIG.ScanDelay)
        end
    end)
end

local function StopAutoJoiner()
    CONFIG.AutoJoinEnabled = false
    AutoJoinBtn.Text = "▷  Auto Joiner"
    AutoJoinBtn.BackgroundColor3 = Color3.fromRGB(15, 22, 50)
    AutoJoinBtn.TextColor3 = Color3.fromRGB(100, 140, 220)
    AJStroke.Color = Color3.fromRGB(30, 55, 130)
    autoJoinThread = nil
    StatusLabel.Text = "⏳ Idle  •  " .. serversScanned .. " servers scanned"
    StatusLabel.TextColor3 = Color3.fromRGB(60, 110, 190)
end

-------------------------------------------------
-- BUTTON CONNECTIONS
-------------------------------------------------

HopButton.MouseButton1Click:Connect(function()
    ServerHop()
end)

AutoJoinBtn.MouseButton1Click:Connect(function()
    if CONFIG.AutoJoinEnabled then
        StopAutoJoiner()
    else
        StartAutoJoiner()
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    StopAutoJoiner()
    ScreenGui:Destroy()
end)

local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    ResultsFrame.Visible = not minimized
    BottomFrame.Visible = not minimized
    TabBar.Visible = not minimized
    MainFrame.Size = minimized and UDim2.new(0, 340, 0, 50) or UDim2.new(0, 340, 0, 440)
    MinBtn.Text = minimized and "+" or "—"
end)

-- Hover effects
local function AddHover(btn)
    local orig = btn.BackgroundColor3
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(
            math.min(orig.R * 255 + 20, 255),
            math.min(orig.G * 255 + 20, 255),
            math.min(orig.B * 255 + 20, 255)
        )
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = orig
    end)
end

AddHover(HopButton)
AddHover(CloseBtn)

-------------------------------------------------
-- INITIAL SCAN ON LOAD
-------------------------------------------------

task.spawn(function()
    task.wait(1)
    StatusLabel.Text = "🔍 Initial scan..."

    local found = ScanCurrentServer()
    serversScanned = 1

    local foundList = {}
    for _, data in pairs(found) do
        table.insert(foundList, data)
    end

    if #foundList > 0 then
        detectedBrainrots = foundList
        RenderResults()
        StatusLabel.Text = "✅ Found " .. #foundList .. " brainrot(s) in current server!"
        StatusLabel.TextColor3 = Color3.fromRGB(80, 255, 130)
    else
        StatusLabel.Text = "⏳ No brainrots here • " .. serversScanned .. " scanned"
    end
end)

-------------------------------------------------
-- PING + FPS UPDATER
-------------------------------------------------

task.spawn(function()
    while ScreenGui.Parent do
        local ping = 0
        pcall(function()
            ping = math.floor(LocalPlayer:GetNetworkPing() * 1000)
        end)

        local fps = 0
        pcall(function()
            fps = math.floor(1 / RunService.RenderStepped:Wait())
        end)

        local pingColor = ping < 80 and "🟢" or (ping < 150 and "🟡" or "🔴")

        PingLabel.Text = pingColor .. " " .. ping .. "ms  |  " .. fps .. " FPS"

        task.wait(0.5)
    end
end)

-------------------------------------------------
-- INIT LOG
-------------------------------------------------

print("[SynthZXSHub] ✅ Loaded!")
print("[SynthZXSHub] by synthzxshub")
print("[SynthZXSHub] Server: " .. string.sub(JobId, 1, 20))
print("[SynthZXSHub] Brainrots in DB: " .. (function() local c = 0 for _ in pairs(BRAINROT_DB) do c = c + 1 end return c end)())

pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "⚡ SynthZXSHub",
        Text = "Scanner loaded! Ready to find brainrots.",
        Duration = 5,
    })
end)
