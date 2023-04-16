local EspManager = {}

local GlobalESPFolder = game.CoreGui:FindFirstChild("ESPFolder")

if GlobalESPFolder == nil then
	GlobalESPFolder = Instance.new("Folder", game.CoreGui)
	GlobalESPFolder.Name = "ESPFolder"
end


local Items = {
	Key = "KeyObtain"
}

EspManager.AddEsp = function (Item,color,Text) 
	if table.find(Item.Name) then
		local highlight = Instance.new("Highlight",Item)
		highlight.Adornee = Item
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.FillColor = Color3.new(0.337255, 0.337255, 0.337255)
		highlight.OutlineColor = color
		--TRACER
		bill = Instance.new("BillboardGui", esp_folder)
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
end

return EspManager
