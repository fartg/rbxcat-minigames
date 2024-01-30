local _game = {}

_game.Info = {
	["Maps"] = {
		["Map1"] = {
			id = "map1",
			display = "Map1",
			instance = game.Workspace.Maps.map1.Map;
			spawns = game.Workspace.Maps.map1.Spawns;
		},
		["Map2"] = {
			id = "map2",
			display = "Map2",
			instance = game.Workspace.Maps.map2.Map;
			spawns = game.Workspace.Maps.map2.Spawns;
		}
	},
	["Gamemodes"] = {
		["ball_fall"] = {
			display = "ball fall!",
			id = "ball_fall",
			mode = "survival",
			_time = 30,
			instance = game.ServerStorage.Storage.Gamemodes.ball_fall,
			compatible = {"map1"},
			vars = {
				["points"] = 0,
			},
		},
		["lava_fall"] = {
			display = "lava fall!",
			id = "lava_fall",
			mode = "survival",
			_time = 30,
			instance = game.ServerStorage.Storage.Gamemodes.lava_fall,
			compatible = {"map2"},
			vars = {},
		}
	},
}

return _game
