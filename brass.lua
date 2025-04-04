---@diagnostic disable: undefined-global

local estoque = peripheral.wrap("sophisticatedstorage:controller_0")
local melterCobre = peripheral.wrap("tconstruct:melter_0")
local melterZinco = peripheral.wrap("tconstruct:melter_1")
local monitor = peripheral.wrap("monitor_2")  -- <- Altere aqui se o nome for diferente

if not monitor then
  print("Monitor não encontrado!")
  return
end

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

function fazerBrass()
  monitor.setCursorPos(1, 7)
  monitor.write("Fazendo Brass...    ")
  enviarItem("minecraft:copper_ingot", 3, melterCobre)
  enviarItem("create:zinc_ingot", 1, melterZinco)
  sleep(1)
  monitor.setCursorPos(1, 7)
  monitor.write("Brass enviado!     ")
end

function desenharBotao()
  monitor.setTextScale(2)
  monitor.clear()
  monitor.setCursorPos(5, 5)
  monitor.write("[ FAZER BRASS ]")
end

function monitorLoop()
  while true do
    local event, side, x, y = os.pullEvent("monitor_touch")
    if side == peripheral.getName(monitor) and x >= 5 and x <= 18 and y == 5 then
      fazerBrass()
    end
  end
end

desenharBotao()
parallel.waitForAny(monitorLoop)
