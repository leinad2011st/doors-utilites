local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

if game.PlaceId ~= 6839171747 and game.PlaceId ~= 6516141723 then 
    print("Not in doors")
    return
end

--ADD YOUR KEY BIND SCRIPT INTO THIS
--ethier buttons or key bind settings tab


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

local eyesspawned = false
local seekchaseRoom = 0


local client = Tabs.Main:AddLeftGroupbox('client')
local entityBypasses = Tabs.Main:AddLeftGroupbox('entityBypasses')


client:AddToggle('Toggle WalkSpeed', {
    Text = 'Toggle Walk Speed',
    Default = false, -- Default value (true / false)
    Tooltip = 'toggle speed', -- Information shown when you hover over the toggle

    Callback = function(Value)
        print('[cb] MyToggle changed to:', Value)
        flags.ChangeSpeed = not flags.ChangeSpeed
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

client:AddToggle('fullBright',{
    Text = 'Full Bright',
    default = false,
    Tooltip = 'gives full bright',
    Callback = function(Value)
        if not _G.FullBrightExecuted then

            _G.FullBrightEnabled = false
        
            _G.NormalLightingSettings = {
                Brightness = game:GetService("Lighting").Brightness,
                ClockTime = game:GetService("Lighting").ClockTime,
                FogEnd = game:GetService("Lighting").FogEnd,
                GlobalShadows = game:GetService("Lighting").GlobalShadows,
                Ambient = game:GetService("Lighting").Ambient
            }
        
            game:GetService("Lighting"):GetPropertyChangedSignal("Brightness"):Connect(function()
                if game:GetService("Lighting").Brightness ~= 1 and game:GetService("Lighting").Brightness ~= _G.NormalLightingSettings.Brightness then
                    _G.NormalLightingSettings.Brightness = game:GetService("Lighting").Brightness
                    if not _G.FullBrightEnabled then
                        repeat
                            wait()
                        until _G.FullBrightEnabled
                    end
                    game:GetService("Lighting").Brightness = 1
                end
            end)
        
            game:GetService("Lighting"):GetPropertyChangedSignal("ClockTime"):Connect(function()
                if game:GetService("Lighting").ClockTime ~= 12 and game:GetService("Lighting").ClockTime ~= _G.NormalLightingSettings.ClockTime then
                    _G.NormalLightingSettings.ClockTime = game:GetService("Lighting").ClockTime
                    if not _G.FullBrightEnabled then
                        repeat
                            wait()
                        until _G.FullBrightEnabled
                    end
                    game:GetService("Lighting").ClockTime = 12
                end
            end)
        
            game:GetService("Lighting"):GetPropertyChangedSignal("FogEnd"):Connect(function()
                if game:GetService("Lighting").FogEnd ~= 786543 and game:GetService("Lighting").FogEnd ~= _G.NormalLightingSettings.FogEnd then
                    _G.NormalLightingSettings.FogEnd = game:GetService("Lighting").FogEnd
                    if not _G.FullBrightEnabled then
                        repeat
                            wait()
                        until _G.FullBrightEnabled
                    end
                    game:GetService("Lighting").FogEnd = 786543
                end
            end)
        
            game:GetService("Lighting"):GetPropertyChangedSignal("GlobalShadows"):Connect(function()
                if game:GetService("Lighting").GlobalShadows ~= false and game:GetService("Lighting").GlobalShadows ~= _G.NormalLightingSettings.GlobalShadows then
                    _G.NormalLightingSettings.GlobalShadows = game:GetService("Lighting").GlobalShadows
                    if not _G.FullBrightEnabled then
                        repeat
                            wait()
                        until _G.FullBrightEnabled
                    end
                    game:GetService("Lighting").GlobalShadows = false
                end
            end)
        
            game:GetService("Lighting"):GetPropertyChangedSignal("Ambient"):Connect(function()
                if game:GetService("Lighting").Ambient ~= Color3.fromRGB(178, 178, 178) and game:GetService("Lighting").Ambient ~= _G.NormalLightingSettings.Ambient then
                    _G.NormalLightingSettings.Ambient = game:GetService("Lighting").Ambient
                    if not _G.FullBrightEnabled then
                        repeat
                            wait()
                        until _G.FullBrightEnabled
                    end
                    game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)
                end
            end)
        
            game:GetService("Lighting").Brightness = 1
            game:GetService("Lighting").ClockTime = 12
            game:GetService("Lighting").FogEnd = 786543
            game:GetService("Lighting").GlobalShadows = false
            game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)
        
            local LatestValue = true
            spawn(function()
                repeat
                    wait()
                until _G.FullBrightEnabled
                while wait() do
                    if _G.FullBrightEnabled ~= LatestValue then
                        if not _G.FullBrightEnabled then
                            game:GetService("Lighting").Brightness = _G.NormalLightingSettings.Brightness
                            game:GetService("Lighting").ClockTime = _G.NormalLightingSettings.ClockTime
                            game:GetService("Lighting").FogEnd = _G.NormalLightingSettings.FogEnd
                            game:GetService("Lighting").GlobalShadows = _G.NormalLightingSettings.GlobalShadows
                            game:GetService("Lighting").Ambient = _G.NormalLightingSettings.Ambient
                        else
                            game:GetService("Lighting").Brightness = 1
                            game:GetService("Lighting").ClockTime = 12
                            game:GetService("Lighting").FogEnd = 786543
                            game:GetService("Lighting").GlobalShadows = false
                            game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)
                        end
                        LatestValue = not LatestValue
                    end
                end
            end)
        end
        
        _G.FullBrightExecuted = true
        _G.FullBrightEnabled = not _G.FullBrightEnabled
    end
})

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
            if Value==true then
                for x,i in pairs(game.Workspace:GetChildren()) do 
                    if i.Name=="BananaPeel" then 
                        i:FindFirstChild("TouchInterest"):Destroy() 
                    end 
                end
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
                for x,i in pairs(game.Workspace:GetChildren()) do 
                    if i.Name=="JeffTheKiller" then 
                        for xx,ii in pairs(i:GetChildren()) do 
                            if ii:FindFirstChild("TouchInterest") then 
                                ii:FindFirstChild("TouchInterest"):Destroy() 
                            end 
                        end
                        i:FindFirstChild("TouchInterest"):Destroy() 
                    end 
                end
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
    if flags.noJeffDamage==true then
        if child.Name=="JeffTheKiller" then 
            for x,i in pairs(game.Workspace:GetChildren()) do 
                if i.Name=="JeffTheKiller" then 
                    for xx,ii in pairs(i:GetChildren()) do 
                        if ii:FindFirstChild("TouchInterest") then 
                            ii:FindFirstChild("TouchInterest"):Destroy() 
                        end 
                    end
                    i:FindFirstChild("TouchInterest"):Destroy() 
                end 
            end
        end 
    end
    if flags.BananaBypass==true then
        if child.Name=="BananaPeel" then 
            for x,i in pairs(game.Workspace:GetChildren()) do 
                if i.Name=="BananaPeel" then 
                    i:FindFirstChild("TouchInterest"):Destroy() 
                end 
            end
        end 
    end
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
                inst.Destroying:Wait()
                con:Disconnect()
                eyesspawned = false
            end
        end
    end)
end)