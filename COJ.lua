--Location :thirsy vampire
--Creator:Mr-fes
--Team:COJ
--Script source↓↓↓
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/cat"))()
local Window = Library:CreateWindow("COJ 1.0", Vector2.new(492, 598), Enum.KeyCode.RightControl)

local SettingsTab = Window:CreateTab("Setting")
local PlayerSection = SettingsTab:CreateSector("Player", "left")

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

SettingsTab:CreateConfigSystem("right")

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
