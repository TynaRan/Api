while true do
    local args = {
        "Punch"
    }
    local remoteEvent = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("VampireEvent")
    remoteEvent:FireServer(table.unpack(args))
    wait(0.1)
end
