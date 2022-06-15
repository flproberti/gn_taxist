taxi = {
    
    ['Notificações'] = {
        ['EntrouServiço'] = 'Você entrou em serviço!',
        ['IniciouRota'] = 'Você iniciou a rota, pegue o seu taxi e espere por um passageiro!',
        ['ChamadoPassageiro'] = 'Um passageiro te chamou, vá buscar ele!',
        ['LeveAoDestino'] = 'Leve o passageiro até o destino marcado em seu GPS!',
        ['SairServiço'] = 'Você saiu de serviço!',
        ['Pagamento'] = { 'Você recebeu <b>$',' dólares</b>.' },
        ['CarroErrado'] = 'Você precisa utilizar o veículo de trabalho para pegar o passageiro!',
        ['ForaDoCarro'] = 'Você precisa estar dentro do veículo de trabalho para pegar o passageiro!',
    },
        
    ['IniciarServiço'] = {
        ['Coordenadas'] = { 900.79, -160.56, 74.15 },
        ['Blip'] = { id = 20, scale = { 0.3,0.3,0.3 }, color = { 255,255,255,100 }, jump = false, rotate = true },
        ['Texto3D'] = { text = '~w~PRESSIONE ~p~[E] ~w~PARA ~p~ENTRAR EM SERVIÇO', font = 7, scale = { 0.35,0.35 } },
        ['GrupoTaxista'] = 'taxista',
    },
    
    ['IniciarRota'] = {
        ['Coordenadas'] = { 891.26, -176.74, 74.69 },
        ['Blip'] = { id = 20, scale = { 0.3,0.3,0.3 }, color = { 255,255,255,100 }, jump = false, rotate = true },
        ['Texto3D'] = { text = '~w~PRESSIONE ~p~[E] ~w~PARA ~p~INICIAR A ROTA', font = 7, scale = { 0.35,0.35 } },
        ['CarroServiço'] = 'taxi',
        ['DelayEntrega'] = { min = 20, max = 40 },
    },
    
    ['EmRota'] = {
        ['CongelarCarroNoPassageiro'] = false,
        ['CongelarCarroNoDestino'] = false,
        ['MovimentoPorta'] = false,
        ['BlipPassageiro'] = { sprite = 1, color = 5, scale = 0.5, text = 'Passageiro' },
        ['BlipDestino'] = { sprite = 1, color = 5, scale = 0.5, text = 'Destino' },
        ['Blip'] = { id = 20, scale = { 2.0,2.0,2.0 }, color = { 255,255,255,100 }, jump = false, rotate = true },
        ['Pagamento'] = { min = 800, max = 1000 },
        ['ModelosPed'] = {
            's_m_m_highsec_02',
            'a_f_m_ktown_01',
            's_m_o_busker_01',
            'a_f_m_downtown_01',
            'a_f_m_fatbla_01',
            'g_m_m_chigoon_01',
            'a_f_y_bevhills_02',
            'g_m_y_mexgoon_01',
            'a_m_m_farmer_01',
            'a_m_m_soucent_03',
            'a_m_m_genfat_01',
            'a_f_m_fatwhite_01',
            'a_f_m_bevhills_01',
            'a_m_m_og_boss_01',
            'a_m_m_polynesian_01',
            'a_f_y_business_01',
            'a_f_y_bevhills_04',
            'a_m_y_beachvesp_01',
            'a_m_y_clubcust_01',
            'g_m_importexport_0',
            'a_f_y_bevhills_03',
            'a_m_y_soucent_03',
            'a_f_y_business_02',
            'a_m_y_stbla_01',
            'a_f_o_genstreet_01',
            's_m_y_robber_01',
            'a_m_m_afriamer_01',
            'a_f_y_business_03',
            'a_m_y_genstreet_01',
            's_m_m_lifeinvad_01',
            'a_m_m_bevhills_02',
            'a_f_m_soucentmc_01',
            'a_m_y_downtown_01',
            'a_f_y_hiker_01',
            'a_f_m_bevhills_02',
            'a_f_y_tourist_01',
        },
        ['Passageiros'] = {
            { -566.17, 682.02, 145.89, 174.53 },
            { -554.62, 666.86, 144.69, 348.31 },
            { -609.99, 677.64, 149.79, 15.12 },
            { -699.44, 709.96, 157.86, 315.83 },
            { -671.07, 758.28, 174.06, 11.99 },
            { -584.46, 736.43, 183.29, 56.18 },
            { -601.2, 804.28, 191.12, 175.97 },
            { -742.79, 812.13, 213.42, 326.99 },
            { -489.3, 740.5, 162.79, 270.91 },
            { -657.57, 902.66, 228.62, 338.28 },
            { -399.9, 667.43, 163.83, 332.69 },
            { -353.95, 667.04, 169.06, 138.88 },
            { -310.59, 641.45, 176.14, 114.30 },
            { -276.5, 606.09, 181.42, 354.94 },
            { -136.59, 592.96, 204.53, 2.87 },
            { -486.45, 551.16, 119.57, 336.57 },
            { -436.43, 542.77, 122.03, 13.74 },
            { -419.65, 552.52, 122.78, 159.24 },
            { -380.67, 526.37, 121.4, 184.49 },
            { -382.47, 509.91, 120.25, 320.41 },
            { -359.64, 510.0, 119.38, 98.76 },
            { -353.26, 470.42, 112.57, 337.69 },
            { -317.22, 463.71, 108.59, 157.39 },
            { -311.22, 437.76, 108.55, 31.13 },
            { -1963.62, 620.57, 121.25, 244.71 },
            { -1928.63, 643.15, 124.03, 58.20 },
            { -1949.77, 594.4, 119.58, 88.72 },
            { -1960.25, 547.75, 112.55, 95.89 },
            { -1996.38, 478.56, 104.08, 253.65 },
            { -1963.5, 428.31, 98.67, 122.72 },
            { -1957.3, 377.19, 93.52, 111.75 },
            { -1962.18, 269.74, 86.19, 284.10 },
            { -1930.17, 244.45, 84.68, 137.37 },
            { -1883.76, 175.38, 81.83, 135.76 },
            { -1787.27, 357.71, 88.58, 72.84 },
            { -1871.4, 332.99, 88.58, 19.39 },
            { -1675.98, 393.49, 89.04, 352.05 },
            { 274.22, -2040.29, 18.28, 58.50 },
            { 266.51, -2026.12, 18.81, 239.17 },
            { 274.71, -2015.82, 19.47, 246.32 },
            { 291.21, -1995.73, 20.51, 237.06 },
            { 319.21, -1987.01, 22.63, 58.53 },
            { 308.11, -1975.72, 22.72, 236.69 },
            { 78.64, -1908.11, 21.39, 150.11 },
            { 115.01, -1950.18, 20.69, 50.41 },
            { 26.35, -1884.18, 22.71, 326.66 },
            { 24.64, -1863.29, 23.25, 142.95 },
            { -21.67, -1843.37, 25.22, 322.29 },
            { -108.15, -1771.09, 29.8, 326.54 },
            { -173.29, -1576.68, 35.25, 233.50 },
            { -65.91, -1460.87, 32.02, 202.30 },
            { 20.24, -1460.99, 30.43, 152.32 },
            { 483.12, -1796.84, 28.43, 229.56 },
            { 503.96, -1783.41, 28.5, 95.36 },
            { 505.96, -1745.36, 28.83, 73.73 },
            { 497.23, -1725.25, 29.21, 252.50 },
        },
        ['Destinos'] = {
            { -106.47, -610.16, 36.06 },
            { -169.46, -810.28, 31.33 },
            { 257.08, -1062.19, 29.21 },
            { 274.32, -589.42, 43.15 },
            { 235.91, -369.38, 44.25 },
            { -133.21, -265.74, 42.59 },
            { -405.02, -373.0, 32.19 },
            { -929.77, -464.28, 37.08 },
            { -1258.31, -888.72, 11.66 },
            { -1598.82, -1041.48, 13.02 },
            { -3015.36, 91.0, 11.62 },
            { -3158.66, 1080.67, 20.7 },
            { -2333.7, 272.8, 169.47 },
            { -1643.4, 142.25, 61.89 },
            { -551.78, -159.75, 38.23 },
            { -504.39, -258.67, 35.14 },
            { 920.44, 48.4, 80.9 },
            { 1057.63, 228.42, 80.86 },
            { -204.05, -1884.71, 27.85 },
        },
    },
}