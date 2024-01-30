local server = game.ServerStorage.Server
local r_server = server:Clone();

r_server.Parent = game.ReplicatedStorage

server.AttributeChanged:Connect(function(attribute)
	r_server:SetAttribute(attribute, server:GetAttribute(attribute))
end)

-- set attributes since we can't do that in Rojo
server:SetAttribute("in_game", false);
server:SetAttribute("next_gamemode", "None");
server:SetAttribute("next_map", "None");
server:SetAttribute("status", "waiting");
server:SetAttribute("version", "v0.0.0");
server:SetAttribute("waiting", false);

server.CurrentGame.AttributeChanged:Connect(function(attribute)
	r_server.CurrentGame:SetAttribute(attribute, server.CurrentGame:GetAttribute(attribute))
end)