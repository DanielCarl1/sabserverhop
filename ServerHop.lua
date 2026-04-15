--[[
    ╔══════════════════════════════════════════════════════════════╗
    ║                   SynthZXSHub                                ║
    ║             FPS Booster & Smoother                           ║
    ╚══════════════════════════════════════════════════════════════╝
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Terrain = Workspace:WaitForChild("Terrain")

local LocalPlayer = Players.LocalPlayer

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
-- PING BAR & WATERMARK
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
Watermark.Text = "⚡ synthzxshub (FPS Boost)"
Watermark.TextColor3 = Color3.fromRGB(70, 130, 240)
Watermark.TextSize = 10
Watermark.Font = Enum.Font.GothamBold
Watermark.Parent = ScreenGui

-------------------------------------------------
-- SERVER HOP BUTTON
-------------------------------------------------
local HopButton = Instance.new("TextButton")
HopButton.Name = "ServerHopButton"
HopButton.Size = UDim2.new(0, 150, 0, 24)
HopButton.Position = UDim2.new(1, -160, 0, 56)
HopButton.BackgroundColor3 = Color3.fromRGB(15, 20, 30)
HopButton.BackgroundTransparency = 0.2
HopButton.BorderSizePixel = 0
HopButton.Text = "🌍 Server Hop"
HopButton.TextColor3 = Color3.fromRGB(100, 180, 255)
HopButton.TextSize = 12
HopButton.Font = Enum.Font.GothamBold
HopButton.Parent = ScreenGui
Instance.new("UICorner", HopButton).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", HopButton).Color = Color3.fromRGB(40, 90, 200)

-------------------------------------------------
-- AUTO EXIT ON BRAINROT
-------------------------------------------------
local AutoExitButton = Instance.new("TextButton")
AutoExitButton.Name = "AutoExitButton"
AutoExitButton.Size = UDim2.new(0, 150, 0, 24)
AutoExitButton.Position = UDim2.new(1, -160, 0, 84)
AutoExitButton.BackgroundColor3 = Color3.fromRGB(15, 20, 30)
AutoExitButton.BackgroundTransparency = 0.2
AutoExitButton.BorderSizePixel = 0
AutoExitButton.Text = "🛑 Auto Exit: OFF"
AutoExitButton.TextColor3 = Color3.fromRGB(100, 180, 255)
AutoExitButton.TextSize = 12
AutoExitButton.Font = Enum.Font.GothamBold
AutoExitButton.Parent = ScreenGui
Instance.new("UICorner", AutoExitButton).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", AutoExitButton).Color = Color3.fromRGB(40, 90, 200)

local autoExitEnabled = false
AutoExitButton.MouseButton1Click:Connect(function()
    autoExitEnabled = not autoExitEnabled
    AutoExitButton.Text = "🛑 Auto Exit: " .. (autoExitEnabled and "ON" or "OFF")
end)

local function triggerAutoExit()
    if not autoExitEnabled then return end
    
    -- Blue UI Message
    local ExitGui = Instance.new("ScreenGui")
    ExitGui.Name = "AutoExitMessage"
    ExitGui.IgnoreGuiInset = true
    pcall(function() ExitGui.Parent = CoreGui end)
    if not ExitGui.Parent then ExitGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end
    
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 1, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
    Frame.BorderSizePixel = 0
    Frame.Parent = ExitGui
    
    local Text = Instance.new("TextLabel")
    Text.Size = UDim2.new(1, 0, 1, 0)
    Text.BackgroundTransparency = 1
    Text.Text = "PALDO KA NA NAMAN"
    Text.TextColor3 = Color3.fromRGB(255, 255, 255)
    Text.TextSize = 60
    Text.Font = Enum.Font.GothamBlack
    Text.Parent = Frame
    
    -- Very short wait just to flash the blue UI, then instantly kick
    task.wait(0.1)
    LocalPlayer:Kick("PALDO KA NA NAMAN SARDINAS")
end

-- Detect Leaderstats Increase (when you successfully steal/deposit it)
task.spawn(function()
    local leaderstats = LocalPlayer:WaitForChild("leaderstats", 10)
    if leaderstats then
        for _, stat in ipairs(leaderstats:GetChildren()) do
            if stat:IsA("IntValue") or stat:IsA("NumberValue") then
                local lastValue = stat.Value
                stat.Changed:Connect(function(newValue)
                    if newValue > lastValue then
                        triggerAutoExit()
                    end
                    lastValue = newValue
                end)
            end
        end
        leaderstats.ChildAdded:Connect(function(stat)
            if stat:IsA("IntValue") or stat:IsA("NumberValue") then
                local lastValue = stat.Value
                stat.Changed:Connect(function(newValue)
                    if newValue > lastValue then
                        triggerAutoExit()
                    end
                    lastValue = newValue
                end)
            end
        end)
    end
end)

-- Detect obtaining a Brainrot tool (When you pick it up)
local function checkToolAdded(child)
    if child:IsA("Tool") then
        local name = string.lower(child.Name)
        if name:find("brainrot") or name:find("skibidi") or name:find("gyatt") or name:find("sigma") or name:find("mewing") or name:find("rizz") then
            triggerAutoExit()
        end
    end
end
LocalPlayer.Backpack.ChildAdded:Connect(checkToolAdded)
LocalPlayer.CharacterAdded:Connect(function(char)
    char.ChildAdded:Connect(checkToolAdded)
end)
if LocalPlayer.Character then
    LocalPlayer.Character.ChildAdded:Connect(checkToolAdded)
end

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

local isHopping = false
HopButton.MouseButton1Click:Connect(function()
    if isHopping then return end
    isHopping = true
    HopButton.Text = "⏳ Hopping..."
    
    task.spawn(function()
        local placeId = game.PlaceId
        local currentJobId = game.JobId
        
        local function fetchServers()
            -- excludeFullGames ensures we don't try to join full servers
            local url = "https://games.roblox.com/v1/games/" .. tostring(placeId) .. "/servers/Public?sortOrder=Desc&excludeFullGames=true&limit=100"
            local success, result = pcall(function()
                return HttpService:JSONDecode(game:HttpGet(url))
            end)
            if success and result and result.data then
                return result
            end
            return nil
        end

        local serverData = fetchServers()
        local servers = {}
        
        if serverData and serverData.data then
            for _, v in ipairs(serverData.data) do
                if type(v) == "table" and v.playing and v.maxPlayers and v.id then
                    -- Don't join the current server, and make sure there's at least one slot open
                    if v.id ~= currentJobId and v.playing < v.maxPlayers then
                        table.insert(servers, v.id)
                    end
                end
            end
        end

        if #servers > 0 then
            local randomServer = servers[math.random(1, #servers)]
            pcall(function()
                TeleportService:TeleportToPlaceInstance(placeId, randomServer, LocalPlayer)
            end)
            
            -- If we haven't teleported after 5 seconds, let the user try again
            task.wait(5)
            HopButton.Text = "❌ Teleport Failed"
            task.wait(2)
            HopButton.Text = "🌍 Server Hop"
            isHopping = false
        else
            HopButton.Text = "❌ No Servers Found"
            task.wait(2)
            HopButton.Text = "🌍 Server Hop"
            isHopping = false
        end
    end)
end)

-------------------------------------------------
-- FPS BOOSTER / SMOOTHER LOGIC
-------------------------------------------------
local function OptimizeGame()
    -- 1. Optimize Lighting
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    Lighting.ShadowSoftness = 0

    pcall(function()
        Lighting.Technology = Enum.Technology.Compatibility
    end)

    -- 2. Clean Lighting Effects
    for _, obj in ipairs(Lighting:GetChildren()) do
        if obj:IsA("BlurEffect") or obj:IsA("SunRaysEffect") or obj:IsA("ColorCorrectionEffect") or obj:IsA("BloomEffect") or obj:IsA("DepthOfFieldEffect") then
            obj.Enabled = false
        end
    end

    -- 3. Optimize Terrain Waters & Decorations
    Terrain.WaterWaveSize = 0
    Terrain.WaterWaveSpeed = 0
    Terrain.WaterReflectance = 0
    Terrain.WaterTransparency = 0
    pcall(function() Terrain.Decoration = false end)

    -- 4. Strip Graphics from Parts (Smooth Plastic, No Shadows)
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.Material = Enum.Material.SmoothPlastic
            obj.Reflectance = 0
            obj.CastShadow = false
        elseif obj:IsA("Decal") or obj:IsA("Texture") then
            obj.Transparency = 1 -- Hide textures safely
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
            obj.Lifetime = NumberRange.new(0)
        elseif obj:IsA("Explosion") then
            obj.BlastPressure = 1
            obj.BlastRadius = 1
        elseif obj:IsA("Fire") or obj:IsA("SpotLight") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
            obj.Enabled = false
        end
    end
end

-- Run optimization on script execution
pcall(function()
    OptimizeGame()
    -- Notify User
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "⚡ SynthZXSHub",
        Text = "FPS Graphics Booster applied successfully!",
        Duration = 5,
    })
end)

-- Hook onto newly created objects to keep the game optimized and smooth
Workspace.DescendantAdded:Connect(function(obj)
    if obj:IsA("BasePart") then
        obj.Material = Enum.Material.SmoothPlastic
        obj.Reflectance = 0
        obj.CastShadow = false
    elseif obj:IsA("Decal") or obj:IsA("Texture") then
        obj.Transparency = 1
    elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
        obj.Lifetime = NumberRange.new(0)
    elseif obj:IsA("Fire") or obj:IsA("SpotLight") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
        obj.Enabled = false
    end
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
