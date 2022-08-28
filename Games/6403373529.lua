if getgenv().Rogue_AlreadyLoaded ~= nil then error("Rogue Hub was already found running or you have other scripts executed!") return else getgenv().Rogue_AlreadyLoaded = 0 end

if game.PlaceId == 6403373529 or game.PlaceId == 9015014224 or game.PlaceId == 9431156611 then else return end

-- easter egg moment
if syn then
  print("DohmBoy is cool!")
end

-- walkspeed anticheat bypass for slap royale
if game.PlaceId == 9431156611 and getrawmetatable then
    local gmt = getrawmetatable(game)
    local oldNamecall = gmt.__namecall
    
    setreadonly(gmt, false)
    
    gmt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        
        if tostring(self) == "WS" and tostring(method) == "FireServer" then
            return
        end
        
        return oldNamecall(self, ...)
    end)
    
    setreadonly(gmt, true)
end

local sound = Instance.new("Sound")
sound.Parent = game:GetService("Workspace")
sound.SoundId = "rbxassetid://1548304764"
sound.PlayOnRemove = true
sound.Volume = 0.5

local Config = {
    WindowName = "Rogue Hub | " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
    Color = Color3.fromRGB(30,30,30),
    Keybind = Enum.KeyCode.RightControl
}

local toxicPhrases = {
    "you got clapped",
    "nice one",
    "obviously, im better :p",
    "try harder next time",
    "practice a lil more",
    "could of won if you were good",
    "try coping harder",
    "Kitzoon 7750 was here",
    "may the slap gods slap you from mother earth",
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
    "notice me tencelll!!!!!!!!!!!!!!",
    "2022-07-31",
    "never was you, never want to be you",
    "rogue hub mega haram!",
    "cant get me :)",
    "join the chads .gg/uzXNguueug",
    "your slap battles experience greatly ruined by dsc.gg/uzXNguueug",
    "toch gras",
    "kyron was also here!!!111!!!"
}

local localPlr = game:GetService("Players").LocalPlayer

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/BracketV3.lua"))()
local window = library:CreateWindow(Config, game:GetService("CoreGui"))
local mainTab = window:CreateTab("Main")

window:ChangeColor(Color3.fromRGB(201,144,150))

getgenv().settings = {
    gloveExtend = false,
    extendOption = "Meat Stick",
    autoClicker = false,
    autoToxic = false,
    walkSpeed = 20,
    jumpPower = 50,
    noRagdoll = false,
    noReaper = false,
    noTimestop = false,
    noRock = false,
    autoJoin = false,
    joinOption = "Normal Arena",
    noVoid = false,
    auraSlap = false,
    auraOption = "Legit",
    voidRainbow = false,
    voidForce = false,
    playerForce = false,
    fov = 70,
    spamFart = false,
    spin = false,
    spinSpeed = 10
}

if makefolder and isfolder and not isfolder("Rogue Hub") then
    makefolder("Rogue Hub")
    
    makefolder("Rogue Hub/Configs")
    makefolder("Rogue Hub/Data")
end

if readfile and isfile and isfile("Rogue Hub/Configs/SlapBattles_Config.ROGUEHUB") then
    getgenv().settings = game:GetService("HttpService"):JSONDecode(readfile("Rogue Hub/Configs/SlapBattles_Config.ROGUEHUB"))
end

local function saveSettings()
    if writefile then
        writefile("Rogue Hub/Configs/SlapBattles_Config.ROGUEHUB", game:GetService("HttpService"):JSONEncode(getgenv().settings))
    end
end

local function getTool()
    local tool = localPlr.Character:FindFirstChildOfClass("Tool") or localPlr:WaitForChild("Backpack"):FindFirstChildOfClass("Tool")
    
    if tool ~= nil and tool:FindFirstChild("Glove") ~= nil then
        return tool    
    end
end

localPlr.CharacterAdded:Connect(function()
    localPlr.Character:WaitForChild("Humanoid")
    
    task.wait(3)
    
    if getgenv().settings.noRagdoll then
        if localPlr.Character.HumanoidRootPart == nil then return end
        
        localPlr.Character.Ragdolled:GetPropertyChangedSignal("Value"):Connect(function()
            if localPlr.Character.HumanoidRootPart == nil then return end
            
            local oldCFrame = localPlr.Character.HumanoidRootPart.CFrame
            
            pcall(function()
                repeat task.wait()
                    localPlr.Character.HumanoidRootPart.CFrame = oldCFrame
                until localPlr.Character.Ragdolled.Value == false or localPlr.Character == nil or localPlr.Character.HumanoidRootPart == nil
            end)
        end)
    end
    
    if getgenv().settings.noReaper then
        localPlr.Character.ChildAdded:Connect(function(child)
            if child.Name == "DeathMark" and child:IsA("StringValue") then
                game:GetService("ReplicatedStorage").ReaperGone:FireServer(child)
                game:GetService("Lighting"):WaitForChild("DeathMarkColorCorrection"):Destroy()
                child:Destroy()
            end
        end)
    end
    
    repeat task.wait() until getTool() ~= nil
        
    if getgenv().settings.auraSlap and getgenv().settings.auraOption == "Legit" then
        getTool().Glove.Touched:Connect(function(part)
            if part.Parent:FindFirstChildOfClass("Humanoid") and getgenv().settings.auraSlap and getgenv().settings.auraOption == "Legit" then
                getTool():Activate()
                task.wait(0.3)
            end
        end)
    end
end)

-- Player

local playerSec = mainTab:CreateSection("Player")

playerSec:CreateToggle("Autoclicker", getgenv().settings.autoClicker, function(bool)
    getgenv().settings.autoClicker = bool
    saveSettings()
end)

local toxicTog = playerSec:CreateToggle("Auto Toxic", getgenv().settings.autoToxic, function(bool)
    getgenv().settings.autoToxic = bool
    saveSettings()
    
    if getgenv().settings.autoToxic and game.PlaceId ~= 9431156611 then
        localPlr.leaderstats.Slaps:GetPropertyChangedSignal("Value"):Connect(function()
            if not getgenv().settings.autoToxic then return end
            
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(toxicPhrases[math.random(#toxicPhrases)], "All")
        end)
    elseif getgenv().settings.autoToxic and game.PlaceId == 9431156611 then
        localPlr.Slaps:GetPropertyChangedSignal("Value"):Connect(function()
            if not getgenv().settings.autoToxic then return end
            
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(toxicPhrases[math.random(#toxicPhrases)], "All")
        end)
    end
end)
    
toxicTog:AddToolTip("automatically says a toxic phrase when you slap someone")

local noRagTog = playerSec:CreateToggle("Anti Ragdoll", getgenv().settings.noRagdoll, function(bool)
    getgenv().settings.noRagdoll = bool
    saveSettings()
    
    if getgenv().settings.noRagdoll and localPlr.Character:FindFirstChildOfClass("Humanoid") then
        localPlr.Character.Ragdolled:GetPropertyChangedSignal("Value"):Connect(function()
            if localPlr.Character:FindFirstChild("HumanoidRootPart") then
                local oldCFrame = localPlr.Character.HumanoidRootPart.CFrame
                
                repeat task.wait()
                    if localPlr.Character:FindFirstChild("HumanoidRootPart") then
                        localPlr.Character.HumanoidRootPart.CFrame = oldCFrame
                    end
                until localPlr.Character:FindFirstChild("HumanoidRootPart") == nil or localPlr.Character.Ragdolled.Value == false
            end
        end)
    end
end)

noRagTog:AddToolTip("looks clunky, but works good")

if game.PlaceId ~= 9431156611 then
    local reaperGod = playerSec:CreateToggle("Reaper Godmode", getgenv().settings.noReaper, function(bool)
        getgenv().settings.noReaper = bool
        saveSettings()
        
        if getgenv().settings.noReaper and localPlr.Character:FindFirstChildOfClass("Humanoid") then
            for _, v in next, localPlr.Character:GetChildren() do
                if v.Name == "DeathMark" and v:IsA("StringValue") then
                    game:GetService("ReplicatedStorage").ReaperGone:FireServer(v)
                    game:GetService("Lighting"):WaitForChild("DeathMarkColorCorrection"):Destroy()
                    v:Destroy()
                end
            end
            
            localPlr.Character.ChildAdded:Connect(function(child)
                if child.Name == "DeathMark" and child:IsA("StringValue") then
                    game:GetService("ReplicatedStorage").ReaperGone:FireServer(child)
                    game:GetService("Lighting"):WaitForChild("DeathMarkColorCorrection"):Destroy()
                    child:Destroy()
                end
            end)
        end
    end)
    
    reaperGod:AddToolTip("immune from the reaper death ability")
    
    local rockGod = playerSec:CreateToggle("Rock Godmode", getgenv().settings.noRock, function(bool)
        getgenv().settings.noRock = bool
        saveSettings()
        
        if getgenv().settings.noRock then
            for _, target in pairs(game:GetService("Players"):GetPlayers()) do
                if target.Character ~= nil and target.Character:FindFirstChild("rock") and target.Character.rock:FindFirstChild("TouchInterest") then
                    target.Character:FindFirstChild("rock").TouchInterest:Destroy()
                end
            end
        end
    end)
    
    rockGod:AddToolTip("immune from dangerous rocks! sometimes works, sometimes doesnt")
    
    playerSec:CreateToggle("Move in Timestop & Cutscenes", getgenv().settings.noTimestop, function(bool)
        getgenv().settings.noTimestop = bool
        saveSettings()
    end)

    playerSec:CreateToggle("Anti Void", getgenv().settings.noVoid, function(bool)
        getgenv().settings.noVoid = bool
        saveSettings()
        
        game:GetService("Workspace").dedBarrier.CanCollide = getgenv().settings.noVoid
    end)
    
    game:GetService("Workspace").dedBarrier.CanCollide = getgenv().settings.noVoid
end

local spinTog = playerSec:CreateToggle("Spin", getgenv().settings.spin, function(bool)
    getgenv().settings.spin = bool
    saveSettings()
end)

spinTog:AddToolTip("Makes your player spin around, looks derpy :D")

playerSec:CreateSlider("Spin Speed", 10,100,getgenv().settings.spinSpeed,true, function(value)
	getgenv().settings.spinSpeed = value
	saveSettings()
end)

playerSec:CreateSlider("Walk Speed", 20,50,getgenv().settings.walkSpeed,true, function(value)
	getgenv().settings.walkSpeed = value
	saveSettings()
end)

playerSec:CreateSlider("Jump Power", 50,100,getgenv().settings.jumpPower,true, function(value)
	getgenv().settings.jumpPower = value
	saveSettings()
end)

-- Glove

local gloveSec = mainTab:CreateSection("Glove")

if game.PlaceId ~= 9431156611 then
    local farmTog = gloveSec:CreateToggle("Slap Farm", false, function(bool)
        getgenv().slapFarm = bool
        
        while task.wait() and getgenv().slapFarm do
            if game.PlaceId ~= 9431156611 then
                for _, target in next, game:GetService("Players"):GetPlayers() do
                    if target.Character ~= nil and target.Character:FindFirstChild("entered") ~= nil and localPlr.Character:FindFirstChild("entered") ~= nil and target.Character:FindFirstChild("rock") == nil and target.Character:FindFirstChild("Ragdolled").Value == false and target.Character:FindFirstChild("Reverse") == nil and target.Character:FindFirstChild("Right Arm") and target.Character:FindFirstChild("Error") == nil and target.Character:FindFirstChild("Orbit") == nil and target.Character:FindFirstChild("Spectator") == nil and target.Backpack:FindFirstChild("Spectator") == nil and getgenv().slapFarm then
                        if getTool() ~= nil and getTool().Name == "Default" and getgenv().slapFarm then
                            localPlr.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0,15,0)
                            game:GetService("ReplicatedStorage").b:FireServer(target.Character["Right Arm"])
                        elseif getTool() ~= nil and getTool().Name ~= "Default" and getgenv().slapFarm then
                            localPlr.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,3.5)
                            getTool():Activate()
                        end
                    end
                end
            else
                for _, target in next, game:GetService("Players"):GetPlayers() do
                    if target.Character ~= nil and target.Character:FindFirstChild("inMatch").Value and localPlr.Character:FindFirstChild("inMatch").Value and target.Character:FindFirstChild("Ragdolled").Value == false and target.Character:FindFirstChild("Right Arm") and getgenv().slapFarm then
                        if getTool() ~= nil and getTool().Name == "Pack-A-Punch" and getgenv().slapFarm then
                            localPlr.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0,15,0)
                            game:GetService("ReplicatedStorage").Events.Slap:FireServer(target.Character["Right Arm"])
                        elseif getTool() ~= nil and getTool().Name ~= "Default" and getgenv().slapFarm then
                            localPlr.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,3.5)
                            getTool():Activate()
                        end
                    end
                end
            end
        end
    end)
    
    farmTog:AddToolTip("Auto farm slaps, works best when paired with auto join (ban warning from mods)") 
end

if game.PlaceId ~= 9431156611 then
    local fartTog = gloveSec:CreateToggle("Fart Spam", false, function(bool)
        getgenv().settings.spamFart = bool
        saveSettings()
    end)
    
    fartTog:AddToolTip("no explanation needed, only works for the default glove") 
end

gloveSec:CreateToggle("Glove Extender", getgenv().settings.gloveExtend, function(bool)
    getgenv().settings.gloveExtend = bool
    saveSettings()
end)

local extendDrop = gloveSec:CreateDropdown("Extender Type", {"Meat Stick","Pancake", "Growth"}, function(option)
	getgenv().settings.extendOption = option
	saveSettings()
end)

extendDrop:SetOption(getgenv().settings.extendOption)

if game.PlaceId ~= 9431156611 then
    -- Auto Join
    local joinSec = mainTab:CreateSection("Auto Join")
    
    local autoEnabled = joinSec:CreateToggle("Enabled", getgenv().settings.autoJoin, function(bool)
        getgenv().settings.autoJoin = bool
        saveSettings()
    end)
    
    autoEnabled:AddToolTip("Automatically join an arena of your choice.")
    
    local joinDrop = joinSec:CreateDropdown("Auto join in:", {"Normal Arena","Default Only Arena"}, function(option)
    	getgenv().settings.joinOption = option
    	saveSettings()
    end)
    
    joinDrop:SetOption(getgenv().settings.joinOption)
end

-- Slap aura

local auraSec = mainTab:CreateSection("Slap Aura")

auraSec:CreateToggle("Enabled", getgenv().settings.auraSlap, function(bool)
    getgenv().settings.auraSlap = bool
    saveSettings()
    
    while getTool() == nil and wait() do return end

    if getgenv().settings.auraSlap and getgenv().settings.auraOption == "Legit" then
        getTool().Glove.Touched:Connect(function(part)
            if part.Parent:FindFirstChildOfClass("Humanoid") and getgenv().settings.auraSlap and getgenv().settings.auraOption == "Legit" then
                getTool():Activate()
                task.wait(0.3)
            end
        end)
    end
end)

local auraDrop = auraSec:CreateDropdown("Type", {"Legit","Blatant"}, function(option)
	getgenv().settings.auraOption = option
	saveSettings()
	
	if getgenv().settings.auraOption == "Blatant" then
	    if game.PlaceId ~= 9431156611 then
    	    game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Rogue Hub Note",
                Text = "Blatant Type only works on the default glove, use legit for any glove type.",
                Duration = 5
            })
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Rogue Hub Note",
                Text = "Blatant Type only works on the Pack-A-Punch glove, use legit for any glove type.",
                Duration = 5
            })
        end
	end
end)

auraDrop:SetOption(getgenv().settings.auraOption)

-- Visuals

local visualSec = mainTab:CreateSection("Visuals")

if game.PlaceId ~= 9431156611 then
    local rainbowVoidTog = visualSec:CreateToggle("Rainbow Void", getgenv().settings.voidRainbow, function(bool)
        getgenv().settings.voidRainbow = bool
        saveSettings()
    end)
    
    rainbowVoidTog:AddToolTip("changes the void's color to rainbow")
    
    local forceVoidTog = visualSec:CreateToggle("ForceField Void", getgenv().settings.voidForce, function(bool)
        getgenv().settings.voidForce = bool
        saveSettings()
    end)

    forceVoidTog:AddToolTip("changes the void's material to a forcefield")
end

local forcePlayerTog = visualSec:CreateToggle("ForceField Player", getgenv().settings.playerForce, function(bool)
    getgenv().settings.playerForce = bool
    saveSettings()
end)

forcePlayerTog:AddToolTip("changes your player's material to a forcefield")

local fovSlider = visualSec:CreateSlider("Field of View", 70,120,getgenv().settings.fov,true, function(value)
	getgenv().settings.fov = value
	game:GetService("Workspace").CurrentCamera.FieldOfView = getgenv().settings.fov
	saveSettings()
end)

fovSlider:AddToolTip("changes the camera's FOV")

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

game:GetService("RunService").RenderStepped:Connect(function()
    if game.PlaceId ~= 9431156611 and localPlr ~= nil and getTool() ~= nil and localPlr.Character:FindFirstChild("entered") ~= nil or game.PlaceId == 9431156611 and localPlr ~= nil and getTool() ~= nil and localPlr.Character:FindFirstChild("inMatch").Value then
        if getgenv().settings.gloveExtend and getgenv().settings.extendOption == "Meat Stick" and getTool():FindFirstChild("Glove").Size ~= Vector3.new(0, 25, 2) then
            getTool().Glove.Transparency = 0.5
            getTool().Glove.Size = Vector3.new(0, 25, 2)
        elseif getgenv().settings.gloveExtend and getgenv().settings.extendOption == "Pancake" and getTool():FindFirstChild("Glove").Size ~= Vector3.new(0, 25, 25) then
            getTool().Glove.Transparency = 0.5
            getTool().Glove.Size = Vector3.new(0, 25, 25)
        elseif getgenv().settings.gloveExtend and getgenv().settings.extendOption == "Growth" and getTool():FindFirstChild("Glove").Size ~= Vector3.new(25, 25, 25) then
            getTool().Glove.Transparency = 0.5
            getTool().Glove.Size = Vector3.new(25, 25, 25)
        elseif getgenv().settings.gloveExtend == false then
            getTool().Glove.Transparency = 1
            getTool().Glove.Size = Vector3.new(2.5, 2.5, 1.7)
        end

        if getgenv().settings.autoClicker then
            getTool():Activate()
        end
        
        if getgenv().settings.noTimestop then
            for _, v in next, localPlr.Character:GetChildren() do
                if v:IsA("Part") or v:IsA("MeshPart") and v.Anchored then
                    v.Anchored = false
                end
            end
        end
        
        if getgenv().settings.auraSlap and getgenv().settings.auraOption == "Blatant" then
            if game.PlaceId ~= 9431156611 then
                for _, target in next, game:GetService("Players"):GetPlayers() do
                    if target.Character and target.Character:FindFirstChild("Humanoid") ~= nil and target.Character:FindFirstChild("rock") == nil and target.Character:FindFirstChild("Reverse") == nil and getgenv().settings.auraOption == "Blatant" and target:DistanceFromCharacter(localPlr.Character.HumanoidRootPart.Position) < 20 and getTool().Name == "Default" then
                        game:GetService("ReplicatedStorage").b:FireServer(target.Character.HumanoidRootPart)
                    end
                end
            else
                for _, target in next, game:GetService("Players"):GetPlayers() do
                    if target.Character and target.Character:FindFirstChild("Humanoid") ~= nil and getgenv().settings.auraOption == "Blatant" and target:DistanceFromCharacter(localPlr.Character.HumanoidRootPart.Position) < 20 and getTool().Name == "Pack-A-Punch" then
                        game:GetService("ReplicatedStorage").Events.Slap:FireServer(target.Character.HumanoidRootPart)
                    end
                end
            end
        end
        
        if getgenv().settings.noRock and game.PlaceId ~= 9431156611 then
            for _, target in next, game:GetService("Players"):GetPlayers() do
                if target.Character ~= nil and target.Character:FindFirstChild("rock") and target.Character.rock:FindFirstChild("TouchInterest") then
                    target.Character:FindFirstChild("rock").TouchInterest:Destroy()
                end
            end
        end
        
        if getgenv().settings.playerForce then
            for _, v in next, localPlr.Character:GetChildren() do
                if v:IsA("Part") or v:IsA("MeshPart") then
                    v.Material = "ForceField"
                end
            end
        else
            for _, v in next, localPlr.Character:GetChildren() do
                if v:IsA("Part") or v:IsA("MeshPart") then
                    v.Material = "Plastic"
                end
            end 
        end
        
        if getgenv().settings.spamFart and getTool().Name == "Default" then
            game:GetService("ReplicatedStorage").Fart:FireServer()
        end
        
        if getgenv().settings.spin and localPlr:GetMouse().Icon ~= "rbxasset://textures/MouseLockedCursor.png" and not getgenv().slapFarm then
            localPlr.Character.HumanoidRootPart.CFrame = localPlr.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(getgenv().settings.spinSpeed), 0)
        end
        
        localPlr.Character.Humanoid.WalkSpeed = getgenv().settings.walkSpeed
        localPlr.Character.Humanoid.JumpPower = getgenv().settings.jumpPower
    end
    
    if getgenv().settings.autoJoin and getgenv().settings.joinOption == "Normal Arena" then
        if game.PlaceId == 9431156611 then return end
        
        if not localPlr.Character:FindFirstChild("entered") and localPlr.Character:FindFirstChild("HumanoidRootPart") then
            firetouchinterest(localPlr.Character.HumanoidRootPart, game:GetService("Workspace").Lobby.Teleport1, 0)
            firetouchinterest(localPlr.Character.HumanoidRootPart, game:GetService("Workspace").Lobby.Teleport1, 1)
        end
    elseif getgenv().settings.autoJoin and getgenv().settings.joinOption == "Default Only Arena" then
        if game.PlaceId == 9431156611 then return end
        
        if not localPlr.Character:FindFirstChild("entered") and localPlr.Character:FindFirstChild("HumanoidRootPart") then
            firetouchinterest(localPlr.Character.HumanoidRootPart, game:GetService("Workspace").Lobby.Teleport2, 0)
            firetouchinterest(localPlr.Character.HumanoidRootPart, game:GetService("Workspace").Lobby.Teleport2, 1)
        end
    end
    
    if getgenv().settings.voidRainbow and game.PlaceId ~= 9431156611 then
        local hue = tick() % 10 / 10
        local rainbow = Color3.fromHSV(hue, 1, 1)
        
        game:GetService("Workspace").dedBarrier.Transparency = 0
        game:GetService("Workspace").dedBarrier.Color = rainbow
    else
        if game.PlaceId == 9431156611 then return end
        
        if not getgenv().settings.voidForce then
            game:GetService("Workspace").dedBarrier.Transparency = 1
        end
        
        game:GetService("Workspace").dedBarrier.Color = Color3.fromRGB(163, 162, 165)
    end
    
    if getgenv().settings.voidForce and game.PlaceId ~= 9431156611 then
        game:GetService("Workspace").dedBarrier.Transparency = 0
        game:GetService("Workspace").dedBarrier.Material = "ForceField"
    else
        if game.PlaceId == 9431156611 then return end
        
        if not getgenv().settings.voidRainbow then
            game:GetService("Workspace").dedBarrier.Transparency = 1
        end
        
        game:GetService("Workspace").dedBarrier.Material = "Plastic"
    end
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Rogue Hub Message",
    Text = "Successfully loaded.",
    Duration = 5
})

sound:Destroy()

task.wait(5)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Please Note",
    Text = "The rogue hub version you are using is currently in alpha, bugs may occur.",
    Duration = 10
})

while getTool() == nil and wait() do return end

if getgenv().settings.auraSlap and getgenv().settings.auraOption == "Legit" then
    getTool().Glove.Touched:Connect(function(part)
        if part.Parent:FindFirstChildOfClass("Humanoid") and getgenv().settings.auraSlap and getgenv().settings.auraOption == "Legit" then
            getTool():Activate()
            task.wait(0.3)
        end
    end)
end
