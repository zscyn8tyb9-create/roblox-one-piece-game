# Roblox One Piece Starter Game (Advanced Version)

This repo is a more advanced Roblox starter project inspired by anime pirate adventures.

## Included features

- Island map with trees and ocean
- Player health, stamina, and movement
- Combat with attack damage, cooldown, and dash
- Enemy AI that chases and attacks nearby players
- Bounty system using leaderstats
- Admin/owner commands for the game creator
- Client-side UI for combat and admin controls

## Roblox Studio setup

1. Open Roblox Studio.
2. Create a new Baseplate game.
3. Paste these scripts into the matching folders:
   - `src/ServerScriptService/GameBootstrap.server.lua` -> ServerScriptService
   - `src/ServerScriptService/EnemyAI.server.lua` -> ServerScriptService
   - `src/ServerScriptService/OwnerCommands.server.lua` -> ServerScriptService
   - `src/StarterPlayer/StarterPlayerScripts/CombatClient.client.lua` -> StarterPlayer > StarterPlayerScripts
   - `src/StarterPlayer/StarterPlayerScripts/AdminClient.client.lua` -> StarterPlayer > StarterPlayerScripts
   - `src/ReplicatedStorage/Modules/CombatConfig.lua` -> ReplicatedStorage > Modules
4. Press Play.

## Controls

- WASD: Move
- Left Mouse Click or F: Attack
- Shift: Dash
- Q: Skill burst / quick slash

## Owner commands

Open the admin panel in the top-left of the screen and type one of the following commands:

- `/heal` — restores your full health
- `/god` — gives invincibility for 15 seconds
- `/spawnenemy` — creates a new enemy near you
- `/reset` — resets your position and health
- `/tp x y z` — teleports to coordinates
- `/bounty 250` — sets a bounty value

Example:

- `/tp 0 10 50`
- `/bounty 500`

## Notes

This is still a starter project, not a full commercial game. It is designed as a base you can expand with:

- Devil Fruit powers
- quests and NPCs
- multiple islands
- collection and inventory systems
- boss fights
- sword slash effects
- animation systems

This repo is meant to be a clean starting point for your own Roblox pirate game.
