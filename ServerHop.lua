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
