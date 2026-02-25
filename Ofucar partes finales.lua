local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Parent = player.PlayerGui
gui.Name = "NumberBuilderGUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 200)
frame.Position = UDim2.new(0.5, -200, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active = true
frame.Draggable = true

-- TextBox para número
local box = Instance.new("TextBox", frame)
box.Size = UDim2.new(1, -20, 0, 50)
box.Position = UDim2.new(0, 10, 0, 10)
box.PlaceholderText = "Escribe el número (ej: 23)"
box.Text = ""
box.ClearTextOnFocus = false
box.TextColor3 = Color3.new(1,1,1)
box.BackgroundColor3 = Color3.fromRGB(40,40,40)

-- Output
local output = Instance.new("TextBox", frame)
output.Size = UDim2.new(1, -20, 0, 90)
output.Position = UDim2.new(0, 10, 0, 70)
output.MultiLine = true
output.TextWrapped = false
output.TextXAlignment = Enum.TextXAlignment.Left
output.TextYAlignment = Enum.TextYAlignment.Top
output.Text = ""
output.ClearTextOnFocus = false
output.TextColor3 = Color3.fromRGB(0,1,0)
output.BackgroundColor3 = Color3.fromRGB(30,30,30)

-- Botón
local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(1, -20, 0, 30)
button.Position = UDim2.new(0, 10, 1, -40)
button.Text = "GENERAR"
button.BackgroundColor3 = Color3.fromRGB(60,60,60)
button.TextColor3 = Color3.new(1,1,1)

-- Generador
button.MouseButton1Click:Connect(function()

    local numero = box.Text

    if numero == "" then
        output.Text = "Escribe un número"
        return
    end

    -- convertir número a tabla de dígitos automáticamente
    local tabla = {}
    for i = 1, #numero do
        table.insert(tabla, numero:sub(i,i))
    end

    local digitos = table.concat(tabla, ",")

    local codigo = [[
local function d(t)
    local s = ""
    for i = 1, #t do
        s = s .. string.char(t[i])
    end
    return s
end

local k = 0
for _,v in ipairs({]]..digitos..[[}) do
    k = k * 10 + v
end

if _ and _[k] then
    local decoded = d(_[k])
    loadstring(decoded)()
else
    warn("Indice no válido:", k)
end
]]

    output.Text = codigo

    if setclipboard then
        setclipboard(codigo)
    end

end)
