local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()


local Debris = game:GetService("Debris")


if game.PlaceId ~= 6839171747 and game.PlaceId ~= 6516141723 then 
    print("Not in doors")
    return
end

-- --------------------------------------------------------------------------- --

--TO DOOOO
--TO DO




--ADD YOUR KEY BIND SCRIPT INTO THIS
--ethier buttons or key bind settings tab
--add noclip and fly scripts
--maybe freecam
-- DEFFENTILY ADD CONFIG/ unload
--DEBUG ANTI DUPE

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
}


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
                local latesetRoom=game:GetService("ReplicatedStorage").GameData.LatestRoom.Value
                local plusroom = latesetRoom+1
                if plusroom==50 then
                    local Room = game.Workspace.CurrentRooms:FindFirstChild(latesetRoom)
                    local Door=Room:FindFirstChild("Door")
                    local EVENT=Door:FindFirstChild("ClientOpen")
                    repeat
                        game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame= workspace.CurrentRooms["50"].FigureSetup.FigureCamPos.CFrame
                        EVENT:FireServer()
                        wait()
                    until workspace.CurrentRooms:FindFirstChild("51")
                    
                end
            end)
        elseif Value==false then 
            figurething:Disconnect()
            figurething = nil
        end
    end
})

local FigureremoverThing = nil
serverMain:AddToggle('DeleteFigure', {
    Text = 'Delete figure',
    Default = false, -- Default value (true / false)
    Tooltip = 'only works before opening door 50', -- Information shown when you hover over the toggle

    Callback = function(Value)
        print("CALL")
        flags.AntiFigureCutscene = Value
        if Value==true then 
            FigureremoverThing=game["Run Service"].RenderStepped:Connect(function ()
                local latesetRoom=game:GetService("ReplicatedStorage").GameData.LatestRoom.Value
                local Room = game.Workspace.CurrentRooms:FindFirstChild(latesetRoom)
                if latesetRoom==49 then 
                    local ragdollly = workspace.CurrentRooms["50"].FigureSetup.FigureRagdoll.Root
                    local cframe = CFrame.new(ragdollly.Position.X,ragdollly.Position.Y-20,ragdollly.Position.Z)
                    workspace.CurrentRooms["50"].FigureSetup.FigureRagdoll.Root.CFrame=cframe
                end

            end)
        elseif Value==false then 
            FigureremoverThing:Disconnect()
            FigureremoverThing = nil
        end
    end
})


serverMain:AddButton({
    Text = 'Get Banana Gun',
    Func = function()
        loadstring(game:HttpGet(("rbxassetid://13117491090"),true))()
    end,
    DoubleClick = false,
    Tooltip = 'hold longer for more force'
})

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

game:GetService("ProximityPromptService").PromptShown:Connect(function (Prompt)
    if flags.InstantInteract==true then
        if Prompt.Parent.Name~="KeyObtainFake" then
            Prompt.HoldDuration=0
        else
            Prompt.Enabled=false
            Prompt.HoldDuration=999
        end
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

--antiseekarms
entityBypasses:AddToggle('antiseekarms', {
    Text = "Delete Seek Arms",
    Default = false, -- Default value (true / false)
    Tooltip = 'Bypass Seek', -- Information shown when you hover over the toggle

    Callback = function(Value)
        flags.antiseekarms = Value
    end
})


if game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules:FindFirstChild("Greed") then
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
        end
    end)
end)

workspace.CurrentRooms.ChildAdded:Connect(function(room) 
    --Seek_Arm
    task.spawn(function() 
        wait(0.1)
        if room:FindFirstChild("Assets"):FindFirstChild("Seek_Arm") then 
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


game:GetService("UserInputService").InputBegan:Connect(handleFlyKey)
game:GetService("ContextActionService"):BindAction("forward", handleMovementBind, false, Enum.PlayerActions.CharacterForward)
game:GetService("ContextActionService"):BindAction("backward", handleMovementBind, false, Enum.PlayerActions.CharacterBackward)
game:GetService("ContextActionService"):BindAction("left", handleMovementBind, false, Enum.PlayerActions.CharacterLeft)
game:GetService("ContextActionService"):BindAction("right", handleMovementBind, false, Enum.PlayerActions.CharacterRight)
game:GetService("RunService").RenderStepped:Connect(updateFlying)