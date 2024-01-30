local edit = {}

local function Edit(index, value, dir)
	local Folder = game.ServerStorage:WaitForChild("Server");
	
	if dir == nil then
		Folder:SetAttribute(index, value)
		return
	end
	
	Folder:WaitForChild(dir):SetAttribute(index, value);
end

edit.Self = function(index, value)
	Edit(index, value, nil);
end

edit.Game = function(index, value)
	Edit(index, value, "CurrentGame")
end

edit.Return = function(index, dir)
	local Folder = game.ServerStorage:WaitForChild("Server");

	if dir == nil then
		return Folder:GetAttribute(index)
	end
	
	return Folder:WaitForChild(dir):GetAttribute(index)
end

return edit