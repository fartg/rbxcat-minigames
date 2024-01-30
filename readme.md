<h1 align="center"> rbxcat-minigames: A basic minigames engine built on rbxcat </h1>

![image](https://github.com/fartg/rbxcat-minigames/assets/70608092/1617529b-9acc-4be7-8d10-b701ed072b2a)

This is a simple, example game with an included pre-built .rbxl file made to be an advanced intro course into rbxcat development!

It's playable at [this link.](https://www.roblox.com/games/16172741119/rbxcat-minigames) (hosted by my wonderful friend Leah.)

The game loop, and everything involved with it, can be viewed at [src/ServerScriptService/Main.server.lua](https://github.com/fartg/rbxcat-minigames/blob/main/src/ServerScriptService/Main.server.lua).

<h1 align="center"> Disclaimer </h1>

I highly suggest using the included [.rbxl file](https://github.com/fartg/rbxcat-minigames/releases/) as it includes a gui with included scripts showing you how to listen to the game and its status.

<h1 align="center"> How to build (with the power of Rojo) </h1>

```bash
rojo build -o "rbxcat-obby.rbxlx"
```

Next, open `rbxcat-obby.rbxlx` in Roblox Studio and start the Rojo server:

```bash
rojo serve
```

<h1 align="center"> Information </h1>

built with [rbxcat](https://github.com/fartg/rbxcat)

compatible with [rbxcat-server](https://github.com/lostmedia/rbxcat-server)
