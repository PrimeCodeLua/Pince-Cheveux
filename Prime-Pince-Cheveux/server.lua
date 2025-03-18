ESX = exports["es_extended"]:getSharedObject()


ESX.RegisterUsableItem('pincecheveux', function(source)
    TriggerClientEvent('ledjo_epingle:use', source)
end)