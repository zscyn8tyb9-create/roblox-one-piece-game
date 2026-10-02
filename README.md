# Roblox One Piece Starter Game - PREMIUM Edition

✨ **A polished, feature-complete One Piece-inspired Roblox pirate game starter.**

## 🎮 Features

### Combat System
- ✅ Basic attacks with cooldown
- ✅ **Combo moves** (3-hit combo chain)
- ✅ Dash/sprint mechanic
- ✅ Stamina system
- ✅ Devil Fruit power-ups (10 types)
- ✅ Attack range and damage scaling

### World & NPCs
- ✅ Large island arena
- ✅ **NPC Quest Givers** with dialogue
- ✅ **NPC Shopkeeper** with weapon/item shop
- ✅ Enemy AI (chase and attack)
- ✅ Boss encounters (5+ unique bosses)
- ✅ Dynamic enemy spawning

### Progression
- ✅ Bounty/XP system
- ✅ Level progression
- ✅ Quest board with objectives
- ✅ Reward system
- ✅ Inventory tracking

### UI/UX
- ✅ Combat HUD (health, stamina, bounty)
- ✅ Admin panel with 40+ commands
- ✅ Boss health bar
- ✅ Floating damage numbers
- ✅ Quest log UI

### Devil Fruits (10 Types)
1. **Fire** (1.8x damage, burn effect)
2. **Storm** (1.7x speed, area attacks)
3. **Ice** (1.6x defense, slow enemies)
4. **Lightning** (1.9x attack speed)
5. **Quake** (2.0x knockback)
6. **Sand** (1.7x mobility)
7. **Magma** (2.0x damage vs ice)
8. **Darkness** (stealth mode)
9. **Gravity** (2.1x pull effect)
10. **Time** (super speed - 2.2x)

### Owner Commands (40+)
- Overpowered combat commands
- Spawning and control commands
- Aesthetic commands
- Group commands
- Testing utilities

---

## 📋 Quick Setup (Follow STUDIO_SETUP.md)

1. Open Roblox Studio
2. Create new Baseplate game
3. Follow the 9-step checklist in STUDIO_SETUP.md
4. Copy all scripts into correct folders
5. Press Play!

---

## 🎮 Controls

**Movement:**
- WASD - Move around
- Space - Jump
- Shift - Sprint/Dash

**Combat:**
- Left Click - Attack (tap 3x for combo)
- F - Quick attack
- Q - Special ability
- E - Interact (talk to NPCs, buy from shop)

**UI:**
- Tab - Quest log
- I - Inventory
- Admin Panel (top-left) - Owner commands

---

## 🗣️ NPCs

### Quen (Quest Giver)
- Location: Center island
- Offers bounty hunting quests
- Rewards: Bounty + XP
- Dialogue options included

### Merchant (Shopkeeper)
- Location: East island
- Sells: Weapons, potions, scrolls
- Prices scale with level
- Inventory system included

### Captain (Boss)
- Location: North island
- Boss fight encounter
- Special rewards

---

## ⚔️ Combo System

**3-Hit Combo:**
1. Press LMB - First strike (light)
2. Press LMB - Second strike (medium)
3. Press LMB - Third strike (heavy + knockback)

**Damage scaling:**
- Hit 1: 1.0x damage
- Hit 2: 1.2x damage
- Hit 3: 1.5x damage + knockback

Combo resets after 3 seconds of no attacks.

---

## 👹 Enemy Types

| Enemy | HP | Damage | Speed | Reward |
|-------|----|---------|---------|---------|
| Bandit | 100 | 15 | 10 | 35 |
| Pirate | 150 | 20 | 12 | 50 |
| Captain | 200 | 25 | 14 | 75 |
| Boss | 500+ | 35+ | 14+ | 700+ |

---

## 🎁 Devil Fruits

Each fruit provides:
- **Health Multiplier**: 1.6x - 2.2x
- **Speed Multiplier**: 1.5x - 2.0x
- **Damage Multiplier**: 1.6x - 2.2x
- **Special Effect**: Unique to each fruit

Equip by:
1. Finding fruit on island
2. Using `/setfruit [name]` command
3. Talking to shopkeeper

---

## 💰 Economy

**Currency: Bounty (Berry equivalents)**

- Kill enemy: +35-75 bounty
- Defeat boss: +700 bounty
- Complete quest: +150-500 bounty
- Shop prices: 50-500 bounty

---

## 🛡️ Owner Commands (40+)

See **OWNER_COMMANDS.md** for full list.

**Quick Reference:**
```
/heal              - Full health
/max               - Godlike stats
/god 30            - Invincibility
/spawnboss         - Spawn boss
/killall           - Kill everything
/setfruit quake    - Equip fruit
/wave 20           - Spawn 20 enemies
/damageup 10       - 10x damage
/scale 2           - Double size
/invisible         - Become invisible
/glow              - Neon glow
/attackspeed 0.1   - Super fast attacks
/healall           - Heal all players
/giveall 500       - Give bounty to all
```

---

## 📁 File Structure

```
src/
├── ServerScriptService/
│   ├── GameBootstrap.server.lua
│   ├── OwnerCommands.server.lua
│   ├── CombatHandler.server.lua
│   ├── NPCManager.server.lua
│   └── EnemyAI.server.lua
├── ReplicatedStorage/
│   ├── Modules/
│   │   ├── CombatConfig.lua
│   │   ├── WorldBuilder.lua
│   │   ├── ComboSystem.lua
│   │   └── NPCDialogue.lua
│   └── Remotes/
│       ├── Attack
│       ├── RunCommand
│       └── NPCInteraction
└── StarterPlayer/
    └── StarterPlayerScripts/
        ├── CombatClient.client.lua
        ├── AdminClient.client.lua
        ├── UIClient.client.lua
        └── NPCClient.client.lua
```

---

## 🚀 Getting Started

1. **Read STUDIO_SETUP.md** - Follow the exact checklist
2. **Copy all scripts** - Exact names and locations
3. **Press Play** - Test in Studio
4. **Try commands** - Use `/max` to test
5. **Enjoy!** - Build your game from here

---

## ✨ What's Included

✅ Full combat system with combos  
✅ NPC quest system with dialogue  
✅ NPC shopkeeper with inventory  
✅ 10 devil fruits with unique effects  
✅ Boss encounters  
✅ Progression system  
✅ Beautiful island arena  
✅ 40+ overpowered owner commands  
✅ Professional UI/UX  
✅ Collision and physics  
✅ Audio hooks (ready for sfx)  
✅ Well-commented code  

---

## 🎯 Next Steps (Optional)

Expand your game with:
- Custom animations
- Sound effects
- Particle effects
- More islands
- PvP arena
- Clans/teams
- Trading system
- Leaderboards
- Mobile support

---

## 🐛 Troubleshooting

**Scripts don't run?**
- Check STUDIO_SETUP.md Step 7
- Verify module names
- Check Output for errors

**NPCs don't appear?**
- Make sure NPCManager script exists
- Check Workspace for "NPCHub" folder
- Wait 5 seconds after loading

**Commands don't work?**
- Verify you're the game creator
- Check admin panel loads
- Review OWNER_COMMANDS.md

**Enemies don't spawn?**
- Check EnemyAI.server.lua is running
- Verify Enemies folder exists
- Check Output for errors

---

## 📞 Support

Check the repo issues or README files for:
- Common errors
- Setup help
- Command reference
- Feature explanations

---

**🎮 Ready to create your One Piece-inspired Roblox game? Let's go! 🏴‍☠️**
