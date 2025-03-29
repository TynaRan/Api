--Location :thirsy vampire
--Creator:Mr-fes
--Team:COJ
--Script source↓↓↓
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/cat"))()
local Window = Library:CreateWindow("COJ 1.0", Vector2.new(492, 598), Enum.KeyCode.RightControl)

local SettingsTab = Window:CreateTab("Setting")
local PlayerSection = SettingsTab:CreateSector("Player", "left")
local PlayerSection2 = SettingsTab:CreateSector("esp", "right")
local spinbotEnabled = false
local loopEnabled = false
local speedNormal = 16
local fovNormal = 70

PlayerSection:AddSlider("Speed Normal", 16, 10, 100, 1, function(value)
    speedNormal = value
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.WalkSpeed = speedNormal
    end
end)

PlayerSection:AddSlider("FOV Normal", 70, 40, 120, 1, function(value)
    fovNormal = value
    workspace.CurrentCamera.FieldOfView = fovNormal
end)

PlayerSection:AddToggle("Loop Mode", false, function(state)
    loopEnabled = state
    while loopEnabled do
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.WalkSpeed = speedNormal
        end
        workspace.CurrentCamera.FieldOfView = fovNormal
        wait(0.1)
    end
end)

local AutomaticTab = Window:CreateTab("Human Automatic")
local HumanAutomaticSection = AutomaticTab:CreateSector("Human Automatic", "left")

local swingStakeEnabled = false
local autoHitterEnabled = false
local silentKillerEnabled = false

HumanAutomaticSection:AddToggle("Swing Stake", false, function(state)
    swingStakeEnabled = state
    while swingStakeEnabled do
        local player = game:GetService("Players").LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local stake = character:FindFirstChild("Stake")
        if stake then
            local args = {
                [1] = false
            }
            local swingEvent = stake:FindFirstChild("SwingEvent")
            if swingEvent then
                swingEvent:FireServer(table.unpack(args))
            end
        end
        wait(0.1)
    end
end)

HumanAutomaticSection:AddToggle("Auto Hitter (Vampire)", false, function(state)
    autoHitterEnabled = state
    while autoHitterEnabled do
        local args = {
            "Punch"
        }
        local remoteEvent = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("VampireEvent")
        remoteEvent:FireServer(table.unpack(args))
        wait(0.1)
    end
end)

HumanAutomaticSection:AddToggle("Silent Killer", false, function(state)
    silentKillerEnabled = state
    while silentKillerEnabled do
        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local function getClosestEnemy(player)
            local closestPlayer = nil
            local shortestDistance = math.huge
            for _, otherPlayer in ipairs(Players:GetPlayers()) do
                if otherPlayer ~= player and otherPlayer.Team ~= player.Team then
                    local character = otherPlayer.Character
                    local playerCharacter = player.Character
                    if character and playerCharacter then
                        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                        local playerHumanoidRootPart = playerCharacter:FindFirstChild("HumanoidRootPart")
                        if humanoidRootPart and playerHumanoidRootPart then
                            local distance = (humanoidRootPart.Position - playerHumanoidRootPart.Position).Magnitude
                            if distance < shortestDistance then
                                shortestDistance = distance
                                closestPlayer = otherPlayer
                            end
                        end
                    end
                end
            end
            return closestPlayer
        end

        local player = Players.LocalPlayer
        local closestEnemy = getClosestEnemy(player)
        if closestEnemy then
            local args = {
                [1] = "Kill",
                [2] = {
                    ["Target"] = closestEnemy
                }
            }
            local combatEvent = ReplicatedStorage:FindFirstChild("RemoteEvents") and ReplicatedStorage.RemoteEvents:FindFirstChild("CombatEvent")
            if combatEvent then
                combatEvent:FireServer(unpack(args))
            end
        end
        wait(0.00005)
    end
end)
PlayerSection:AddToggle("Spinbot", false, function(state)
    spinbotEnabled = state
    while spinbotEnabled do
        if not spinbotEnabled then break end
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        if character and character:FindFirstChild("HumanoidRootPart") then
            local rootPart = character.HumanoidRootPart
            if not spinbotEnabled then break end
            wait(0.00000001)
            rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, math.rad(100), 0)
        end
    end
end)

PlayerSection:AddButton("hitbox", function(nocallback)
    loadstring(game:HttpGet("https://github.com/Drop56796/CreepyEyeHub/blob/main/thr.lua?raw=true"))()
end)
local Players = game:GetService("Players")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local mt = getrawmetatable(game)
local originalNamecall = mt.__namecall
local antiKickEnabled = false

setreadonly(mt, false)

local function enableAntiKick()
    if antiKickEnabled then return end
    antiKickEnabled = true
    mt.__namecall = function(self, ...)
        local method = getnamecallmethod()
        if self == LocalPlayer and method == "Kick" then
            return nil
        end
        return originalNamecall(self, ...)
    end
end

local function disableAntiKick()
    if not antiKickEnabled then return end
    antiKickEnabled = false
    mt.__namecall = originalNamecall
end

setreadonly(mt, true)

PlayerSection:AddToggle("Anti-Kick", false, function(state)
    if state then
        enableAntiKick()
    else
        disableAntiKick()
    end
end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local autoTeleportEnabled = false

local function getNearestPlayer()
    local nearestPlayer = nil
    local nearestDistance = math.huge

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team then
            local targetCharacter = player.Character
            local localCharacter = LocalPlayer.Character
            if targetCharacter and localCharacter and targetCharacter:FindFirstChild("HumanoidRootPart") and localCharacter:FindFirstChild("HumanoidRootPart") then
                local distance = (localCharacter.HumanoidRootPart.Position - targetCharacter.HumanoidRootPart.Position).Magnitude
                if distance < nearestDistance then
                    nearestDistance = distance
                    nearestPlayer = player
                end
            end
        end
    end
    return nearestPlayer
end

local function autoTeleport()
    while autoTeleportEnabled do
        local targetPlayer = getNearestPlayer()
        if targetPlayer then
            local targetCharacter = targetPlayer.Character
            if targetCharacter and targetCharacter:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character:SetPrimaryPartCFrame(targetCharacter.HumanoidRootPart.CFrame)
            end
        end
        wait(0.000001) 
    end
end

PlayerSection:AddToggle("Auto TP (Different Team)", false, function(state)
    autoTeleportEnabled = state
    if autoTeleportEnabled then
        task.spawn(autoTeleport)
    end
end)
local T, P, L = game:GetService("Teams"), game:GetService("Players"), game.Players.LocalPlayer
local E, N, I, H, D, A, V, F, S, J = false, false, false, false, false, false, false, false, false, false

local function cE(p)
    local c, tC = p.Character, p.Team and T:FindFirstChild(p.Team.Name) and T[p.Team.Name].TeamColor.Color or Color3.new(1, 1, 1)
    if c then
        if not c:FindFirstChild("Highlight") then Instance.new("Highlight", c).FillColor, Instance.new("BillboardGui", c).Adornee = tC, c:FindFirstChild("HumanoidRootPart") end
        local h = c:FindFirstChild("Humanoid")
        local a = h and h.Health > 0
        local st = h and (h.Sit and "Sitting" or h.Jump and "Jumping" or h.FloorMaterial ~= Enum.Material.Air and "Standing" or "Idle")
        Instance.new("TextLabel", c:FindFirstChild("BillboardGui")).Text =
            (N and p.Name or "") ..
            (H and ("\nHP: " .. math.floor(h and h.Health or 0)) or "") ..
            (D and ("\nDist: " .. math.floor((L.Character.HumanoidRootPart.Position - c.HumanoidRootPart.Position).Magnitude)) or "") ..
            (A and ("\nAlive: " .. (a and "Yes" or "No")) or "") ..
            (V and ("\nSpeed: " .. math.floor(h and h.WalkSpeed or 0)) or "") ..
            (F and ("\nJump: " .. math.floor(h and h.JumpPower or 0)) or "") ..
            (S and ("\nState: " .. (st or "Unknown")) or "")
        if I then
            Instance.new("TextLabel", Instance.new("BillboardGui", c)).Text =
                "Item: " .. (p.Backpack:FindFirstChildWhichIsA("Tool") and p.Backpack:FindFirstChildWhichIsA("Tool").Name or "None")
        end
    end
end

local function rE(p) for _, v in ipairs({"Highlight", "BillboardGui"}) do local o = p.Character and p.Character:FindFirstChild(v) if o then o:Destroy() end end end

P.PlayerAdded:Connect(function(p) p.CharacterAdded:Connect(function() E and cE(p) end) end)
P.PlayerRemoving:Connect(rE)

local function uE()
    for _, p in ipairs(P:GetPlayers()) do
        if p ~= L then E and cE(p) or rE(p) end
    end
end

for _, o in pairs({
    {"ESP", false}, {"Names", false}, {"Items", false}, {"Health", false},
    {"Distance", false}, {"Alive", false}, {"Speed", false}, {"Jump", false}, {"Sit/Jump State", false}
}) do
    PlayerSection2:AddToggle(o[1], o[2], function(s)
        _G[o[1]:lower():gsub("/", "")] = s
        uE()
    end)
end
