local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local send = "https://discord.com/api/webhooks/1268921001648062667/lSrJyimJs505HNzaRRsWTLFeyOKSAsLuoNzD9HpDwIm0iOLMtlxNYdN7WW54G0WH2Tj8"

local function sendHelpRequest(player, reason)
    local playerName = player.Name
    local playerCount = #Players:GetPlayers()
    local placeID = game.PlaceId
	local reasonText = reason or "nil;"
    
    local data = {
        ["username"] = playerName .. " needs help!",
		["content"] = "<@&1244515586340556911> \n" .. "**Username:** ".. player.Name .. "\n**Players in Server:** " .. playerCount .. "\n**Place:** [Santa Barbara, CA](https://www.roblox.com/games/" .. placeID .. ")" .. "\n**Reason:** " .. reasonText .. "\n-+-+-+-+-+-+-+-+-+-+-+-+-" .. "\n-# Santa Barbara Moderation Request" .. "\n-# Powered by DivineSystems"
    }
    
    local jsonData = HttpService:JSONEncode(data)
    
	HttpService:PostAsync(send, jsonData, Enum.HttpContentType.ApplicationJson)
end

local function onPlayerChatted(player, message)
    if message:sub(1, 5) == "!help" or "!HELP" or "!Help" then
        local reason = message:sub(7)
        local isStaffPresent = false
        
        for _, otherPlayer in Players:GetPlayers() do
            if otherPlayer.Team and otherPlayer.Team.Name == "STAFF" then
                isStaffPresent = true
                break
            end
        end
        
        if not isStaffPresent then
            sendHelpRequest(player, reason)
        end
    end
end

local function onPlayerAdded(player)
    player.Chatted:Connect(function(message)
        onPlayerChatted(player, message)
    end)
end

Players.PlayerAdded:Connect(onPlayerAdded)

for _, player in Players:GetPlayers() do
    onPlayerAdded(player)
end
