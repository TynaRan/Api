-- Services
local CoreGui = game:GetService("CoreGui")

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = CoreGui

-- Main Frame
local Frame = Instance.new("Frame")
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Size = UDim2.new(0, 700, 0, 500)
Frame.Position = UDim2.new(0, 100, 0, 100)
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

-- ScrollingFrame for Input Box
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(0, 600, 0, 300)
ScrollingFrame.Position = UDim2.new(0, 60, 0, 60)
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.ScrollBarThickness = 10
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.Parent = Frame

-- Input Box
local InputBox = Instance.new("TextBox")
InputBox.PlaceholderText = "Enter script here..."
InputBox.Font = Enum.Font.Ubuntu
InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InputBox.TextSize = 18
InputBox.Size = UDim2.new(1, -10, 1, 0)
InputBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
InputBox.ClearTextOnFocus = false
InputBox.MultiLine = true
InputBox.TextXAlignment = Enum.TextXAlignment.Left
InputBox.TextYAlignment = Enum.TextYAlignment.Top
InputBox.Parent = ScrollingFrame

-- Highlight Label
local HighlightLabel = Instance.new("TextLabel")
HighlightLabel.Size = UDim2.new(1, -10, 1, 0)
HighlightLabel.Position = UDim2.new(0, 0, 0, 0)
HighlightLabel.BackgroundTransparency = 1
HighlightLabel.Font = Enum.Font.Ubuntu
HighlightLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
HighlightLabel.TextSize = 18
HighlightLabel.TextXAlignment = Enum.TextXAlignment.Left
HighlightLabel.TextYAlignment = Enum.TextYAlignment.Top
HighlightLabel.RichText = true
HighlightLabel.Parent = ScrollingFrame


local highlightRules = {
    -- Lua基础关键字
    ["function"] = "rgb(0,128,255)",
    ["local"] = "rgb(0,255,0)",
    ["end"] = "rgb(255,0,0)",
    ["if"] = "rgb(255,165,0)",
    ["then"] = "rgb(173,216,230)",
    ["else"] = "rgb(255,105,180)",
    ["elseif"] = "rgb(255,215,0)",
    ["true"] = "rgb(0,255,255)",
    ["false"] = "rgb(255,69,0)",
    ["do"] = "rgb(255,140,0)",
    ["while"] = "rgb(0,100,0)",
    ["repeat"] = "rgb(138,43,226)",
    ["until"] = "rgb(70,130,180)",
    ["for"] = "rgb(189,183,107)",
    ["in"] = "rgb(205,92,92)",
    ["return"] = "rgb(75,0,130)",
    ["break"] = "rgb(178,34,34)",
    ["continue"] = "rgb(0,128,64)",
    ["nil"] = "rgb(128,128,128)",
    ["not"] = "rgb(255,20,147)",
    ["and"] = "rgb(60,179,113)",
    ["or"] = "rgb(147,112,219)",

    -- 调试与元方法
    ["getmetatable"] = "rgb(102,205,170)",
    ["setmetatable"] = "rgb(30,144,255)",
    ["hookfunction"] = "rgb(255,140,0)",
    ["getrawmetatable"] = "rgb(128,0,128)",
    ["setreadonly"] = "rgb(0,255,128)",
    ["checkcaller"] = "rgb(255,0,128)",
    ["debug.getupvalue"] = "rgb(255,0,128)",
    ["debug.setupvalue"] = "rgb(0,128,255)",
    ["debug.traceback"] = "rgb(255,140,0)",
    ["debug.getinfo"] = "rgb(148,0,211)",
    ["debug.getregistry"] = "rgb(255,165,0)",
    ["debug.getmetatable"] = "rgb(255,69,0)",
    ["rawset"] = "rgb(0,192,192)",
    ["rawget"] = "rgb(255,140,0)",
    ["rawequal"] = "rgb(0,128,255)",

    -- 常用全局函数
    ["pairs"] = "rgb(0,192,255)",
    ["ipairs"] = "rgb(0,100,128)",
    ["next"] = "rgb(0,255,192)",
    ["print"] = "rgb(0,255,255)",
    ["warn"] = "rgb(255,69,0)",
    ["error"] = "rgb(165,42,42)",
    ["type"] = "rgb(112,128,144)",
    ["tonumber"] = "rgb(255,20,147)",
    ["tostring"] = "rgb(148,0,211)",
    ["pcall"] = "rgb(34,139,34)",
    ["xpcall"] = "rgb(244,164,96)",
    ["assert"] = "rgb(255,215,0)",
    ["require"] = "rgb(245,222,179)",

    -- Roblox相关
    ["game"] = "rgb(46,139,87)",
    ["workspace"] = "rgb(0,255,128)",
    ["Instance.new"] = "rgb(240,128,128)",
    ["script"] = "rgb(128,0,0)",
    ["wait"] = "rgb(255,160,122)",
    ["CFrame"] = "rgb(127,255,212)",
    ["Vector3"] = "rgb(135,206,235)",
    ["Player"] = "rgb(173,255,47)",
    ["Humanoid"] = "rgb(176,224,230)",
    ["Clone"] = "rgb(123,104,238)",
    ["FindFirstChild"] = "rgb(255,69,0)",
    ["GetService"] = "rgb(75,0,130)",
    ["TextButton"] = "rgb(240,128,128)",
    ["ImageLabel"] = "rgb(0,128,128)",
    ["Frame"] = "rgb(70,130,180)",
    ["TweenService"] = "rgb(189,183,107)",
    ["Lighting"] = "rgb(72,61,139)",
    ["ReplicatedStorage"] = "rgb(123,104,238)",
    ["Debris"] = "rgb(210,105,30)",

    -- 数学与表操作
    ["math.random"] = "rgb(139,69,19)",
    ["math.abs"] = "rgb(210,105,30)",
    ["math.pi"] = "rgb(205,133,63)",
    ["math.floor"] = "rgb(188,143,143)",
    ["math.ceil"] = "rgb(255,228,181)",
    ["math.max"] = "rgb(220,20,60)",
    ["math.min"] = "rgb(255,69,0)",
    ["math.sqrt"] = "rgb(0,255,255)",
    ["table.insert"] = "rgb(0,128,255)",
    ["table.remove"] = "rgb(72,61,139)",
    ["table.sort"] = "rgb(255,222,173)",
    ["table.concat"] = "rgb(127,255,0)",
    ["table.unpack"] = "rgb(100,149,237)",

    -- 其他补充
    ["os.time"] = "rgb(128,128,0)",
    ["os.date"] = "rgb(255,160,122)",
    ["os.clock"] = "rgb(255,69,0)",
    ["os.difftime"] = "rgb(176,224,230)",

    -- 协程相关
    ["coroutine.resume"] = "rgb(255,105,180)",
    ["coroutine.yield"] = "rgb(255,69,0)",
    ["coroutine.create"] = "rgb(100,149,237)",
    ["coroutine.wrap"] = "rgb(123,104,238)",

    -- 附加：更多Roblox服务
    ["RunService"] = "rgb(46,139,87)",
    ["UserInputService"] = "rgb(60,179,113)",
    ["HttpService"] = "rgb(240,128,128)",
    ["Players"] = "rgb(173,255,47)",
    ["GuiService"] = "rgb(70,130,180)"
}

-- Toggle Input and Highlighter Visibility
InputBox:GetPropertyChangedSignal("Text"):Connect(function()
    local rawText = InputBox.Text
    local highlightedText = rawText

    
    -- Highlight comments and keywords
    for word, color in pairs(highlightRules) do
        highlightedText = highlightedText:gsub(
            "(%f[%w])" .. word .. "(%f[%W])",
            string.format("<font color='%s'>%s</font>", color, word)
        )
    end

    -- Highlight single-line comments (e.g., -- This is a comment)
    highlightedText = highlightedText:gsub("(%-%-.*)", "<font color='rgb(128,128,128)'>%1</font>")

    HighlightLabel.Text = highlightedText
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, math.max(#InputBox.Text:split("\n") * 25, 300))
end)

InputBox.Focused:Connect(function()
    HighlightLabel.Visible = false -- Hide highlighter while typing
end)

InputBox.FocusLost:Connect(function()
    HighlightLabel.Visible = true -- Show highlighter after typing
end)

-- Execution Button
local ExecuteButton = Instance.new("TextButton")
ExecuteButton.Text = "Execute"
ExecuteButton.Font = Enum.Font.Ubuntu
ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecuteButton.TextSize = 20
ExecuteButton.Size = UDim2.new(0, 100, 0, 50)
ExecuteButton.Position = UDim2.new(0, 60, 0, 370)
ExecuteButton.BackgroundTransparency = 1
ExecuteButton.Parent = Frame

-- Execution Logic
ExecuteButton.MouseButton1Click:Connect(function()
    local script = InputBox.Text
    local loadResult, err = loadstring(script)
    if loadResult then
        loadResult()
        print("Script executed successfully.")
    else
        print("Error in script: ", err)
    end
end)

-- Clear Button
local ClearButton = Instance.new("TextButton")
ClearButton.Text = "Clear"
ClearButton.Font = Enum.Font.Ubuntu
ClearButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ClearButton.TextSize = 20
ClearButton.Size = UDim2.new(0, 100, 0, 50)
ClearButton.Position = UDim2.new(0, 180, 0, 370)
ClearButton.BackgroundTransparency = 1
ClearButton.Parent = Frame

-- Clear Logic
ClearButton.MouseButton1Click:Connect(function()
    InputBox.Text = ""
end)

loadstring(game:HttpGet("https://raw.githubusercontent.com/TynaRan/Api/refs/heads/main/Scriptblox.lua"))()
