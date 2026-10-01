local CombatConfig = {
    Player = {
        MaxHealth = 120,
        WalkSpeed = 16,
        JumpPower = 45,
        AttackDamage = 22,
        AttackRange = 15,
        AttackCooldown = 0.6,
        DashSpeed = 40,
        DashTime = 0.18,
        StaminaMax = 100,
        StaminaRegen = 18,
    },

    Enemy = {
        MaxHealth = 80,
        Damage = 10,
        ChaseSpeed = 8,
        SpawnCount = 7,
        AttackRange = 7,
        AttackCooldown = 1.2,
        Reward = 25,
    },

    Admin = {
        Prefix = "/",
    },
}

return CombatConfig
