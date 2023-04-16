local EspManager = {}

local GlobalESPFolder = game.CoreGui:FindFirstChild("ESPFolder")

if GlobalESPFolder == nil then
	GlobalESPFolder = Instance.new("Folder", game.CoreGui)
	GlobalESPFolder.Name = "ESPFolder"
end


local Items = {
	Key = "KeyObtain"
}

module.AddEsp = function (Item,color) 
	if table.find(Item.Name) then
		local highlight = Instance.new("Highlight",Item)
		highlight.Adornee = Item
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.FillColor = Color3.new(0.337255, 0.337255, 0.337255)
		highlight.OutlineColor = color
	end
end

return EspManager
