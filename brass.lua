---@diagnostic disable: undefined-global

-- Nome dos periféricos
local estoque = peripheral.wrap("sophisticatedstorage:controller_0")
local melterCobre = peripheral.wrap("tconstruct:melter_0")
local melterZinco = peripheral.wrap("tconstruct:melter_1")

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

-- Enviar 3 cobres para o melter 0
enviarItem("minecraft:copper_ingot", 3, melterCobre)

-- Enviar 1 zinco para o melter 1
enviarItem("create:zinc_ingot", 1, melterZinco)

