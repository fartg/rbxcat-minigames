local Events = game.ReplicatedStorage.Events.Game;

local edit_player = require(game.ServerStorage.rbxcat.Modules.Functions.EditPlayer);
local edit_server = require(game.ServerStorage.rbxcat.Modules.Functions.EditServer);

Events.EndGame.Event:Connect(function(winners_table)
	edit_server.Game("active", false);
	
	if winners_table ~= nil then
		Events.RewardWinners:Fire(winners_table);
	end
end)

Events.RewardWinners.Event:Connect(function(winners_table: {Player})
	for _, player in pairs(winners_table) do
		edit_player.Stats(player, "wins", edit_player.Return(player, "Stats", "wins") + 1);
		game.ReplicatedStorage.Events.Client.SystemMessage:FireAllClients(player.DisplayName .. " won!", "system");
		task.wait(.25)
		game.ReplicatedStorage.Events.Client.SystemMessage:FireClient(player, "you win a bunch of coins or something. congrats i think", "info");
	end
end)