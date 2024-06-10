local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Robojini/Tuturial_UI_Library/main/UI_Template_1"))()

local Window = Library.CreateLib("Universal script nexus", "RJTheme3")

local Tab = Window:NewTab("main")

local Section = Tab:NewSection("visuals")

Section:NewButton("glow", "ButtonInfo", function()
    for i,v in pairs(game.Players:GetPlayers()) do
    if v ~= game.Players.LocalPlayer then
        local function addEsp(character)
            local newHighlight = Instance.new("Highlight")
            
            newHighlight.Parent = character
        end
        
        addEsp(v.Character)
        
        v.CharacterAdded:Connect(function(char)
            addEsp(char)
        end)
    end
end

game.Players.PlayerAdded:Connect(function(v)
     local function addEsp(character)
        local newHighlight = Instance.new("Highlight")
        
        newHighlight.Parent = character
    end
    
    addEsp(v.Character)
    
    v.CharacterAdded:Connect(function(char)
        addEsp(char)
    end)
end)
end)
Section:NewButton("Tracer", "ButtonInfo", function()
    local lplr = game.Players.LocalPlayer
local camera = game:GetService("Workspace").CurrentCamera
local CurrentCamera = workspace.CurrentCamera
local worldToViewportPoint = CurrentCamera.worldToViewportPoint

_G.TeamCheck = false -- Use True or False to toggle TeamCheck

for i,v in pairs(game.Players:GetChildren()) do
    local Tracer = Drawing.new("Line")
    Tracer.Visible = false
    Tracer.Color = Color3.new(1,1,1)
    Tracer.Thickness = 1
    Tracer.Transparency = 1

    function lineesp()
        game:GetService("RunService").RenderStepped:Connect(function()
            if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lplr and v.Character.Humanoid.Health > 0 then
                local Vector, OnScreen = camera:worldToViewportPoint(v.Character.HumanoidRootPart.Position)

                if OnScreen then
                    Tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 1)
                    Tracer.To = Vector2.new(Vector.X, Vector.Y)

                    if _G.TeamCheck and v.TeamColor == lplr.TeamColor then
                        --//Teammates
                        Tracer.Visible = false
                    else
                        --//Enemies
                        Tracer.Visible = true
                    end
                else
                    Tracer.Visible = false
                end
            else
                Tracer.Visible = false
            end
        end)
    end
    coroutine.wrap(lineesp)()
end

game.Players.PlayerAdded:Connect(function(v)
    local Tracer = Drawing.new("Line")
    Tracer.Visible = false
    Tracer.Color = Color3.new(1,1,1)
    Tracer.Thickness = 1
    Tracer.Transparency = 1

    function lineesp()
        game:GetService("RunService").RenderStepped:Connect(function()
            if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lplr and v.Character.Humanoid.Health > 0 then
                local Vector, OnScreen = camera:worldToViewportPoint(v.Character.HumanoidRootPart.Position)

                if OnScreen then
                    Tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 1)
                    Tracer.To = Vector2.new(Vector.X, Vector.Y)

                    if _G.TeamCheck and v.TeamColor == lplr.TeamColor then
                        --//Teammates
                        Tracer.Visible = false
                    else
                        --//Enemies
                        Tracer.Visible = true
                    end
                else
                    Tracer.Visible = false
                end
            else
                Tracer.Visible = false
            end
        end)
    end
    coroutine.wrap(lineesp)()
end)
end)

local Tab = Window:NewTab("local")

local Section = Tab:NewSection("speed")

Section:NewSlider("speed", "SliderInfo", 500, 0, function(s) -- 500 (Макс. значение) | 0 (Мин. значение)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)
Section:NewButton("fly", "ButtonInfo", function()
    -- FE SELF FLING REAL
-- used for trolling example: bang someone and when they turn around and look at you, FLING YOURSELF
-- hotkey dont have to be capitals lol
-- press e to fling urself and q to go back where u previously were

local Config = {
    FlingHotkey = "E",
    TpBackHotkey = "Q",
    Permanent = false
}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer

local Character = Player.Character
local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
local RootPart = Humanoid.RootPart

for _, x in next, Config do
    if type(x) == "string" then
        Config[_] = x:upper()
    end
end

local CurrentPos
local Connection

Connection = UserInputService.InputBegan:Connect(function(Key, Typing)
    if not Typing then
        if Key.KeyCode == Enum.KeyCode[Config.FlingHotkey] then
            if Config.Permanent then
                if Player.Character.Humanoid.RootPart.Velocity.Magnitude <= 20 then
                    CurrentPos = Player.Character.Humanoid.RootPart.CFrame
                end
                Player.Character.Humanoid.RootPart.Velocity = (Player.Character.Humanoid.RootPart.Velocity + Vector3.new(0, 50, 0)) + (Player.Character.Humanoid.RootPart.CFrame.LookVector * 100)
                Player.Character.Humanoid.RootPart.RotVelocity = (Player.Character.Humanoid.RootPart.RotVelocity + Vector3.new(math.random(200, 300), math.random(-200, 300), math.random(200, 300))) 
            else
                if RootPart.Velocity.Magnitude <= 20 then
                    CurrentPos = RootPart.CFrame
                end
                RootPart.Velocity = (RootPart.Velocity + Vector3.new(0, 50, 0)) + (RootPart.CFrame.LookVector * 100)
                RootPart.RotVelocity = (RootPart.RotVelocity + Vector3.new(math.random(200, 300), math.random(-200, 300), math.random(200, 300)))
            end
        elseif Key.KeyCode == Enum.KeyCode[Config.TpBackHotkey] then
            if CurrentPos then
                if Config.Permanent then
                    if Player.Character.Humanoid.RootPart.Velocity.Magnitude >= 20 then
                        Player.Character.Humanoid.RootPart.Velocity = Vector3.new()
                        Player.Character.Humanoid.RootPart.RotVelocity = Vector3.new()
                        Player.Character.Humanoid.RootPart.CFrame = CurrentPos
                        Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                    end
                else
                    if RootPart.Velocity.Magnitude >= 20 then
                        RootPart.Velocity = Vector3.new()
                        RootPart.RotVelocity = Vector3.new()
                        RootPart.CFrame = CurrentPos
                        Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                    end
                end
            end
        end
    end
end)

if not Config.Permanent then
    Humanoid.Died:Connect(function()
        Connection:Disconnect()
    end)
end
end)
