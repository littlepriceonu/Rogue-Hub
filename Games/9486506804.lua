if getgenv().Rogue_AlreadyLoaded ~= nil then error("Spooky Hub was already found running or you have other scripts executed!") return else getgenv().Rogue_AlreadyLoaded = 0 end

if game.PlaceId ~= 9486506804 then return end

local teleportFunc = queueonteleport or queue_on_teleport or syn and syn.queue_on_teleport

if teleportFunc then
    teleportFunc([[loadstring(game:HttpGet("https://raw.githubusercontent.com/Kitzoon/Rogue-Hub/main/Main.lua", true))()]])
end

local sound = Instance.new("Sound", workspace)
sound.SoundId = "rbxassetid://1548304764"
sound.PlayOnRemove = true
sound.Volume = 0.5

local Config = {
    WindowName = "Spooky Hub | " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name or "FIFA World",
    Color = Color3.fromRGB(242, 125, 20),
    Keybind = Enum.KeyCode.RightControl
}

getgenv().settings = {
    walkSpeedVal = 16
}

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/BracketV3.lua"))()
local window = library:CreateWindow(Config, game:GetService("CoreGui"))
local mainTab = window:CreateTab("Main")

local localPlr = game:GetService("Players").LocalPlayer

localPlr.CharacterAdded:Connect(function()
    local humanoid = localPlr.Character:WaitForChild("Humanoid")
    
    localPlr.Character.Humanoid.WalkSpeed = getgenv().settings.walkSpeedVal or 16
end)

-- Collecting

local collectSec = mainTab:CreateSection("Collecting")

local letter = collectSec:CreateButton("Collect All Letters", function()
    if localPlr.Character ~= nil then
        for _, letter in pairs(workspace.ScavengerHunt.Step1.Objects:GetChildren()) do
            if string.find(letter.Name, "Symbol") then
                firetouchinterest(localPlr.Character.HumanoidRootPart, letter.Root, 0)
                firetouchinterest(localPlr.Character.HumanoidRootPart, letter.Root, 1)
            end
        end
    end
end)

letter:AddToolTip("Collects all treasure hunt letters, gets you a free UGC item.")

collectSec:CreateButton("Collect All Visa Coins", function()
    if localPlr.Character ~= nil then
        for _, coin in ipairs(workspace:GetDescendants()) do
            if coin.Name == "Coin" and coin:FindFirstChildOfClass("TouchTransmitter") then
                firetouchinterest(localPlr.Character.HumanoidRootPart, coin, 0)
                firetouchinterest(localPlr.Character.HumanoidRootPart, coin, 1)
            end
        end
    end
end)

-- Player

local playerSec = mainTab:CreateSection("Player")

playerSec:CreateSlider("Walk Speed", 16,300,getgenv().settings.walkSpeedVal or 16,true, function(value)
	getgenv().settings.walkSpeedVal = value
    localPlr.Character.Humanoid.WalkSpeed = getgenv().settings.walkSpeedVal
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Spooky Hub Message",
    Text = "Happy Halloween!",
    Duration = 5
})

sound:Destroy()
