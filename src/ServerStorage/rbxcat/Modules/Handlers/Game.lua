local _game = {}

local TweenService = game:GetService("TweenService");

local game_info = require(game.ServerStorage.rbxcat.Modules.Info.Game).Info;
local edit_player = require(game.ServerStorage.rbxcat.Modules.Functions.EditPlayer);

-- because lua doesn't like string keys in arrays, here's this
local createModes = function()
	local keys = {};
	for k in pairs(game_info.Gamemodes) do
		table.insert(keys, k)
	end
	return keys
end

local createMaps = function()
	local keys = {};
	for k in pairs(game_info.Maps) do
		table.insert(keys, k)
	end
	return keys
end


_game.GetActivePlayers = function()
	local active_players = {};
	
	for _, player in pairs(game.Players:GetPlayers()) do
		if edit_player.Return(player, "Settings", "playing") and not edit_player.Return(player, nil, "afk") then
			table.insert(active_players, player);
		end
	end
	
	return active_players;
end

_game.GetAlivePlayers = function()
	local alive_players = {};
	
	for _, player in pairs(game.Players:GetPlayers()) do
		if edit_player.Return(player, nil, "alive") then
			table.insert(alive_players, player);
		end
	end

	return alive_players;
end

_game.RandomGamemode = function()
	local modes = createModes();
	
	local selected_gamemode = game_info.Gamemodes[modes[math.random(1, #modes)]];
	
	return selected_gamemode;
end

_game.LoadGamemode = function(gamemode)
	local gamemode_instance = gamemode:Clone();
	gamemode_instance.Parent = game.ServerScriptService.rbxcat.CurrentGame;
end

_game.CleanupGamemode = function(gamemode)
	local gamemode_instance = game.ServerScriptService.rbxcat.CurrentGame:FindFirstChild(gamemode.Name);
	gamemode_instance:Destroy();
end

_game.RandomMap = function(gamemode)
	local maps = createMaps();
	
	local selected_map = game_info.Maps[maps[math.random(1, #maps)]]

while table.find(gamemode.compatible, selected_map.id) == nil do
		selected_map = game_info.Maps[maps[math.random(1, #maps)]]
	end
	
	return selected_map;
end

_game.LoadMap = function(map)
	for _, part in pairs(map:GetChildren()) do
		local coro = coroutine.create(function()
			TweenService:Create(part, TweenInfo.new(1), {Transparency = 0}):Play();
			part.CanCollide = true;
		end)
		
		local succ, res = coroutine.resume(coro);
	end
	
	local objects_folder = Instance.new("Folder"); objects_folder.Parent = map.Parent; objects_folder.Name = "Objects";
end

_game.CleanupMap = function(map)
	map.Parent:FindFirstChild("Objects"):Destroy()
	
	for _, part in pairs(map:GetChildren()) do
		TweenService:Create(part, TweenInfo.new(1), {Transparency = 1}):Play();
		part.CanCollide = false;
	end
end

_game.CheckCompatible = function(gamemode, map)
	if table.find(gamemode.compatible, map.id) ~= nil then return true end;
	return false;
end

return _game
