local Events = game.ReplicatedStorage.Events.Game;

local EditServer = require(game.ServerStorage.rbxcat.Modules.Functions.EditServer);
local _game = require(game.ServerStorage.rbxcat.Modules.Handlers.Game);

local server_map = EditServer.Return("map_id", "CurrentGame");
local workspace_map = game.Workspace.Maps:FindFirstChild(server_map);

local test = 0;

while test < 10 do
	wait(1)
	test += 1;	
	print('asdf' .. test);
end

Events.EndGame:Fire(_game.GetAlivePlayers());