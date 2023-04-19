local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local MainEspManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/leinad2011st/doors-utilites/main/UNNAMEDDOORS/EspManager.lua"))()

local Debris = game:GetService("Debris")


if game.PlaceId ~= 6839171747 and game.PlaceId ~= 6516141723 then 
    print("Not in doors")
    print("why")
    return
end

-- --------------------------------------------------------------------------- --

--TO DOOOO
--TO DO


--FINNISH UP ESP FULLLY

--ADD YOUR KEY BIND SCRIPT INTO THIS
--key bind settings tab
--maybe freecam
-- DEFFENTILY ADD CONFIG/ unload window

-- --------------------------------------------------------------------------- --


local Window = Library:CreateWindow({
    -- Set Center to true if you want the menu to appear in the center
    -- Set AutoShow to true if you want the menu to appear when it is created
    -- Position and Size are also valid options here
    -- but you do not need to define them unless you are changing them :)

    Title = 'UNNAMED DOORS',
    Center = true,
    AutoShow = true,
    TabPadding = 8
})

local Tabs = {
    -- Creates a new tab titled Main
    Main = Window:AddTab('Main'),
    Server = Window:AddTab('Server'),
    ['configs'] = Window:AddTab('configs'),
}

local ishardmode = false

if game:GetService("ReplicatedStorage").GameData.Floor.Value=="Fools" then 
    ishardmode=true
end


local flags = {}
flags.ChangeSpeed = false
flags.BananaBypass = false
flags.noeyesdamage = false
flags.noseek=false
flags.noJeffDamage = false
flags.Fullbright = false
flags.InstantInteract = false
flags.HidingExitFix = false
flags.AntiDupe = false --Closet
flags.AntiFigureCutscene = false
flags.antiseekarms = false
flags.NoInteractDelay = false
flags.GuidingLightSkip = false
flags.JumpScareSkip = false
flags.AntiHalt = false
flags.AntiGlitch = false
flags.AntiVoid = false
flags.HidingReach = false
flags.A100NoLocks = false


local eyesspawned = false
local seekchaseRoom = 0
local removebannathing = nil
local removeJeffThing = nil

local client = Tabs.Main:AddLeftGroupbox('client')
local entityBypasses = Tabs.Main:AddLeftGroupbox('Entity Bypasses')

local serverMain = Tabs.Server:AddLeftGroupbox('Main')

local figurething = nil
serverMain:AddToggle('OpenDoor50NoCutscene', {
    Text = 'open door 50 without cutscene',
    Default = false, -- Default value (true / false)
    Tooltip = 'Disable Figure cutscene', -- Information shown when you hover over the toggle

    Callback = function(Value)
        flags.AntiFigureCutscene = Value
        if Value==true then 
            figurething=game["Run Service"].RenderStepped:Connect(function () 
                local latesetRoom=workspace.CurrentRooms:GetChildren()[1].Name
                local plusroom = latesetRoom+1
                if plusroom==50 then
                    local Room = workspace.CurrentRooms:FindFirstChild(latesetRoom)
                    local Door=Room:FindFirstChild("Door")
                    local EVENT=Door:FindFirstChild("ClientOpen")
                    local door = workspace.CurrentRooms["49"].Door
                    local maxrepeats = 50
                    local repeats = 0
                    repeat
                        wait()
                        char:PivotTo(door.Hidden.CFrame)
                        if door:FindFirstChild("ClientOpen") then
                            door.ClientOpen:FireServer()
                        end
                        repeats=repeats+1
                    until repeats==maxrepeats

                    -- repeat
                        --game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame= workspace.CurrentRooms["50"].FigureSetup.FigureCamPos.CFrame
                    --     EVENT:FireServer()
                    --     wait()
                    -- until workspace.CurrentRooms:FindFirstChild("51")
                    
                end
            end)
        elseif Value==false then 
            figurething:Disconnect()
            figurething = nil
        end
    end
})








-- local FigureremoverThing = nil
serverMain:AddButton({
    Text = 'Delete Figure',
    Tooltip = 'only works before opening door 50', -- Information shown when you hover over the toggle
    DoubleClick = false,
    Func = function(Value)
        print("CALL")
        -- flags.AntiFigureCutscene = Value
        -- if Value==true then 
        --     FigureremoverThing=game["Run Service"].RenderStepped:Connect(function ()
            local latesetRoom=game:GetService("ReplicatedStorage").GameData.LatestRoom.Value
            local Room = game.Workspace.CurrentRooms:FindFirstChild(latesetRoom)
            -- if latesetRoom==49 or flags.AntiFigureCutscene==true then 
            if workspace.CurrentRooms:FindFirstChild("50") then 
                workspace.CurrentRooms["50"].FigureSetup.FigureRagdoll.Torso:ApplyImpulse(Vector3.new(1, -100000, 1))
                workspace.CurrentRooms["50"].FigureSetup.FigureRagdoll.Torso:ApplyImpulse(Vector3.new(1, -100000, 1))
                local ragdollly = workspace.CurrentRooms["50"].FigureSetup.FigureRagdoll.Torso
                local cframe = CFrame.new(ragdollly.Position.X-500,ragdollly.Position.Y-100,ragdollly.Position.Z-500)
                ragdollly.CFrame=cframe
            end
            -- end

            -- end)
        -- elseif Value==false then 
        --     FigureremoverThing:Disconnect()
        --     FigureremoverThing = nil
        -- end
    end
})

serverMain:AddButton({
    Text = 'Delete Figure 2.0',
    Tooltip = 'only works during the cutscene', -- Information shown when you hover over the toggle
    DoubleClick = false,
    Func = function(Value)
        print("CALL")
        -- flags.AntiFigureCutscene = Value
        -- if Value==true then 
        --     FigureremoverThing=game["Run Service"].RenderStepped:Connect(function ()
            local latesetRoom=game:GetService("ReplicatedStorage").GameData.LatestRoom.Value
            local Room = game.Workspace.CurrentRooms:FindFirstChild(latesetRoom)
            -- if latesetRoom==49 or flags.AntiFigureCutscene==true then 
            if workspace.CurrentRooms:FindFirstChild("50") then 
                workspace.CurrentRooms["50"].FigureSetup.FigureRagdoll.Root:ApplyImpulse(Vector3.new(10000, 9999999, 1000000))
                workspace.CurrentRooms["50"].FigureSetup.FigureRagdoll.Torso:ApplyImpulse(Vector3.new(10000, 9999999, 1000000))
            end
            -- end 

            -- end)
        -- elseif Value==false then 
        --     FigureremoverThing:Disconnect()
        --     FigureremoverThing = nil
        -- end
    end
})


serverMain:AddButton({
    Text = "Agressive Figure",
    Tooltip = 'only works after opening door 50',
    DoubleClick = false,
    Func = function() 
        if workspace.CurrentRooms["51"] then
			local char = game.Players.LocalPlayer.Character
            local pos=char.HumanoidRootPart.CFrame
			local door = workspace.CurrentRooms["51"].Door
            local repeats = 0
            local maxrepeats = 50
            repeat
                char:PivotTo(door.Hidden.CFrame)
                if door:FindFirstChild("ClientOpen") then
                    door.ClientOpen:FireServer()
                end
                repeats=repeats+1
                wait()
            until repeats==maxrepeats
            char:PivotTo(pos)

		end
    end
})

if ishardmode==true then 
    serverMain:AddLabel('---SUPER HARD MODE---')

    serverMain:AddButton({
        Text = 'Get Banana Gun',
        Func = function()
            loadstring(game:GetObjects('rbxassetid://13118971711')[1].Source)()-- rbxassetid://13118971711
        end,
        DoubleClick = false,
        Tooltip = 'hold longer for more force'
    })
    
    --game:GetObjects("rbxassetid://13129056104")[1]  jeff gun
    
    serverMain:AddButton({
        Text = 'Get Jeff Gun',
        Func = function()
            loadstring(game:GetObjects("rbxassetid://13129056104")[1].Source)()-- rbxassetid://13129056104
        end,
        DoubleClick = false,
        Tooltip = 'hold longer for more force'
    })
end

local flyKey = Enum.KeyCode.R
local camera = game:GetService("Workspace").CurrentCamera
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rp = character:WaitForChild("HumanoidRootPart")
local bodyGyro = Instance.new("BodyGyro")
local bodyVel = Instance.new("BodyVelocity")

local speed=1

bodyGyro.MaxTorque = Vector3.new(1, 1, 1) * 10^6
bodyGyro.P = 10^6
bodyVel.MaxForce = Vector3.new(1, 1, 1) * 10^6
bodyVel.P = 10^4

local isFlying = false
local movement = {
	forward = 0, 
	backward = 0, 
	right = 0, 
	left = 0
}


local function setFlying(flying)
	isFlying = flying
	bodyGyro.Parent = isFlying and rp or nil
	bodyVel.Parent = isFlying and rp or nil
	bodyGyro.CFrame = rp.CFrame
	bodyVel.Velocity = Vector3.new()
	
end

local function updateFlying(dt)
	if isFlying then
		humanoid.PlatformStand=true
		local cf = camera.CFrame
		local direction = cf.RightVector * (movement.right - movement.left) + cf.LookVector * (movement.forward - movement.backward)
		if direction:Dot(direction) > 0 then
			direction = direction.Unit
		end
		bodyGyro.CFrame = cf
		bodyVel.Velocity = direction * humanoid.WalkSpeed * speed
	else
		humanoid.PlatformStand=false
	end
end

local function handleFlyKey(input, gameProcessedEvent)
	if not gameProcessedEvent and input.KeyCode == flyKey then
		if humanoid:GetState() ~= Enum.HumanoidStateType.Dead then
			setFlying(not isFlying)
            Toggles.Fly:SetValue(isFlying)
		end
	end
end

local function handleMovementBind(actionName, inputState, inputObject)
	if inputState == Enum.UserInputState.Begin then
		movement[actionName] = 1
	elseif inputState == Enum.UserInputState.End then
		movement[actionName] = 0
	end
	local isMoving = movement.right + movement.left + movement.forward + movement.backward > 0
	return Enum.ContextActionResult.Pass
end




_G.Keybind = "N"
_G.IncludeNoclip = true

local isEnabled = false

local UIS = game:GetService("UserInputService")

local Plr = game.Players.LocalPlayer
local Char = Plr.Character or Plr.CharacterAdded:Wait()

function getValue()
    local value
    if isEnabled then
        value = "On"
    else
        value = "Off"
    end
    return value
end

function ToggleNoclip()
    isEnabled = not isEnabled
end

function setNoClip(Val)
    Toggles.NoClip:SetValue(Val)
    isEnabled=Val
end

UIS.InputBegan:Connect(function(input, gp)
    if gp then return end

    if input.KeyCode == Enum.KeyCode[_G.Keybind] then
        ToggleNoclip()
        task.wait()
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if not Char:FindFirstChild("HumanoidRootPart") then return end
    if _G.IncludeNoclip then
        Char.HumanoidRootPart.CanCollide = not isEnabled
        Char.Collision.CanCollide = not isEnabled
    end

    local HrpCFrame = Char.HumanoidRootPart.CFrame

    local ray = Ray.new(HrpCFrame.Position, HrpCFrame.LookVector * 0.5)
    local part = workspace:FindPartOnRay(ray)
    if part and part.CanCollide == true and isEnabled then
        Char.HumanoidRootPart.Anchored = true
        Char:PivotTo(Char.HumanoidRootPart.CFrame * CFrame.new(0, 1000, 0))
        task.wait()
        Char:PivotTo(Char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -4))
        task.wait()
        Char:PivotTo(Char.HumanoidRootPart.CFrame * CFrame.new(0, -1000, 0))
        task.wait(0.1)
        Char.HumanoidRootPart.Anchored = false
    end
end)


client:AddToggle('Toggle WalkSpeed', {
    Text = 'Toggle Walk Speed',
    Default = false, -- Default value (true / false)
    Tooltip = 'toggle speed', -- Information shown when you hover over the toggle

    Callback = function(Value)
        flags.ChangeSpeed = Value
    end
})

client:AddSlider('WalkSpeed', {
    Text = 'WalkSpeed',
    Default = 16,
    Min = 14,
    Max = 21,
    Rounding = 1,
    Compact = false,

    Callback = function(Value)

    end
})

--FULL BRIGHT STUFF

_G.Ambient=game:GetService("Lighting").Ambient
_G.OutdoorAmbient = game:GetService("Lighting").OutdoorAmbient
_G.Brightness = game:GetService("Lighting").Brightness
_G.FogStart = game:GetService("Lighting").FogStart
_G.FogEnd = game:GetService("Lighting").FogEnd

local fullbrightThing = nil

client:AddToggle('fullBright',{
    Text = 'Full Bright',
    default = false,
    Tooltip = 'Gives Full Bright',
    Callback = function(Value)
        flags.Fullbright=Value
        if flags.Fullbright==true then

            fullbrightThing=game["Run Service"].RenderStepped:Connect(function ()
                game:GetService("Lighting").Ambient = Color3.new(0,0,0)
                game:GetService("Lighting").OutdoorAmbient=Color3.new(1,1,1)
                game:GetService("Lighting").Brightness = 1
                game:GetService("Lighting").GlobalShadows=false
                game:GetService("Lighting").FogStart = 9999999
                game:GetService("Lighting").FogEnd = 9999999

            end)

        elseif flags.Fullbright==false then
            fullbrightThing:Disconnect()
            fullbrightThing = nil
            game:GetService("Lighting").Ambient = _G.Ambient
            game:GetService("Lighting").OutdoorAmbient = _G.OutdoorAmbient
            game:GetService("Lighting").Brightness = _G.Brightness
            game:GetService("Lighting").FogStart = _G.FogStart
            game:GetService("Lighting").GlobalShadows=true
            game:GetService("Lighting").FogEnd = _G.FogEnd
        end
    end
})

client:AddToggle('InstantInteract',{
    Text = 'Instant Interact',
    default = false,
    Tooltip = 'Disables HoldDaration for ProximityPrompts',
    Callback = function(Value)
        flags.InstantInteract=Value
    end
})
client:AddToggle('NoInteractDelay',{
    Text = 'No Interact Delay',
    default = false,
    Tooltip = 'Disables The Delay for most ProximityPrompts',
    Callback = function(Value)
        flags.NoInteractDelay=Value
    end
})

client:AddToggle('NoClip',{
    Text = 'NOCLIP (N)',
    default = false,
    Tooltip = 'noclips with a keybind',
    Callback = function(Value)
        setNoClip(Value)
    end
})

local deddd = nil
client:AddToggle('Fly',{
    Text = 'Fly (R)',
    default = false,
    Tooltip = 'Fly with a keybind',
    Callback = function(Value)
        if Value==true then
            local dedd = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid").Died:Connect(function ()
                bodyGyro = Instance.new("BodyGyro")
                bodyVel = Instance.new("BodyVelocity") 
            end) 
        else
            if dedd then
                dedd:Disconnect() 
                dedd = nil
            end
        end
        setFlying(Value)
    end
})

client:AddToggle('HidingReach',{
    Text = 'Hiding Reach',
    default = false,
    Tooltip = 'Hide from a further distance',
    Callback = function(Value)
        flags.HidingReach = Value
    end
})

client:AddToggle('A100NoLocks',{
    Text = 'A-100 no locks or skelton key',
    default = false,
    Tooltip = 'removes',
    Callback = function(Value)
        flags.A100NoLocks = Value
    end
})

-- client:AddToggle('HidingExitingFix',{
--     Text = 'Hiding/Exiting Fix',
--     default = false,
--     Tooltip = 'instant hide/exit',
--     Callback = function(Value)
--         flags.HidingExitFix=Value
--         -- if Value==true then
--         -- end
--     end
-- })

game:GetService("ProximityPromptService").PromptTriggered:Connect(function (prompt) 
    if flags.HidingExitFix==true then
        if prompt.Name=="HidePrompt" then
            wait(0.1)
            local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            
            -- repeat
            --     for i,v in ipairs(humanoid:GetPlayingAnimationTracks()) do
            --         v:Stop()
            --         -- print("AHHAHA")
            --     end
            --     wait()
            -- until #humanoid:GetPlayingAnimationTracks()==1

        end
    end

    if flags.NoInteractDelay==true then 
        wait(0.07)
        prompt.Enabled=true
    end
end)




entityBypasses:AddToggle('AntiScreach', {
    Text = 'Bypass Screach',
    Default = false, -- Default value (true / false)
    Tooltip = 'Bypass Screach', -- Information shown when you hover over the toggle

    Callback = function(Value)
        if Value==true then
            game.StarterGui.MainUI.Initiator.Main_Game.RemoteListener.Modules.Screech.Parent=game.ReplicatedStorage
            game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules.Screech.Parent=game.ReplicatedStorage
        elseif Value==false then
            game.ReplicatedStorage:FindFirstChild("Screech").Parent = game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules
            game.ReplicatedStorage:FindFirstChild("Screech").Parent = game.StarterGui.MainUI.Initiator.Main_Game.RemoteListener.Modules
        end
    end
})


entityBypasses:AddToggle('AntiEyes', {
    Text = "No Eyes Damage",
    Default = false, -- Default value (true / false)
    Tooltip = 'Bypass Eyes', -- Information shown when you hover over the toggle

    Callback = function(Value)
        flags.noeyesdamage = Value
    end
})

entityBypasses:AddToggle('AntiDupe', {
    Text = "Disable Dupe",
    Default = false, -- Default value (true / false)
    Tooltip = 'Bypass Dupe', -- Information shown when you hover over the toggle

    Callback = function(Value)
        flags.AntiDupe = Value
    end
})

entityBypasses:AddToggle('DisableChase', {
	Text = "Disable Seek chase",
	Default = false,
    Tooltip = 'Bypass Seek (CLIENT)',
	Callback = function(val)
		flags.noseek = val

		if val then
			local addconnect
			addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
				local trigger = room:WaitForChild("TriggerEventCollision",2)
                seekchaseRoom = room.Name
				if trigger then
					trigger.Parent = game.ReplicatedStorage
				end
			end)

			repeat task.wait() until not (flags.noseek or game.Workspace.CurrentRooms:FindFirstChild(seekchaseRoom))
            if game.ReplicatedStorage:FindFirstChild("TriggerEventCollision") then
                if game.Workspace.CurrentRooms:FindFirstChild(seekchaseRoom) then
                    game.ReplicatedStorage:FindFirstChild("TriggerEventCollision").Parent=game.Workspace.CurrentRooms:FindFirstChild(seekchaseRoom)
                else
                    game.ReplicatedStorage:FindFirstChild("TriggerEventCollision"):Destroy()
                end
            end
			addconnect:Disconnect()
		end
	end
})

entityBypasses:AddToggle('AntiHalt', {
    Text = "Bypass Halt",
    Default = false, -- Default value (true / false)
    Tooltip = 'Bypass Halt', -- Information shown when you hover over the toggle

    Callback = function(Value)
        flags.AntiHalt = Value
        if Value == true then 
            game:GetService("ReplicatedStorage").ClientModules.EntityModules:FindFirstChild("Shade").Parent = game:GetService("ReplicatedStorage").ClientModules
        else 
            game:GetService("ReplicatedStorage").ClientModules:FindFirstChild("Shade").Parent = game:GetService("ReplicatedStorage").ClientModules.EntityModules
        end
    end
})

entityBypasses:AddToggle('AntiGlitch', {
    Text = "Bypass Glitch",
    Default = false, -- Default value (true / false)
    Tooltip = 'Bypass Glitch', -- Information shown when you hover over the toggle

    Callback = function(Value)
        flags.AntiGlitch = Value
        if Value == true then 
            game:GetService("ReplicatedStorage").ClientModules.EntityModules:FindFirstChild("Glitch").Parent = game:GetService("ReplicatedStorage").ClientModules
        else 
            game:GetService("ReplicatedStorage").ClientModules:FindFirstChild("Glitch").Parent = game:GetService("ReplicatedStorage").ClientModules.EntityModules
        end
    end
})

entityBypasses:AddToggle('AntiVoid', {
    Text = "Bypass Void",
    Default = false, -- Default value (true / false)
    Tooltip = 'Bypass Void', -- Information shown when you hover over the toggle

    Callback = function(Value)
        flags.AntiVoid = Value
        if Value == true then 
            game:GetService("ReplicatedStorage").ClientModules.EntityModules:FindFirstChild("Void").Parent = game:GetService("ReplicatedStorage").ClientModules
        else 
            game:GetService("ReplicatedStorage").ClientModules:FindFirstChild("Void").Parent = game:GetService("ReplicatedStorage").ClientModules.EntityModules
        end
    end
})




--antiseekarms
entityBypasses:AddToggle('antiseekarms', {
    Text = "Delete Seek Arms",
    Default = false, -- Default value (true / false)
    Tooltip = 'Bypass Seek', -- Information shown when you hover over the toggle

    Callback = function(Value)
        flags.antiseekarms = Value
    end
})


--game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Death
local GuidingLightSkipHolder = nil
entityBypasses:AddToggle('GuidingLightSkip', {
    Text = "Skip Guiding Light Message",
    Default = false, -- Default value (true / false)
    Tooltip = 'Bypass Guiding Light', -- Information shown when you hover over the toggle

    Callback = function(Value)
        
        flags.GuidingLightSkip = Value
        if Value then 
            GuidingLightSkipHolder = game["Run Service"].RenderStepped:Connect(function ()
                if game:GetService("Players").LocalPlayer.Character.Humanoid.Health==0 then 
                    game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Death.Visible=false
                
                    --UDim2.new(UDim.new(0.5, 0),UDim.new(0.430000007, 0))
                    --game:GetService("Players").LocalPlayer.PlayerGui.MainUI.DeathPanel Statistics = {0.5, 0}, {0.430000007, 0}
                    game:GetService("Players").LocalPlayer.PlayerGui.MainUI.DeathPanel.Position = UDim2.new(UDim.new(0.5, 0),UDim.new(0.430000007, 0))
                    game:GetService("Players").LocalPlayer.PlayerGui.MainUI.DeathPanel.Visible=true
    
                    --UDim2.new(UDim.new(0.5, 0),UDim.new(0.119999997, 0))
                    --game:GetService("Players").LocalPlayer.PlayerGui.MainUI.DeathPanelDead HodlerRevive = {0.5, 0}, {0.119999997, 0}
                    game:GetService("Players").LocalPlayer.PlayerGui.MainUI.DeathPanelDead.Position = UDim2.new(UDim.new(0.5, 0),UDim.new(0.119999997, 0))
                    game:GetService("Players").LocalPlayer.PlayerGui.MainUI.DeathPanelDead.Visible=true
                    --UDim2.new(UDim.new(0.5, 0),UDim.new(0.800000012, 0))
                    --game:GetService("Players").LocalPlayer.PlayerGui.MainUI.HodlerRevive DeathPanelDead =  {0.5, 0}, {0.800000012, 0}
                    game:GetService("Players").LocalPlayer.PlayerGui.MainUI.HodlerRevive.Position = UDim2.new(UDim.new(0.5, 0),UDim.new(0.800000012, 0))
                    game:GetService("Players").LocalPlayer.PlayerGui.MainUI.HodlerRevive.Visible=true
                    --UDim2.new(UDim.new(0.5, 0),UDim.new(0.930000007, 0))
                    --game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Statistics DeathPanel = {0.5, 0}, {0.930000007, 0}
                    game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Statistics.Position = UDim2.new(UDim.new(0.5, 0),UDim.new(0.930000007, 0))
                    game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Statistics.Visible=true
                else 
                    game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Death.Visible=false
                
                    --UDim2.new(UDim.new(0.5, 0),UDim.new(0.430000007, 0))
                    --game:GetService("Players").LocalPlayer.PlayerGui.MainUI.DeathPanel Statistics = {0.5, 0}, {0.430000007, 0}
                    -- game:GetService("Players").LocalPlayer.PlayerGui.MainUI.DeathPanel.Position = UDim2.new(UDim.new(0.5, 0),UDim.new(0.430000007, 0))
                    game:GetService("Players").LocalPlayer.PlayerGui.MainUI.DeathPanel.Visible=false
    
                    --UDim2.new(UDim.new(0.5, 0),UDim.new(0.119999997, 0))
                    --game:GetService("Players").LocalPlayer.PlayerGui.MainUI.DeathPanelDead HodlerRevive = {0.5, 0}, {0.119999997, 0}
                    -- game:GetService("Players").LocalPlayer.PlayerGui.MainUI.DeathPanelDead.Position = UDim2.new(UDim.new(0.5, 0),UDim.new(0.119999997, 0))
                    game:GetService("Players").LocalPlayer.PlayerGui.MainUI.DeathPanelDead.Visible=false
                    --UDim2.new(UDim.new(0.5, 0),UDim.new(0.800000012, 0))
                    --game:GetService("Players").LocalPlayer.PlayerGui.MainUI.HodlerRevive DeathPanelDead =  {0.5, 0}, {0.800000012, 0}
                    -- game:GetService("Players").LocalPlayer.PlayerGui.MainUI.HodlerRevive.Position = UDim2.new(UDim.new(0.5, 0),UDim.new(0.800000012, 0))
                    game:GetService("Players").LocalPlayer.PlayerGui.MainUI.HodlerRevive.Visible=false
                    --UDim2.new(UDim.new(0.5, 0),UDim.new(0.930000007, 0))
                    --game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Statistics DeathPanel = {0.5, 0}, {0.930000007, 0}
                    -- game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Statistics.Position = UDim2.new(UDim.new(0.5, 0),UDim.new(0.930000007, 0))
                    game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Statistics.Visible=false
                end
            end)
        else 
            GuidingLightSkipHolder:Disconnect()
            GuidingLightSkipHolder=nil
        end
    end
})

local JumppySkip = nil
entityBypasses:AddToggle('JumpScareSkip', {
    Text = "Skip All JumpScares ",
    Default = false, -- Default value (true / false)
    Tooltip = 'Bypass JumpScares', -- Information shown when you hover over the toggle

    Callback = function(Value)
        flags.JumpScareSkip = Value
        if Value==true then 
            JumppySkip = game["Run Service"].RenderStepped:Connect(function ()
                game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Jumpscare.Jumpscare_A90.Visible= false
                game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Jumpscare.Jumpscare_Ambush.Visible=false
                game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Jumpscare.Jumpscare_Rush.Visible=false
                game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Jumpscare.Jumpscare_Seek.Visible=false
                game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Jumpscare.Goblino.Visible=false
                game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Jumpscare.Skeleton.Visible=false
            end)
        else 
            JumppySkip:Disconnect()
            JumppySkip=nil
        end

    end
})

if ishardmode==true then
    entityBypasses:AddLabel('---SUPER HARD MODE---')
    entityBypasses:AddToggle('AntiBanana', {
        Text = 'Bypass Banana',
        Default = false, -- Default value (true / false)
        Tooltip = 'Bypass Banana', -- Information shown when you hover over the toggle
    
        Callback = function(Value)
            flags.BananaBypass = Value
            if flags.BananaBypass then
                removebannathing=game["Run Service"].RenderStepped:Connect(function ()
                    for x,i in pairs(game.Workspace:GetChildren())do
                        if i.Name=="BananaPeel"then
                            -- i.Position=game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(0,5,0)
                            -- i:FindFirstChild("TouchInterest").Parent = nil
                            Debris:AddItem(i:FindFirstChild("TouchInterest"), 0.01)
                        end
                    end
                end)
            else
                removebannathing:Disconnect()
                removebannathing = nil
            end
        
        end
    })
    entityBypasses:AddToggle('AntiJeff', {
        Text = 'No jeff Damage',
        Default = false, -- Default value (true / false)
        Tooltip = 'Bypass jeff', -- Information shown when you hover over the toggle
    
        Callback = function(Value)
            flags.noJeffDamage = Value
            if Value==true then
                removeJeffThing=game["Run Service"].RenderStepped:Connect(function ()
                    for x,i in pairs(game.Workspace:GetChildren()) do 
                        if i.Name=="JeffTheKiller" then 
                            for xx,ii in pairs(i:GetChildren()) do 
                                if ii:FindFirstChild("TouchInterest") then 
                                    Debris:AddItem(ii:FindFirstChild("TouchInterest"), 0.01)
                                end 
                            end
                        end 
                    end
                end)
            else
                removeJeffThing:Disconnect()
                removeJeffThing = nil
            end
        end
    })
end

game["Run Service"].RenderStepped:Connect(function(dealta) 
    if flags.ChangeSpeed==true then
        if game.Players.LocalPlayer.Character then
            if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid") then
                game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed=Options.WalkSpeed.Value
            end
        end
    end 
end)

game.Workspace.ChildAdded:Connect(function (child) 
    -- if flags.BananaBypass==true then
    --     if child.Name=="BananaPeel" then 
    --         for x,i in pairs(game.Workspace:GetChildren()) do 
    --             if i.Name=="BananaPeel" then 
    --                 if i:FindFirstChild("TouchInterest") then
    --                     i:FindFirstChild("TouchInterest").Parent=nil 
    --                 end
    --             end 
    --         end
    --     end 
    -- end
    task.spawn(function()
        if child.Name:gsub("Moving","") == "Eyes" then
            if flags.noeyesdamage == true then
                eyesspawned = true
                local con = game:GetService("RunService").RenderStepped:Connect(function()
                    eyesspawned = true
                    local legrot = 0
                    local bodypitch = 85 -- legit -65
                    local bodyrot = 0
                    game:GetService("ReplicatedStorage").EntityInfo.MotorReplication:FireServer(legrot, bodypitch, bodyrot, false)
                end)
                child.Destroying:Wait()
                con:Disconnect()
                eyesspawned = false
            end
            elseif child.Name:gsub("Moving","") == "Rush" then
                print("RUSHING DOT")
                -- if game.Workspace:FindFirstChild("RushMoving"):FindFirstChild("RushNew").CFrame.Position.Y~=-10000 then 
                    EspManager:AddEsp(game.Workspace:FindFirstChild("RushMoving"),Color3.fromRGB(255,0,0),"Rush", false)
                -- end
            elseif child.Name:gsub("Moving","") == "Ambush" then
                print("AmbushING DOT")
                -- if game.Workspace:FindFirstChild("AmbushMoving"):FindFirstChild("RushNew").CFrame.Position.Y~=-10000 then 
                    EspManager:AddEsp(game.Workspace:FindFirstChild("AmbushMoving"),Color3.fromRGB(255,20,0),"Ambush",false)
                -- end
            elseif child.Name:gsub("Moving","") == "Seek" then 
                EspManager:AddEsp(game.Workspace:FindFirstChild("SeekMoving"):FindFirstChild("SeekRig"),Color3.fromRGB(255,0,0),"Seek",false)
            end
                
    end)
end)

task.spawn(function() 
    local theroom =  workspace.CurrentRooms:FindFirstChild(tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)) 
    for x,IE in pairs(theroom:GetDescendants()) do
        if IE.Name == "KeyObtain" then 
            EspManager:AddEsp(IE,Color3.new(1,1,1),"KeyObtain")
        end
    end
end)

workspace.CurrentRooms.ChildAdded:Connect(function(room) 
        --local theroom =  workspace.CurrentRooms:FindFirstChild(tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)) 
        for x,theroom in pairs(workspace.CurrentRooms:GetChildren()) do 
            for x, IE in pairs(theroom:GetDescendants()) do
                if IE.Name == "KeyObtain" and IE:IsA("Model") then 
                    EspManager:AddEsp(IE,Color3.new(1,1,1),"KeyObtain"..tostring(theroom.Name))
                end
                if IE.Name == "LeverForGate" and IE:IsA("Model") then  
                    EspManager:AddEsp(IE,Color3.new(1,1,1),"Lever ".. tostring(tonumber(IE.Parent.Parent.Name)+1) )
                end
                if IE.Name == "Flashlight" and IE:IsA("Model") then
                    EspManager:AddEsp(IE,Color3.new(1,1,1),"FlashLight")
                end
                if IE.Name=="Battery" and IE:IsA("Model") then
                    EspManager:AddEsp(IE,Color3.new(1,1,1),"Battery")
                end
                if IE.Name=="Candle" and IE:IsA("Model") then 
                    EspManager:AddEsp(IE,Color3.new(1,1,1),"Candle")
                end
                if IE.Name=="Lighter" and IE:IsA("Model") then 
                    EspManager:AddEsp(IE,Color3.new(1,1,1),"Lighter")
                end
                if IE.Name=="Lockpick" and IE:IsA("Model") then 
                    EspManager:AddEsp(IE,Color3.new(1,1,1),"Lockpick")
                end
                if IE.Name=="Vitamins" and IE:IsA("Model") then 
                    EspManager:AddEsp(IE,Color3.new(1,1,1),"Vitamins")
                end
                if IE.Name == "CrucifixOnTheWall"  and IE:IsA("Model") then 
                    EspManager:AddEsp(IE,Color3.new(1,1,1),"Crucifix")
                end
                if IE.Name=="LiveHintBook" and IE:IsA("Model") then 
                    EspManager:AddEsp(IE,Color3.new(1,1,1),"Libary Hint Book")
                end
                if IE.Name=="PickupItem" and IE:IsA("Model") then 
                    EspManager:AddEsp(IE,Color3.new(1,1,1),"Libary Paper")
                end
                    
            
        
                if IE.Name=="Wardrobe" then 
                    if flags.HidingReach == true then 
                        if IE:FindFirstChildWhichIsA("ProximityPrompt") then 
                            IE:FindFirstChildWhichIsA("ProximityPrompt").MaxActivationDistance = 18.5 
                        end
                    end
                elseif IE.Name=="Bed" then
                    if flags.HidingReach == true then 
                        if IE:FindFirstChildWhichIsA("ProximityPrompt") then 
                            IE:FindFirstChildWhichIsA("ProximityPrompt").MaxActivationDistance = 18.5 
                        end
                    end
                end

            end
        end
    
        if flags.A100NoLocks == true then 
            --A_1000 NO LOCKPICKS OR SKELTON KEY !!!!!!!!!!!!!!!!!!!!!!!!!!!!!! MAKE IT
            if workspace.CurrentRooms:FindFirstChild("60") then 
                repeat
                    wait(2)
                    workspace.CurrentRooms["60"].RoomsDoor_Entrance.Door.EnterPrompt.Enabled = true
                    workspace.CurrentRooms["60"].RoomsDoor_Entrance.SkullLock.SkullPrompt.Enabled = false
                until not workspace.CurrentRooms:FindFirstChild("60")
    
            end 
            
        end
        --Seek_Arm
        task.spawn(function() 
            wait(0.1)
            local theroom =  workspace.CurrentRooms[game:GetService("ReplicatedStorage").GameData.LatestRoom.Value]
            if theroom:FindFirstChild("Assets"):FindFirstChild("Seek_Arm") then
                if flags.antiseekarms==true then
                    local thing = game:GetService("RunService").RenderStepped:Connect(function() 
                        for x,i in pairs(room:GetChildren())do 
                            if i.Name == "Seek_Arm" then 
                                Debris:AddItem(i,0.01)
                            end
                        end
                    end)
                    wait(20)
                    thing:Disconnect()
                end
            elseif theroom==50 or room == 100 then 
                    local figuresetup = room:WaitForChild("FigureSetup")
    
                    if figuresetup then
                        local fig = figuresetup:WaitForChild("FigureRagdoll")
                        task.wait(0.1)
                        EspManager:AddEsp(fig,Color3.fromRGB(255,25,25),"Figure")
                    end 
            end
        end)
    
    
        -- print("new ROOM: "..room.Name)
        -- print("well anti dupe = ".. tostring(flags.AntiDupe))
        for xx,ii in pairs(game.Workspace.CurrentRooms:GetChildren()) do 
            for x,i in pairs(ii:GetChildren()) do 
                -- print("ASSET"..i.Name)
                -- print("new ROOM: "..room.Name)
                if flags.AntiDupe == true then 
                    -- print("well anti dupe")
                    if i.Name=="Closet" then
                        -- print("LOAD DELETE hahhahha")
                        if i:FindFirstChild("DoorFake") then
                            Debris:AddItem(i:FindFirstChild("DoorFake").Hidden:FindFirstChild("TouchInterest"), 0.01)
                            print("L BOSO DUPE/SUBSPACE TRIPMINE")
                        end        
                    end
                end
            end
        end
    
end)


game:GetService("ProximityPromptService").PromptShown:Connect(function (Prompt)
    if Prompt.Parent.Name=="KeyObtainFake" then
        Prompt.Enabled=false
        Prompt.HoldDuration=999
    end
    if flags.InstantInteract==true then
        if Prompt.Parent.Name~="KeyObtainFake" then
            Prompt.HoldDuration=0
        end
    end
end)

SaveManager:SetLibrary(Library)

SaveManager:BuildConfigSection(Tabs['configs'])

SaveManager:LoadAutoloadConfig()


game:GetService("UserInputService").InputBegan:Connect(handleFlyKey)
game:GetService("ContextActionService"):BindAction("forward", handleMovementBind, false, Enum.PlayerActions.CharacterForward)
game:GetService("ContextActionService"):BindAction("backward", handleMovementBind, false, Enum.PlayerActions.CharacterBackward)
game:GetService("ContextActionService"):BindAction("left", handleMovementBind, false, Enum.PlayerActions.CharacterLeft)
game:GetService("ContextActionService"):BindAction("right", handleMovementBind, false, Enum.PlayerActions.CharacterRight)
game:GetService("RunService").RenderStepped:Connect(updateFlying)