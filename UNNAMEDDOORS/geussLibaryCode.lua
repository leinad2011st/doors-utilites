local LibaryCodeGeusser = {}

function LibaryCodeGeusser () 
    for x = 0,99999 do 
        if tostring(x):len() == 5 then 
            wait()
            game:GetService("ReplicatedStorage").EntityInfo.PL:FireServer(tostring(x))
        else 
        
        end
    end
   
end


getgenv().LibaryCodeGeusser = LibaryCodeGeusser