if not game:IsLoaded() then
    game.Loaded:Wait()
end

local req = http_request or request or syn.request

if not req then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Rogue Hub Error",
        Text = "Your exploit is unsupported with Rogue Hub!",
        Duration = 5
    })
    return
end

if makefolder and isfolder and not isfolder("Rogue Hub") then
    makefolder("Rogue Hub")

    makefolder("Rogue Hub/Configs")
    makefolder("Rogue Hub/Data")
end

if not isfile("/Rogue Hub/Configs/Quotes.ROGUEHUB") then 
    writefile("/Rogue Hub/Configs/Quotes.ROGUEHUB", req({ Url = "https://raw.githubusercontent.com/littlepriceonu/Rogue-Hub/main/Extra/Quotes.ROGUEHUB" }).Body);
end

if not isfile("/Rogue Hub/Configs/Keybind.ROGUEHUB") then
    writefile("/Rogue Hub/Configs/Keybind.ROGUEHUB", game:GetService("HttpService"):JSONEncode({
        Key = "RightControl"
    }))
end

local response = req({
    Url = "https://raw.githubusercontent.com/littlepriceonu/Rogue-Hub/main/Games/" .. game.PlaceId .. ".lua",
    Method = "GET"
})

if response.Body ~= "404: Not Found" then
    -- Anti AFK
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 2, true, nil, 0)
        wait(1)
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 2, false, nil, 0)
    end)

    -- If its not 404 why make another HTTP request?
    -- ^ Answer to above - Kitzoon is big dumb
    loadstring(response.Body)()
else
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Rogue Hub Error",
        Text = "The game you are trying to play is not supported with Rogue Hub!",
        Duration = 5
    })

    return
end
