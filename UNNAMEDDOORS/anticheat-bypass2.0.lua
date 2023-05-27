local char = game:GetService("Players").LocalPlayer.Character
local plr = game:GetService("Players").LocalPlayer
local Player = plr

repeat wait(.1) until Player.Character
local Character = Player.Character

local Collison = Character:FindFirstChild("Collision")
local HumRootPart = Character:FindFirstChild("HumanoidRootPart")



local Bypass = {}

local Runnder

function Bypass:Enable() 
    Runnder = game:GetService("RunService").RenderStepped:Connect(function()
        if Collison then 
            Collison.Position = HumRootPart.Position - Vector3.new(0,10,0)
        end
        
    end)
end

function Bypass:Disable()
    if Runnder then 
        Runnder:Disconnect()
        Runnder=nil
    end
    Player.Character.Animate.Disabled = true
    Player.Character.Animate.Disabled = false
    HumRootPart.Anchored = true
    wait(0.01)
    Collison.Position = HumRootPart.Position + Vector3.new(0,1,0)
    wait(0.01)
    HumRootPart.Anchored = false
end

getgenv().Bypass = Bypass