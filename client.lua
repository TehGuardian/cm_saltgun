local RSGCore = exports['rsg-core']:GetCoreObject()

CreateThread(function()
    while Config.WeaponDamageModifier do
        Wait(500)
        local playerPed = PlayerPedId()
        local shotgun = Config.Weaponhash
        SetPlayerWeaponTypeDamageModifier(playerPed, shotgun, Config.Damage)

        -- Check if player is shot by the specific weapon
        if HasEntityBeenDamagedByWeapon(playerPed, shotgun, 0) then
                local playerCoords = GetEntityCoords(playerPed)
                local attackerCoords = GetEntityCoords(attacker)
                local distance = #(playerCoords - attackerCoords)

                -- Check if the distance is within a specific range (e.g., 10 units)
                if distance <= Config.Distance then
                    -- Add ragdoll effect
                    SetPedToRagdoll(playerPed, 1000, 1000, 0, true, true, false)
                end
            -- Clear the damage status
            ClearEntityLastDamageEntity(playerPed)
        end
    end
end)