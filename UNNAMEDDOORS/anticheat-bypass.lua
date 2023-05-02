local char = game:GetService("Players").LocalPlayer.Character
local plr = game:GetService("Players").LocalPlayer
local Player = plr

repeat wait(.1) until Player.Character
local Character = Player.Character

local invisRunning = false
local IsRunning = false
local IsInvis = false
local invisFix 
local CF
local invisDied
local InvisibleCharacter


local Bypass = {}

local function fixCam(char) 
	workspace.CurrentCamera:remove()
	wait(.1)
	repeat wait() until char ~= nil
	workspace.CurrentCamera.CameraSubject = char:FindFirstChildWhichIsA('Humanoid')
	workspace.CurrentCamera.CameraType = "Custom"
	Player.CameraMinZoomDistance = 0.5
	Player.CameraMaxZoomDistance = 400
	Player.CameraMode = "Classic"
	char.Head.Anchored = false
end

function Bypass:Respawn()


    IsRunning = false
    if IsInvis == true then
        pcall(function()
            Player.Character = Character
            wait()
            Character.Parent = workspace
            Character:FindFirstChildWhichIsA('Humanoid'):Destroy()
            IsInvis = false
            InvisibleCharacter.Parent = nil
            invisRunning = false
        end)
    elseif IsInvis == false then
        pcall(function()
            Player.Character = Character
            wait()
            Character.Parent = workspace
            Character:FindFirstChildWhichIsA('Humanoid'):Destroy()
            Bypass:Disable()
        end)
    end
end

function Bypass:Enable() 
    if invisRunning then return end
    invisRunning = true
    -- Full credit to AmokahFox @V3rmillion
    -- and infinite yield script for invis command
    for x,i in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do 
        local save = i:Clone() 
        for xx,ii in pairs(save:GetDescendants()) do 
            if ii:IsA("LocalScript")then 
                if ii.Enabled == true then 
                    local thingdefine = Instance.new("ObjectValue",ii) thingdefine.Name="ThisThingWasEnableedPlsEnable" 
                    ii.Enabled=false 
                end
            end
        end
        task.spawn(function () 
            wait(0.8)
            save.Parent = game.Players.LocalPlayer.PlayerGui
            for xx,ii in pairs(save:GetDescendants()) do 
                if ii:IsA("LocalScript")then 
                    
                    if ii:FindFirstChild("ThisThingWasEnableedPlsEnable") then 
                        ii.Enabled=true
                        wait(0.1)
                        ii:FindFirstChild("ThisThingWasEnableedPlsEnable"):Destroy()
                    end
                    
                end
            end
        end)
    end

    Character.Archivable = true

    InvisibleCharacter = Character:Clone()
    InvisibleCharacter.Parent = Lighting
    local Void = workspace.FallenPartsDestroyHeight
    InvisibleCharacter.Name = ""
    
    
    invisFix = game:GetService("RunService").RenderStepped:Connect(function()
            

        local IsInteger
        if tostring(Void):find'-' then
            IsInteger = true
        else
            IsInteger = false
        end
        local Pos = Player.Character.HumanoidRootPart.Position
        local Pos_String = tostring(Pos)
        local Pos_Seperate = Pos_String:split(', ')
        local X = tonumber(Pos_Seperate[1])
        local Y = tonumber(Pos_Seperate[2])
        local Z = tonumber(Pos_Seperate[3])
        if IsInteger == true then
            if Y <= Void then
                Bypass:Respawn()
            end
        elseif IsInteger == false then
            if Y >= Void then
                Bypass:Respawn()
            end
        end
    end)


    
    for i,v in pairs(InvisibleCharacter:GetDescendants())do
        if v:IsA("BasePart") then
            if v.Name == "HumanoidRootPart" then
                v.Transparency = 1
            else
                v.Transparency = 0
            end
        end
    end
    
    invisDied = InvisibleCharacter:FindFirstChildOfClass('Humanoid').Died:Connect(function()
        Bypass:Respawn()
        invisDied:Disconnect()
    end)
    
    if IsInvis == true then return end
    IsInvis = true

    while IsInvis do
        wait()
        Character:FindFirstChild("HumanoidRootPart").Anchored = true
        Character:FindFirstChild("HumanoidRootPart").CFrame = InvisibleCharacter:FindFirstChild("HumanoidRootPart").CFrame
    end


    CF = workspace.CurrentCamera.CFrame
    local CF_1 = Player.Character.HumanoidRootPart.CFrame
    
    workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
    wait(.2)
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    InvisibleCharacter = InvisibleCharacter
    -- Character.Parent = Lighting
    InvisibleCharacter.Parent = workspace
    InvisibleCharacter.HumanoidRootPart.CFrame = CF_1
    Player.Character = InvisibleCharacter
    fixCam(InvisibleCharacter)
    -- execCmd('fixcam')
    Player.Character.Animate.Disabled = true
    Player.Character.Animate.Disabled = false
end

function Bypass:Disable()


    if IsInvis == false then return end

    for x,i in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do 
        local save = i:Clone() 
        for xx,ii in pairs(save:GetDescendants()) do 
            if ii:IsA("LocalScript")then 
                if ii.Enabled == true then 
                    local thingdefine = Instance.new("ObjectValue",ii) thingdefine.Name="ThisThingWasEnableedPlsEnable" 
                    ii.Enabled=false 
                end
            end
        end
        task.spawn(function () 
            wait(0.8)
            save.Parent = game.Players.LocalPlayer.PlayerGui
            for xx,ii in pairs(save:GetDescendants()) do 
                if ii:IsA("LocalScript")then 
                    
                    if ii:FindFirstChild("ThisThingWasEnableedPlsEnable") then 
                        ii.Enabled=true
                        wait(0.1)
                        ii:FindFirstChild("ThisThingWasEnableedPlsEnable"):Destroy()
                    end
                    
                end
            end
        end)
    end

    invisFix:Disconnect()
    invisDied:Disconnect()
    CF = workspace.CurrentCamera.CFrame
    Character = Character
    local CF_1 = Player.Character.HumanoidRootPart.CFrame
    Character.HumanoidRootPart.CFrame = CF_1
    InvisibleCharacter:Destroy()
    Player.Character = Character
    Character.Parent = workspace
    IsInvis = false
    Player.Character.Animate.Disabled = true
    Player.Character.Animate.Disabled = false
    invisDied = Character:FindFirstChildOfClass('Humanoid').Died:Connect(function()
        Bypass:Respawn()
        invisDied:Disconnect()
    end)
    invisRunning = false
end

getgenv().Bypass = Bypass