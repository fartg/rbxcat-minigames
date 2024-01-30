local config = require(game.ServerStorage.rbxcat.Config);

local player_handler = require(game.ServerStorage.rbxcat.Modules.Handlers.Player);
local _game = require(game.ServerStorage.rbxcat.Modules.Handlers.Game);
local _game_info = require(game.ServerStorage.rbxcat.Modules.Info.Game).Info;
local edit_server = require(game.ServerStorage.rbxcat.Modules.Functions.EditServer);
local edit_player = require(game.ServerStorage.rbxcat.Modules.Functions.EditPlayer);

local _spawn = game.Workspace.Spawn;

local maps = _game_info.Maps;
local gamemodes = _game_info.Gamemodes;

edit_server.Self("in_game", false);

while true do
	task.wait(5);
	
	while not edit_server.Return("in_game") do
		edit_server.Self("status", "intermission");

		task.wait(config.intermission);

		if #_game.GetActivePlayers() < config.minimum_players then -- if there's less than minimum_players, we wait
			edit_server.Self("waiting", true);
			edit_server.Self("status", "waiting");
			repeat task.wait() until #_game.GetActivePlayers() >= config.minimum_players
			task.wait(5)
		end

		-- set waiting to false
		edit_server.Self("waiting", false);
		

		-- select map and gamemode
		local next_gamemode = _game.RandomGamemode();
		local next_map = _game.RandomMap(next_gamemode);

		-- handle purchasable map/gamemode
		if edit_server.Return("next_gamemode") ~= "None" then 
			next_gamemode = gamemodes[edit_server.Return("next_gamemode")]; 
			
		end
		
		if edit_server.Return("next_map") ~= "None" then
			if _game.CheckCompatible(next_gamemode, edit_server.Return("next_map")) then
				next_map = maps[edit_server.Return("next_map")];
			end

			-- this will trigger if the selected next map isn't compatible with the current gamemode
			next_map = _game.RandomMap(next_gamemode);
		end

		--load our map
		_game.LoadMap(next_map.instance);
		
		-- set attributes
		edit_server.Game("map", next_map.display);
		edit_server.Game("map_id", next_map.id);
		edit_server.Game("gamemode", next_gamemode.display);
		edit_server.Game("gamemode_id", next_gamemode.id);
		edit_server.Game("time", next_gamemode._time);
		edit_server.Game("mode", next_gamemode.mode);
		edit_server.Self("status", "loading");

		-- wait 5 seconds and begin gamemode
		task.wait(5);

		-- grab current active players and teleport them to spawns on current map
		local active_players = _game.GetActivePlayers();

		for _, player in pairs(active_players) do
			edit_player.Player(player, "alive", true);
			player_handler.CreateGameStats(player, next_gamemode);
			player_handler.TeleportToSpawns(player, next_map.spawns);
		end
		
		_game.LoadGamemode(next_gamemode.instance);


		-- set listener attributes to true
		edit_server.Self("in_game", true);
		edit_server.Game("active", true);
		edit_server.Self("status", "in_game");

		repeat task.wait() until not edit_server.Return("active", "CurrentGame") or #_game.GetAlivePlayers() == 0;

		-- grab the alive players and teleport them back to spawn
		local alive_players = _game.GetAlivePlayers();

		for _, player in pairs(alive_players) do
			player_handler.TeleportToSpawns(player, _spawn.Spawns)
		end
		
		-- delete the stats for every player
		for _, player in pairs(game.Players:GetPlayers()) do
			if game.ReplicatedStorage.Players:FindFirstChild(player.UserId) then
				player_handler.ClearGameStats(player);
			end
		end

		-- cleanup map & gamemode
		_game.CleanupMap(next_map.instance);
		_game.CleanupGamemode(next_gamemode.instance);

		-- set attributes to default values
		edit_server.Game("map", "None");
		edit_server.Game("display", "None");
		edit_server.Game("time", 0);
		edit_server.Game("mode", "none");
		edit_server.Self("status", "ending");

		-- restart the loop
		edit_server.Self("in_game", false);
	end
end