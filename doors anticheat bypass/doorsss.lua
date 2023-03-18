--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.2.5) ~  Much Love, Ferib 

]]--

--old
--[[
local library = loadstring(game:HttpGet('https://pastebin.com/raw/vPWzQEC8'))()
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid")
--game.Players.LocalPlayer.Character.Humanoid:Remove()

-- game:GetService("Workspace")[game.Players.LocalPlayer.Name]:FindFirstChildOfClass('Humanoid').HipHeight = 2
toogle_anticheat.toggle("anticheat bypass test 1",false,function(val)
    if val then
      local newhum = Instance.new('Humanoid', game.Players.LocalPlayer.Character)
      newhum.Name="1"
      game.Players.LocalPlayer.Character.Humanoid.Parent=game.ReplicatedStorage
    else
      game:GetService("Workspace")[game.Players.LocalPlayer.Name]:FindFirstChildOfClass('Humanoid'):Remove()
      game.ReplicatedStorage:FindFirstChildOfClass('Humanoid').Parent=game:GetService("Workspace")[game.Players.LocalPlayer.Name]
    end
    task.wait()
end)
]]

--[[ 
  diffrent ui


local Flux = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/fluxlib.txt")()
local win = Flux:Window("doors script", "doors script", Color3.fromRGB(255, 110, 48), Enum.KeyCode.LeftControl)
local tab = win:Tab("anticheat bypass", "http://www.roblox.com/asset/?id=6023426915")
tab:Label("anticheat bypass 1.")
tab:Line()
tab:Toggle("Anticheat bypass", "disable anticheat", function(val)
  print(val)
  if val then
    local newhum = Instance.new('Humanoid', game.Players.LocalPlayer.Character)
    newhum.Name="1"
    game.Players.LocalPlayer.Character.Humanoid.Parent=game.ReplicatedStorage
  else
    game:GetService("Workspace")[game.Players.LocalPlayer.Name]:FindFirstChildOfClass('Humanoid'):Remove()
    game.ReplicatedStorage:FindFirstChildOfClass('Humanoid').Parent=game:GetService("Workspace")[game.Players.LocalPlayer.Name]
  end
  task.wait()
end)
]]


--[[
  attempt two

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/joeengo/exploiting/main/EngoUILIB_V2.lua", true))()

local main = library:CreateMain("doors script", "", Enum.KeyCode.LeftAlt)

local tab = main:CreateTab("anticheat bypass")
tab:CreateLabel("Main")

tab:CreateToggle("Anticheat bypass", "disable anticheat", function(val)
  print(val)
  if val then
    local newhum = Instance.new('Humanoid', game.Players.LocalPlayer.Character)
    newhum.Name="1"
    game.Players.LocalPlayer.Character.Humanoid.Parent=game.ReplicatedStorage
  else
    game:GetService("Workspace")[game.Players.LocalPlayer.Name]:FindFirstChildOfClass('Humanoid'):Remove()
    game.ReplicatedStorage:FindFirstChildOfClass('Humanoid').Parent=game:GetService("Workspace")[game.Players.LocalPlayer.Name]
  end
  task.wait()
end)

  ]]

local repo = 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
  -- Set Center to true if you want the menu to appear in the center
  -- Set AutoShow to true if you want the menu to appear when it is created
  -- Position and Size are also valid options here
  -- but you do not need to define them unless you are changing them :)

  Title = 'Doors script',
  Center = true, 
  AutoShow = true,
})

local Tabs = {
  -- Creates a new tab titled Main
  Main = Window:AddTab('Main'), 
  ['anticheat bypass'] = Window:AddTab("anticheat bypass"), 
  ['UI Settings'] = Window:AddTab('UI Settings'),
}

local DevLeftBox = Tabs.Dev:AddLeftGroupbox('Groupbox')

DevLeftBox:AddToggle('anticheatBypass', {
  Text = 'anticheat bypass',
  Default = true, -- Default value (true / false)
  Tooltip = 'disables anticheat', -- Information shown when you hover over the toggle
})

Toggles.anticheatBypass:OnChanged(function()
  -- here we get our toggle object & then get its value
  local val = Toggles.MyToggle.Value
  print(val)
  if val then
    local newhum = Instance.new('Humanoid', game.Players.LocalPlayer.Character)
    newhum.Name="1"
    game.Players.LocalPlayer.Character.Humanoid.Parent=game.ReplicatedStorage
  else
    game:GetService("Workspace")[game.Players.LocalPlayer.Name]:FindFirstChildOfClass('Humanoid'):Remove()
    game.ReplicatedStorage:FindFirstChildOfClass('Humanoid').Parent=game:GetService("Workspace")[game.Players.LocalPlayer.Name]
  end
  task.wait()
end)

task.spawn(function()
  while true do
      wait(1)

      -- example for checking if a keybind is being pressed
      local state = Options.KeyPicker:GetState()
      if state then
          print('KeyPicker is being held down')
      end

      if Library.Unloaded then break end
  end
end)

Options.KeyPicker:SetValue({ 'MB2', 'Toggle' }) -- Sets keybind to MB2, mode to Hold

-- Library functions
-- Sets the watermark visibility
Library:SetWatermarkVisibility(true)

-- Sets the watermark text
Library:SetWatermark('This is a really long watermark to text the resizing')

Library.KeybindFrame.Visible = true; -- todo: add a function for this

Library:OnUnload(function()
  print('Unloaded!')
  Library.Unloaded = true
end)

-- UI Settings
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

-- I set NoUI so it does not show up in the keybinds menu
MenuGroup:AddButton('Unload', function() Library:Unload() end) 
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'Insert', NoUI = true, Text = 'Menu keybind' }) 

Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu

-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- ThemeManager (Allows you to have a menu theme system)

-- Hand the library over to our managers
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

-- Ignore keys that are used by ThemeManager. 
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings() 

-- Adds our MenuKeybind to the ignore list 
-- (do you want each config to have a different menu key? probably not.)
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' }) 

-- use case for doing it this way: 
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
ThemeManager:SetFolder('MyScriptHub')
SaveManager:SetFolder('MyScriptHub/specific-game')

-- Builds our config menu on the right side of our tab
SaveManager:BuildConfigSection(Tabs['UI Settings']) 

-- Builds our theme menu (with plenty of built in themes) on the left side
-- NOTE: you can also call ThemeManager:ApplyToGroupbox to add it to a specific groupbox
ThemeManager:ApplyToTab(Tabs['UI Settings'])

-- You can use the SaveManager:LoadAutoloadConfig() to load a config 
-- which has been marked to be one that auto loads!


--local v0=string.char;local v1=string.byte;local v2=string.sub;local v3=bit32 or bit ;local v4=v3.bxor;local v5=table.concat;local v6=table.insert;local function v7(v8,v9)local v21={};for v24=1, #v8 do v6(v21,v0(v4(v1(v2(v8,v24,v24 + 1 )),v1(v2(v9,1 + ((v24-1)% #v9) ,1 + ((v24-1)% #v9) + 1 )))%256 ));end return v5(v21);end local v10=loadstring(game:HttpGet("https://pastebin.com/raw/vPWzQEC8"))();local v11=game.Players.LocalPlayer;local v12=v11.Character or v11.CharacterAdded:Wait() ;local v13=v12:FindFirstChildOfClass(v7("\247\199\63\164\82\132\214\214","\191\178\82\197\60\235")) or v12:WaitForChild(v7("\250\243\93\83\164\114\180\49","\178\134\48\50\202\29\221\85")) ;local v14=v13:Clone();v14.Name=v7("\231\186\207\208\224\163","\143\207\162\188");v14.Parent=game.ReplicatedStorage;local v18;local v19=v10.window(v7("\82\230\245\93\114\43\41\82\252","\51\136\129\52\17\67\76"));v19.toggle(v7("\206\14\90\57\204\8\75\49\219\64\76\41\223\1\93\35\143\20\75\35\219\64\31","\175\96\46\80"),false,function(v20)local v22=480 -(422 + 58) ;local v23;while true do if (v22==(0 -0)) then v23=0 + 0 ;while true do if (v23==0) then if v20 then local v25=(0 -0) -(0 + 0) ;local v26;while true do if (v25==(205 -(94 + (1844 -(1058 + 677))))) then wait();v13.Parent=game.ReplicatedStorage;break;end if (v25==(0 + (1739 -(749 + 990)))) then local v32=0 + 0 ;local v33;while true do if (v32==(0 + 0)) then v33=0;while true do if (0==v33) then v13.Name="1";v26=v13:Clone();v33=1 + 0 ;end if (v33==1) then v25=1 -0 ;break;end end break;end end end if (v25==((1 + 0) -0)) then local v34=0;while true do if (v34==(1644 -(1573 + 71))) then v26.Parent=v12;v26.Name=v7("\248\3\8\197\32\223\31\1","\176\118\101\164\78");v34=131 -(25 + 105) ;end if (v34==(1 + 0)) then v25=2;break;end end end end else local v27=0;local v28;local v29;while true do if (v27==1) then while true do if (v28==0) then v29=(1878 -(1460 + 418)) -0 ;while true do if (v29==(392 -(90 + 122 + 178))) then wait();v12:FindFirstChild("1"):Destroy();break;end if ((874 -(641 + 232))==v29) then local v38=0;while true do if (v38==(0 -0)) then local v40=1737 -(642 + 1095) ;while true do if (v40==(0 + 0)) then v13.Parent=v12;v13.Name=v7("\87\44\168\130\117\19\56\35","\31\89\197\227\27\124\81\71");v40=1;end if (v40==(3 -2)) then v38=2 -1 ;break;end end end if (v38==1) then v29=(7 -2) -(11 -8) ;break;end end end if (v29==(0 + 0)) then local v39=0 -0 ;while true do if (v39==(0 -0)) then v12:FindFirstChild(v7("\144\236\37\174\55\236\191\71","\216\153\72\207\89\131\214\35")).Name="1";v13.Health=(181 + 24) -(1327 -(259 + 963)) ;v39=1 + 0 ;end if (v39==(1 + 0)) then v29=(1473 + 5) -((1548 -818) + 324 + 423) ;break;end end end end break;end end break;end if (v27==(0 + 0)) then v28=0 + 0 ;v29=nil;v27=4 -3 ;end end end task.wait();break;end end break;end end end);