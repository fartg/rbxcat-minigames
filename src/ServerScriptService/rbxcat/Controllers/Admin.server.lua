local events = game.ReplicatedStorage.Events.Admin;
local Admin = require(game.ServerStorage.rbxcat.Modules.Info.Admin);

events.CheckAdmin.OnServerInvoke = function(player)
	return Admin.Check(player);
end

events.IsAdmin.OnServerInvoke = function(fired_player, player)
	return Admin.Check(player);
end

events.SkipMinigame.OnServerEvent:Connect(function (fired_player)
	if not Admin.Check(fired_player) then return end;
	edit_server.Game("active", false);
end)