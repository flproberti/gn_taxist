-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--( Tunnel )-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
scriptTaxi = {}
Tunnel.bindInterface('taxi',scriptTaxi)
taxiSV = Tunnel.getInterface('taxi')
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--( Variáveis )----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local emServico,emRota,emTransito,pedSpawnado,rotaSelecionada,veiculo,npc
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--( Iniciar Serviço )----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local cooldown = 1000
            if not emServico and not emRota then
                local ped = PlayerPedId()
                local x,y,z = taxi['IniciarServiço']['Coordenadas'][1],taxi['IniciarServiço']['Coordenadas'][2],taxi['IniciarServiço']['Coordenadas'][3]
                local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),x,y,z)
                if distance <= 5 then
                    cooldown = 5
                    DrawMarker(taxi['IniciarServiço']['Blip']['id'],x,y,z-0.77,0,0,0,0,0,0,taxi['IniciarServiço']['Blip']['scale'][1],taxi['IniciarServiço']['Blip']['scale'][2],taxi['IniciarServiço']['Blip']['scale'][3],taxi['IniciarServiço']['Blip']['color'][1],taxi['IniciarServiço']['Blip']['color'][2],taxi['IniciarServiço']['Blip']['color'][3],taxi['IniciarServiço']['Blip']['color'][4],taxi['IniciarServiço']['Blip']['jump'],0,0,taxi['IniciarServiço']['Blip']['rotate'])
                    Text3D(x,y,z,taxi['IniciarServiço']['Texto3D']['font'],taxi['IniciarServiço']['Texto3D']['scale'][1],taxi['IniciarServiço']['Texto3D']['scale'][2],0,0,0,255,taxi['IniciarServiço']['Texto3D']['text'])
                    if distance <= 1.2 and IsControlJustPressed(0,38) then
                        TriggerEvent('Notify','sucesso',taxi['Notificações']['EntrouServiço'])	
                        taxiSV.setarCargo()
                        emServico = true
                    end
                end
            end
        Wait(cooldown)
    end
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--( Iniciar Rota )-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local cooldown = 1000
            if emServico and not emRota then
                local ped = PlayerPedId()
                local x,y,z = taxi['IniciarRota']['Coordenadas'][1],taxi['IniciarRota']['Coordenadas'][2],taxi['IniciarRota']['Coordenadas'][3]
                local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),x,y,z)
                if distance <= 5 then
                    cooldown = 5
                    DrawMarker(taxi['IniciarRota']['Blip']['id'],x,y,z-0.77,0,0,0,0,0,0,taxi['IniciarRota']['Blip']['scale'][1],taxi['IniciarRota']['Blip']['scale'][2],taxi['IniciarRota']['Blip']['scale'][3],taxi['IniciarRota']['Blip']['color'][1],taxi['IniciarRota']['Blip']['color'][2],taxi['IniciarRota']['Blip']['color'][3],taxi['IniciarRota']['Blip']['color'][4],taxi['IniciarRota']['Blip']['jump'],0,0,taxi['IniciarRota']['Blip']['rotate'])
                    Text3D(x,y,z,taxi['IniciarRota']['Texto3D']['font'],taxi['IniciarRota']['Texto3D']['scale'][1],taxi['IniciarRota']['Texto3D']['scale'][2],0,0,0,255,taxi['IniciarRota']['Texto3D']['text'])
                    if distance <= 1.2 and IsControlJustPressed(0,38) then
                        TriggerEvent('Notify','aviso',taxi['Notificações']['IniciouRota'])
                        emServico = false
                        Wait(math.random(taxi['IniciarRota']['DelayEntrega']['min']*1000,taxi['IniciarRota']['DelayEntrega']['max']*1000))
                        TriggerEvent('Notify','aviso',taxi['Notificações']['ChamadoPassageiro'])
                        rotaSelecionada = math.random(#taxi['EmRota']['Passageiros'])
                        CriarBlipPassageiro(rotaSelecionada)
                        emRota = true
                    end
                end
            end
        Wait(cooldown)
    end
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--( Spawnar Ped )--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do 
        local cooldown = 1000
        if emRota and not pedSpawnado then
            local ped = PlayerPedId()
            local x,y,z,h = taxi['EmRota']['Passageiros'][rotaSelecionada][1],taxi['EmRota']['Passageiros'][rotaSelecionada][2],taxi['EmRota']['Passageiros'][rotaSelecionada][3],taxi['EmRota']['Passageiros'][rotaSelecionada][4]
            local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),x,y,z)
            if distance <= 400 then
                npc = spawnarPed(x,y,z,h)
                SetEntityInvincible(npc,true)
                FreezeEntityPosition(npc,true)
                pedSpawnado = true
            end
        end
        Wait(cooldown)
    end
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--( Rota )---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do 
        local cooldown = 1000
        if emRota and pedSpawnado then
            local ped = PlayerPedId()
            local x,y,z,h = taxi['EmRota']['Passageiros'][rotaSelecionada][1],taxi['EmRota']['Passageiros'][rotaSelecionada][2],taxi['EmRota']['Passageiros'][rotaSelecionada][3],taxi['EmRota']['Passageiros'][rotaSelecionada][4]
            local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),x,y,z)
            veiculo = GetVehiclePedIsIn(ped,false)
            if distance <= 10 then 
                cooldown = 5
                if IsControlJustPressed(0,38) then
                    if IsPedInAnyVehicle(ped,false) then
                        if GetEntityModel(GetVehiclePedIsIn(ped,false)) == GetHashKey(taxi['IniciarRota']['CarroServiço']) then
                            FreezeEntityPosition(npc,false)
                            SetVehicleDoorsLocked(veiculo,false)
                            if taxi['EmRota']['CongelarCarroNoPassageiro'] then
                                FreezeEntityPosition(veiculo,true)
                            else
                                FreezeEntityPosition(veiculo,false)
                            end
                            TaskEnterVehicle(npc,veiculo,-1,2,1.0,1,0)
                            emRota = false
                        else
                            TriggerEvent('Notify','aviso',taxi['Notificações']['CarroErrado'])
                        end
                    else
                        TriggerEvent('Notify','aviso',taxi['Notificações']['ForaDoCarro'])	
                    end
                end
            end
        end
        Wait(cooldown)
    end
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--( Verificar se o ped está no veículo )---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local cooldown = 1000
        if not emRota and not emTransito and DoesEntityExist(npc) and IsPedSittingInVehicle(npc,veiculo) then
            RemoveBlip(blips)
            FreezeEntityPosition(veiculo,false)
            rotaSelecionada = math.random(#taxi['EmRota']['Destinos'])
            CriarBlipDestino(rotaSelecionada)
            emTransito = true
            TriggerEvent('Notify','aviso',taxi['Notificações']['LeveAoDestino'])
        end
        Wait(cooldown)
    end
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--( Entregar Passageiro )-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local cooldown = 1000
        if emTransito then
            local ped = PlayerPedId()
            local x,y,z = taxi['EmRota']['Destinos'][rotaSelecionada][1],taxi['EmRota']['Destinos'][rotaSelecionada][2],taxi['EmRota']['Destinos'][rotaSelecionada][3]
            local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),x,y,z)
            if emTransito and distance <= 60 then
                cooldown = 5
                DrawMarker(taxi['EmRota']['Blip']['id'],x,y,z,0,0,0,0,0,0,taxi['EmRota']['Blip']['scale'][1],taxi['EmRota']['Blip']['scale'][2],taxi['EmRota']['Blip']['scale'][3],taxi['EmRota']['Blip']['color'][1],taxi['EmRota']['Blip']['color'][2],taxi['EmRota']['Blip']['color'][3],taxi['EmRota']['Blip']['color'][4],taxi['EmRota']['Blip']['jump'],0,0,taxi['EmRota']['Blip']['rotate'])
                if IsControlJustPressed(0,38) and distance <= 5 then
                    if IsPedInAnyVehicle(ped,false) then
                        if GetEntityModel(GetVehiclePedIsIn(ped,false)) == GetHashKey(taxi['IniciarRota']['CarroServiço']) then
                            if taxi['EmRota']['CongelarCarroNoDestino'] then
                                FreezeEntityPosition(veiculo,true)
                            else
                                FreezeEntityPosition(veiculo,false)
                            end
                            taxiSV.pagamento()
                            Wait(2000)
                            TaskLeaveVehicle(npc,veiculo,131072)
                            TaskWanderStandard(npc,10,10)
                            SetEntityInvincible(npc,false)
                            
                            Wait(2000)
                            SetVehicleDoorShut(veiculo,3,not taxi['EmRota']['MovimentoPorta'])
                            FreezeEntityPosition(veiculo,false)
                            pedSpawnado = false
                            emTransito = false
                            RemoveBlip(blips)
                            
                            Wait(math.random(taxi['IniciarRota']['DelayEntrega']['min']*1000,taxi['IniciarRota']['DelayEntrega']['max']*1000))
                            TriggerEvent('Notify','aviso',taxi['Notificações']['ChamadoPassageiro'])
                            rotaSelecionada = math.random(#taxi['EmRota']['Passageiros'])
                            CriarBlipPassageiro(rotaSelecionada)
                            emRota = true
                        else
                            TriggerEvent('Notify','aviso',taxi['Notificações']['CarroErrado'])
                        end
                    else
                        TriggerEvent('Notify','aviso',taxi['Notificações']['ForaDoCarro'])	
                    end
                end
            end
        end
        Wait(cooldown)
    end
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--( Remover cargo se não estiver em serviço )----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local cooldown = 1000
            if taxiSV.verificarCargo() and not emServico then
                taxiSV.retirarCargo()
            end
        Wait(cooldown)
    end
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--( Sair de serviço )---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local cooldown = 1000
        if emServico or emRota or emTransito then
            cooldown = 5
            if IsControlJustPressed(0,168) then 
                TriggerEvent('Notify','aviso',taxi['Notificações']['SairServiço'])
                if DoesEntityExist(npc) then
                    DeleteEntity(npc)
                end
                RemoveBlip(blips)
                emServico = false
                emRota = false
                emTransito = false
                pedSpawnado = false
            end          
        end
        Wait(cooldown)
    end
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--( Funções )------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function spawnarPed(x,y,z,h)

    local pedSelecionado = math.random(#taxi['EmRota']['ModelosPed'])
    local ped = GetHashKey(taxi['EmRota']['ModelosPed'][pedSelecionado])

    RequestModel(ped)
	while not HasModelLoaded(ped) do
		Wait(100)
	end

    return CreatePed(4,ped,x,y,z-1,h,false,true)
end

function CriarBlipPassageiro(rotaSelected)
	blips = AddBlipForCoord(taxi['EmRota']['Passageiros'][rotaSelected][1],taxi['EmRota']['Passageiros'][rotaSelected][2],taxi['EmRota']['Passageiros'][rotaSelected][3])
	SetBlipSprite(blips,taxi['EmRota']['BlipPassageiro']['sprite'])
	SetBlipColour(blips,taxi['EmRota']['BlipPassageiro']['color'])
	SetBlipScale(blips,taxi['EmRota']['BlipPassageiro']['scale'])
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString(taxi['EmRota']['BlipPassageiro']['text'])
	EndTextCommandSetBlipName(blips)
end

function CriarBlipDestino(rotaSelected)
	blips = AddBlipForCoord(taxi['EmRota']['Destinos'][rotaSelected][1],taxi['EmRota']['Destinos'][rotaSelected][2],taxi['EmRota']['Destinos'][rotaSelected][3])
	SetBlipSprite(blips,taxi['EmRota']['BlipDestino']['sprite'])
	SetBlipColour(blips,taxi['EmRota']['BlipDestino']['color'])
	SetBlipScale(blips,taxi['EmRota']['BlipDestino']['scale'])
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString(taxi['EmRota']['BlipDestino']['text'])
	EndTextCommandSetBlipName(blips)
end

function Text3D(x,y,z,font,scale,scale2,r,g,b,a,text)
    local screen,x2,y2 = GetScreenCoordFromWorldCoord(x,y,z)
    if screen then
        SetTextFont(font)
        SetTextScale(scale,scale2)
        SetTextColour(r,g,b,a)
        SetTextCentre(1)
        SetTextEntry('STRING')
        AddTextComponentString(text)
        DrawText(x2,y2)
    end
end