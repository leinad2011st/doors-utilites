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
--add instant interact
--add noclip and fly scripts
--maybe freecam

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
                    EVENT:FireServer()
                end
            end)
        elseif Value==false then 
            figurething:Disconnect()
            figurething = nil
        end
    end
})


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

client:AddToggle('HidingExitingFix',{
    Text = 'Hiding/Exiting Fix',
    default = false,
    Tooltip = 'instant hide/exit',
    Callback = function(Value)
        flags.HidingExitFix=Value
        -- if Value==true then
        -- end
    end
})

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
    for x,i in ipairs(room:GetChildren()) do 
        if flags.AntiDupe == true then 
            if i.Name=="Closet" then
                if i:FindFirstChild("DoorFake") then
                    Debris:AddItem(i:FindFirstChild("DoorFake"):FindFirstChild("TouchInterest"), 0.01)
                end        
            end
        end
    end
end)