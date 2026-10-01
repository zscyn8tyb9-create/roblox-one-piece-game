# Roblox One Piece Starter Game

This repo is a more advanced Roblox pirate starter project inspired by anime adventure games.

## Features

- Large island map with ocean and trees
- Player health, stamina, and movement tuning
- Basic sword combat and dash movement
- Enemy AI and boss fights
- Devil Fruit pickups and power boosts
- Quest board and island quest progression
- Overpowered owner/admin commands

## Included systems

- Devil Fruits: Fire, Storm, Ice, Lightning, Quake
- Bosses: Sand Warlord, Thunder Beast, Sea Demon
- Quests: speak to the island quest board to complete objectives and earn bounty
- Admin powers: heal, god mode, max stats, summon bosses, kill all enemies, teleport, set bounty, power boosts

## Roblox Studio setup

1. Open Roblox Studio and create a new Baseplate game.
2. Place the scripts into the matching folders:
   - `src/ServerScriptService/GameBootstrap.server.lua` -> ServerScriptService
   - `src/ServerScriptService/OwnerCommands.server.lua` -> ServerScriptService
   - `src/ReplicatedStorage/Modules/CombatConfig.lua` -> ReplicatedStorage > Modules
   - `src/ReplicatedStorage/Modules/WorldBuilder.lua` -> ReplicatedStorage > Modules
   - `src/StarterPlayer/StarterPlayerScripts/CombatClient.client.lua` -> StarterPlayer > StarterPlayerScripts
   - `src/StarterPlayer/StarterPlayerScripts/AdminClient.client.lua` -> StarterPlayer > StarterPlayerScripts
3. Press Play.

## Commands

Use the command input in the game or the admin UI. Owner-only commands include:

- `/heal`
- `/god 30`
- `/max`
- `/tp x y z`
- `/bounty 5000`
- `/level 25`
- `/spawnboss`
- `/killall`
- `/spawnfruit fire`
- `/setfruit lightning`
- `/speed 80`
- `/superjump`
- `/fly`
- `/reset`

Examples:

- `/tp 0 20 50`
- `/setfruit quake`
- `/spawnboss`
- `/killall`

## Notes

This is a starter prototype and a good foundation for a larger one-piece-inspired game. It is designed to be expanded with:

- sword combos
- move sets
- quests with NPC dialogue
- more islands
- shops and inventory
- boss arena progression
- actual animation systems

