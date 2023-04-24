local char = game:GetService("Players").LocalPlayer.Character
local plr = game:GetService("Players").LocalPlayer


local Decipher = {}

local function GetCodeInfo () 
--loop through each players

end

function Decipher:DecipherCode () 
    --LINE 2663 https://github.com/mstudio45/poopdoors_edited/blob/117f50c199de457e2142104fec8e4da7618eba27/poopdoors_edited.lua
    local code = {[1]="_",[2]="_",[3]="_",[4]="_",[5]="_"}
    if game.Players.LocalPlayer:FindFirstChild("LibraryHintPaper") then 
        local paper = game.Players.LocalPlayer:FindFirstChild("LibraryHintPaper")
        local hints = plr.PlayerGui:WaitForChild("PermUI"):WaitForChild("Hints")

        if paper then
            for i,v in pairs(paper:WaitForChild("UI"):GetChildren()) do
                if v:IsA("ImageLabel") and v.Name ~= "Image" then
                    for i,img in pairs(hints:GetChildren()) do
                        if img:IsA("ImageLabel") and img.Visible and v.ImageRectOffset == img.ImageRectOffset then
                            local num = img:FindFirstChild("TextLabel").Text
    
                            code[tonumber(v.Name)] = num 
                        end
                    end
                end
            end 
        end
    elseif game.Players.LocalPlayer.Character:FindFirstChild("LibraryHintPaper") then
        local paper = game.Players.LocalPlayer.Character:FindFirstChild("LibraryHintPaper")
        local hints = plr.PlayerGui:WaitForChild("PermUI"):WaitForChild("Hints")
    
        if paper then
            for i,v in pairs(paper:WaitForChild("UI"):GetChildren()) do
                if v:IsA("ImageLabel") and v.Name ~= "Image" then
                    for i,img in pairs(hints:GetChildren()) do
                        if img:IsA("ImageLabel") and img.Visible and v.ImageRectOffset == img.ImageRectOffset then
                            local num = img:FindFirstChild("TextLabel").Text
    
                            code[tonumber(v.Name)] = num 
                        end
                    end
                end
            end 
        end
    elseif #game.Players:GetChildren()>1 then
        for x,plr in pairs(game.Players:GetChildren()) do 
            if plr:FindFirstChild("LibraryHintPaper") then 
                local paper = game.Players.LocalPlayer:FindFirstChild("LibraryHintPaper")
                local hints = plr.PlayerGui:WaitForChild("PermUI"):WaitForChild("Hints")
        
                if paper then
                    for i,v in pairs(paper:WaitForChild("UI"):GetChildren()) do
                        if v:IsA("ImageLabel") and v.Name ~= "Image" then
                            for i,img in pairs(hints:GetChildren()) do
                                if img:IsA("ImageLabel") and img.Visible and v.ImageRectOffset == img.ImageRectOffset then
                                    local num = img:FindFirstChild("TextLabel").Text
            
                                    code[tonumber(v.Name)] = num 
                                end
                            end
                        end
                    end 
                end
            elseif plr.Character:FindFirstChild("LibraryHintPaper") then
                local paper = game.Players.LocalPlayer.Character:FindFirstChild("LibraryHintPaper")
                local hints = plr.PlayerGui:WaitForChild("PermUI"):WaitForChild("Hints")
            
                if paper then
                    for i,v in pairs(paper:WaitForChild("UI"):GetChildren()) do
                        if v:IsA("ImageLabel") and v.Name ~= "Image" then
                            for i,img in pairs(hints:GetChildren()) do
                                if img:IsA("ImageLabel") and img.Visible and v.ImageRectOffset == img.ImageRectOffset then
                                    local num = img:FindFirstChild("TextLabel").Text
                                    code[tonumber(v.Name)] = num 
                                end
                            end
                        end
                    end 
                end
            end
        end
    end 

    return code
end