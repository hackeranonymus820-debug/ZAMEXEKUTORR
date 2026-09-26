--[[
    CRESSTON - ZAMSTUDIO
    Map   : Build A Rocket Ship
    Exec  : Delta
    Made by ZamStudio
]]

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local CoreGui           = game:GetService("CoreGui")
local TweenService      = game:GetService("TweenService")
local StarterGui        = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LP = Players.LocalPlayer

if CoreGui:FindFirstChild("CRESSTON_ZamStudio") then
    CoreGui.CRESSTON_ZamStudio:Destroy()
end

-- WARNA
local GOLD   = Color3.fromRGB(255, 210, 0)
local BLACK  = Color3.fromRGB(10, 10, 10)
local PANEL  = Color3.fromRGB(22, 22, 22)
local WHITE  = Color3.fromRGB(240, 240, 240)
local HOVER  = Color3.fromRGB(45, 40, 0)
local RED    = Color3.fromRGB(200, 50, 50)
local GREEN  = Color3.fromRGB(60, 200, 60)

-- PASSWORD
local PASSWORD = "ZAM-5C0DF-65EP1"

------------------------------------------------------------
-- SCREEN GUI
------------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CRESSTON_ZamStudio"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LP:WaitForChild("PlayerGui") end

------------------------------------------------------------
-- HELPER POPUP
------------------------------------------------------------
local function showPopup(text, ok)
    local popup = Instance.new("Frame", ScreenGui)
    popup.Size = UDim2.new(0, 300, 0, 46)
    popup.Position = UDim2.new(0.5, -150, 1.2, 0)
    popup.BackgroundColor3 = PANEL
    popup.BorderSizePixel = 0
    popup.ZIndex = 100

    local pc = Instance.new("UICorner", popup); pc.CornerRadius = UDim.new(0, 10)
    local ps = Instance.new("UIStroke", popup)
    ps.Color = ok and GREEN or RED
    ps.Thickness = 2

    local lbl = Instance.new("TextLabel", popup)
    lbl.Size = UDim2.new(1, -20, 1, 0); lbl.Position = UDim2.new(0,10,0,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = WHITE
    lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Center

    TweenService:Create(popup, TweenInfo.new(0.35, Enum.EasingStyle.Quint), {
        Position = UDim2.new(0.5, -150, 0.5, -23)
    }):Play()

    task.delay(2, function()
        local out = TweenService:Create(popup, TweenInfo.new(0.35, Enum.EasingStyle.Quint), {
            Position = UDim2.new(0.5, -150, 1.2, 0)
        })
        out:Play()
        out.Completed:Connect(function() popup:Destroy() end)
    end)
end

------------------------------------------------------------
-- LOGIN FRAME (MUNCUL PERTAMA)
------------------------------------------------------------
local LoginFrame = Instance.new("Frame", ScreenGui)
LoginFrame.Size = UDim2.new(0, 300, 0, 210)
LoginFrame.Position = UDim2.new(0.5, -150, 0.5, -105)
LoginFrame.BackgroundColor3 = BLACK
LoginFrame.BorderSizePixel = 0
LoginFrame.Active = true
LoginFrame.Draggable = true
LoginFrame.Visible = true

local lfc = Instance.new("UICorner", LoginFrame); lfc.CornerRadius = UDim.new(0, 12)
local lfs = Instance.new("UIStroke", LoginFrame); lfs.Color = GOLD; lfs.Thickness = 2; lfs.Transparency = 0.15

-- Title bar
local LTitle = Instance.new("Frame", LoginFrame)
LTitle.Size = UDim2.new(1,0,0,40)
LTitle.BackgroundColor3 = Color3.fromRGB(5,5,5)
LTitle.BorderSizePixel = 0
local ltc = Instance.new("UICorner", LTitle); ltc.CornerRadius = UDim.new(0,12)
local ltfix = Instance.new("Frame", LTitle)
ltfix.Size = UDim2.new(1,0,0,20); ltfix.Position = UDim2.new(0,0,1,-20)
ltfix.BackgroundColor3 = Color3.fromRGB(5,5,5); ltfix.BorderSizePixel = 0

local LTitleLbl = Instance.new("TextLabel", LTitle)
LTitleLbl.Size = UDim2.new(1,-20,1,0); LTitleLbl.Position = UDim2.new(0,15,0,0)
LTitleLbl.BackgroundTransparency = 1
LTitleLbl.Text = "CRESSTON - LOGIN"
LTitleLbl.TextColor3 = GOLD
LTitleLbl.Font = Enum.Font.GothamBlack; LTitleLbl.TextSize = 14
LTitleLbl.TextXAlignment = Enum.TextXAlignment.Left

-- Info
local LInfo = Instance.new("TextLabel", LoginFrame)
LInfo.Size = UDim2.new(1,-40,0,20)
LInfo.Position = UDim2.new(0,20,0,55)
LInfo.BackgroundTransparency = 1
LInfo.Text = "Masukkan Password"
LInfo.TextColor3 = WHITE
LInfo.Font = Enum.Font.GothamBold; LInfo.TextSize = 12
LInfo.TextXAlignment = Enum.TextXAlignment.Left

-- Input password
local PassInput = Instance.new("TextBox", LoginFrame)
PassInput.Size = UDim2.new(1,-40,0,42)
PassInput.Position = UDim2.new(0,20,0,80)
PassInput.BackgroundColor3 = PANEL
PassInput.BorderSizePixel = 0
PassInput.Text = ""
PassInput.PlaceholderText = "Password..."
PassInput.TextColor3 = WHITE
PassInput.PlaceholderColor3 = Color3.fromRGB(120,120,120)
PassInput.Font = Enum.Font.Gotham; PassInput.TextSize = 13
PassInput.ClearTextOnFocus = false
PassInput.TextXAlignment = Enum.TextXAlignment.Center

local pic = Instance.new("UICorner", PassInput); pic.CornerRadius = UDim.new(0,8)
local pis = Instance.new("UIStroke", PassInput); pis.Color = GOLD; pis.Thickness = 1; pis.Transparency = 0.4

-- Tombol Masuk
local LoginBtn = Instance.new("TextButton", LoginFrame)
LoginBtn.Size = UDim2.new(1,-40,0,42)
LoginBtn.Position = UDim2.new(0,20,0,135)
LoginBtn.BackgroundColor3 = Color3.fromRGB(60,50,0)
LoginBtn.BorderSizePixel = 0
LoginBtn.Text = "MASUK"
LoginBtn.TextColor3 = GOLD
LoginBtn.Font = Enum.Font.GothamBlack; LoginBtn.TextSize = 15
LoginBtn.AutoButtonColor = false

local lbc = Instance.new("UICorner", LoginBtn); lbc.CornerRadius = UDim.new(0,8)
local lbs = Instance.new("UIStroke", LoginBtn); lbs.Color = GOLD; lbs.Thickness = 1; lbs.Transparency = 0.3

LoginBtn.MouseEnter:Connect(function()
    TweenService:Create(LoginBtn, TweenInfo.new(0.15), {BackgroundColor3 = HOVER}):Play()
end)
LoginBtn.MouseLeave:Connect(function()
    TweenService:Create(LoginBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(60,50,0)}):Play()
end)

------------------------------------------------------------
-- LOGO BULAT (muncul setelah login)
------------------------------------------------------------
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 54, 0, 54)
ToggleBtn.Position = UDim2.new(0, 20, 0.5, -27)
ToggleBtn.BackgroundColor3 = BLACK
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Text = ""
ToggleBtn.AutoButtonColor = false
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Visible = false
ToggleBtn.Parent = ScreenGui

local tc = Instance.new("UICorner", ToggleBtn); tc.CornerRadius = UDim.new(1, 0)
local ts = Instance.new("UIStroke", ToggleBtn); ts.Color = GOLD; ts.Thickness = 2; ts.Transparency = 0.1

local logoLbl = Instance.new("TextLabel", ToggleBtn)
logoLbl.Size = UDim2.new(1,0,1,0); logoLbl.BackgroundTransparency = 1
logoLbl.Text = "✦"
logoLbl.TextColor3 = GOLD
logoLbl.Font = Enum.Font.GothamBlack; logoLbl.TextSize = 30

------------------------------------------------------------
-- MAIN FRAME
------------------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 340, 0, 470)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -235)
MainFrame.BackgroundColor3 = BLACK
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local mc = Instance.new("UICorner", MainFrame); mc.CornerRadius = UDim.new(0, 12)
local mstroke = Instance.new("UIStroke", MainFrame)
mstroke.Color = GOLD; mstroke.Thickness = 2; mstroke.Transparency = 0.15

------------------------------------------------------------
-- TITLE BAR
------------------------------------------------------------
local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 44)
TitleBar.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
TitleBar.BorderSizePixel = 0
local tbc = Instance.new("UICorner", TitleBar); tbc.CornerRadius = UDim.new(0, 12)
local tbfix = Instance.new("Frame", TitleBar)
tbfix.Size = UDim2.new(1,0,0,22); tbfix.Position = UDim2.new(0,0,1,-22)
tbfix.BackgroundColor3 = Color3.fromRGB(5, 5, 5); tbfix.BorderSizePixel = 0

local TitleLbl = Instance.new("TextLabel", TitleBar)
TitleLbl.Size = UDim2.new(1,-20,1,0); TitleLbl.Position = UDim2.new(0,15,0,0)
TitleLbl.BackgroundTransparency = 1
TitleLbl.Text = "CRESSTON - ZAMSTUDIOS"
TitleLbl.TextColor3 = GOLD
TitleLbl.Font = Enum.Font.GothamBlack; TitleLbl.TextSize = 15
TitleLbl.TextXAlignment = Enum.TextXAlignment.Left

local line = Instance.new("Frame", TitleBar)
line.Size = UDim2.new(1,-20,0,1); line.Position = UDim2.new(0,10,1,-2)
line.BackgroundColor3 = GOLD; line.BorderSizePixel = 0; line.BackgroundTransparency = 0.4

------------------------------------------------------------
-- SCROLL
------------------------------------------------------------
local Scroll = Instance.new("ScrollingFrame", MainFrame)
Scroll.Size = UDim2.new(1, -20, 1, -80)
Scroll.Position = UDim2.new(0, 10, 0, 50)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 3
Scroll.ScrollBarImageColor3 = GOLD
Scroll.CanvasSize = UDim2.new(0,0,0,0)
Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

local sL = Instance.new("UIListLayout", Scroll)
sL.Padding = UDim.new(0, 6); sL.SortOrder = Enum.SortOrder.LayoutOrder
local sP = Instance.new("UIPadding", Scroll)
sP.PaddingTop = UDim.new(0, 6); sP.PaddingBottom = UDim.new(0, 6)

------------------------------------------------------------
-- HELPER: SWITCH
------------------------------------------------------------
local function makeSwitchRow(labelText, defaultState, callback)
    local row = Instance.new("Frame", Scroll)
    row.Size = UDim2.new(1, 0, 0, 38)
    row.BackgroundColor3 = PANEL
    row.BorderSizePixel = 0
    local rc = Instance.new("UICorner", row); rc.CornerRadius = UDim.new(0, 8)
    local rs = Instance.new("UIStroke", row); rs.Color = GOLD; rs.Thickness = 1; rs.Transparency = 0.7

    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(1, -80, 1, 0); lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = labelText
    lbl.TextColor3 = WHITE
    lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local switchBg = Instance.new("Frame", row)
    switchBg.Size = UDim2.new(0, 48, 0, 24)
    switchBg.Position = UDim2.new(1, -58, 0.5, -12)
    switchBg.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    switchBg.BorderSizePixel = 0
    local sbc = Instance.new("UICorner", switchBg); sbc.CornerRadius = UDim.new(1,0)

    local knob = Instance.new("Frame", switchBg)
    knob.Size = UDim2.new(0, 18, 0, 18)
    knob.Position = UDim2.new(0, 3, 0.5, -9)
    knob.BackgroundColor3 = WHITE
    knob.BorderSizePixel = 0
    local kc = Instance.new("UICorner", knob); kc.CornerRadius = UDim.new(1,0)

    local state = defaultState or false
    local function refresh()
        if state then
            TweenService:Create(switchBg, TweenInfo.new(0.2), {BackgroundColor3 = GOLD}):Play()
            TweenService:Create(knob, TweenInfo.new(0.2), {Position = UDim2.new(0,27,0.5,-9)}):Play()
        else
            TweenService:Create(switchBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60,60,60)}):Play()
            TweenService:Create(knob, TweenInfo.new(0.2), {Position = UDim2.new(0,3,0.5,-9)}):Play()
        end
    end
    refresh()

    local btn = Instance.new("TextButton", row)
    btn.Size = UDim2.new(1,0,1,0)
    btn.BackgroundTransparency = 1; btn.Text = ""; btn.ZIndex = 5
    btn.MouseButton1Click:Connect(function()
        state = not state
        refresh()
        if callback then task.spawn(function() callback(state) end) end
    end)
    return row
end

------------------------------------------------------------
-- HELPER: BUTTON
------------------------------------------------------------
local function makeButton(text, color, callback)
    local btn = Instance.new("TextButton", Scroll)
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.BackgroundColor3 = color or PANEL
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = WHITE
    btn.Font = Enum.Font.GothamBold; btn.TextSize = 13
    btn.AutoButtonColor = false
    local c = Instance.new("UICorner", btn); c.CornerRadius = UDim.new(0, 8)
    local s = Instance.new("UIStroke", btn); s.Color = GOLD; s.Thickness = 1; s.Transparency = 0.6

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = HOVER}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = color or PANEL}):Play()
    end)
    btn.MouseButton1Click:Connect(function()
        task.spawn(function() if callback then callback() end end)
    end)
    return btn
end

local function makeSection(text)
    local f = Instance.new("Frame", Scroll)
    f.Size = UDim2.new(1, 0, 0, 26)
    f.BackgroundColor3 = Color3.fromRGB(5,5,5)
    f.BorderSizePixel = 0
    local c = Instance.new("UICorner", f); c.CornerRadius = UDim.new(0, 6)
    local lbl = Instance.new("TextLabel", f)
    lbl.Size = UDim2.new(1,-20,1,0); lbl.Position = UDim2.new(0,10,0,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = GOLD
    lbl.Font = Enum.Font.GothamBlack; lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    return f
end

------------------------------------------------------------
-- FUNGSI BANTUAN
------------------------------------------------------------
local function getMyRocket()
    local char = LP.Character
    if not char then return nil end
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Model") or v:IsA("Tool") then
            local nm = v.Name:lower()
            if nm:find("rocket") or nm:find("ship") or nm:find("spaceship") then
                local owner = v:GetAttribute("Owner") or v:GetAttribute("Player")
                if owner == LP.Name or v:FindFirstChild(LP.Name) or v:GetAttribute("UserId") == LP.UserId then
                    return v
                end
            end
        end
    end
    for _, v in ipairs(char:GetChildren()) do
        local nm = v.Name:lower()
        if nm:find("rocket") or nm:find("ship") then return v end
    end
    return nil
end

local function detectMoneyStats()
    local stats = {}
    local container = LP:FindFirstChild("leaderstats") or LP:FindFirstChild("PlayerStats") or LP:FindFirstChild("Stats")
    if container then
        for _, v in ipairs(container:GetChildren()) do
            if v:IsA("IntValue") or v:IsA("NumberValue") then
                table.insert(stats, v)
            end
        end
    end
    return stats
end

local function setMoney(amount)
    local stats = detectMoneyStats()
    for _, s in ipairs(stats) do pcall(function() s.Value = amount end) end
    for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            local ln = obj.Name:lower()
            if ln:find("money") or ln:find("cash") or ln:find("coin") or ln:find("reward") then
                pcall(function()
                    if obj:IsA("RemoteEvent") then
                        obj:FireServer(amount)
                    else
                        obj:InvokeServer(amount)
                    end
                end)
            end
        end
    end
end

------------------------------------------------------------
-- FITUR-FITUR (dipanggil setelah login)
------------------------------------------------------------
local function buildFeatures()

    -- 1. FARM UANG
    local farmMoneyOn = false
    local farmMoneyConn
    makeSwitchRow("FARM UANG", false, function(state)
        farmMoneyOn = state
        if state then
            if farmMoneyConn then farmMoneyConn:Disconnect() end
            farmMoneyConn = RunService.Heartbeat:Connect(function()
                if not farmMoneyOn then return end
                setMoney(9000000)
            end)
            setMoney(9000000)
        else
            if farmMoneyConn then farmMoneyConn:Disconnect() end
        end
    end)

    -- 2. INFINITY FUEL
    local infFuelOn = false
    local fuelConn
    makeSwitchRow("INFINITY FUEL", false, function(state)
        infFuelOn = state
        if state then
            if fuelConn then fuelConn:Disconnect() end
            fuelConn = RunService.Heartbeat:Connect(function()
                if not infFuelOn then return end
                local rocket = getMyRocket()
                if rocket then
                    for _, obj in ipairs(rocket:GetDescendants()) do
                        if obj:IsA("NumberValue") or obj:IsA("IntValue") then
                            local ln = obj.Name:lower()
                            if ln:find("fuel") or ln:find("bensin") or ln:find("gas") or ln:find("energy") then
                                pcall(function() obj.Value = 999999 end)
                            end
                        end
                    end
                end
                for _, s in ipairs(detectMoneyStats()) do
                    if s.Name:lower():find("fuel") then
                        pcall(function() s.Value = 999999 end)
                    end
                end
            end)
        else
            if fuelConn then fuelConn:Disconnect() end
        end
    end)

    -- 3. ROCKET FLY + SLIDER
    local rocketFlyOn = false
    local rocketConn
    local flySpeed = 500

    local speedFrame = Instance.new("Frame", Scroll)
    speedFrame.Size = UDim2.new(1,0,0,54)
    speedFrame.BackgroundColor3 = PANEL
    speedFrame.BorderSizePixel = 0
    local spc = Instance.new("UICorner", speedFrame); spc.CornerRadius = UDim.new(0,8)
    local sps = Instance.new("UIStroke", speedFrame); sps.Color = GOLD; sps.Thickness = 1; sps.Transparency = 0.7

    local spLbl = Instance.new("TextLabel", speedFrame)
    spLbl.Size = UDim2.new(1,-20,0,22); spLbl.Position = UDim2.new(0,10,0,4)
    spLbl.BackgroundTransparency = 1
    spLbl.Text = "SPEED : 500"
    spLbl.TextColor3 = WHITE
    spLbl.Font = Enum.Font.GothamBold; spLbl.TextSize = 12
    spLbl.TextXAlignment = Enum.TextXAlignment.Left

    local sliderBg = Instance.new("Frame", speedFrame)
    sliderBg.Size = UDim2.new(1,-20,0,8)
    sliderBg.Position = UDim2.new(0,10,1,-18)
    sliderBg.BackgroundColor3 = Color3.fromRGB(50,50,50)
    sliderBg.BorderSizePixel = 0
    local slc = Instance.new("UICorner", sliderBg); slc.CornerRadius = UDim.new(1,0)

    local sliderFill = Instance.new("Frame", sliderBg)
    sliderFill.Size = UDim2.new(0.01,0,1,0)
    sliderFill.BackgroundColor3 = GOLD
    sliderFill.BorderSizePixel = 0
    local sfc = Instance.new("UICorner", sliderFill); sfc.CornerRadius = UDim.new(1,0)

    local sliderBtn = Instance.new("TextButton", sliderBg)
    sliderBtn.Size = UDim2.new(1,0,1,20)
    sliderBtn.Position = UDim2.new(0,0,-6,0)
    sliderBtn.BackgroundTransparency = 1
    sliderBtn.Text = ""

    local sliderValue = 500
    local sliderMax = 900000000000

    local function updateSlider(px)
        local pos = math.clamp(px / sliderBg.AbsoluteSize.X, 0, 1)
        sliderFill.Size = UDim2.new(pos, 0, 1, 0)
        sliderValue = math.floor(pos * sliderMax)
        if sliderValue < 1 then sliderValue = 1 end
        flySpeed = sliderValue
        spLbl.Text = "SPEED : " .. tostring(sliderValue)
    end

    sliderBtn.MouseButton1Down:Connect(function()
        local moving = true
        local conn
        conn = UserInputService.InputChanged:Connect(function(input)
            if moving and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local rel = input.Position.X - sliderBg.AbsolutePosition.X
                updateSlider(rel)
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                moving = false
                if conn then conn:Disconnect() end
            end
        end)
    end)

    local function startRocketFly()
        local char = LP.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Velocity = Vector3.new(0,0,0)
        bv.Parent = hrp

        rocketConn = RunService.RenderStepped:Connect(function()
            if not rocketFlyOn then return end
            local cam = workspace.CurrentCamera
            local dir = Vector3.new(0,0,0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0,1,0) end
            if dir.Magnitude > 0 then dir = dir.Unit end
            bv.Velocity = dir * flySpeed
        end)
    end

    makeSwitchRow("ROCKET FLY", false, function(state)
        rocketFlyOn = state
        if state then
            startRocketFly()
        else
            if rocketConn then rocketConn:Disconnect() end
        end
    end)

    -- 4. ESP
    makeSection("ESP")
    local espFolder = Instance.new("Folder", ScreenGui); espFolder.Name = "ESP"

    local function attachESP(obj, name)
        if obj:FindFirstChild("_ESP") then return end
        local hl = Instance.new("Highlight")
        hl.Name = "_ESP"
        hl.FillColor = Color3.fromRGB(0, 120, 255)
        hl.OutlineColor = Color3.fromRGB(0, 200, 255)
        hl.FillTransparency = 0.6
        hl.OutlineTransparency = 0
        hl.Adornee = obj
        hl.Parent = espFolder

        local bill = Instance.new("BillboardGui", hl)
        bill.Size = UDim2.new(0, 160, 0, 22)
        bill.StudsOffset = Vector3.new(0, 3, 0)
        bill.AlwaysOnTop = true
        bill.Adornee = obj

        local txt = Instance.new("TextLabel", bill)
        txt.Size = UDim2.new(1,0,1,0); txt.BackgroundTransparency = 1
        txt.Text = name or obj.Name
        txt.TextColor3 = Color3.fromRGB(0, 200, 255)
        txt.TextStrokeTransparency = 0
        txt.TextStrokeColor3 = Color3.fromRGB(0,0,0)
        txt.Font = Enum.Font.GothamBold; txt.TextSize = 12
    end

    local espOn = false
    makeSwitchRow("ESP ROCKET & USER", false, function(state)
        espOn = state
        if state then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LP and p.Character then
                    pcall(attachESP, p.Character, p.Name)
                end
            end
            for _, v in ipairs(workspace:GetDescendants()) do
                if (v:IsA("Model") or v:IsA("Tool")) then
                    local nm = v.Name:lower()
                    if nm:find("rocket") or nm:find("ship") or nm:find("spaceship") then
                        pcall(attachESP, v, v.Name)
                    end
                end
            end
        else
            espFolder:ClearAllChildren()
        end
    end)

    Players.PlayerAdded:Connect(function(p)
        if espOn then
            p.CharacterAdded:Connect(function(c)
                task.wait(1)
                if espOn then pcall(attachESP, c, p.Name) end
            end)
        end
    end)

    -- 5. FARM / BUY
    makeSection("FARM")

    local function scanItems()
        local items = {}
        for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
            if v:IsA("Tool") or v:IsA("Model") or v:IsA("Configuration") or v:IsA("Folder") then
                local nm = v.Name
                if not table.find(items, nm) then
                    local price = v:GetAttribute("Price") or v:GetAttribute("Cost")
                    table.insert(items, {name = nm, price = price or "?", obj = v})
                end
            end
        end
        local shop = ReplicatedStorage:FindFirstChild("Shop") or ReplicatedStorage:FindFirstChild("Items") or ReplicatedStorage:FindFirstChild("Store")
        if shop then
            for _, v in ipairs(shop:GetChildren()) do
                if not table.find(items, v.Name) then
                    local price = v:GetAttribute("Price") or v:GetAttribute("Cost")
                    table.insert(items, {name = v.Name, price = price or "?", obj = v})
                end
            end
        end
        return items
    end

    local BuyRow = Instance.new("Frame", Scroll)
    BuyRow.Size = UDim2.new(1,0,0,38)
    BuyRow.BackgroundColor3 = PANEL
    BuyRow.BorderSizePixel = 0
    local brc = Instance.new("UICorner", BuyRow); brc.CornerRadius = UDim.new(0,8)
    local brs = Instance.new("UIStroke", BuyRow); brs.Color = GOLD; brs.Thickness = 1; brs.Transparency = 0.7

    local BuyLbl = Instance.new("TextLabel", BuyRow)
    BuyLbl.Size = UDim2.new(1,-120,1,0); BuyLbl.Position = UDim2.new(0,12,0,0)
    BuyLbl.BackgroundTransparency = 1
    BuyLbl.Text = "BUY"
    BuyLbl.TextColor3 = WHITE
    BuyLbl.Font = Enum.Font.GothamBold; BuyLbl.TextSize = 13
    BuyLbl.TextXAlignment = Enum.TextXAlignment.Left

    local BuyBtn = Instance.new("TextButton", BuyRow)
    BuyBtn.Size = UDim2.new(0, 110, 0, 26)
    BuyBtn.Position = UDim2.new(1,-118,0.5,-13)
    BuyBtn.BackgroundColor3 = Color3.fromRGB(60,50,0)
    BuyBtn.BorderSizePixel = 0
    BuyBtn.Text = "PILIH ITEM"
    BuyBtn.TextColor3 = GOLD
    BuyBtn.Font = Enum.Font.GothamBold; BuyBtn.TextSize = 11
    BuyBtn.AutoButtonColor = false
    local bbc = Instance.new("UICorner", BuyBtn); bbc.CornerRadius = UDim.new(0,6)
    local bbs = Instance.new("UIStroke", BuyBtn); bbs.Color = GOLD; bbs.Thickness = 1; bbs.Transparency = 0.4

    local DropFrame = Instance.new("Frame", Scroll)
    DropFrame.Size = UDim2.new(1,0,0,0)
    DropFrame.BackgroundColor3 = Color3.fromRGB(15,15,15)
    DropFrame.BorderSizePixel = 0
    DropFrame.ClipsDescendants = true
    DropFrame.Visible = false
    local dfc = Instance.new("UICorner", DropFrame); dfc.CornerRadius = UDim.new(0,8)
    local dfs = Instance.new("UIStroke", DropFrame); dfs.Color = GOLD; dfs.Thickness = 1; dfs.Transparency = 0.5

    local DropL = Instance.new("UIListLayout", DropFrame)
    DropL.Padding = UDim.new(0,2); DropL.SortOrder = Enum.SortOrder.LayoutOrder

    local itemList = {}
    local selectedItem = nil

    local function refreshDrop()
        for _, c in ipairs(DropFrame:GetChildren()) do
            if c:IsA("TextButton") then c:Destroy() end
        end
        itemList = scanItems()
        for _, it in ipairs(itemList) do
            local b = Instance.new("TextButton", DropFrame)
            b.Size = UDim2.new(1,-8,0,30)
            b.BackgroundColor3 = Color3.fromRGB(25,25,25)
            b.BorderSizePixel = 0
            b.Text = it.name .. "  ["..tostring(it.price).."]"
            b.TextColor3 = WHITE
            b.Font = Enum.Font.Gotham; b.TextSize = 11
            b.AutoButtonColor = false
            local bc = Instance.new("UICorner", b); bc.CornerRadius = UDim.new(0,6)
            b.MouseEnter:Connect(function()
                TweenService:Create(b, TweenInfo.new(0.1), {BackgroundColor3 = HOVER}):Play()
            end)
            b.MouseLeave:Connect(function()
                TweenService:Create(b, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(25,25,25)}):Play()
            end)
            b.MouseButton1Click:Connect(function()
                selectedItem = it
                BuyBtn.Text = it.name
                DropFrame.Visible = false
            end)
        end
        local cnt = math.max(1, #itemList)
        DropFrame.Size = UDim2.new(1, 0, 0, math.min(cnt, 8) * 32 + 4)
    end

    BuyBtn.MouseButton1Click:Connect(function()
        if DropFrame.Visible then
            DropFrame.Visible = false
        else
            refreshDrop()
            DropFrame.Visible = true
        end
    end)

    local function doBuy(item)
        if not item then return end

        local stock = nil
        if item.obj then
            stock = item.obj:GetAttribute("Stock") or item.obj:GetAttribute("Amount")
            if item.obj:FindFirstChild("Stock") then
                local sv = item.obj.Stock
                if sv:IsA("IntValue") or sv:IsA("NumberValue") then stock = sv.Value end
            end
        end

        local price = nil
        if item.obj then
            price = item.obj:GetAttribute("Price") or item.obj:GetAttribute("Cost")
        end
        if not price or price == "?" then price = 0 end

        if stock ~= nil and stock <= 0 then
            showPopup("GAGAL - STOK HABIS", false)
            return
        end

        local stats = detectMoneyStats()
        if #stats > 0 then
            local money = stats[1]
            if money.Value < price then
                showPopup("GAGAL - UANG KURANG", false)
                return
            end
            pcall(function() money.Value = money.Value - price end)
        end

        local fired = false
        for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
            if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                local ln = obj.Name:lower()
                if ln:find("buy") or ln:find("purchase") or ln:find("shop") or ln:find("store") then
                    pcall(function()
                        if obj:IsA("RemoteEvent") then
                            obj:FireServer(item.name)
                        else
                            obj:InvokeServer(item.name)
                        end
                    end)
                    fired = true
                end
            end
        end

        if fired then
            showPopup("BERHASIL BELI : "..item.name, true)
        else
            showPopup("GAGAL - REMOTE BELI TIDAK DITEMUKAN", false)
        end
    end

    makeButton("BELI ITEM SEKARANG", Color3.fromRGB(60,50,0), function()
        if not selectedItem then
            showPopup("PILIH ITEM DULU", false)
            return
        end
        doBuy(selectedItem)
    end)

    -- FOOTER
    local Footer = Instance.new("TextLabel", MainFrame)
    Footer.Size = UDim2.new(1,-20,0,18)
    Footer.Position = UDim2.new(0,10,1,-20)
    Footer.BackgroundTransparency = 1
    Footer.Text = "created by zamstudio"
    Footer.TextColor3 = WHITE
    Footer.Font = Enum.Font.Gotham; Footer.TextSize = 11
    Footer.TextTransparency = 0.3
end

------------------------------------------------------------
-- LOGIN ACTION
------------------------------------------------------------
local loggedIn = false

local function doLogin()
    if loggedIn then return end
    if PassInput.Text == PASSWORD then
        loggedIn = true
        showPopup("LOGIN BERHASIL", true)
        -- hilangin login frame
        local out = TweenService:Create(LoginFrame, TweenInfo.new(0.3), {
            Position = UDim2.new(0.5, -150, 1.3, 0)
        })
        out:Play()
        out.Completed:Connect(function()
            LoginFrame:Destroy()
        end)
        -- bangun fitur + munculin toggle logo
        buildFeatures()
        task.wait(0.2)
        ToggleBtn.Visible = true
    else
        showPopup("PASSWORD SALAH", false)
        PassInput.Text = ""
    end
end

LoginBtn.MouseButton1Click:Connect(doLogin)
PassInput.FocusLost:Connect(function(enter)
    if enter then doLogin() end
end)

------------------------------------------------------------
-- TOGGLE MAIN FRAME
------------------------------------------------------------
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

print("[CRESSTON - ZAMSTUDIO] Loaded - created by zamstudio")
