# Roblox One Piece Starter Game - Studio Ready

This is a complete, production-ready Roblox pirate starter game inspired by One Piece.

## ✅ Verified to work in Roblox Studio

All scripts are tested and ready to use. Just follow the setup steps below.

## Quick Setup (5 minutes)

1. **Open Roblox Studio** and create a new **Baseplate** game
2. **Copy the scripts** from this repo into your game:
   - ServerScriptService scripts
   - ReplicatedStorage modules
   - StarterPlayer scripts
3. **Press Play** and enjoy!

## Setup Steps

### Step 1: Create Folder Structure

1. In **ReplicatedStorage**, create a folder called `Modules`
2. In **ServerScriptService**, keep it as is (default)
3. In **StarterPlayer > StarterPlayerScripts**, keep it as is (default)

### Step 2: Add Scripts to ServerScriptService

1. Right-click **ServerScriptService** → Insert Object → Script
2. Name it `GameBootstrap`
3. Copy the contents of `src/ServerScriptService/GameBootstrap.server.lua` into it
4. Repeat for `OwnerCommandsHandler` (use `src/ServerScriptService/OwnerCommands.server.lua`)

### Step 3: Add Modules to ReplicatedStorage > Modules

1. Right-click **Modules** → Insert Object → ModuleScript
2. Name it `CombatConfig`
3. Copy `src/ReplicatedStorage/Modules/CombatConfig.lua` into it
4. Create another ModuleScript called `WorldBuilder`
5. Copy `src/ReplicatedStorage/Modules/WorldBuilder.lua` into it

### Step 4: Add Client Scripts to StarterPlayer > StarterPlayerScripts

1. Right-click **StarterPlayerScripts** → Insert Object → LocalScript
2. Name it `CombatClient`
3. Copy `src/StarterPlayer/StarterPlayerScripts/CombatClient.client.lua` into it
4. Create another LocalScript called `AdminClient`
5. Copy `src/StarterPlayer/StarterPlayerScripts/AdminClient.client.lua` into it

## 🎮 Controls

- **WASD** - Move around
- **Left Click or F** - Attack
- **Shift** - Dash
- **Q** - Quick attack

## 🛠️ Owner Commands

Type commands in the Admin Panel (top-left of screen):

```
/heal              - Full health
/god 30            - God mode for 30 seconds
/max               - Max stats (9999 HP, 200 speed)
/tp 0 10 50        - Teleport to coordinates
/bounty 5000       - Set bounty value
/level 25          - Set level
/spawnboss         - Spawn a boss near you
/killall           - Kill all enemies and bosses
/spawnfruit fire   - Spawn a devil fruit
/setfruit quake    - Equip a devil fruit (fire, storm, ice, lightning, quake)
/speed 80          - Set walk speed
/superjump         - Super jump for 12 seconds
/fly               - Fly for 12 seconds
/reset             - Reset to spawn
```

## 📋 Features

✅ Island map with trees, sand, water  
✅ Player stats (health, stamina, speed)  
✅ Enemy AI (chase and attack)  
✅ Boss encounters (Storm Titan, Sea Wyrm)  
✅ Devil Fruit system (5 types with buffs)  
✅ Quest board  
✅ Bounty/score system  
✅ Owner admin commands  
✅ Combat UI  
✅ Admin panel with command input  

## ❌ Common Issues & Fixes

### Scripts don't run
- Make sure all scripts are in the **right location** (see Step 2-4)
- Check that **ModuleScripts** are in ReplicatedStorage > Modules
- Restart Roblox Studio if things break

### Errors about missing modules
- Verify that `CombatConfig` and `WorldBuilder` exist in ReplicatedStorage > Modules
- Check the script names match exactly

### Commands don't work
- Make sure you're the game **Creator** (owner)
- Open the Admin Panel in the top-left corner
- Type the command and press Enter or click "Run Command"

### No enemies spawning
- Wait 5 seconds after the game loads
- Check that `GameBootstrap` script is running (no red error icon)
- Look for "Enemies" folder in Workspace

## 🚀 What's Next?

You can expand this with:
- Sword slash effects and animations
- NPC quest givers with dialogue
- Multiple islands to explore
- Weapon/item shops
- Combo attack system
- Boss arena battles
- Persistent progression

## 📝 Notes

- This starter uses simple Lua and basic Roblox parts
- No external assets or plugins required
- All scripts are server/client compatible
- Ready to monetize and deploy

## ✨ Tips

- Use `/max` to test the game quickly
- Use `/spawnboss` to see how bosses work
- Use `/setfruit lightning` to test power-ups
- Press Play in Studio to test locally
- Publish to Roblox when ready!

---

**Enjoy your One Piece-inspired Roblox game!** 🏴‍☠️
