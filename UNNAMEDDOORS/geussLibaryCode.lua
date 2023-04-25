
local LibaryCodeGeusser = {}

function startGeussing (LibaryCodeLength) 
    task.spawn(function()  
        for x = 0,99999 do 
            wait()
            local howmuch = LibaryCodeLength - tostring(x):len()
            local geuss = tostring(x)..tostring(math.pow(10,3+1)):sub(2,howmuch+1)
            print(geuss)
            game:GetService("ReplicatedStorage").EntityInfo.PL:FireServer(tostring(geuss))
    end
end)
task.spawn(function()  
    for x = 99999,0,-1 do 
        wait()
            local howmuch = LibaryCodeLengthc - tostring(x):len()
            local geuss = tostring(x)..tostring(math.pow(10,3+1)):sub(2,howmuch+1)
            print(geuss)
            game:GetService("ReplicatedStorage").EntityInfo.PL:FireServer(tostring(geuss))
    end
end)
task.spawn(function()  
    for x = 49999,0,-1 do 
        wait()
            local howmuch = 5 - tostring(x):len()
            local geuss = tostring(x)..tostring(math.pow(10,3+1)):sub(2,howmuch+1)
            print(geuss)
            game:GetService("ReplicatedStorage").EntityInfo.PL:FireServer(tostring(geuss))
    end
end)
task.spawn(function()  
    for x = 49999,0,-1 do 
        wait()
            local howmuch = 5 - tostring(x):len()
            local geuss = tostring(x)..tostring(math.pow(10,3+1)):sub(2,howmuch+1)
            print(geuss)
            game:GetService("ReplicatedStorage").EntityInfo.PL:FireServer(tostring(geuss))
    end
end)
task.spawn(function()  
    for x = 24999,99999,1 do 
        wait()
            local howmuch = 5 - tostring(x):len()
            local geuss = tostring(x)..tostring(math.pow(10,3+1)):sub(2,howmuch+1)
            print(geuss)
            game:GetService("ReplicatedStorage").EntityInfo.PL:FireServer(tostring(geuss))
    end
end)
    for x = 24999,0,-1 do 
        wait()
            local howmuch = 5 - tostring(x):len()
            local geuss = tostring(x)..tostring(math.pow(10,3+1)):sub(2,howmuch+1)
            print(geuss)
            game:GetService("ReplicatedStorage").EntityInfo.PL:FireServer(tostring(geuss))
    end
end


function LibaryCodeGeusser:Geuss(LibaryCodeLength) 
    task.spawn(function() 
        startGeussing(LibaryCodeLength)
    end) 
    task.spawn(function() 
        startGeussing(LibaryCodeLength)
    end) 
   
end

getgenv().LibaryCodeGeusser = LibaryCodeGeusser