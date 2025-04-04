---@diagnostic disable: undefined-global

-- Conectar periféricos
local estoque = peripheral.wrap("bottom") -- Altere para o nome correto!
local melterCobre = peripheral.wrap("tconstruct:melter_0")
local melterZinco = peripheral.wrap("tconstruct:melter_1")
local monitor = peripheral.wrap("monitor_3") -- Altere para o nome correto do seu monitor

if not monitor then
  print("Monitor não encontrado!")
  return
end

-- Detectar tamanho do monitor
local largura, altura = monitor.getSize()
local textoBotao = "[ FAZER BRASS ]"
local botaoX = math.floor((largura - #textoBotao) / 2) + 1
local botaoY = math.floor(altura / 2)

-- Enviar item por nome
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

-- Ação do botão
function fazerBrass()
  monitor.setCursorPos(1, altura)
  monitor.write("Fazendo brass...         ")
  enviarItem("minecraft:copper_ingot", 3, melterCobre)
  enviarItem("create:zinc_ingot", 1, melterZinco)
  sleep(1)
  monitor.setCursorPos(1, altura)
  monitor.write("Feito!                   ")
end

-- Desenhar botão na tela
function desenharBotao()
  monitor.setTextScale(1)
  monitor.setBackgroundColor(colors.black)
  monitor.setTextColor(colors.white)
  monitor.clear()
  monitor.setCursorPos(botaoX, botaoY)
  monitor.write(textoBotao)
end

-- Loop de escuta de clique
function monitorLoop()
  while true do
    local event, side, x, y = os.pullEvent("monitor_touch")
    if side == peripheral.getName(monitor) then
      if y == botaoY and x >= botaoX and x <= botaoX + #textoBotao then
        fazerBrass()
      end
    end
  end
end

-- Iniciar tudo
desenharBotao()
monitorLoop()
