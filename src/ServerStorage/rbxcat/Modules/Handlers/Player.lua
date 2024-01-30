local player = {}

local edit_player = require(game.ServerStorage.rbxcat.Modules.Functions.EditPlayer);
local game_info = require(game.ServerStorage.rbxcat.Modules.Info.Game).Info;

player.TeleportToSpawns = function(player, spawns)
	local spawn_children = spawns:GetChildren();

	local random_spawn = math.random(#spawn_children);

	local selected_spawn = spawns[random_spawn];

	player.Character:PivotTo(selected_spawn:GetPivot());
end

player.ClearGameStats = function(player)
	local _player = game.ServerStorage.Players:FindFirstChild(player.UserId);
	
	for i, v in pairs(_player.PerGame:GetAttributes()) do
		edit_player.PerGame(player, i, nil);
	end
end

player.CreateGameStats = function(player, gamemode)
	for i, v in pairs(gamemode.vars) do
		edit_player.PerGame(player, i, v);
	end
end

return player
