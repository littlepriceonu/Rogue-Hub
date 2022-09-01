-- anticheat bypass, ty WhoIsE (staff manager at the krnl discord server) for this

if getconnections then
    for _, connection in pairs(getconnections(game:GetService("LogService").MessageOut)) do
        connection:Disable()
    end
    
    for _, connection in pairs(getconnections(game:GetService("ScriptContext").Error)) do
        connection:Disable()
    end
end

if getgenv().Rogue_AlreadyLoaded ~= nil then error("Rogue Hub was already found running or you have other scripts executed!") return else getgenv().Rogue_AlreadyLoaded = 0 end

if game.PlaceId ~= 6407649031 then return end

local sound = Instance.new("Sound")
sound.Parent = game:GetService("Workspace")
sound.SoundId = "rbxassetid://1548304764"
sound.PlayOnRemove = true
sound.Volume = 0.5

local Config = {
    WindowName = "Rogue Hub | " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
    Color = Color3.fromRGB(153, 148, 148),
    Keybind = Enum.KeyCode.RightControl
}

local localPlr = game:GetService("Players").LocalPlayer
local mouseDown = false
local isLoaded = false

local toxicPhrases = {
    "you got clapped bruv",
    "nice one",
    "obviously, im better :p",
    "try harder next time",
    "practice a lil more",
    "could of won if you were good",
    "try coping harder",
    "Kitzoon 7750 was here",
    "goofy ahh noob",
    "get gud",
    "badddd",
    "join the el' bozo party",
    "you wish you were me",
    "should quit this game if you play like that",
    "wanna-be tryhard",
    "TRAIN LOL",
    "my grandma plays better then you",
    "literally garbago",
    "9/11 was such a tragedy, sad that you are too",
    "if common sense is common, why are you without it",
    "sorry, not sorry",
    "its been a year daddy, I really really miss you - quote from you",
    "your with stupid",
    "you doo doo bruv",
    "never was you, never want to be you",
    "rogue hub mega haram!",
    "cant get me :)",
    "join the chads .gg/uzXNguueug",
    "LL dsc.gg/uzXNguueug",
    "cry about it",
    "SISSY BOY",
    "jajajajajaja",
    "boo-hoo :C",
    "cry baby boy",
    "toch gras",
    "legit so mad LOL",
    "mad cus you bad",
    "not using rogue hub... imagine",
    "kyron was also here!!!111!!!"
}

getgenv().settings = {
    infJump = false,
    bunnyHop = false,
    triggerBot = false,
    aimBotTog = false,
    aimbotPart = "Head",
    fovRadius = 150,
    showFOV = false,
    toxicAuto = false,
    playerESP = false,
    playerDistance = 0,
    espWeapon = false,
    distanceESP = false,
    clipInf = false,
    rangeInf = false,
    reloadInstantly = false,
    equipInstantly = false,
    rateFire = false,
    oneHit = false,
    noRecoil = false,
    noSpread = false,
    walkSpeed = 20,
    rainbowFOV = false,
    killSound = "Default"
}

if makefolder and isfolder and not isfolder("Rogue Hub") then
    makefolder("Rogue Hub")
    
    makefolder("Rogue Hub/Configs")
    makefolder("Rogue Hub/Data")
end

if readfile and isfile and isfile("Rogue Hub/Configs/NoScopeArcade_Config.ROGUEHUB") then
    getgenv().settings = game:GetService("HttpService"):JSONDecode(readfile("Rogue Hub/Configs/NoScopeArcade_Config.ROGUEHUB"))
end

local function saveSettings()
    if writefile then
        writefile("Rogue Hub/Configs/NoScopeArcade_Config.ROGUEHUB", game:GetService("HttpService"):JSONEncode(getgenv().settings))
    end
end

local function getGun(player)
    if #game:GetService("Workspace").CurrentCamera:GetChildren() == 0 then return nil end
    
    for _, v in ipairs(player:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("Fire") then
            return v
        end
    end
end

local function esp(object, text, player, color)
    local espText = Drawing.new("Text")
    espText.Visible = false
    espText.Center = true
    espText.Outline = true
    espText.Font = 3
    espText.Color = color
    espText.Size = 15
    
    if getgenv().settings.playerESP == false and espText and connection then
        espText.Visible = false
        espText:Remove()
        connection:Disconnect()
    end

    game:GetService("Players").PlayerRemoving:Connect(function(plr)
        if plr == player and espText and connection then
            espText.Visible = false
            espText:Remove()
            connection:Disconnect()
        end
    end)
    
    local connection
    connection = game:GetService("RunService").RenderStepped:Connect(function()
        if object.Parent ~= nil and getgenv().settings.playerESP and not object.Parent:FindFirstChild("Highlight") then
            local objectPos, onScreen = game:GetService("Workspace").CurrentCamera:WorldToViewportPoint(object.Position)
            local targetDistance = (object.Position - game:GetService("Workspace").CurrentCamera.CFrame.Position).magnitude
            
            if onScreen and getgenv().settings.playerESP and targetDistance < getgenv().settings.playerDistance and espText and #game:GetService("Workspace").CurrentCamera:GetChildren() ~= 0 and not object.Parent:FindFirstChild("ForceField") then
                espText.Position = Vector2.new(objectPos.X, objectPos.Y + math.clamp(targetDistance / 10,10,30) -10)
                
                if getgenv().settings.espWeapon and getGun(object.Parent) ~= nil and not getgenv().settings.distanceESP then
                    espText.Text = text .. " | " .. getGun(object.Parent).Name
                elseif getgenv().settings.distanceESP and not getgenv().settings.espWeapon then
                    espText.Text = text .. " | " .. tostring(math.floor(targetDistance)) .. " meters"
                elseif getgenv().settings.espWeapon and getGun(object.Parent) ~= nil and getgenv().settings.distanceESP then
                    espText.Text = text .. " | " .. getGun(object.Parent).Name .. " | " .. tostring(math.floor(targetDistance)) .. " meters"
                else
                    espText.Text = text
                end
                
                espText.Visible = true
            else
                if espText then
                    espText.Visible = false
                end
            end
        else
            espText.Visible = false
            espText:Remove()
            connection:Disconnect()
        end
    end)
end

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/BracketV3.lua"))()
local window = library:CreateWindow(Config, game:GetService("CoreGui"))
local mainTab = window:CreateTab("Main")

-- Player

local playerSec = mainTab:CreateSection("Player")

playerSec:CreateToggle("Infinite Jump", getgenv().settings.infJump, function(bool)
    getgenv().settings.infJump = bool
    saveSettings()
end)

local bHop = playerSec:CreateToggle("Bunny-Hop", getgenv().settings.bunnyHop, function(bool)
    getgenv().settings.bunnyHop = bool
    saveSettings()
end)

bHop:AddToolTip("hippity hop!")

local triggerTog = playerSec:CreateToggle("Trigger-Bot", getgenv().settings.triggerBot, function(bool)
    getgenv().settings.triggerBot = bool
    saveSettings()
end)

triggerTog:AddToolTip("automatically shoots when you aim at a player")

local toxicTog = playerSec:CreateToggle("Auto Toxic", getgenv().settings.toxicAuto, function(bool)
    getgenv().settings.toxicAuto = bool
    saveSettings()
    
    if getgenv().settings.toxicAuto then
        localPlr.leaderstats.Kills:GetPropertyChangedSignal("Value"):Connect(function()
            if not getgenv().settings.toxicAuto then return end
            
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(toxicPhrases[math.random(#toxicPhrases)], "All")
        end)
    end
end)

toxicTog:AddToolTip("automatically says a toxic phrase when you earn a kill")

-- Visuals

local visualSec = mainTab:CreateSection("Visuals")

visualSec:CreateToggle("Space Skybox", getgenv().settings.spaceSkybox, function(bool)
    getgenv().settings.spaceSkybox = bool
    saveSettings()
    
    if getgenv().settings.spaceSkybox then
        local space = Instance.new("Sky")
        
        space.Name = "SpaceHD"
        space.Parent = game:GetService("Lighting")
        
        space.MoonTextureId = "rbxassetid://1075087760"
        space.SkyboxBk = "rbxassetid://1084529998"
        space.SkyboxDn = "rbxassetid://1084531389"
        space.SkyboxFt = "rbxassetid://1084530496"
        space.SkyboxLf = "rbxassetid://1084530280"
        space.SkyboxRt = "rbxassetid://1084529769"
        space.SkyboxUp = "rbxassetid://1084531033"
        space.SunTextureId = "rbxassetid://1084351190"
        space.StarCount = 500
        space.SunAngularSize = 12
        space.MoonAngularSize = 1.5
    else
        game:GetService("Lighting"):FindFirstChild("SpaceHD"):Destroy()
    end
end)

local fovButton = visualSec:CreateButton("High FOV", function()
    if not getgenv().fovDone then
        local camMod = require(game:GetService("ReplicatedStorage").GunSystem.GunClientAssets.Modules.Camera)
	    
	    camMod:ModifyFOV(120,120,120)
	    getgenv().fovDone = true
	else
	    game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Rogue Hub Error",
            Text = "High FOV is already applied!",
            Duration = 5
        })
	end
end)

fovButton:AddToolTip("Set's your camera's FOV to 120")

local soundKill = visualSec:CreateDropdown("Killsounds", {"Default","Bonk","Team Fortress 2","Rust","CSGO","Hitmarker"}, function(option)
    getgenv().settings.killSound = option
    saveSettings()
    
    if getgenv().settings.killSound == "Default" then
        game:GetService("Workspace").Sounds.Kill.SoundId = "rbxassetid://" .. 2121076754
    elseif getgenv().settings.killSound == "Bonk" then
        game:GetService("Workspace").Sounds.Kill.SoundId = "rbxassetid://" .. 5635027625
    elseif getgenv().settings.killSound == "Team Fortress 2" then
        game:GetService("Workspace").Sounds.Kill.SoundId = "rbxassetid://" .. 5650646664
    elseif getgenv().settings.killSound == "Rust" then
        game:GetService("Workspace").Sounds.Kill.SoundId = "rbxassetid://" .. 5043539486
    elseif getgenv().settings.killSound == "CSGO" then
        game:GetService("Workspace").Sounds.Kill.SoundId = "rbxassetid://" .. 8679627751
    elseif getgenv().settings.killSound == "Hitmarker" then
        game:GetService("Workspace").Sounds.Kill.SoundId = "rbxassetid://" .. 160432334
    end
end)

soundKill:SetOption(getgenv().settings.killSound)

local soundButton = visualSec:CreateButton("Preview Killsound", function()
	game:GetService("Workspace").Sounds.Kill:Play()
end)

soundButton:AddToolTip("Lets you play the killsound to see if its for you.")

-- Player ESP

local espSec = mainTab:CreateSection("Player ESP")

espSec:CreateToggle("Enabled", getgenv().settings.playerESP, function(bool)
    getgenv().settings.playerESP = bool
    saveSettings()
    
    if getgenv().settings.playerESP and isLoaded then
        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            if player ~= localPlr and player.Character and getgenv().settings.playerESP then
                esp(player.Character:WaitForChild("Head"), player.Name, player, Color3.fromRGB(255,255,255))
                
                player.CharacterAdded:Connect(function(playerChar)
                    esp(playerChar:WaitForChild("Head"), player.Name, player, Color3.fromRGB(255,255,255))
                end)
            end
        end
    end
end)

game:GetService("Players").PlayerAdded:Connect(function(player)
	if player ~= localPlr and player.Character and getgenv().settings.playerESP then
	    esp(player.Character:WaitForChild("Head"), player.Name, player, Color3.fromRGB(255,255,255))
	elseif player ~= localPlr and getgenv().settings.playerESP then
        player.CharacterAdded:Connect(function(playerChar)
            esp(playerChar:WaitForChild("Head"), player.Name, player, Color3.fromRGB(255,255,255))
        end)
    end
end)

espSec:CreateToggle("Show Player Weapon", getgenv().settings.espWeapon, function(bool)
    getgenv().settings.espWeapon = bool
    saveSettings()
end)

espSec:CreateToggle("Show Player Distance", getgenv().settings.distanceESP, function(bool)
    getgenv().settings.distanceESP = bool
    saveSettings()
end)

local distanceSlider = espSec:CreateSlider("ESP Distance Limit", 0,1000,getgenv().settings.playerDistance,true, function(value)
    getgenv().settings.playerDistance = value
    saveSettings()
end)

-- Aiming

local aimSec = mainTab:CreateSection("Aiming")
getgenv().fovColor = Color3.fromRGB(255,255,255)

FOVCircle = Drawing.new("Circle")

FOVCircle.Visible = false
FOVCircle.Radius = getgenv().settings.fovRadius
FOVCircle.Color = getgenv().fovColor
FOVCircle.Thickness = 2
FOVCircle.Filled = false
FOVCircle.Transparency = 1

local botTog = aimSec:CreateToggle("Aimbot", getgenv().settings.aimBotTog, function(bool)
	getgenv().settings.aimBotTog = bool
	saveSettings()
end)

aimSec:CreateToggle("Show FOV", getgenv().settings.showFOV, function(bool)
    getgenv().settings.showFOV = bool
    FOVCircle.Visible = getgenv().settings.showFOV
    saveSettings()
end)

aimSec:CreateToggle("Rainbow FOV", getgenv().settings.rainbowFOV, function(bool)
    getgenv().settings.rainbowFOV = bool
    saveSettings()
end)

aimSec:CreateSlider("FOV Radius", 0,500,getgenv().settings.fovRadius,true, function(value)
	getgenv().settings.fovRadius = value
    FOVCircle.Radius = getgenv().settings.fovRadius
    saveSettings()
end)

local colorFOV = aimSec:CreateColorpicker("FOV Color", function(color)
	getgenv().fovColor = color
	FOVCircle.Color = getgenv().fovColor
end)

colorFOV:UpdateColor(getgenv().fovColor)

local partDrop = aimSec:CreateDropdown("Aim Part", {"Head","Chest"}, function(option)
    if option == "Chest" then
        getgenv().settings.aimbotPart = "HumanoidRootPart"
        saveSettings()
    else
        getgenv().settings.aimbotPart = option
        saveSettings()
    end
end)

partDrop:SetOption(getgenv().settings.aimbotPart)

-- Gun Mods

if getgc and rawget then
    local gunMods = mainTab:CreateSection("Gun Mods")

    gunMods:CreateToggle("No Spread", false, function(bool)
        if not isLoaded then return end
        getgenv().settings.noSpread = bool

        if getgenv().settings.noSpread then
            for _, v in ipairs(getgc(true)) do
                if type(v) == "table" and rawget(v, "Spread") then
                    v.Spread = 0
                end
            end
        else
            for _, v in ipairs(getgc(true)) do
                if type(v) == "table" and rawget(v, "Spread") then
                    v.Spread = 5
                end
            end
        end
    end)

    gunMods:CreateToggle("No Recoil", false, function(bool)
        if not isLoaded then return end
        getgenv().settings.noRecoil = bool

        if getgenv().settings.noRecoil then
            for _, v in ipairs(getgc(true)) do
                if type(v) == "table" and rawget(v, "RecoilMult") then
                    v.RecoilMult = 0
                end
            end
        else
            for _, v in ipairs(getgc(true)) do
                if type(v) == "table" and rawget(v, "RecoilMult") then
                    v.RecoilMult = 4
                end
            end
        end
    end)

    local oneHitTog = gunMods:CreateToggle("One Hit", false, function(bool)
        if not isLoaded then return end
        getgenv().settings.oneHit = bool

        if getgenv().settings.oneHit then
            for _, v in ipairs(getgc(true)) do
                if type(v) == "table" and rawget(v, "Damage") then
                    v.Damage = math.huge
                    v.HeadshotDmg = math.huge
                end
            end
        else
            for _, v in ipairs(getgc(true)) do
                if type(v) == "table" and rawget(v, "Damage") then
                    v.Damage = 65
                    v.HeadshotDmg = 90
                end
            end
        end
    end)
    
    oneHitTog:AddToolTip("makes your weapon instantly kill players")

    local fireRateTog = gunMods:CreateToggle("No Fire-Rate", false, function(bool)
        if not isLoaded then return end
        getgenv().settings.rateFire = bool

        if getgenv().settings.rateFire then
            for _, v in ipairs(getgc(true)) do
                if type(v) == "table" and rawget(v, "FireRate") then
                    v.FireRate = 0
                end
            end
        else
            for _, v in ipairs(getgc(true)) do
                if type(v) == "table" and rawget(v, "FireRate") then
                    v.FireRate = 0.25
                end
            end
        end
    end)
    
    fireRateTog:AddToolTip("the shooting delay of your weapon")

    gunMods:CreateToggle("Instant Equip", false, function(bool)
        if not isLoaded then return end
        getgenv().settings.equipInstantly = bool

        if getgenv().settings.equipInstantly then
            for _, v in ipairs(getgc(true)) do
                if type(v) == "table" and rawget(v, "EquipTime") then
                    v.EquipTime = 0
                end
            end
        else
            for _, v in ipairs(getgc(true)) do
                if type(v) == "table" and rawget(v, "EquipTime") then
                    v.EquipTime = 0.4
                end
            end
        end
    end)

    gunMods:CreateToggle("Instant Reload", false, function(bool)
        if not isLoaded then return end
        getgenv().settings.reloadInstantly = bool

        if getgenv().settings.reloadInstantly then
            for _, v in ipairs(getgc(true)) do
                if type(v) == "table" and rawget(v, "ReloadTime") then
                    v.ReloadTime = 0
                end
            end
        else
            for _, v in ipairs(getgc(true)) do
                if type(v) == "table" and rawget(v, "ReloadTime") then
                    v.ReloadTime = 2.8
                end
            end
        end
    end)

    gunMods:CreateToggle("Infinite Clip Size", false, function(bool)
        if not isLoaded then return end
        getgenv().settings.clipInf = bool

        if getgenv().settings.clipInf then
            for _, v in ipairs(getgc(true)) do
                if type(v) == "table" and rawget(v, "ClipSize") then
                    v.ClipSize = math.huge
                end
            end
        else
            for _, v in ipairs(getgc(true)) do
                if type(v) == "table" and rawget(v, "ClipSize") then
                    v.ClipSize = 7
                end
            end
        end
    end)

    local speedSlider = gunMods:CreateSlider("Walk Speed", 20,500,20,true, function(value)
        if not isLoaded then return end
        getgenv().settings.walkSpeed = value  
        
        for _, v in ipairs(getgc(true)) do
            if type(v) == "table" and rawget(v, "WalkSpeed") then
                v.WalkSpeed = getgenv().settings.walkSpeed
            end
        end
    end)
    
    speedSlider:AddToolTip("Changes your speed, sometimes makes your viewmodel have a seizure (dont use if you suffer from epilepsy, im not kidding)")
end

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

local uiRainbow = uiSec:CreateToggle("Rainbow UI", nil, function(bool)
	getgenv().rainbowUI = bool
	
	if getgenv().rainbowUI == false then
	    window:ChangeColor(Config.Color)
	end
    
    while getgenv().rainbowUI and task.wait() do
        local hue = tick() % 10 / 10
        local rainbow = Color3.fromHSV(hue, 1, 1)
            
        window:ChangeColor(rainbow)
        uiColor:UpdateColor(rainbow)
    end
end)

local infoSec = infoTab:CreateSection("Credits")

local req = http_request or request or syn.request

infoSec:CreateButton("Father of Rogue Hub: Kitzoon#7750", function()
    setclipboard("Kitzoon#7750")
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Rogue Hub Note",
        Text = "Copied Kitzoon's discord username and tag to your clipboard.",
        Duration = 5
    })
end)

infoSec:CreateButton("Help with a lot: Kyron#6083", function()
    setclipboard("Kyron#6083")
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Script Notification",
        Text = "Copied Kyron's discord username and tag to your clipboard.",
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
            Title = "Rogue Hub Note",
            Text = "Copied our discord server to your clipboard.",
            Duration = 5
        })
    end
end)

game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 and mouseDown == false then
        mouseDown = true
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 and mouseDown then
        mouseDown = false
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    FOVCircle.Position = Vector2.new(localPlr:GetMouse().X, localPlr:GetMouse().Y + 36)
    
    if getgenv().settings.rainbowFOV then
        local hue = tick() % 10 / 10
        local rainbow = Color3.fromHSV(hue, 1, 1)
        
        FOVCircle.Color = rainbow
        colorFOV:UpdateColor(rainbow)    
    end
    
    if localPlr.Character and #game:GetService("Workspace").CurrentCamera:GetChildren() ~= 0 then
        if getgenv().settings.infJump and game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
            localPlr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
        
        if getgenv().settings.triggerBot and localPlr:GetMouse().Target and localPlr:GetMouse().Target.Parent:FindFirstChild("Humanoid") and not localPlr:GetMouse().Target.Parent:FindFirstChild("ForceField") and getGun(localPlr:GetMouse().Target.Parent) ~= nil or getgenv().settings.triggerBot and localPlr:GetMouse().Target and localPlr:GetMouse().Target.Parent.Parent:FindFirstChild("Humanoid") and not localPlr:GetMouse().Target.Parent.Parent:FindFirstChild("ForceField") and getGun(localPlr:GetMouse().Target.Parent.Parent) ~= nil then
            mouse1click()
        end

        if getgenv().settings.bunnyHop and localPlr.Character:WaitForChild("Humanoid") and localPlr.Character.Humanoid.FloorMaterial ~= Enum.Material.Air and localPlr.Character.Humanoid.MoveDirection ~= Vector3.new(0,0,0) then
            localPlr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            task.wait(2)
        end

        if getgenv().settings.aimBotTog and mouseDown then
            for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                if player ~= localPlr and player.Character and player.Status ~= "Dead" and not player.Character:FindFirstChild("ForceField") and player.Character:FindFirstChild(getgenv().settings.aimbotPart) then
                    local partPos, onScreen = game:GetService("Workspace").CurrentCamera:WorldToViewportPoint(player.Character[getgenv().settings.aimbotPart].Position)
                    local obsParts = game:GetService("Workspace").CurrentCamera:GetPartsObscuringTarget({player.Character[getgenv().settings.aimbotPart].Position}, {game:GetService("Workspace").CurrentCamera, localPlr.Character, player.Character})

                    if onScreen and #obsParts == 0 then
                        local distance = math.huge
                        local mag = (Vector2.new(localPlr:GetMouse().X, localPlr:GetMouse().Y) - Vector2.new(partPos.X, partPos.Y)).magnitude
                        
                        if mag < distance and mag < getgenv().settings.fovRadius then
                            distance = mag
                            closestPlayer = player.Character
                            game:GetService("Workspace").CurrentCamera.CFrame = CFrame.new(game:GetService("Workspace").CurrentCamera.CFrame.Position, closestPlayer[getgenv().settings.aimbotPart].Position)
                        end
                    end
                end
            end
        end
    end
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Rogue Hub Message",
    Text = "Successfully loaded.",
    Duration = 5
})

sound:Destroy()
isLoaded = true

if getgenv().settings.playerESP and isLoaded then
    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
        if player ~= localPlr and player.Character and getgenv().settings.playerESP then
            esp(player.Character:WaitForChild("Head"), player.Name, player, Color3.fromRGB(255,255,255))
            
            player.CharacterAdded:Connect(function(playerChar)
                esp(playerChar:WaitForChild("Head"), player.Name, player, Color3.fromRGB(255,255,255))
            end)
        end
    end
end

task.wait(5)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Please Note",
    Text = "The rogue hub version you are using is currently in alpha, bugs may occur.",
    Duration = 10
})
