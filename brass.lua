-- Nome dos periféricos
local estoque = peripheral.wrap("sophisticatedstorage:controller_0")
local melterCobre = peripheral.wrap("tconstruct:melter_0")
local melterZinco = peripheral.wrap("tconstruct:melter_1")
local monitor = peripheral.find("monitor")  -- Acha um monitor automaticamente

-- Função para mover item por nome
function enviarItem(nomeItem, quantidade, destino)
  local lista = estoque.list()
  for slot, item in pairs(lista) do
    if item.name == nomeItem then
      local enviado = estoque.pushItems(peripheral.getName(destino), slot, quantidade)
      print("Enviado "..enviado.."x "..nomeItem.." para "..peripheral.getName(destino))
      return enviado
    end
  end
  print("Item "..nomeItem.." não encontrado!")
  return 0
end

-- Função para fazer brass
function fazerBrass()
    enviarItem("minecraft:copper_ingot", 3, melterCobre)
    enviarItem("create:zinc_ingot", 1, melterZinco)
    print("Produção de Brass iniciada!")
end

function desenharBotao()
    if not monitor then
      print("Monitor não encontrado!")
      return
    end
    monitor.clear()
    monitor.setTextScale(2)
    monitor.setCursorPos(5, 5)
    monitor.write("[ FAZER BRASS ]")
end

-- Detectar clique no botão
function checarToque()
    while true do
      local evento, lado, x, y = os.pullEvent("monitor_touch")
      if x >= 5 and x <= 18 and y == 5 then
        fazerBrass()
      end
    end
end

-- Executar
desenharBotao()
checarToque()
