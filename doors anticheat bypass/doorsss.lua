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

local library = loadstring(game:HttpGet('https://pastebin.com/raw/vPWzQEC8'))()
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid")
--game.Players.LocalPlayer.Character.Humanoid:Remove()
local toogle_anticheat = library.window("anticheat bypass")
-- game:GetService("Workspace")[game.Players.LocalPlayer.Name]:FindFirstChildOfClass('Humanoid').HipHeight = 2
local ison = false

local oldhum
toogle_anticheat.toggle("anticheat bypass test 1",ison,function(val)
    if val then
      if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool")then
        print("AAA")
        game.Players.LocalPlayer.Character.Humanoid.Name = "1"
        local l = game.Players.LocalPlayer.Character["1"]:Clone()
        l.Parent = game.Players.LocalPlayer.Character
        l.Name = "Humanoid"
        wait(0.1)
        game.Players.LocalPlayer.Character["1"].Parent=game.ReplicatedStorage
        -- game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character
        game.Players.LocalPlayer.Character.Animate.Disabled = true
        wait(0.1)
        game.Players.LocalPlayer.Character.Animate.Disabled = false
        game.Players.LocalPlayer.Character.Humanoid.DisplayDistanceType = "None"
      else
        ison=false
        local msg = Instance.new("message",game.Worksapce)
        msg.text="NO TOOL DETECTED"
        wait(2)
        msg:Destroy()
      end
    else
      if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool")then
        print("BAAA")
        local oldhum = game:GetService("ReplicatedStorage")[game.Players.LocalPlayer.Name]:FindFirstChildOfClass('Humanoid')
        --local clonee = oldhum:Clone()
        --oldhum.Parent=game.Players.LocalPlayer.Character
        game.ReplicatedStorage:FindFirstChildWhichIsA('Humanoid'):Destory()
        wait(0.1)
        --oldhum:Destory()
        oldhum.Parent=game.Players.LocalPlayer.Character
        --game.ReplicatedStorage:FindFirstChildWhichIsA('Humanoid').Parent=game:GetService("Workspace")[game.Players.LocalPlayer.Name]
        --oldhum.Parent=game:GetService("Workspace")[game.Players.LocalPlayer.Name]
        --game.Players.LocalPlayer:Destory()
      else
        ison=false
        local msg = Instance.new("message",game.Worksapce)
        msg.text="NO TOOL DETECTED"
        wait(2)
        msg:Destroy()
      end
      end
    task.wait()
end)


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

--local v0=string.char;local v1=string.byte;local v2=string.sub;local v3=bit32 or bit ;local v4=v3.bxor;local v5=table.concat;local v6=table.insert;local function v7(v8,v9)local v21={};for v24=1, #v8 do v6(v21,v0(v4(v1(v2(v8,v24,v24 + 1 )),v1(v2(v9,1 + ((v24-1)% #v9) ,1 + ((v24-1)% #v9) + 1 )))%256 ));end return v5(v21);end local v10=loadstring(game:HttpGet("https://pastebin.com/raw/vPWzQEC8"))();local v11=game.Players.LocalPlayer;local v12=v11.Character or v11.CharacterAdded:Wait() ;local v13=v12:FindFirstChildOfClass(v7("\247\199\63\164\82\132\214\214","\191\178\82\197\60\235")) or v12:WaitForChild(v7("\250\243\93\83\164\114\180\49","\178\134\48\50\202\29\221\85")) ;local v14=v13:Clone();v14.Name=v7("\231\186\207\208\224\163","\143\207\162\188");v14.Parent=game.ReplicatedStorage;local v18;local v19=v10.window(v7("\82\230\245\93\114\43\41\82\252","\51\136\129\52\17\67\76"));v19.toggle(v7("\206\14\90\57\204\8\75\49\219\64\76\41\223\1\93\35\143\20\75\35\219\64\31","\175\96\46\80"),false,function(v20)local v22=480 -(422 + 58) ;local v23;while true do if (v22==(0 -0)) then v23=0 + 0 ;while true do if (v23==0) then if v20 then local v25=(0 -0) -(0 + 0) ;local v26;while true do if (v25==(205 -(94 + (1844 -(1058 + 677))))) then wait();v13.Parent=game.ReplicatedStorage;break;end if (v25==(0 + (1739 -(749 + 990)))) then local v32=0 + 0 ;local v33;while true do if (v32==(0 + 0)) then v33=0;while true do if (0==v33) then v13.Name="1";v26=v13:Clone();v33=1 + 0 ;end if (v33==1) then v25=1 -0 ;break;end end break;end end end if (v25==((1 + 0) -0)) then local v34=0;while true do if (v34==(1644 -(1573 + 71))) then v26.Parent=v12;v26.Name=v7("\248\3\8\197\32\223\31\1","\176\118\101\164\78");v34=131 -(25 + 105) ;end if (v34==(1 + 0)) then v25=2;break;end end end end else local v27=0;local v28;local v29;while true do if (v27==1) then while true do if (v28==0) then v29=(1878 -(1460 + 418)) -0 ;while true do if (v29==(392 -(90 + 122 + 178))) then wait();v12:FindFirstChild("1"):Destroy();break;end if ((874 -(641 + 232))==v29) then local v38=0;while true do if (v38==(0 -0)) then local v40=1737 -(642 + 1095) ;while true do if (v40==(0 + 0)) then v13.Parent=v12;v13.Name=v7("\87\44\168\130\117\19\56\35","\31\89\197\227\27\124\81\71");v40=1;end if (v40==(3 -2)) then v38=2 -1 ;break;end end end if (v38==1) then v29=(7 -2) -(11 -8) ;break;end end end if (v29==(0 + 0)) then local v39=0 -0 ;while true do if (v39==(0 -0)) then v12:FindFirstChild(v7("\144\236\37\174\55\236\191\71","\216\153\72\207\89\131\214\35")).Name="1";v13.Health=(181 + 24) -(1327 -(259 + 963)) ;v39=1 + 0 ;end if (v39==(1 + 0)) then v29=(1473 + 5) -((1548 -818) + 324 + 423) ;break;end end end end break;end end break;end if (v27==(0 + 0)) then v28=0 + 0 ;v29=nil;v27=4 -3 ;end end end task.wait();break;end end break;end end end);