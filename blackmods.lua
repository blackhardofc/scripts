-- =============================================
-- 🔪 BLACK HUB — KNIFE DUELS | VERSÃO COMPLETA
-- 🔑 CHAVE: BLACK2026
-- 🛡️ PROTEÇÕES ANTI-BAN + TODAS AS FUNÇÕES
-- =============================================

local Protecoes = {}

Protecoes.LimparLogs = function()
    task.spawn(function()
        while task.wait(2) do
            pcall(function()
                if game:GetService("LogService") then
                    game:GetService("LogService").MessageOut:DisconnectAll()
                end
            end)
            pcall(function()
                local Stats = game:GetService("Stats")
                if Stats then Stats.Network:ClearAllChildren() end
            end)
        end
    end)
end

Protecoes.LimiteSeguranca = function()
    task.spawn(function()
        while task.wait(1) do
            pcall(function()
                local plr = game.Players.LocalPlayer
                if plr and plr.Character and plr.Character:FindFirstChild("Humanoid") then
                    local Hum = plr.Character.Humanoid
                    if Hum.WalkSpeed > 45 then Hum.WalkSpeed = 35 end
                    if Hum.JumpPower > 70 then Hum.JumpPower = 60 end
                end
            end)
        end
    end)
end

Protecoes.AntiRelog = function()
    pcall(function()
        local Gui = getfenv(0).script.Parent
        if Gui and Gui:IsA("ScreenGui") then Gui.ResetOnSpawn = false end
    end)
end

Protecoes.Ocultar = function()
    pcall(function()
        local Gui = getfenv(0).script.Parent
        if Gui then Gui.ClipsDescendants = true end
    end)
end

Protecoes.NomeAleatorio = function()
    local s = ""
    for _=1,math.random(8,14) do s=s..string.char(math.random(65,90)) end
    return s
end

Protecoes.LimparLogs()
Protecoes.LimiteSeguranca()
Protecoes.AntiRelog()
Protecoes.Ocultar()

-- =============================================
-- 🔑 SISTEMA DE CHAVE
-- =============================================
local ChaveCorreta = "BLACK2026"
local TelaInicial = Instance.new("ScreenGui")
TelaInicial.Name = Protecoes.NomeAleatorio()
TelaInicial.Parent = game.CoreGui
TelaInicial.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
TelaInicial.ResetOnSpawn = false

local FundoChave = Instance.new("Frame")
FundoChave.Name = Protecoes.NomeAleatorio()
FundoChave.Parent = TelaInicial
FundoChave.BackgroundColor3 = Color3.fromRGB(12, 12, 20)
FundoChave.Position = UDim2.new(0.5, -160, 0.5, -110)
FundoChave.Size = UDim2.new(0, 320, 0, 220)
FundoChave.Active = true
FundoChave.Draggable = true
Instance.new("UICorner", FundoChave).CornerRadius = UDim.new(0, 14)
local Borda = Instance.new("UIStroke")
Borda.Thickness = 2
Borda.Color = Color3.fromRGB(0, 180, 255)
Borda.Parent = FundoChave

local Titulo = Instance.new("TextLabel")
Titulo.Parent = FundoChave
Titulo.Text = "🔑 INSIRA A CHAVE"
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 22
Titulo.TextColor3 = Color3.fromRGB(0, 230, 255)
Titulo.Position = UDim2.new(0,0,0,20)
Titulo.Size = UDim2.new(1,0,0,35)

local Caixa = Instance.new("TextBox")
Caixa.Parent = FundoChave
Caixa.Text = ""
Caixa.PlaceholderText = "Digite a chave..."
Caixa.Font = Enum.Font.Gotham
Caixa.TextSize = 16
Caixa.TextColor3 = Color3.fromRGB(255,255,255)
Caixa.BackgroundColor3 = Color3.fromRGB(25,25,40)
Caixa.Position = UDim2.new(0.5,-120,0,70)
Caixa.Size = UDim2.new(0,240,0,45)
Caixa.ClearTextOnFocus = false
Instance.new("UICorner", Caixa).CornerRadius = UDim.new(0,8)

local BotaoEntrar = Instance.new("TextButton")
BotaoEntrar.Parent = FundoChave
BotaoEntrar.Text = "✅ LIBERAR PAINEL"
BotaoEntrar.Font = Enum.Font.GothamBold
BotaoEntrar.TextSize = 15
BotaoEntrar.TextColor3 = Color3.fromRGB(255,255,255)
BotaoEntrar.BackgroundColor3 = Color3.fromRGB(0, 160, 255)
BotaoEntrar.Position = UDim2.new(0.5,-120,0,135)
BotaoEntrar.Size = UDim2.new(0,240,0,45)
Instance.new("UICorner", BotaoEntrar).CornerRadius = UDim.new(0,8)

local Aviso = Instance.new("TextLabel")
Aviso.Parent = FundoChave
Aviso.Text = ""
Aviso.Font = Enum.Font.Gotham
Aviso.TextSize = 13
Aviso.TextColor3 = Color3.fromRGB(255,80,80)
Aviso.Position = UDim2.new(0,0,0,185)
Aviso.Size = UDim2.new(1,0,0,30)

-- =============================================
-- 🎯 SISTEMA DE FUNÇÕES PRINCIPAIS
-- =============================================
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local Funcoes = {
    SilentAim = false,
    TriggerBot = false,
    ESP = false,
    Velocidade = false,
    PuloAlto = false,
    SemCooldown = false,
    LancamentoRapido = false,
    AlcanceMax = false,
    HitboxAumentada = false,
    ModoCabeca = false,
    AimKey = Enum.UserInputType.MouseButton2,
    TriggerKey = Enum.UserInputType.MouseButton1,
    Smoothness = 3,
    AimPart = "Head"
}

local function GetAlvo()
    local Melhor, Distancia = nil, math.huge
    for _, v in pairs(workspace:GetChildren()) do
        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v ~= Player.Character and v.Humanoid.Health > 0 then
            local Pos, Vis = Camera:WorldToScreenPoint(v.Head.Position)
            if Vis then
                local Dist = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(Pos.X, Pos.Y)).Magnitude
                if Dist < Distancia and Dist < 150 then
                    Distancia = Dist
                    Melhor = v
                end
            end
        end
    end
    return Melhor
end

RunService.RenderStepped:Connect(function()
    if Funcoes.SilentAim and UIS:IsMouseButtonDown(Funcoes.AimKey) then
        local Alvo = GetAlvo()
        if Alvo and Alvo:FindFirstChild(Funcoes.AimPart) then
            local Pos = Camera:WorldToScreenPoint(Alvo[Funcoes.AimPart].Position)
            mousemoverel((Pos.X - Mouse.X)/Funcoes.Smoothness, (Pos.Y - Mouse.Y)/Funcoes.Smoothness)
        end
    end
end)

task.spawn(function()
    while task.wait(0.08) do
        if Funcoes.TriggerBot and UIS:IsMouseButtonDown(Funcoes.TriggerKey) then
            local Alvo = GetAlvo()
            if Alvo then
                pcall(function() game:GetService("ReplicatedStorage").Remotes.Throw:FireServer() end)
            end
        end
    end
end)

local ESPAtivos = {}
RunService.RenderStepped:Connect(function()
    if Funcoes.ESP then
        for _, v in pairs(workspace:GetChildren()) do
            if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v ~= Player.Character and v.Humanoid.Health > 0 then
                if not ESPAtivos[v] then
                    local Pos = Instance.new("BillboardGui")
                    Pos.Name = Protecoes.NomeAleatorio()
                    Pos.Parent = v.Head
                    Pos.AlwaysOnTop = true
                    Pos.Size = UDim2.new(0,150,0,50)
                    local Texto = Instance.new("TextLabel")
                    Texto.Parent = Pos
                    Texto.BackgroundTransparency = 1
                    Texto.Size = UDim2.new(1,0,1,0)
                    Texto.Text = v.Name
                    Texto.Font = Enum.Font.GothamBold
                    Texto.TextSize = 12
                    Texto.TextColor3 = Color3.fromRGB(0,255,130)
                    ESPAtivos[v] = Pos
                end
            end
        end
    else
        for v, gui in pairs(ESPAtivos) do if gui then gui:Destroy() end end
        table.clear(ESPAtivos)
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if Funcoes.HitboxAumentada then
            for _, v in pairs(workspace:GetChildren()) do
                if v:FindFirstChild("HumanoidRootPart") and v ~= Player.Character then
                    pcall(function() v.HumanoidRootPart.Size = Vector3.new(6,8,6) end)
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if Player.Character and Player.Character:FindFirstChild("Knife") then
            local Knife = Player.Character.Knife
            if Funcoes.SemCooldown then pcall(function() Knife.Cooldown.Value = 0 end) end
            if Funcoes.LancamentoRapido then pcall(function() Knife.ThrowSpeed.Value = 120 end) end
            if Funcoes.AlcanceMax then pcall(function() Knife.Range.Value = 250 end) end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if not Funcoes.HitboxAumentada then
            for _, v in pairs(workspace:GetChildren()) do
                if v:FindFirstChild("HumanoidRootPart") and v ~= Player.Character then
                    pcall(function() v.HumanoidRootPart.Size = Vector3.new(2,2,2) end)
                end
            end
        end
    end
end)

-- =============================================
-- 🎮 PAINEL PRINCIPAL
-- =============================================
function AbrirPainel()
    TelaInicial:Destroy()
    local Tela = Instance.new("ScreenGui")
    Tela.Name = Protecoes.NomeAleatorio()
    Tela.Parent = game.CoreGui
    Tela.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Tela.ResetOnSpawn = false

    local Painel = Instance.new("Frame")
    Painel.Name = Protecoes.NomeAleatorio()
    Painel.Parent = Tela
    Painel.BackgroundColor3 = Color3.fromRGB(8, 10, 24)
    Painel.Position = UDim2.new(0.05,0,0.10,0)
    Painel.Size = UDim2.new(0,310,0,440)
    Painel.Active = true
    Instance.new("UICorner", Painel).CornerRadius = UDim.new(0,16)
    local BordaP = Instance.new("UIStroke")
    BordaP.Thickness = 3
    BordaP.Color = Color3.fromRGB(0,190,255)
    BordaP.Transparency = 0.15
    BordaP.Parent = Painel

    local Barra = Instance.new("Frame")
    Barra.Name = Protecoes.NomeAleatorio()
    Barra.Parent = Painel
    Barra.BackgroundColor3 = Color3.fromRGB(0,140,220)
    Barra.Size = UDim2.new(1,0,0,42)
    Barra.Position = UDim2.new(0,0,0,0)
    Instance.new("UICorner", Barra).CornerRadius = UDim.new(0,16)

    local TituloP = Instance.new("TextLabel")
    TituloP.Parent = Barra
    TituloP.Text = "⚡ BLACK HUB — KNIFE DUELS"
    TituloP.Font = Enum.Font.GothamBold
    TituloP.TextSize = 14
    TituloP.TextColor3 = Color3.fromRGB(255,255,255)
    TituloP.Position = UDim2.new(0,12,0,0)
    TituloP.Size = UDim2.new(1,-50,1,0)

    local BtnMin = Instance.new("TextButton")
    BtnMin.Name = Protecoes.NomeAleatorio()
    BtnMin.Parent = Barra
    BtnMin.Text = "−"
    BtnMin.Font = Enum.Font.GothamBold
    BtnMin.TextSize = 22
    BtnMin.TextColor3 = Color3.fromRGB(255,255,255)
    BtnMin.BackgroundTransparency = 1
    BtnMin.Position = UDim2.new(1,-35,0,0)
    BtnMin.Size = UDim2.new(0,30,1,0)

    local Conteudo = Instance.new("ScrollingFrame")
    Conteudo.Parent = Painel
    Conteudo.BackgroundTransparency = 1
    Conteudo.Position = UDim2.new(0,10,0,52)
    Conteudo.Size = UDim2.new(1,-20,1,-62)
    Conteudo.ScrollBarThickness = 4
    Conteudo.ScrollBarColor3 = Color3.fromRGB(0,180,255)
    Conteudo.CanvasSize = UDim2.new(0,0,0,700)

    local Layout = Instance.new("UIListLayout")
    Layout.Parent = Conteudo
    Layout.Padding = UDim.new(0,9)
    Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local function CriarBotao(Nome, Tabela, Chave, ValorSeguro, ValorNormal)
        local Btn = Instance.new("TextButton")
        Btn.Name = Protecoes.NomeAleatorio()
        Btn.Parent = Conteudo
        Btn.Text = "⚫ "..Nome
        Btn.Font = Enum.Font.GothamBold
        Btn.TextSize = 13
        Btn.TextColor3 = Color3.fromRGB(230,230,230)
        Btn.BackgroundColor3 = Color3.fromRGB(22,28,45)
        Btn.Size = UDim2.new(0,285,0,42)
        Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,10)
        local BordaBtn = Instance.new("UIStroke")
        BordaBtn.Thickness = 1.5
        BordaBtn.Color = Color3.fromRGB(0,160,255)
        BordaBtn.Transparency = 0.4
        BordaBtn.Parent = Btn

        local Ligado = false
        Btn.MouseButton1Click:Connect(function()
            Ligado = not Ligado
            Tabela[Chave] = Ligado
            BordaBtn.Transparency = Ligado and 0 or 0.4
            BordaBtn.Color = Ligado and Color3.fromRGB(0,255,130) or Color3.fromRGB(0,160,255)
            Btn.Text = Ligado and "🟢 "..Nome.." [ON]" or "⚫ "..Nome
            if ValorSeguro then
                pcall(function()
                    local Hum = Player.Character and Player.Character:FindFirstChild("Humanoid")
                    if Hum then
                        if Chave == "Velocidade" then Hum.WalkSpeed = Ligado and ValorSeguro or ValorNormal end
                        if Chave == "PuloAlto" then Hum.JumpPower = Ligado and ValorSeguro or ValorNormal end
                    end
                end)
            end
        end)
    end

    CriarBotao("🎯 SILENT AIM", Funcoes, "SilentAim")
    CriarBotao("⚡ TRIGGER BOT", Funcoes, "TriggerBot")
    CriarBotao("👁️ ESP — VER JOGADORES", Funcoes, "ESP")
    CriarBotao("🏃 VELOCIDADE ALTA", Funcoes, "Velocidade", 35, 16)
    CriarBotao("⬆️ PULO ALTO", Funcoes, "PuloAlto", 60, 50)
    CriarBotao("🔄 SEM RESFRIAMENTO", Funcoes, "SemCooldown")
    CriarBotao("🚀 LANÇAMENTO RÁPIDO", Funcoes, "LancamentoRapido")
    CriarBotao("📏 ALCANCE MÁXIMO", Funcoes, "AlcanceMax")
    CriarBotao("💥 HITBOX AUMENTADA", Funcoes, "HitboxAumentada")
    CriarBotao("🎯 MODO CABEÇA", Funcoes, "ModoCabeca")

    local Arrastando, Inicio, InicioP = false, Vector2.new(), UDim2.new()
    Barra.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then Arrastando, Inicio, InicioP = true, i.Position, Painel.Position end end)
    Barra.InputEnded:Connect(function() Arrastando = false end)
    UIS.InputChanged:Connect(function(i)
        if Arrastando and i.UserInputType == Enum.UserInputType.MouseMovement then
            local D = i.Position - Inicio
            Painel.Position = UDim2.new(InicioP.X.Scale, InicioP.X.Offset + D.X, InicioP.Y.Scale, InicioP.Y.Offset + D.Y)
        end
    end)

    local Min = false
    BtnMin.MouseButton1Click:Connect(function()
        Min = not Min
        Conteudo.Visible = not Min
        Painel.Size = Min and UDim2.new(0,310,0,42) or UDim2.new(0,310,0,440)
        BtnMin.Text = Min and "+" or "−"
    end)
end

BotaoEntrar.MouseButton1Click:Connect(function()
    if Caixa.Text == ChaveCorreta then
        Aviso.Text = "✅ CARREGANDO..."
        task.wait(0.8)
        AbrirPainel()
    else
        Aviso.Text = "❌ CHAVE INCORRETA! USE: BLACK2026"
    end
end)
