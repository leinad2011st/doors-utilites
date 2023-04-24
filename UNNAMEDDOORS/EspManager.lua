local EspManager = {}

local GlobalESPFolder = game.CoreGui:FindFirstChild("ESPFolder")

if GlobalESPFolder == nil then
	GlobalESPFolder = Instance.new("Folder", game.CoreGui)
	GlobalESPFolder.Name = "ESPFolder"
end



function EspManager:AddEsp(Item,color,Text, esp) 

    local name = Item.Name

	local highlight





	local esp_folder = GlobalESPFolder:FindFirstChild(name)
	if game.Players:FindFirstChild(name) then
		esp_folder = GlobalESPFolder:FindFirstChild("PlayerESP")
		if not esp_folder then
			esp_folder = Instance.new("Folder")
			esp_folder.Parent = GlobalESPFolder
			esp_folder.Name = "PlayerESP"
		end
	end
	if not esp_folder then
		esp_folder = Instance.new("Folder")
		esp_folder.Parent = GlobalESPFolder
		esp_folder.Name = name
	end
	task.spawn(function() 
		
		for XX,espPP_folder in pairs(GlobalESPFolder:GetChildren()) do 
			local tabel = {}
			for x,i in pairs(espPP_folder:GetChildren()) do 
				if not table.find(tabel,i) then 
					table.insert(tabel,i)
				else 
					i:Destroy()
				end
			end
		end
	end)
	if esp~=false then 
		highlight = Instance.new("Highlight",esp_folder)
		highlight.Adornee = Item
		highlight.Name = "Charms"
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.FillColor = Color3.new(0.337255, 0.337255, 0.337255)
		highlight.OutlineColor = color
		game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.PromptServiceHint.Highlight.AttributeChanged:Connect(function (attr) 
			if attr == "Enabled" then 
				if game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.PromptServiceHint.Highlight.Enabled==true then 
					if game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.PromptServiceHint.Highlight.Adornee == Item then 
						game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.PromptServiceHint.Highlight.AttributeChanged:Wait()
						wait(0.5)
						highlight.Enabled=true
					end 
				end 
			end 
		end)
	end
	
	--TRACER
	local bill = Instance.new("BillboardGui", esp_folder)
	bill.AlwaysOnTop = true
	bill.Size = UDim2.new(0,400,0,100)
	bill.Adornee = Item
	bill.MaxDistance = 2000

	local mid = Instance.new("Frame",bill)
	mid.AnchorPoint = Vector2.new(0.5,0.5)
	mid.BackgroundColor3 = color
	mid.Size = UDim2.new(0,8,0,8)
	mid.Position = UDim2.new(0.5,0,0.5,0)
	Instance.new("UICorner",mid).CornerRadius = UDim.new(1,0)
	Instance.new("UIStroke",mid)

	local txt = Instance.new("TextLabel",bill)
	txt.AnchorPoint = Vector2.new(0.5,0.5)
	txt.BackgroundTransparency = 1
	txt.BackgroundColor3 = color
	txt.TextColor3 = color
	txt.Size = UDim2.new(1,0,0,20)
	txt.Position = UDim2.new(0.5,0,0.7,0)
	txt.Text = Text
	Instance.new("UIStroke",txt)

	task.spawn(function()
		bill.Adornee.Destroying:Connect(function()
			bill.Enabled = false
			bill.Adornee = nil
			--pcall(function() table.remove(boxes, table.find(boxes, bill)) end)
			bill:Destroy() 
		end)
		if esp~=false then 
			if highlight then 
				highlight.Adornee.Destroying:Connect(function() 
					highlight.Enabled=false
					highlight.Adornee = nil
					highlight:Destroy()
				end) 
			end
		end
		while bill do 
			wait(5)
			if not bill.Adornee then
				bill.Enabled = false
				bill.Adornee = nil
				bill:Destroy() 
				if highlight then 
					highlight.Enabled=false
					highlight.Adornee = nil
					highlight:Destroy()
				end
			end
		end
		--while bill do
		--	if bill.Adornee == nil or not bill.Adornee:IsDescendantOf(workspace) then
		--		bill.Enabled = false
		--		bill.Adornee = nil
		--		--pcall(function() table.remove(boxes, table.find(boxes, bill)) end)
		--		bill:Destroy() 
		--	end  
		--	task.wait()
		--end
	end)
        --ADD TRACKERS
        --HERE IS LINK: https://github.com/mstudio45/poopdoors_edited/blob/117f50c199de457e2142104fec8e4da7618eba27/poopdoors_edited.lua#LC637
end

getgenv().EspManager = EspManager