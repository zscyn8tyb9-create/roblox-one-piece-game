# ✅ Roblox Studio Setup Checklist

## Before You Start
- Download and install **Roblox Studio** from roblox.com/create
- You must be the **game creator** for owner commands to work

---

## Step 1: Create New Game ✓

1. Open **Roblox Studio**
2. Click **"File" → "New"**
3. Select **"Baseplate"** template
4. Click **"Create"**
5. Save the game (Ctrl+S) and name it

---

## Step 2: Create Module Folder ✓

1. In **Explorer** (left panel), find **ReplicatedStorage**
2. Right-click **ReplicatedStorage** → **Insert Object** → **Folder**
3. Name it exactly: **`Modules`**
4. **ReplicatedStorage** should now look like:
   ```
   ReplicatedStorage
   ├── Modules (NEW)
   ```

---

## Step 3: Add CombatConfig Module ✓

1. Right-click **Modules** → **Insert Object** → **ModuleScript**
2. Name it exactly: **`CombatConfig`**
3. Delete all default text in the script
4. Copy **entire contents** from `src/ReplicatedStorage/Modules/CombatConfig.lua`
5. Paste into the script
6. Press **Ctrl+S** to save

---

## Step 4: Add WorldBuilder Module ✓

1. Right-click **Modules** → **Insert Object** → **ModuleScript**
2. Name it exactly: **`WorldBuilder`**
3. Delete all default text
4. Copy **entire contents** from `src/ReplicatedStorage/Modules/WorldBuilder.lua`
5. Paste into the script
6. Press **Ctrl+S** to save

**Your Modules folder should now have:**
```
Modules
├── CombatConfig
├── WorldBuilder
```

---

## Step 5: Add ServerScriptService Scripts ✓

### Script 5a: GameBootstrap

1. In **Explorer**, find **ServerScriptService**
2. Right-click it → **Insert Object** → **Script**
3. Name it exactly: **`GameBootstrap`**
4. Delete all default text
5. Copy **entire contents** from `src/ServerScriptService/GameBootstrap.server.lua`
6. Paste into the script
7. Press **Ctrl+S**

### Script 5b: OwnerCommands

1. Right-click **ServerScriptService** → **Insert Object** → **Script**
2. Name it exactly: **`OwnerCommands`**
3. Delete all default text
4. Copy **entire contents** from `src/ServerScriptService/OwnerCommands.server.lua`
5. Paste into the script
6. Press **Ctrl+S**

**Your ServerScriptService should now have:**
```
ServerScriptService
├── GameBootstrap (Script)
├── OwnerCommands (Script)
```

---

## Step 6: Add Client Scripts ✓

### Script 6a: CombatClient

1. In **Explorer**, expand **StarterPlayer**
2. Expand **StarterPlayerScripts**
3. Right-click **StarterPlayerScripts** → **Insert Object** → **LocalScript**
4. Name it exactly: **`CombatClient`**
5. Delete all default text
6. Copy **entire contents** from `src/StarterPlayer/StarterPlayerScripts/CombatClient.client.lua`
7. Paste into the script
8. Press **Ctrl+S**

### Script 6b: AdminClient

1. Right-click **StarterPlayerScripts** → **Insert Object** → **LocalScript**
2. Name it exactly: **`AdminClient`**
3. Delete all default text
4. Copy **entire contents** from `src/StarterPlayer/StarterPlayerScripts/AdminClient.client.lua`
5. Paste into the script
6. Press **Ctrl+S**

**Your StarterPlayerScripts should now have:**
```
StarterPlayerScripts
├── CombatClient (LocalScript)
├── AdminClient (LocalScript)
```

---

## Step 7: Verify Everything ✓

**Check these folders are correct:**

- [ ] ReplicatedStorage
  - [ ] Modules
    - [ ] CombatConfig (ModuleScript)
    - [ ] WorldBuilder (ModuleScript)

- [ ] ServerScriptService
  - [ ] GameBootstrap (Script)
  - [ ] OwnerCommands (Script)

- [ ] StarterPlayer > StarterPlayerScripts
  - [ ] CombatClient (LocalScript)
  - [ ] AdminClient (LocalScript)

**If any script is in the wrong place, the game will crash.**

---

## Step 8: Test the Game ✓

1. Press the **Green Play Button** (top of screen) or press **F5**
2. Look at the **Output** panel (bottom of screen)
3. You should see messages like:
   ```
   [GameBootstrap] Starting game initialization...
   [GameBootstrap] Modules loaded successfully.
   [GameBootstrap] Creating island...
   [GameBootstrap] ✅ Game initialized successfully!
   ```

**If you see red errors:**
- Check script names match exactly
- Check scripts are in correct folders
- Check you copied all the code (no missing lines)
- Restart Studio

---

## Step 9: Test Owner Commands ✓

1. While the game is running (in Play mode)
2. Look at **top-left corner** - you should see **"Owner Commands"** panel
3. Type in the command box: `/heal`
4. Click **"Run Command"** or press **Enter**
5. Your health should go to full

**If panel doesn't appear:**
- Check AdminClient is in StarterPlayerScripts
- Check your admin panel code was pasted correctly
- Check Output for errors

---

## Common Issues & Fixes

### Issue: "Modules is not a valid member of ReplicatedStorage"
**Fix:** You didn't create the Modules folder. Go back to Step 2.

### Issue: Scripts have red X marks
**Fix:** You may have syntax errors. Compare your code with the repo.

### Issue: Game loads but no UI appears
**Fix:** Check that CombatClient and AdminClient are LocalScripts (not Scripts) in StarterPlayerScripts.

### Issue: Commands don't work
**Fix:** Make sure you're the game creator. Owner commands only work for the creator.

### Issue: Enemies don't spawn
**Fix:** Check Output for errors. Wait 5 seconds after pressing Play.

### Issue: "Attempt to call a nil value" error
**Fix:** A module script didn't load. Make sure ModuleScripts are named exactly right.

---

## ✅ Final Checklist Before Playing

- [ ] All 7 scripts created and named correctly
- [ ] All scripts in correct folders
- [ ] ModuleScripts in Modules folder
- [ ] LocalScripts in StarterPlayerScripts
- [ ] Scripts in ServerScriptService
- [ ] Pressed Ctrl+S on all scripts
- [ ] No red error icons in Explorer
- [ ] Game runs without crashing (press Play)
- [ ] Output shows success messages
- [ ] Admin panel appears in top-left
- [ ] Commands work (/heal, /max, etc)

---

## 🎮 Controls Once Running

**In Game:**
- **WASD** - Move
- **Left Click or F** - Attack
- **Shift** - Dash
- **Q** - Quick attack

**Admin Panel (Top-Left):**
- Type commands
- Press Enter or click "Run Command"

---

## 🚀 You're Ready!

Once all scripts are in place and the game runs without errors, you have a working One Piece starter game with 40+ owner commands!

Start with these to test:
```
/heal        - Full health
/max         - Max stats
/god 30      - God mode 30 seconds
/spawnboss   - Summon boss
/killall     - Kill all enemies
```

**Good luck! 🎮**
