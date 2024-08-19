local RSGCore = exports['rsg-core']:GetCoreObject()

-- Define the Discord webhook URL
local webhookURL = "YOUR_DISCORD_WEBHOOK_URL"

-- Function to send a log message to Discord
local function SendDiscordLog(message)
    PerformHttpRequest(webhookURL, function(err, text, headers) end, 'POST', json.encode({
        username = "CM Logger",
        content = message
    }), { ['Content-Type'] = 'application/json' })
end

-- Event handler for when a player is shot
AddEventHandler('gameEventTriggered', function(eventName, eventData)
    if eventName == 'CEventNetworkEntityDamage' then
        local victim = eventData[1]
        local attacker = eventData[2]
        local weaponHash = eventData[3]

        -- Check if the weapon used is a shotgun
        local shotgunHashes = {
            joaat(Config.Weaponhash),
        }

        for _, hash in ipairs(shotgunHashes) do
            if weaponHash == hash then
                local victimName = GetPlayerName(victim)
                local attackerName = GetPlayerName(attacker)
                local message = string.format("Player %s was shot by %s with a shotgun.", victimName, attackerName)
                SendDiscordLog(message)
                break
            end
        end
    end
end)