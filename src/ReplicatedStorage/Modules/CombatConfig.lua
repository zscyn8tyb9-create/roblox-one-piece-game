local CombatConfig = {}

CombatConfig.Player = {
    MaxHealth = 250,
    WalkSpeed = 22,
    JumpPower = 70,
    AttackDamage = 60,
    AttackRange = 20,
    AttackCooldown = 0.4,
    DashSpeed = 55,
    DashTime = 0.22,
    StaminaMax = 150,
    StaminaRegen = 24,
    PowerMultiplier = 1.7,
}

CombatConfig.Enemy = {
    MaxHealth = 100,
    Damage = 15,
    ChaseSpeed = 10,
    SpawnCount = 12,
    AttackRange = 9,
    AttackCooldown = 0.9,
    Reward = 35,
}

CombatConfig.Boss = {
    MaxHealth = 500,
    Damage = 35,
    ChaseSpeed = 14,
    AttackRange = 12,
    AttackCooldown = 1.1,
    Reward = 700,
}

CombatConfig.DevilFruit = {
    Names = {"fire", "storm", "ice", "lightning", "quake"},
    Colors = {
        fire = Color3.fromRGB(255, 110, 40),
        storm = Color3.fromRGB(160, 180, 255),
        ice = Color3.fromRGB(120, 220, 255),
        lightning = Color3.fromRGB(255, 230, 70),
        quake = Color3.fromRGB(200, 110, 50),
    },
    Boost = {
        fire = 1.8,
        storm = 1.7,
        ice = 1.6,
        lightning = 1.9,
        quake = 2.0,
    },
}

CombatConfig.Admin = {
    Prefix = "/",
}

return CombatConfig
