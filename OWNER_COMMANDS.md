# Owner Commands Reference

## 40 Overpowered Owner Commands

All commands start with **`/`** and are typed in the Admin Panel (top-left of screen).

### Basic Commands

| Command | Effect | Duration |
|---------|--------|----------|
| `/heal` | Restore full health | Instant |
| `/max` | Max stats (9999 HP, 200 speed) | Permanent |
| `/reset` | Teleport to spawn | Instant |
| `/god 30` | Invincibility (30 seconds) | 30 seconds |

### Movement Commands

| Command | Effect | Duration |
|---------|--------|----------|
| `/tp 0 10 50` | Teleport to coordinates | Instant |
| `/speed 80` | Set walk speed | Permanent |
| `/superjump` | Super jump (500 power) | 12 seconds |
| `/fly` | Flight mode | 12 seconds |
| `/noclip` | Pass through objects | Permanent |
| `/collision` | Enable collision again | Permanent |
| `/slow 10` | Slow movement for 10 seconds | 10 seconds |
| `/freeze 5` | Freeze in place for 5 seconds | 5 seconds |

### Appearance Commands

| Command | Effect | Duration |
|---------|--------|----------|
| `/scale 2` | Double size | Permanent |
| `/invisible` | Become translucent | Permanent |
| `/visible` | Become fully visible | Permanent |
| `/glow` | Neon glow effect | Permanent |
| `/rainbow` | Rainbow color effect | Permanent |

### Combat Commands

| Command | Effect | Duration |
|---------|--------|----------|
| `/damageup 10` | 10x damage multiplier | Permanent |
| `/attackspeed 0.1` | Super fast attacks | Permanent |
| `/instakill` | Next attack one-hits | Single hit |
| `/lifesteal` | Heal when damaging enemies | Permanent |
| `/pierce` | Ignore armor | Permanent |
| `/pushback 100` | Knockback on hit | Permanent |

### Stamina & Resources

| Command | Effect | Duration |
|---------|--------|----------|
| `/infinitestamina` | Never run out of stamina | Permanent |

### Devil Fruit Commands

| Command | Effect | Boost |
|---------|--------|-------|
| `/setfruit fire` | Fire power (1.8x) | 1.8x |
| `/setfruit storm` | Storm power (1.7x) | 1.7x |
| `/setfruit ice` | Ice power (1.6x) | 1.6x |
| `/setfruit lightning` | Lightning power (1.9x) | 1.9x |
| `/setfruit quake` | Quake power (2.0x) | 2.0x |
| `/spawnfruit fire` | Spawn fruit nearby | N/A |
| `/spawnfruit storm` | Spawn fruit nearby | N/A |

### Boss Commands

| Command | Effect | Spawns |
|---------|--------|--------|
| `/spawnboss` | Spawn boss near you | 1 Boss |
| `/spawnboss "Storm Titan"` | Spawn specific boss | Custom |
| `/wave 10` | Spawn 10 enemies in circle | 10 Enemies |

### Group Commands

| Command | Effect | Targets |
|---------|--------|----------|
| `/killall` | Kill all enemies and bosses | Everyone |
| `/healall` | Heal all players | Everyone |
| `/giveall 500` | Give all players 500 bounty | Everyone |

### Stats Commands

| Command | Effect | Sets |
|---------|--------|-------|
| `/bounty 5000` | Set your bounty | Score |
| `/level 25` | Set your level | Level |

---

## Example Command Chains

**Become a god warrior:**
```
/max
/setfruit lightning
/damageup 10
/attackspeed 0.1
```

**Get creative:**
```
/scale 3
/glow
/damageup 20
/superjump
```

**Boss rush:**
```
/max
/spawnboss
/spawnboss "Storm Titan"
/spawnboss "Sea Wyrm"
```

**Army spawn:**
```
/wave 50
/killall
/wave 100
```

---

## Tips

- Combine commands for maximum effect
- Some commands stack (damage, scale, speed)
- Use `/god 30` before testing combat
- `/killall` works on any spawned enemy or boss
- `/scale` stacks with `/max` for huge player
- `/invisible` lets you observe without being seen

---

## Command Syntax

**Simple:** `/heal`

**With number:** `/god 60`

**With coordinates:** `/tp 50 20 100`

**With multiplier:** `/damageup 5`

**With fruit name:** `/setfruit quake`

---

**Note:** All commands are owner-only. Only the game creator can use them.
