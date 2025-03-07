local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local c = game:GetService("CoreGui")
local apiUrls = {
    ScriptBlox = "https://scriptblox-api-proxy.vercel.app/api/search?q=",
    RScript = "https://rscript-api-proxy.vercel.app/api/search?q="
}

local currentApi = "ScriptBlox"
local screenGui, inputFrame, closeButton, miniButton

local function searchScripts(keyword, page)
    local url = apiUrls[currentApi] .. HttpService:UrlEncode(keyword) .. "&page=" .. tostring(page) .. "&mode=free"
    local success, response = pcall(function()
        return request({
            Url = url,
            Method = "GET",
        })
    end)
    assert(success, "Request failed")
    assert(type(response) == "table", "Response must be a table")
    assert(response.StatusCode == 200, "Did not return a 200 status code")

    local data = HttpService:JSONDecode(response.Body)
    assert(type(data) == "table" and type(data["result"]) == "table", "Did not return a table with a result key")
    assert(type(data["result"]["scripts"]) == "table", "Did not return a table with scripts")

    return data["result"]["scripts"], data["result"]["totalPages"]
end

local function createUI(script, parent)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.8, 0, 0, 200)
    frame.Position = UDim2.new(0.1, 0, 0, 0)
    frame.BackgroundTransparency = 0.5
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.BorderSizePixel = 1
    frame.BorderColor3 = Color3.new(1, 1, 1)
    frame.Parent = parent

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -10, 0, 30)
    titleLabel.Position = UDim2.new(0, 5, 0, 5)
    titleLabel.Text = script.title or "Unknown Title"
    titleLabel.Font = Enum.Font.SourceSans
    titleLabel.TextSize = 24
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = frame

    local detailsLabel = Instance.new("TextLabel")
    detailsLabel.Size = UDim2.new(1, -10, 0, 100)
    detailsLabel.Position = UDim2.new(0, 5, 0, 40)
    detailsLabel.Text = 
        "Game: " .. (script.game and script.game.name or "Unknown Game Name") .. 
        "\nViews: " .. (script.views or "Unknown Views") ..
        "\nScript URL: " .. (script.script or "Unknown Script URL") ..
        "\nCreated At: " .. (script.createdAt or "Unknown Created At") ..
        "\nUpdated At: " .. (script.updatedAt or "Unknown Updated At") ..
        "\nScript Type: " .. (script.scriptType or "Unknown Type") ..
        "\nVerified: " .. tostring(script.verified)
    detailsLabel.Font = Enum.Font.SourceSans
    detailsLabel.TextSize = 18
    detailsLabel.TextWrapped = true
    detailsLabel.TextColor3 = Color3.new(1, 1, 1)
    detailsLabel.BackgroundTransparency = 1
    detailsLabel.TextXAlignment = Enum.TextXAlignment.Left
    detailsLabel.TextYAlignment = Enum.TextYAlignment.Top
    detailsLabel.Parent = frame

    local copyButton = Instance.new("TextButton")
    copyButton.Size = UDim2.new(0, 100, 0, 30)
    copyButton.Position = UDim2.new(0, 5, 1, -35)
    copyButton.Text = "Copy"
    copyButton.Font = Enum.Font.SourceSans
    copyButton.TextSize = 18
    copyButton.TextColor3 = Color3.new(1, 1, 1)
    copyButton.BackgroundTransparency = 1
    copyButton.Parent = frame
    copyButton.MouseButton1Click:Connect(function()
        setclipboard(script.script)
    end)

    local executeButton = Instance.new("TextButton")
    executeButton.Size = UDim2.new(0, 100, 0, 30)
    executeButton.Position = UDim2.new(0, 110, 1, -35)
    executeButton.Text = "Execute"
    executeButton.Font = Enum.Font.SourceSans
    executeButton.TextSize = 18
    executeButton.TextColor3 = Color3.new(1, 1, 1)
    executeButton.BackgroundTransparency = 1
    executeButton.Parent = frame
    executeButton.MouseButton1Click:Connect(function()
        loadstring(script.script)()
    end)
end

local function displaySearchResults(keyword, page)
    local scripts, totalPages = searchScripts(keyword, page)
    --print("Total Pages: " .. (totalPages or "Unknown"))

    local scrollingFrame = Instance.new("ScrollingFrame")
    scrollingFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollingFrame.Position = UDim2.new(0, 0, 0, 50)
    scrollingFrame.CanvasSize = UDim2.new(1, 0, 0, 200 * #scripts)
    scrollingFrame.ScrollBarThickness = 10
    scrollingFrame.BackgroundColor3 = Color3.new(0, 0, 0)
    scrollingFrame.BorderSizePixel = 0
    scrollingFrame.Parent = screenGui

    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 10)
    listLayout.Parent = scrollingFrame

    for i, script in ipairs(scripts) do
        createUI(script, scrollingFrame)
    end

    scrollingFrame.CanvasSize = UDim2.new(1, 0, 0, 200 * #scripts)
end

local function closeUI()
    inputFrame.Visible = false
    for _, child in ipairs(screenGui:GetChildren()) do
        if child:IsA("ScrollingFrame") then
            child:Destroy()
        end
    end
    miniButton.Visible = true
end

local function openUI()
    inputFrame.Visible = true
    miniButton.Visible = false
end

local function createMiniButton()
    miniButton = Instance.new("TextButton")
    miniButton.Size = UDim2.new(0, 50, 0, 50)
    miniButton.Position = UDim2.new(0.1, 0, 0.1, 0)
    miniButton.Text = "S"
    miniButton.Font = Enum.Font.SourceSans
    miniButton.TextSize = 24
    miniButton.TextColor3 = Color3.new(1, 1, 1)
    miniButton.BackgroundTransparency = 0
    miniButton.Visible = false
    miniButton.BackgroundColor3 = Color3.new(0, 0, 0)
    miniButton.Parent = screenGui
    miniButton.MouseButton1Click:Connect(openUI)
    miniButton.BorderSizePixel = 0
    miniButton.Draggable = true
end

local function createUIWithInput()
    local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
    screenGui = Instance.new("ScreenGui")
    screenGui.Parent = c

    inputFrame = Instance.new("Frame")
    inputFrame.Size = UDim2.new(1, 0, 0, 50)
    inputFrame.BackgroundColor3 = Color3.new(0, 0, 0)
    inputFrame.BorderSizePixel = 1
    inputFrame.BorderColor3 = Color3.new(1, 1, 1)
    inputFrame.Parent = screenGui

    local inputBox = Instance.new("TextBox")
    inputBox.Size = UDim2.new(0.7, 0, 0.8, 0)
    inputBox.Position = UDim2.new(0.2, 0, 0.1, 0)
    inputBox.PlaceholderText = "Enter script (power by api http)"
    inputBox.Text = "example:vape v4"
    inputBox.Font = Enum.Font.SourceSans
    inputBox.TextSize = 24
    inputBox.TextColor3 = Color3.new(1, 1, 1)
    inputBox.BackgroundColor3 = Color3.new(0, 0, 0)
    inputBox.BorderSizePixel = 1
    inputBox.TextXAlignment = Enum.TextXAlignment.Left
    inputBox.BorderColor3 = Color3.new(1, 1, 1)
    inputBox.Parent = inputFrame

    inputBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            displaySearchResults(inputBox.Text, 1)
        end
    end)

    local apiSwitchButton = Instance.new("TextButton")
    apiSwitchButton.Size = UDim2.new(0.1, 0, 0.8, 0)
    apiSwitchButton.Position = UDim2.new(0.9, 0, 0.1, 0)
    apiSwitchButton.Text = "Switch API"
    apiSwitchButton.Font = Enum.Font.SourceSans
    apiSwitchButton.TextSize = 18
    apiSwitchButton.TextColor3 = Color3.new(1, 1, 1)
    apiSwitchButton.BackgroundTransparency = 1
    apiSwitchButton.Parent = inputFrame
    apiSwitchButton.MouseButton1Click:Connect(function()
        currentApi = currentApi == "ScriptBlox" and "RScript" or "ScriptBlox"
        print("Switched API to: " .. currentApi)
    end)

    closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0.1, 0, 0.8, 0)
    closeButton.Position = UDim2.new(0, 0, 0.1, 0)
    closeButton.Text = "Close"
    closeButton.Font = Enum.Font.SourceSans
    closeButton.TextSize = 18
    closeButton.TextColor3 = Color3.new(1, 1, 1)
    closeButton.BackgroundTransparency = 1
    closeButton.Parent = inputFrame
    closeButton.MouseButton1Click:Connect(closeUI)
end

createUIWithInput()
createMiniButton()
