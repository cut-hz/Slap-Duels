local API_URL = "https://hustz.manus.space/api/v1/exec/LgWFetIpjkbtsRS_"
local API_TOKEN = "3Ycc28RiMM4h5skVuenggHvCPie3adPp"

print("🔄 Carregando script seguro...")

local function loadSecureScript()
    local success, result = pcall(function()       
        
        -- Método 1: syn.request (Synapse X, Delta)
        if syn and syn.request then
            print("🔧 Usando syn.request...")
            local response = syn.request({
                Url = API_URL,
                Method = "GET",
                Headers = {
                    ["Authorization"] = "Bearer " .. API_TOKEN
                }
            })
            
            if response.StatusCode == 200 then
                return response.Body
            else
                error("HTTP " .. response.StatusCode .. ": " .. (response.Body or "Unknown error"))
            end
        
        -- Método 2: http_request (Script-Ware, Krnl)
        elseif http_request then
            print("🔧 Usando http_request...")
            local response = http_request({
                Url = API_URL,
                Method = "GET",
                Headers = {
                    ["Authorization"] = "Bearer " .. API_TOKEN
                }
            })
            
            if response.StatusCode == 200 then
                return response.Body
            else
                error("HTTP " .. response.StatusCode .. ": " .. (response.Body or "Unknown error"))
            end
        
        -- Método 3: request (Fluxus, Delta)
        elseif request then
            print("🔧 Usando request...")
            local response = request({
                Url = API_URL,
                Method = "GET",
                Headers = {
                    ["Authorization"] = "Bearer " .. API_TOKEN
                }
            })
            
            if response.StatusCode == 200 then
                return response.Body
            else
                error("HTTP " .. response.StatusCode .. ": " .. (response.Body or "Unknown error"))
            end
        
        -- Método 4: game:HttpGet com headers (alguns executors)
        else
            print("🔧 Usando game:HttpGet...")
            -- Nota: Nem todos os executors suportam headers customizados no HttpGet
            -- Se este método falhar, seu executor pode não suportar autenticação
            return game:HttpGet(API_URL, true)
        end
    end)
    
    if success then
        return result
    else
        return nil, result
    end
end

-- Carregar e executar o script
local scriptCode, errorMsg = loadSecureScript()

if scriptCode then
    print("✅ Script baixado com sucesso!")
    print("📦 Tamanho:", #scriptCode, "bytes")
    print("🚀 Executando...")
    
    -- Executar o script baixado
    local execSuccess, execError = pcall(function()
        loadstring(scriptCode)()
    end)
    
    if execSuccess then
        print("✅ Script executado com sucesso!")
    else
        warn("❌ Erro ao executar script:", execError)
    end
else
    warn("❌ Erro ao carregar script:", errorMsg)
    warn("")
    warn("Possíveis causas:")
    warn("1. Script ID incorreto na URL")
    warn("2. Token inválido ou expirado")
    warn("3. Script está desativado no painel")
    warn("4. Seu executor não suporta requisições HTTP com headers")
    warn("")
    warn("Verifique o painel administrativo para mais detalhes nos logs.")
end