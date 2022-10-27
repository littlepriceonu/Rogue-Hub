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

local ourColor = Color3.fromRGB(242, 125, 20)

function CheckConfigFile()
    if not isfile("/Rogue Hub/Configs/Keybind.ROGUEHUB") then return Enum.KeyCode.RightControl else return Enum.KeyCode[game:GetService("HttpService"):JSONDecode(readfile("/Rogue Hub/Configs/Keybind.ROGUEHUB"))["Key"]] or Enum.KeyCode.RightControl end
end

local Config = {
    WindowName = "Rogue Hub | " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
    Color = ourColor,
    Keybind = CheckConfigFile()
}

getgenv().settings = {
    walkSpeedVal = 16
}

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Bracket/main/BracketV3.lua"))()
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

-- Info

local infoTab = window:CreateTab("Extra")
local uiSec = infoTab:CreateSection("UI Settings")

local uiColor = uiSec:CreateColorpicker("UI Color", function(color)
	window:ChangeColor(color)
end)

uiColor:UpdateColor(Config.Color)

local uiTog = uiSec:CreateToggle("UI Toggle", nil, function(bool)
	window:Toggle(bool)
end)

uiTog:CreateKeybind(tostring(Config.Keybind):gsub("Enum.KeyCode.", ""), function(key)
	if key == "Escape" or key == "Backspace" then key = "NONE" end
	
    if key == "NONE" then return else Config.Keybind = Enum.KeyCode[key] end
end)

uiTog:SetState(true)

local uiRainbow = uiSec:CreateToggle("Rainbow UI", false, function(bool)
	getgenv().rainbowUI = bool
    
    while getgenv().rainbowUI and task.wait() do
        local hue = tick() % 10 / 10
        local rainbow = Color3.fromHSV(hue, 1, 1)
            
        window:ChangeColor(rainbow)
        uiColor:UpdateColor(rainbow)
    end
end)

local infoSec = infoTab:CreateSection("Credits")

local req = http_request or request or syn.request

-- I ALSO KILLED KYRON ON MY BIRTHDAY - FROM KITZOON
infoSec:CreateLabel("🍑 MY UNCLE DID A PUMPKIN IN BED 🍑")

infoSec:CreateButton("Devil of Spooky Hub: Kitzoon#7750", function()
    setclipboard("Kitzoon#7750")
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Spooky Hub Note",
        Text = "Copied Kitzoon's discord username and tag to your clipboard.",
        Duration = 5
    })
end)

infoSec:CreateButton("Blood sucking helper: Kyron#6083", function()
    setclipboard("Kyron#6083")
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Script Notification",
        Text = "Copied Kyron's discord username and tag to your clipboard.",
        Duration = 5
    })
end)

infoSec:CreateButton("Consider donating on PayPal!", function()
    setclipboard("https://paypal.me/RogueHub")
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Spooky Hub Note",
        Text = "Copied our PayPal donate page to your clipboard, donate any amount to it!",
        Duration = 5
    })
end)

infoSec:CreateButton("Consider donating on Bitcoin!", function()
    setclipboard("bc1qnrajmhe83hreyjm9uzrq0ytvu2mg6w2nknl2vy")
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Spooky Hub Note",
        Text = "Copied our Bitcoin address to your clipboard, donate any amount to it!",
        Duration = 5
    })
end)

infoSec:CreateButton("Join us on discord!", function()
	if req then
        req({
            Url = "http://127.0.0.1:6463/rpc?v=1",
            Method = "POST",
            
            Headers = {
                ["Content-Type"] = "application/json",
                ["origin"] = "https://discord.com",
            },
                    
            Body = game:GetService("HttpService"):JSONEncode(
            {
                ["args"] = {
                ["code"] = "VdrHU8KP7c",
                },
                        
                ["cmd"] = "INVITE_BROWSER",
                ["nonce"] = "."
            })
        })
    else
        setclipboard("https://discord.gg/VdrHU8KP7c")
    
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Spooky Hub Note",
            Text = "Copied our discord server to your clipboard.",
            Duration = 5
        })
    end
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Spooky Hub Message",
    Text = "Happy Halloween!",
    Duration = 5
})

sound:Destroy()
