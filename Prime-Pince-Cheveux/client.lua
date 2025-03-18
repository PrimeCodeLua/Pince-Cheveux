local originalHairStyles = {} -- Table pour stocker les coiffures originales des joueurs

-- Fonction pour afficher le menu
function toggleepingle()
    lib.registerContext({
        id = 'epingle_menu',
        title = 'Pince A Cheveux 🪮',
        onExit = function() end,
        options = {
            {
                title = 'Attacher Vos Cheveux',
                arrow = true,
                icon = 'fa-solid fa-hat-cowboy',
                iconColor = 'green',
                onSelect = function(args)
                    attachHair()
                end,
            },
            {
                title = 'Détacher Vos Cheveux',
                arrow = true,
                icon = 'fa-solid fa-hat-cowboy',
                iconColor = 'red',
                onSelect = function(args)
                    detachHair()
                end,
            },
        }
    })
    lib.showContext('epingle_menu')
end

-- Quand le joueur utilise l'item pincecheveux, on ouvre le menu
RegisterNetEvent('ledjo_epingle:use')
AddEventHandler('ledjo_epingle:use', function()
    toggleepingle()
end)

-- Fonction pour attacher les cheveux
function attachHair()
    lib.progressCircle({
        duration = 1200,
        label = "En train d'attacher vos cheveux",
        useWhileDead = false,
        canCancel = true,
        anim = {
            dict = 'mp_masks@on_foot',
            clip = 'put_on_mask'
        },
    })

    local playerPed = PlayerPedId()
    local playerId = GetPlayerServerId(PlayerId())

    if not originalHairStyles[playerId] then
        local currentHairDrawable = GetPedDrawableVariation(playerPed, 2)
        local currentHairTexture = GetPedTextureVariation(playerPed, 2)
        originalHairStyles[playerId] = {drawable = currentHairDrawable, texture = currentHairTexture}
    end

    SetPedComponentVariation(playerPed, 2, 1, 141, 2) -- Changer la coiffure

    TriggerEvent('chat:addMessage', {
        color = {255, 0, 0},
        multiline = true,
        args = {"Hair", "Vos cheveux sont maintenant attachés."}
    })
end

-- Fonction pour détacher les cheveux
function detachHair()
    lib.progressCircle({
        duration = 1200,
        label = "En train de détacher vos cheveux",
        useWhileDead = false,
        canCancel = true,
        anim = {
            dict = 'mp_masks@on_foot',
            clip = 'put_on_mask'
        },
    })

    local playerPed = PlayerPedId()
    local playerId = GetPlayerServerId(PlayerId())

    if originalHairStyles[playerId] then
        local originalHair = originalHairStyles[playerId]
        SetPedComponentVariation(playerPed, 2, originalHair.drawable, originalHair.texture, 2)

        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Hair", "Vos cheveux sont détachés."}
        })
        
        originalHairStyles[playerId] = nil
    else
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Hair", "Aucune coiffure précédente trouvée."}
        })
    end
end
