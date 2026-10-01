# Roblox One Piece Starter Game

This repository is a simple Roblox starter project inspired by anime pirate adventure games. It includes:
- a basic island map
- enemy NPCs
- sword combat with attack range and cooldown
- health UI and simple stats

## What to do in Roblox Studio

1. Create a new place in Roblox Studio.
2. Copy the scripts from the `src/` folder into the matching Roblox services:
   - `src/ServerScriptService/IslandBuilder.server.lua` -> ServerScriptService
   - `src/ServerScriptService/EnemySpawner.server.lua` -> ServerScriptService
   - `src/ServerScriptService/Main.server.lua` -> ServerScriptService
   - `src/StarterPlayer/StarterPlayerScripts/CombatClient.client.lua` -> StarterPlayer > StarterPlayerScripts
   - `src/ReplicatedStorage/Modules/CombatConfig.lua` -> ReplicatedStorage > Modules
3. Press Play to test.
4. Use WASD to move and click or press F to attack.

## Game features

- Simple 3D island arena
- Player health and UI
- Enemy chase + attack behavior
- Basic combat with cooldowns
- Bounty / score reward on enemy defeat

## Notes

This is intentionally simple and meant to be used as a starting point. You can expand it later with:
- sword slash effects
- quests
- multiple islands
- devil fruit abilities
- NPC boss fights
- inventory and shops

## Important

This repository does not include the full Roblox Studio project file. Instead, it contains the Lua scripts and folder structure that you can paste into your Roblox game.
