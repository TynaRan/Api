--Location :thirsy vampire
--Creator:Mr-fes
--Team:COJ
--Script source↓↓↓
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local originalProperties = {}
for _, part in ipairs(character:GetDescendants()) do
    if part:IsA("BasePart") then
        originalProperties[part] = {
            Transparency = part.Transparency,
            Material = part.Material,
            Color = part.Color
        }
    end
end
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

if LocalPlayer and LocalPlayer.Character then
    for _, descendant in pairs(LocalPlayer.Character:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant.Name == "Hitbox" then
            descendant:Destroy()
        end
    end
end

local notify, guiService, tweenService, notificationHolder, notifications, padding =
    {}, game:GetService("CoreGui"), game:GetService("TweenService"), nil, {}, 10

notificationHolder = Instance.new("ScreenGui")
notificationHolder.Name = "NotifyHolder"
notificationHolder.Parent = guiService
notificationHolder.ResetOnSpawn = false

notify.new = function(message, duration)
    local outline, frame, label =
        Instance.new("Frame"), Instance.new("Frame"), Instance.new("TextLabel")

    outline.Name = "Outline"
    outline.Parent = notificationHolder
    outline.AnchorPoint = Vector2.new(0, 0)
    outline.Position = UDim2.new(0, 10, 0, -50)
    outline.Size = UDim2.new(0, 0, 0, 44)
    outline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    outline.BorderSizePixel = 0

    frame.Name = "MainFrame"
    frame.Parent = outline
    frame.AnchorPoint = Vector2.new(0, 0)
    frame.Size = UDim2.new(1, -2, 1, -2)
    frame.Position = UDim2.new(0, 1, 0, 1)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BorderSizePixel = 0

    label.Name = "Text"
    label.Parent = frame
    label.AnchorPoint = Vector2.new(0, 0.5)
    label.Position = UDim2.new(0, 10, 0.5, 0)
    label.Size = UDim2.new(1, -20, 1, 0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.RobotoMono
    label.Text = message or "Notification"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.TextStrokeTransparency = 0.9
    label.TextSize = 20
    label.TextXAlignment = Enum.TextXAlignment.Left

    local textWidth = label.TextBounds.X + 30

    table.insert(notifications, outline)
    for index, notification in ipairs(notifications) do
        local targetY = (index - 1) * (44 + padding)
        local position = UDim2.new(0, 10, 0, targetY)
        tweenService:Create(notification, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = position}):Play()
    end

    outline.Position = UDim2.new(0, 10, 0, -50)
    local finalY = (#notifications - 1) * (44 + padding)
    tweenService:Create(outline, TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {Position = UDim2.new(0, 10, 0, finalY)}):Play()
    tweenService:Create(outline, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, textWidth, 0, 44)}):Play()

    task.spawn(function()
        task.wait(duration or 3)
        tweenService:Create(outline, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 44)}):Play()
        task.wait(0.5)
        for i, notification in ipairs(notifications) do
            if notification == outline then
                table.remove(notifications, i)
                break
            end
        end
        for i, notification in ipairs(notifications) do
            local targetY = (i - 1) * (44 + padding)
            local position = UDim2.new(0, 10, 0, targetY)
            tweenService:Create(notification, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = position}):Play()
        end
        outline:Destroy()
    end)
end
notify.new("Welcome COJ V1.2", 4)

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/cat"))()
local platform = game:GetService("UserInputService").TouchEnabled 
    and (game:GetService("UserInputService").KeyboardEnabled and "Android")
    or (game:GetService("UserInputService").MouseEnabled and "Windows" or "Mac")

local Window = Library:CreateWindow("COJ 1.2 - " .. platform, Vector2.new(492, 598), Enum.KeyCode.RightControl)
local SettingsTab = Window:CreateTab("Setting")
local PlayerSection = SettingsTab:CreateSector("Player", "left")
local PlayerSection2 = SettingsTab:CreateSector("esp", "right")
local Misc = Window:CreateTab("Misc")
local Misc = Misc:CreateSector("Misc", "left")
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
local E, N, I, H, D, A, V, F, S, J, TLoop = false, false, false, false, false, false, false, false, false, false, false

local function cE(p)
    local c = p.Character
    local tC = p.Team and T:FindFirstChild(p.Team.Name) and T[p.Team.Name].TeamColor.Color or Color3.new(1, 1, 1)
    if c and c:FindFirstChild("HumanoidRootPart") then
        if E and not c:FindFirstChild("Highlight") then
            local highlight = Instance.new("Highlight", c)
            highlight.Adornee = c
            highlight.FillColor = tC
            highlight.OutlineColor = Color3.new(1, 1, 1)
        end

        local rootPart = c:FindFirstChild("HumanoidRootPart")
        if rootPart then
            local billboard = rootPart:FindFirstChild("BillboardGui") or Instance.new("BillboardGui", rootPart)
            billboard.Adornee = rootPart
            billboard.Size = UDim2.new(12, 0, 6, 0)
            billboard.AlwaysOnTop = true

            local label = billboard:FindFirstChild("InfoLabel") or Instance.new("TextLabel", billboard)
            label.Name = "InfoLabel"
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Font = Enum.Font.SourceSansBold
            label.TextSize = 15
            label.TextColor3 = Color3.new(1, 0, 0)
            label.TextStrokeTransparency = 0
            label.TextStrokeColor3 = Color3.new(0, 0, 0)

            spawn(function()
                while E and label.Parent do
                    local text = ""
                    if N then text = text .. "NAME: " .. tostring(p.Name) .. "\n" end
                    if I then text = text .. "ITEM: " .. (p.Backpack:FindFirstChildWhichIsA("Tool") and p.Backpack:FindFirstChildWhichIsA("Tool").Name or "NONE") .. "\n" end
                    if H then text = text .. "HEALTH: " .. tostring(math.floor(c:FindFirstChild("Humanoid") and c.Humanoid.Health or 0)) .. "\n" end
                    if D then text = text .. "DISTANCE: " .. tostring(math.floor((L.Character.HumanoidRootPart.Position - rootPart.Position).Magnitude)) .. "\n" end
                    if A then text = text .. "ALIVE: " .. (c:FindFirstChild("Humanoid") and (c.Humanoid.Health > 0 and "YES" or "NO") or "UNKNOWN") .. "\n" end
                    if V then text = text .. "SPEED: " .. tostring(math.floor(c:FindFirstChild("Humanoid") and c.Humanoid.WalkSpeed or 0)) .. "\n" end
                    if F then text = text .. "JUMP POWER: " .. tostring(math.floor(c:FindFirstChild("Humanoid") and c.Humanoid.JumpPower or 0)) .. "\n" end
                    if S then text = text .. "STATE: " .. (c:FindFirstChild("Humanoid") and (c.Humanoid.Sit and "SITTING" or c.Humanoid.Jump and "JUMPING") or "UNKNOWN") .. "\n" end
                    label.Text = text:sub(1, -2)
                    wait(1)
                end
            end)
        end
    end
end

local function rE(p)
    for _, v in ipairs({"Highlight", "BillboardGui"}) do
        local o = p.Character and p.Character:FindFirstChild(v)
        if o then o:Destroy() end
    end
end

local function monitorPlayers()
    while E do
        for _, p in ipairs(P:GetPlayers()) do
            if p ~= L and p.Character then
                cE(p)
            end
        end
        wait(1)
    end
end

local function monitorTeamChanges()
    while TLoop do
        for _, p in ipairs(P:GetPlayers()) do
            if p ~= L and p.Character then
                local highlight = p.Character:FindFirstChild("Highlight")
                if highlight then
                    local tC = p.Team and T:FindFirstChild(p.Team.Name) and T[p.Team.Name].TeamColor.Color or Color3.new(1, 1, 1)
                    highlight.FillColor = tC
                end
            end
        end
        wait(1)
    end
end

P.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function()
        if E then
            cE(p)
        end
    end)
end)

for _, o in pairs({
    {"ESP", false}, {"Names", false}, {"Items", false}, {"Health", false},
    {"Distance", false}, {"Alive", false}, {"Speed", false}, {"Jump", false}, {"Sit/Jump State", false}, {"Loop Team", false}
}) do
    PlayerSection2:AddToggle(o[1], o[2], function(s)
        if o[1] == "ESP" then 
            E = s
            if E then
                spawn(monitorPlayers)
            end
        end
        if o[1] == "Loop Team" then 
            TLoop = s
            if TLoop then
                spawn(monitorTeamChanges)
            end
        end
        if o[1] == "Names" then N = s end
        if o[1] == "Items" then I = s end
        if o[1] == "Health" then H = s end
        if o[1] == "Distance" then D = s end
        if o[1] == "Alive" then A = s end
        if o[1] == "Speed" then V = s end
        if o[1] == "Jump" then F = s end
        if o[1] == "Sit/Jump State" then S = s end
    end)
end

local danceAnimationId = "rbxassetid://507771019"

Misc:AddTextbox("Dance Animation ID", danceAnimationId, function(value)
    danceAnimationId = value
end)

Misc:AddToggle("Dance Walk", false, function(state)
    danceWalkEnabled = state
    local player = game.Players.LocalPlayer
    local function setupDanceWalk()
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        local animator = humanoid:FindFirstChild("Animator") or Instance.new("Animator", humanoid)

        if danceWalkEnabled then
            local danceAnimation = character:FindFirstChild("DanceAnimation") or Instance.new("Animation", character)
            danceAnimation.Name = "DanceAnimation"
            danceAnimation.AnimationId = danceAnimationId
            local danceTrack = animator:LoadAnimation(danceAnimation)
            danceTrack.Looped = true
            danceTrack:Play()
        end
    end

    if state then
        player.CharacterAdded:Connect(function()
            task.wait(1.399) 
            setupDanceWalk()
        end)
        setupDanceWalk()
    else
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                local animator = humanoid:FindFirstChild("Animator")
                if animator then
                    for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
                        if track.Animation.AnimationId == danceAnimationId then
                            track:Stop()
                        end
                    end
                end
            end
            for _, part in ipairs(character:GetChildren()) do
                if part:IsA("Animation") and part.Name == "DanceAnimation" then
                    part:Destroy()
                end
            end
        end
    end
end)
PlayerSection:AddToggle("GlowEffect", false, function(state)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    if state then
        task.spawn(function()
            while true do
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Transparency = 0.9
                        part.Material = Enum.Material.ForceField
                        part.Color = Color3.fromRGB(255, 255, 255)
                    end
                end
                task.wait(0.1)
            end
        end)
    else
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") and originalProperties[part] then
                part.Transparency = originalProperties[part].Transparency
                part.Material = originalProperties[part].Material
                part.Color = originalProperties[part].Color
            end
        end
    end
end)
PlayerSection:AddToggle("Auto Jump", false, function(state)
    local Services = {
        Players = game:GetService("Players"),
        RunService = game:GetService("RunService")
    }

    local LocalPlayer = Services.Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")

    local Settings = {
        JumpCooldown = 0.3
    }

    local CanJump = true

    function AutoJump()
        if state and Humanoid.FloorMaterial ~= Enum.Material.Air and CanJump then
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            CanJump = false
            wait(Settings.JumpCooldown)
            CanJump = true
        end
    end

    if state then
        Services.RunService.RenderStepped:Connect(function()
            AutoJump()
        end)
    end
end)
PlayerSection:AddToggle("Target Strafe", false, function(state)
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")

    local settings = {
        radius = 1.5,
        speed = 5
    }

    local target = nil
    local localPlayer = Players.LocalPlayer

    if not localPlayer:GetAttribute("TargetStrafeActive") then
        localPlayer:SetAttribute("TargetStrafeActive", false)
    end

    local function getTarget()
        local closest, shortestDistance = nil, 5
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer 
            and player.Team ~= localPlayer.Team 
            and player.Team 
            and player.Team.Name == "Vampire" 
            and player.Character 
            and player.Character:FindFirstChild("HumanoidRootPart")
            and player.Character:FindFirstChild("Humanoid").Health > 0 then
                local distance = (localPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    closest = player
                end
            end
        end
        return closest
    end

    if state then
        localPlayer:SetAttribute("TargetStrafeActive", true)
        RunService:BindToRenderStep("TargetStrafe", Enum.RenderPriority.Character.Value, function()
            if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") or target.Character:FindFirstChild("Humanoid").Health <= 0 then
                target = getTarget()
            end

            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local targetPosition = target.Character.HumanoidRootPart.Position
                local angle = tick() * settings.speed
                local strafePosition = Vector3.new(
                    targetPosition.X + math.cos(angle) * settings.radius,
                    targetPosition.Y,
                    targetPosition.Z + math.sin(angle) * settings.radius
                )
                localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(strafePosition, targetPosition)
            end
        end)
    else
        localPlayer:SetAttribute("TargetStrafeActive", false)
        RunService:UnbindFromRenderStep("TargetStrafe")
        target = nil
    end
end)

PlayerSection:AddTextbox("Radius", 1.5, function(input)
    settings.radius = tonumber(input) or settings.radius
end)

PlayerSection:AddTextbox("Speed", 5, function(input)
    settings.speed = tonumber(input) or settings.speed
end)
Misc:AddButton("serverhop", function(nocallback)
    local HttpService = game:GetService("HttpService")
    local TeleportService = game:GetService("TeleportService")
    local currentPlaceId = game.PlaceId
    local currentJobId = game.JobId

    
    local serverListResponse = syn and syn.request or request
    if serverListResponse then
        local response = serverListResponse({
            Url = "https://games.roblox.com/v1/games/" .. currentPlaceId .. "/servers/Public?limit=100",
            Method = "GET"
        })

        if response.StatusCode == 200 then
            local servers = HttpService:JSONDecode(response.Body)
            for _, server in pairs(servers.data) do
                if server.playing < server.maxPlayers and server.id ~= currentJobId then
                    print("Hopping to server: " .. server.id)
                    TeleportService:TeleportToPlaceInstance(currentPlaceId, server.id)
                    return
                end
            end
            print("No available servers found.")
        else
            print("Failed to fetch server list. HTTP Error: " .. response.StatusCode)
        end
    else
        print("syn.request or request is not supported")
    end
end)
Misc:AddTextbox("Music ID", "", function(id)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. id
    sound.Volume = 1
    sound.Looped = true
    sound.Parent = game:GetService("Workspace")
    sound:Play()
end)

local noclipEnabled = false
local player = game.Players.LocalPlayer

PlayerSection:AddToggle("NoClip", false, function(state)
    noclipEnabled = state
    local character = player.Character or player.CharacterAdded:Wait()

    local function applyNoClip()
        if not character or not character:FindFirstChild("Humanoid") then
            return
        end

        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = not noclipEnabled
            end
        end
    end

    local function setupNoClip()
        game:GetService("RunService").Stepped:Connect(function()
            if noclipEnabled then
                applyNoClip()
            end
        end)
    end

    if noclipEnabled then
        player.CharacterAdded:Connect(function(char)
            character = char
            task.wait(1)
            setupNoClip()
        end)
        setupNoClip()
    else
        if character then
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end)
