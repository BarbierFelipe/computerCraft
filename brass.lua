---@diagnostic disable: undefined-global

-- Conectar periféricos
local estoque = peripheral.wrap("sophisticatedstorage:controller_0")
local melterCobre = peripheral.wrap("tconstruct:melter_0")
local melterZinco = peripheral.wrap("tconstruct:melter_1")
local monitor = peripheral.wrap("monitor_2")  -- Altere para o nome correto

if not monitor then
  print("Monitor não encontrado!")
  return
end

-- Pega tamanho do monitor
local largura, altura = monitor.getSize()

-- Texto do botão
local textoBotao = "[ FAZER BRASS ]"
local botaoX = math.floor((largura - #textoBotao) / 2) + 1
local botaoY = math.floor(altura / 2)

-- Função para mover item
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

-- Função principal: fazer brass
function fazerBrass()
  monitor.setCursorPos(1, altura)
  monitor.write("Fazendo Brass...    ")
  enviarItem("minecraft:copper_ingot", 3, melterCobre)
  enviarItem("create:zinc_ingot", 1, melterZinco)
  sleep(1)
  monitor.setCursorPos(1, altura)
  monitor.write("Brass enviado!      ")
end

-- Desenha botão
function desenharBotao()
  monitor.setTextScale(1)
  monitor.clear()
  monitor.setCursorPos(botaoX, botaoY)
  monitor.write(textoBotao)
end

-- Loop de clique
function monitorLoop()
  while true do
    local event, side, x, y = os.pullEvent("monitor_touch")
    if side == peripheral.getName(monitor) and
       y == botaoY and x >= botaoX and x <= botaoX + #textoBotao then
      fazerBrass()
    end
  end
end

-- Inicialização
desenharBotao()
parallel.waitForAny(monitorLoop)
