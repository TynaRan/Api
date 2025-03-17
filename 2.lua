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
while true do
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
        else
            warn("CombatEvent not found in ReplicatedStorage.RemoteEvents")
        end
    end

    wait(0.00005)
end
