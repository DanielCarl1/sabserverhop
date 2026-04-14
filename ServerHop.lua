--[[
    ╔══════════════════════════════════════════════════════════════╗
    ║                   SynthZXSHub                                ║
    ║        Clean Server Hopper (No Scanner)                      ║
    ║                  volt.bz                                     ║
    ╚══════════════════════════════════════════════════════════════╝
]]

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local PlaceId = game.PlaceId

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
Instance.new("UIStroke", PingBar).Color = Color3.fromRGB(40, 90, 200)

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
-- MAIN GUI FRAME (MINIMAL)
-------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 240, 0, 160)
MainFrame.Position = UDim2.new(0.5, -120, 0.5, -80)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 45, 80)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 8)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -40, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Server Hopper"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 14
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -30, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.BackgroundTransparency = 0.5
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TitleBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 25)
StatusLabel.Position = UDim2.new(0, 0, 1, -30)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Status: Idle"
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.TextSize = 11
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Parent = MainFrame

-------------------------------------------------
-- HOOKS
-------------------------------------------------
local HopAscBtn = Instance.new("TextButton")
HopAscBtn.Size = UDim2.new(1, -20, 0, 35)
HopAscBtn.Position = UDim2.new(0, 10, 0, 45)
HopAscBtn.BackgroundColor3 = Color3.fromRGB(30, 70, 150)
HopAscBtn.Text = "📉 Hop Smallest (Ascending)"
HopAscBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HopAscBtn.TextSize = 12
HopAscBtn.Font = Enum.Font.GothamBold
HopAscBtn.Parent = MainFrame
Instance.new("UICorner", HopAscBtn).CornerRadius = UDim.new(0, 6)

local HopDescBtn = Instance.new("TextButton")
HopDescBtn.Size = UDim2.new(1, -20, 0, 35)
HopDescBtn.Position = UDim2.new(0, 10, 0, 85)
HopDescBtn.BackgroundColor3 = Color3.fromRGB(150, 70, 30)
HopDescBtn.Text = "📈 Hop Biggest (Descending)"
HopDescBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HopDescBtn.TextSize = 12
HopDescBtn.Font = Enum.Font.GothamBold
HopDescBtn.Parent = MainFrame
Instance.new("UICorner", HopDescBtn).CornerRadius = UDim.new(0, 6)

-------------------------------------------------
-- LOGIC
-------------------------------------------------
local function FetchAndHop(sortOrder)
    StatusLabel.Text = "Status: Fetching servers..."
    local url = "https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=" .. sortOrder .. "&limit=100"
    
    local ok, res = pcall(function()
        -- Use standard game:HttpGet, volt.bz natively supports this
        return HttpService:JSONDecode(game:HttpGet(url))
    end)
    
    if not ok then
        StatusLabel.Text = "Status: Failed to fetch API!"
        return
    end

    if res and res.data then
        local targetServer = nil
        
        -- Find the first valid server that is not our current server and has room
        for _, server in ipairs(res.data) do
            if server.id ~= game.JobId and server.playing and server.maxPlayers and server.playing < server.maxPlayers then
                targetServer = server
                break
            end
        end

        if targetServer then
            StatusLabel.Text = "Status: Joining server (" .. targetServer.playing .. " plrs)..."
            pcall(function()
                TeleportService:TeleportToPlaceInstance(PlaceId, targetServer.id, LocalPlayer)
            end)
        else
            StatusLabel.Text = "Status: No open servers found!"
        end
    else
        StatusLabel.Text = "Status: Bad API response."
    end
end

HopAscBtn.MouseButton1Click:Connect(function() 
    HopAscBtn.Text = "..."
    FetchAndHop("Asc") 
    task.wait(1)
    HopAscBtn.Text = "📉 Hop Smallest (Ascending)"
end)

HopDescBtn.MouseButton1Click:Connect(function() 
    HopDescBtn.Text = "..."
    FetchAndHop("Desc") 
    task.wait(1)
    HopDescBtn.Text = "📈 Hop Biggest (Descending)"
end)

-------------------------------------------------
-- PING & FPS LOOP
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
