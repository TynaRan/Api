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
    ["goto"] = "rgb(255,69,0)",

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
    ["debug.getregistry"] = "rgb(255,165,0)",
    ["debug.getconstants"] = "rgb(32,178,170)",
    ["debug.sethook"] = "rgb(220,20,60)", -- 设置调试Hook
    ["rawget"] = "rgb(255,140,0)",
    ["rawset"] = "rgb(0,192,192)",
    ["rawequal"] = "rgb(0,128,255)",
    ["getthreadidentity"] = "rgb(240,230,140)",
    ["setthreadidentity"] = "rgb(124,252,0)",
    ["disassemble"] = "rgb(255,228,181)",

    -- Roblox相关服务与API
    ["game"] = "rgb(46,139,87)",
    ["workspace"] = "rgb(0,255,128)",
    ["Instance.new"] = "rgb(240,128,128)",
    ["script"] = "rgb(128,0,0)",
    ["wait"] = "rgb(255,160,122)",
    ["CFrame"] = "rgb(127,255,212)",
    ["Vector3"] = "rgb(135,206,235)",
    ["Player"] = "rgb(173,255,47)",
    ["Humanoid"] = "rgb(176,224,230)",
    ["FindFirstChild"] = "rgb(255,69,0)",
    ["GetService"] = "rgb(75,0,130)",
    ["Lighting"] = "rgb(72,61,139)",
    ["ReplicatedStorage"] = "rgb(123,104,238)",
    ["RunService"] = "rgb(46,139,87)",
    ["UserInputService"] = "rgb(60,179,113)",
    ["HttpService"] = "rgb(240,128,128)",
    ["Players"] = "rgb(173,255,47)",
    ["TweenService"] = "rgb(189,183,107)",
    ["SoundService"] = "rgb(189,183,107)", -- 声音服务
    ["Mouse"] = "rgb(70,130,180)", -- 鼠标

    -- 数学与表操作扩展
    ["math.abs"] = "rgb(210,105,30)",
    ["math.random"] = "rgb(139,69,19)",
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

    -- 深度内存操作与事件
    ["getgc"] = "rgb(0,128,128)",
    ["getfenv"] = "rgb(240,128,128)",
    ["setfenv"] = "rgb(0,255,128)",
    ["firesignal"] = "rgb(46,139,87)",
    ["newcclosure"] = "rgb(255,69,0)",
    ["setupvalues"] = "rgb(210,105,30)",
    ["setnamecallmethod"] = "rgb(123,104,238)",
    ["getnamecallmethod"] = "rgb(255,105,180)",

    -- 时间和系统操作
    ["os.time"] = "rgb(128,128,0)",
    ["os.date"] = "rgb(255,160,122)",
    ["os.clock"] = "rgb(255,69,0)",
    ["os.difftime"] = "rgb(176,224,230)",
    ["os.getenv"] = "rgb(72,61,139)", -- 获取环境变量
    ["os.setlocale"] = "rgb(123,104,238)", -- 设置区域语言
    ["os.execute"] = "rgb(210,105,30)", -- 执行系统命令

    -- 协程相关
    ["coroutine.resume"] = "rgb(255,105,180)",
    ["coroutine.yield"] = "rgb(255,69,0)",
    ["coroutine.create"] = "rgb(100,149,237)",
    ["coroutine.wrap"] = "rgb(123,104,238)",

    -- Lua语言特性扩展
    ["load"] = "rgb(255,20,147)", -- 动态加载代码
    ["loadfile"] = "rgb(127,255,212)", -- 加载文件
    ["dofile"] = "rgb(70,130,180)", -- 执行文件
    ["_VERSION"] = "rgb(255,223,128)", -- Lua版本信息
    ["_G"] = "rgb(46,139,87)", -- 全局环境表
    ["module"] = "rgb(255,105,180)", -- 模块（过时但可用）
    ["package.loaded"] = "rgb(0,255,128)", -- 已加载模块
    ["package.searchpath"] = "rgb(135,206,250)" -- 搜索模块路径
}

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

-- Add LOGO at the top-left corner
local Logo = Instance.new("TextLabel")
Logo.Text = "R"
Logo.Font = Enum.Font.Ubuntu
Logo.TextColor3 = Color3.fromRGB(255, 255, 255)
Logo.TextSize = 28
Logo.Size = UDim2.new(0, 50, 0, 50) -- Dimensions for the LOGO
Logo.Position = UDim2.new(0, 1, 0, 1) -- x = 1, y = 1
Logo.BackgroundTransparency = 1
Logo.Parent = Frame

-- Add ScrollingFrame for Input Box
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(0, 600, 0, 300)
ScrollingFrame.Position = UDim2.new(0, 60, 0, 60)
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.ScrollBarThickness = 10
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.Parent = Frame

-- Input Box inside ScrollingFrame
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

-- Highlight Layer for syntax highlighting
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

-- Syntax Highlight Logic
InputBox:GetPropertyChangedSignal("Text"):Connect(function()
    local rawText = InputBox.Text
    local highlightedText = rawText
    for word, color in pairs(highlightRules) do
        highlightedText = highlightedText:gsub(
            "(%f[%w])" .. word .. "(%f[%W])",
            string.format("<font color='%s'>%s</font>", color, word)
        )
    end

    -- Highlight single-line comments
    highlightedText = highlightedText:gsub("(%-%-.*)", "<font color='rgb(128,128,128)'>%1</font>")

    HighlightLabel.Text = highlightedText
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, math.max(#InputBox.Text:split("\n") * 25, 300))
end)

InputBox.Focused:Connect(function()
    HighlightLabel.Visible = false
end)

InputBox.FocusLost:Connect(function()
    HighlightLabel.Visible = true
end)

-- Executor Button
local ExecuteButton = Instance.new("TextButton")
ExecuteButton.Text = "Executor"
ExecuteButton.Font = Enum.Font.Ubuntu
ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecuteButton.TextSize = 20
ExecuteButton.Size = UDim2.new(0, 150, 0, 50)
ExecuteButton.Position = UDim2.new(0, 60, 0, 400)
ExecuteButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
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
ClearButton.Size = UDim2.new(0, 150, 0, 50)
ClearButton.Position = UDim2.new(0, 220, 0, 400)
ClearButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ClearButton.Parent = Frame

-- Clear Logic
ClearButton.MouseButton1Click:Connect(function()
    InputBox.Text = ""
end)
loadstring(game:HttpGet("https://raw.githubusercontent.com/TynaRan/Api/refs/heads/main/Scriptblox.lua"))()
