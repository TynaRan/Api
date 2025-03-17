while true do
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
