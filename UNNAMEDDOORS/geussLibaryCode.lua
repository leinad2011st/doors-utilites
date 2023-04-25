
local LibaryCodeGeusser = {}




function LibaryCodeGeusser:Geuss(LibaryCodeLength) 
    for x = 0,99999 do 
            wait()
            local howmuch = LibaryCodeLength - tostring(x):len()
            local geuss = tostring(x)..tostring(math.pow(10,3+1)):sub(2,howmuch+1)
            print(geuss)
            game:GetService("ReplicatedStorage").EntityInfo.PL:FireServer(tostring(geuss))
    end
   
end

getgenv().LibaryCodeGeusser = LibaryCodeGeusser