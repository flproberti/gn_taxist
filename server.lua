-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--( Tunnel )-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
scriptTaxi = {}
Tunnel.bindInterface('taxi',scriptTaxi)
taxiCL = Tunnel.getInterface('taxi')
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--( Funções )------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function scriptTaxi.setarCargo()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        vRP.addUserGroup(user_id,taxi['IniciarServiço']['GrupoTaxista'])     
    end   
end

function scriptTaxi.verificarCargo()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        return vRP.hasGroup(user_id,taxi['IniciarServiço']['GrupoTaxista'])
    end
end

function scriptTaxi.retirarCargo()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        vRP.removeUserGroup(user_id,taxi['IniciarServiço']['GrupoTaxista'])
    end
end

function scriptTaxi.pagamento()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local qtdDinheiro = math.random(taxi['EmRota']['Pagamento']['min'],taxi['EmRota']['Pagamento']['max'])
        vRP.giveMoney(user_id,parseInt(qtdDinheiro))
        TriggerClientEvent('vrp_sound:source',source,'coins',0.5)
        TriggerClientEvent('Notify',source,'sucesso',taxi['Notificações']['Pagamento'][1] .. vRP.format(parseInt(qtdDinheiro)) .. taxi['Notificações']['Pagamento'][2])
    end
end