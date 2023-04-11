local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()



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

game["Run Service"].RenderStepped:Connect(function(dealta) 
    if flags.ChangeSpeed==true then
        if game.Players.LocalPlayer.Character then
            if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid") then
                game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed=Options.WalkSpeed.Value
            end
        end
    end

    if flags.BananaBypass then
        
    end
    
end)

game.Workspace.ChildAdded:Connect(function (child) 
    if flags.BananaBypass then
        if child.Name=="BananaPeel" then 
            child:FindFirstChild("TouchInterest"):Destroy()  
        end 
    end
end)