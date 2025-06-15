-- CompleteImGui.lua
-- Full wrapper for Depso's ImGui library with all components

local CompleteImGui = {}
local ImGui

-- Initialization
function CompleteImGui.Init()
    local RunService = game:GetService("RunService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    
    if RunService:IsStudio() then
        ImGui = require(ReplicatedStorage.ImGui)
    else
        ImGui = loadstring(game:HttpGet('https://github.com/depthso/Roblox-ImGUI/raw/main/ImGui.lua'))()
    end
end

-- Windows
function CompleteImGui.CreateWindow(options)
    options = options or {}
    local window = ImGui:CreateWindow({
        Title = options.Title or "Window",
        Size = options.Size or UDim2.new(0, 600, 0, 500),
        Position = options.Position or UDim2.new(0.5, 0, 0.5, 0),
        NoCollapse = options.NoCollapse,
        NoResize = options.NoResize,
        NoClose = options.NoClose,
        NoTitleBar = options.NoTitleBar,
        AutoSize = options.AutoSize
    })
    if options.Center then window:Center() end
    return window
end

function CompleteImGui.CreateModal(options)
    return ImGui:CreateModal({
        Title = options.Title or "Modal",
        AutoSize = options.AutoSize or "Y"
    })
end

-- Tabs
function CompleteImGui.CreateTab(window, options)
    return window:CreateTab({
        Name = options.Name or "Tab",
        Visible = options.Visible
    })
end

-- Basic Components
function CompleteImGui.CreateButton(parent, options)
    return parent:Button({
        Text = options.Text or "Button",
        Callback = options.Callback,
        Size = options.Size,
        BackgroundColor3 = options.Color,
        CornerRadius = options.CornerRadius
    })
end

function CompleteImGui.CreateLabel(parent, options)
    return parent:Label({
        Text = options.Text or "Label",
        TextWrapped = options.TextWrapped,
        TextColor3 = options.TextColor3,
        RichText = options.RichText
    })
end

function CompleteImGui.CreateInput(parent, options)
    return parent:InputText({
        Label = options.Label,
        PlaceHolder = options.PlaceHolder,
        Value = options.Value,
        ClearButton = options.ClearButton
    })
end

function CompleteImGui.CreateCheckbox(parent, options)
    return parent:Checkbox({
        Label = options.Label or "Checkbox",
        Value = options.Value or false,
        Callback = options.Callback
    })
end

-- Advanced Components
function CompleteImGui.CreateTable(parent, options)
    return parent:Table({
        RowBackground = options.RowBackground or true,
        Border = options.Border or true,
        RowsFill = options.RowsFill,
        Size = options.Size or UDim2.fromScale(1, 0)
    })
end

function CompleteImGui.CreateConsole(parent, options)
    return parent:Console({
        Text = options.Text or "",
        ReadOnly = options.ReadOnly ~= false,
        LineNumbers = options.LineNumbers,
        Border = options.Border,
        Fill = options.Fill ~= false,
        Enabled = options.Enabled ~= false,
        AutoScroll = options.AutoScroll ~= false,
        RichText = options.RichText,
        MaxLines = options.MaxLines or 50
    })
end

function CompleteImGui.CreateCollapsingHeader(parent, options)
    return parent:CollapsingHeader({
        Title = options.Title or "Header",
        Open = options.Open ~= false
    })
end

function CompleteImGui.CreateTreeNode(parent, options)
    return parent:TreeNode({
        Title = options.Title or "Node",
        Open = options.Open ~= false
    })
end

-- Selection Components
function CompleteImGui.CreateCombo(parent, options)
    return parent:Combo({
        Label = options.Label or "Combo",
        Selected = options.Selected,
        Placeholder = options.Placeholder,
        Items = options.Items or {},
        Callback = options.Callback
    })
end

function CompleteImGui.CreateRadioButton(parent, options)
    return parent:RadioButton({
        Label = options.Label or "Radio",
        Value = options.Value or false,
        Callback = options.Callback
    })
end

-- Sliders
function CompleteImGui.CreateSlider(parent, options)
    local slider = parent:Slider({
        Label = options.Label or "Slider",
        Format = options.Format or "%.2f",
        Value = options.Value or 0,
        MinValue = options.Min or 0,
        MaxValue = options.Max or 100,
        ReadOnly = options.ReadOnly,
        CornerRadius = options.CornerRadius
    })
    if options.SetValue then slider:SetValue(options.SetValue) end
    return slider
end

function CompleteImGui.CreateProgressSlider(parent, options)
    return parent:ProgressSlider({
        Label = options.Label or "Progress",
        Value = options.Value or 0,
        MinValue = options.Min or 0,
        MaxValue = options.Max or 100,
        CornerRadius = options.CornerRadius
    })
end

function CompleteImGui.CreateProgressBar(parent, options)
    return parent:ProgressBar({
        Label = options.Label or "Progress",
        Percentage = options.Percentage or 0
    })
end

-- Keybinds
function CompleteImGui.CreateKeybind(parent, options)
    return parent:Keybind({
        Label = options.Label or "Keybind",
        Value = options.Key or Enum.KeyCode.Q,
        IgnoreGameProcessed = options.IgnoreProcessed ~= false,
        Callback = options.Callback
    })
end

-- Layout Components
function CompleteImGui.CreateRow(parent, options)
    return parent:Row({
        Spacing = options.Spacing,
        Fill = options.Fill ~= false
    })
end

function CompleteImGui.CreateSeparator(parent, options)
    return parent:Separator({
        Text = options.Text
    })
end

-- Viewport
function CompleteImGui.CreateViewport(parent, options)
    options = options or {}
    local viewport = parent:Viewport({
        Size = options.Size or UDim2.new(1, 0, 0, 200),
        Clone = options.Clone ~= false,
        Border = options.Border ~= false
    })
    if options.Model then
        viewport:SetModel(options.Model, options.CFrame or CFrame.new(0, -2.5, -5))
    end
    return viewport
end

-- Image
function CompleteImGui.CreateImage(parent, options)
    return parent:Image({
        Image = options.ImageId,
        Ratio = options.Ratio or 16/9,
        AspectType = options.AspectType or Enum.AspectType.FitWithinMaxSize,
        Size = options.Size or UDim2.fromScale(1, 1)
    })
end

-- Key System (Complete Implementation)
function CompleteImGui.CreateKeySystem(options)
    options = options or {}
    local window = CompleteImGui.CreateWindow({
        Title = options.Title or "Key System",
        Size = UDim2.new(0, 350, 0, options.Height or 180),
        NoCollapse = true,
        NoResize = true,
        NoClose = options.NoClose ~= false,
        Center = true
    })
    
    local tab = CompleteImGui.CreateTab(window, {Name = "Auth"})
    
    CompleteImGui.CreateLabel(tab, {
        Text = options.Description or "Enter your license key below:",
        TextWrapped = true
    })
    
    local keyInput = CompleteImGui.CreateInput(tab, {
        Label = options.InputLabel or "License Key:",
        PlaceHolder = options.Placeholder or "Enter key here...",
        ClearButton = true
    })
    
    local statusLabel = CompleteImGui.CreateLabel(tab, {
        Text = "",
        TextWrapped = true,
        TextColor3 = Color3.fromRGB(255, 50, 50),
        Visible = false
    })
    
    local row = CompleteImGui.CreateRow(tab, {Fill = true})
    
    CompleteImGui.CreateButton(row, {
        Text = "Cancel",
        Callback = function()
            if options.OnCancel then options.OnCancel() end
            window:Close()
        end,
        Color = Color3.fromRGB(100, 100, 100)
    })
    
    CompleteImGui.CreateButton(row, {
        Text = "Submit",
        Callback = function()
            local enteredKey = keyInput:GetValue()
            local isValid = options.ValidateFunction and options.ValidateFunction(enteredKey) or enteredKey == (options.ValidKey or "DEMO-KEY")
            
            if isValid then
                statusLabel:SetProperties({
                    Text = options.SuccessMessage or "✓ Valid key! Loading application...",
                    TextColor3 = Color3.fromRGB(50, 255, 50)
                })
                if options.OnSuccess then options.OnSuccess(enteredKey) end
                task.wait(1.5)
                window:Close()
            else
                statusLabel:SetProperties({
                    Text = options.FailureMessage or "✗ Invalid key! Please try again.",
                    TextColor3 = Color3.fromRGB(255, 50, 50),
                    Visible = true
                })
                if options.OnFailure then options.OnFailure(enteredKey) end
                
                -- Shake effect
                local originalPos = window.Position
                for i = 1, 3 do
                    window:SetPosition(originalPos + UDim2.new(0, 5, 0, 0))
                    task.wait(0.05)
                    window:SetPosition(originalPos - UDim2.new(0, 5, 0, 0))
                    task.wait(0.05)
                end
                window:SetPosition(originalPos)
            end
        end,
        Color = Color3.fromRGB(50, 150, 255)
    })
    
    return window
end

-- Watermark
function CompleteImGui.CreateWatermark(text)
    local watermark = CompleteImGui.CreateWindow({
        Title = "",
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.fromOffset(10, 10),
        NoTitleBar = true,
        NoResize = true,
        NoCollapse = true,
        NoClose = true,
        AutoSize = "XY",
        BackgroundTransparency = 0.8
    })
    
    local tab = CompleteImGui.CreateTab(watermark)
    local row = CompleteImGui.CreateRow(tab, {Spacing = 10})
    
    CompleteImGui.CreateLabel(row, {
        Text = text or "Watermark",
        TextColor3 = Color3.fromRGB(255, 255, 0)
    })
    
    local fpsLabel = CompleteImGui.CreateLabel(row)
    
    game:GetService("RunService").RenderStepped:Connect(function(dt)
        fpsLabel.Text = string.format("FPS: %d", math.round(1/dt))
    end)
    
    return watermark
end

return CompleteImGui
