local NPCDialogue = {}

NPCDialogue.Quests = {
    {
        id = 1,
        name = "Slay the Bandits",
        giver = "Quen",
        description = "Defeat 3 bandits on the island.",
        objective = "Kill 3 enemies",
        reward = 150,
        difficulty = "Easy",
    },
    {
        id = 2,
        name = "Defeat the Captain",
        giver = "Quen",
        description = "Defeat the pirate captain north of here.",
        objective = "Defeat 1 boss",
        reward = 500,
        difficulty = "Hard",
    },
    {
        id = 3,
        name = "Collect Devil Fruits",
        giver = "Quen",
        description = "Find and collect 3 devil fruits.",
        objective = "Collect 3 fruits",
        reward = 300,
        difficulty = "Medium",
    },
}

NPCDialogue.ShopItems = {
    {
        id = 1,
        name = "Health Potion",
        price = 50,
        description = "Restore 50 HP",
        effect = "heal",
        value = 50,
    },
    {
        id = 2,
        name = "Stamina Scroll",
        price = 75,
        description = "Restore 30 stamina",
        effect = "stamina",
        value = 30,
    },
    {
        id = 3,
        name = "Power Crystal",
        price = 200,
        description = "Increase damage by 20%",
        effect = "damage",
        value = 0.2,
    },
    {
        id = 4,
        name = "Speed Elixir",
        price = 150,
        description = "Increase speed by 15%",
        effect = "speed",
        value = 0.15,
    },
    {
        id = 5,
        name = "Defense Amulet",
        price = 180,
        description = "Increase defense by 25%",
        effect = "defense",
        value = 0.25,
    },
}

NPCDialogue.NPCs = {
    {
        name = "Quen",
        role = "Quest Giver",
        greeting = "Greetings, traveler! Looking for work?",
        location = Vector3.new(0, 5, 0),
        color = Color3.fromRGB(0, 180, 255),
    },
    {
        name = "Merchant",
        role = "Shopkeeper",
        greeting = "Welcome to my shop! Browse my wares.",
        location = Vector3.new(80, 5, 20),
        color = Color3.fromRGB(255, 200, 100),
    },
    {
        name = "Captain",
        role = "Boss",
        greeting = "You dare challenge me?",
        location = Vector3.new(-80, 5, -80),
        color = Color3.fromRGB(200, 50, 50),
    },
}

return NPCDialogue
