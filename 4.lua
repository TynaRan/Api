local function startSpinbot()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    
    if character and character:FindFirstChild("HumanoidRootPart") then
        local rootPart = character.HumanoidRootPart

      
        while true do
            wait(0.1) 
            rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, math.rad(10), 0) -- 每帧旋转10度
        end
    end
end

startSpinbot()
