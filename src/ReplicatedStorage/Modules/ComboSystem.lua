local ComboSystem = {}

ComboSystem.activeCombo = {}

function ComboSystem.startCombo(player)
    if not ComboSystem.activeCombo[player.UserId] then
        ComboSystem.activeCombo[player.UserId] = {
            hits = 0,
            lastHit = os.clock(),
            combo = 0,
        }
    end
    return ComboSystem.activeCombo[player.UserId]
end

function ComboSystem.getComboCount(player)
    local combo = ComboSystem.activeCombo[player.UserId]
    if not combo then
        return 0
    end
    
    local timeSinceLastHit = os.clock() - combo.lastHit
    if timeSinceLastHit > 3 then
        combo.hits = 0
        combo.combo = 0
    end
    
    return combo.hits
end

function ComboSystem.addComboHit(player)
    local combo = ComboSystem.startCombo(player)
    combo.hits = combo.hits + 1
    combo.lastHit = os.clock()
    combo.combo = combo.hits
    
    if combo.hits >= 3 then
        combo.hits = 0
    end
    
    return combo.combo
end

function ComboSystem.getComboMultiplier(hitNumber)
    local multipliers = {1.0, 1.2, 1.5}
    return multipliers[hitNumber] or 1.0
end

function ComboSystem.getComboKnockback(hitNumber)
    local knockback = {0, 0, 50}
    return knockback[hitNumber] or 0
end

return ComboSystem
