
local library = loadstring(game:HttpGet('https://pastebin.com/raw/vPWzQEC8'))()
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid")
local newhum = hum:Clone()
newhum.Name = "humlol"
newhum.Parent = game.ReplicatedStorage
local newhuma
local toogle_anticheat = library.window("anticheat")

toogle_anticheat.toggle("anticheat bypass test 1",false,function(val)
    if val then
		hum.Name = "1"
		local newHum = hum:Clone()
		newHum.Parent = char
		newHum.Name = "Humanoid"
		wait()
		hum.Parent=game.ReplicatedStorage
    else
        char:FindFirstChild("Humanoid").Name="1"
        hum.Health=100
        hum.Parent=char
        hum.Name = "Humanoid"
        wait()
        char:FindFirstChild("1"):Destroy()
        --newhum.Parent=game.ReplicatedStorage
    end
    task.wait()
end)