require 'faker'

# --- Items ---
item_img = [
  "books/book.png", "accessories/feather.png", "accessories/potion.png",
  "accessories/ring1.png", "accessories/ring2.png", "staves/staff1.png",
  "staves/staff2.png", "staves/staff3.png", "swords/sword1.png",
  "swords/sword2.png", "swords/sword3.png", "swords/arthur_blade_of_secret_sword.png",
  "staves/large_alien_of_utility_staff.png", "staves/dust_of_electricity_staff.png",
  "swords/hectors_displacer_of_ending_sword.png", "accessories/elixir_of_eternal_flame_potion.png",
  "accessories/serpent_venom_potion.png", "accessories/tears_of_the_moon_potion.png",
  "accessories/shadowmeld_draught_potion.png", "accessories/phoenix_embers_potion.png",
  "accessories/potion_of_minor_healing_potion.png", "accessories/elixir_of_energy_potion.png",
  "accessories/draught_of_clarity_potion.png", "accessories/tonic_of_vitality_potion.png",
  "accessories/brew_of_swiftness_potion.png", "accessories/moonlit_dreams_potion.png", 
  "accessories/emberglow_resolve_potion.png", "accessories/frostbloom_essence_potion.png", 
  "accessories/mystic_waters_potion.png", "accessories/potion_of_arcane_fortitude.png",
  "accessories/elixir_of_celestial_insight_potion.png", "accessories/eclipse_draught_potion.png",
  "accessories/dragonheart_elixir_potion.png"
]

item_name = [
  "Book Of Knowledge", "Magic Feather",
  "Healing Potion", "Power Ring",
  "Ring Of Protection", "Wooden Staff",
  "Moon Staff", "Pointy Staff",
  "Training Sword", "Long Sword",
  "Crystal Sword", "Arthur Blade Of Secret",
  "Large Alien Of Utility", "Dust Of Electricity",
  "Hector's Displacer Of Ending",
  "Elixir Of Eternal Flame", "Serpent Venom Potion",
  "Tears Of The Moon Potion", "Shadowmeld Draught Potion",
  "Phoenix Embers Potion", "Potion Of Minor Healing",
  "Elixir Of Energy", "Draught Of Clarity",
  "Tonic Of Vitality", "Brew Of Swiftness",
  "Moonlit Dreams", "Emberglow Resolve",
  "Frostbloom Essence", "Mystic Water",
  "Potion Of Arcane Fortitude", "Elixir Of Celestial Insight",
  "Eclipse Draught", "Dragonheart Elixir"
]

item_description = [
  "An old book containing valuable wisdom and spells.",                                   # Book of Knowledge – Rare
  "A feather with mystical properties, often used in spellcasting.",                     # Magic Feather – Uncommon
  "A potion that heals minor wounds and restores vitality.",                              # Healing Potion – Common
  "A ring that enhances the wearer's strength and agility.",                              # Power Ring – Uncommon
  "A magical ring offering protection from dark forces.",                                 # Ring of Protection – Rare
  "A basic wooden staff for training and channeling magic.",                               # Wooden Staff – Common
  "A legendary staff blessed under the full moon, amplifying magical power.",             # Moon Staff – Rare
  "A staff with a sharp tip, suited for both magic and combat.",                           # Pointy Staff – Uncommon
  "A beginner's sword for training in close combat.",                                      # Training Sword – Common
  "A well-balanced long sword, ideal for knights and warriors.",                           # Long Sword – Uncommon
  "A legendary crystal sword that shimmers with magical energy.",                           # Crystal Sword – Epic
  "A legendary sword that reveals hidden truths, striking with precision and silent power.",# Arthur Blade Of Secret – Legendary
  "A legendary weapon of otherworldly origin, built for both offense and utility.",        # Large Alien Of Utility – Legendary
  "A legendary staff crackling with electrical energy, channeling lightning with every strike.",# Dust Of Electricity – Legendary
  "A legendary sword that severs fate itself with every strike, leaving nothing but finality in its wake.",# Hector's Displacer – Epic
  "A legendary potion of eternal flame, granting unmatched fortitude to its user.",        # Elixir Of Eternal Flame – Legendary
  "A legendary venomous potion, enhancing agility and danger in battle.",                  # Serpent Venom – Legendary
  "A legendary lunar potion, infused with the power of moonlight for mystical effects.",    # Tears Of The Moon – Legendary
  "A legendary shadowmeld draught, granting stealth and arcane power to its drinker.",      # Shadowmeld Draught – Legendary
  "A legendary potion of phoenix embers, igniting courage and fiery strength.",             # Phoenix Embers – Legendary
  "A common potion of minor healing, restoring a small amount of health.",                 # Potion Of Minor Healing – Common
  "A common elixir of energy, refreshing the drinker with vitality.",                      # Elixir Of Energy – Common
  "A common draught of clarity, sharpening focus and mind.",                                # Draught Of Clarity – Common
  "A common tonic of vitality, replenishing stamina and strength.",                         # Tonic Of Vitality – Common
  "A common brew of swiftness, slightly increasing speed and agility.",                      # Brew Of Swiftness – Common
  "A potion that calms the mind and brings restful sleep under the moonlight.",           # Moonlit Dreams Potion – Uncommon
  "A warm, glowing potion that inspires courage and determination in the drinker.",       # Emberglow Resolve Potion – Uncommon
  "A chilling potion that enhances clarity and focus, infused with frostbloom essence.", # Frostbloom Essence Potion – Uncommon
  "A sparkling potion of rejuvenation, drawing mystical energy from pure waters.",       # Mystic Waters Potion – Uncommon
  "A mystical potion that strengthens magical defenses and resilience, empowering the drinker against dark forces.",
  "An elixir that sharpens the mind and enhances awareness, connecting the drinker with celestial wisdom.",
  "A shadowy vial that glimmers faintly, granting clarity and resilience in darkness.",
  "A molten-red brew radiating heat, filling the drinker with strength and resolve."
]

item_type = [
  "Book", "Accessory", "Potion", "Accessory", "Accessory", 
  "Staff", "Staff", "Staff", "Sword", "Sword", 
  "Sword", "Sword", "Staff", "Staff", "Sword", 
  "Potion", "Potion", "Potion", "Potion", "Potion",
  "Potion", "Potion", "Potion", "Potion", "Potion",
  "Potion", "Potion", "Potion", "Potion", "Potion",
  "Potion", "Potion", "Potion", "Potion"
]

item_prices = [
  18000,   # Book Of Knowledge
  12000,   # Magic Feather
  5000,    # Healing Potion
  14000,   # Power Ring
  20000,   # Ring Of Protection
  6000,    # Wooden Staff
  25000,   # Moon Staff
  15000,   # Pointy Staff
  4000,    # Training Sword
  10000,   # Long Sword
  35000,   # Crystal Sword
  60000,   # Arthur Blade Of Secret
  65000,   # Large Alien Of Utility
  55000,   # Dust Of Electricity
  40000,   # Hector's Displacer Of Ending
  80000,   # Elixir Of Eternal Flame
  85000,   # Serpent Venom
  90000,   # Tears Of The Moon
  95000,   # Shadowmeld Draught
  100000,   # Phoenix Embers
  3000,  # Potion Of Minor Healing
  3500,  # Elixir Of Energy
  3200,  # Draught Of Clarity
  3400,  # Tonic Of Vitality
  3600,   # Brew Of Swiftness
  4800, 5300, 5000, 5500,
  12000, 13000, 28000,
  30000
]

item_rarity = [
  "Rare",       # Book Of Knowledge
  "Uncommon",   # Magic Feather
  "Common",     # Healing Potion
  "Uncommon",   # Power Ring
  "Rare",       # Ring Of Protection
  "Common",     # Wooden Staff
  "Rare",       # Moon Staff
  "Uncommon",   # Pointy Staff
  "Common",     # Training Sword
  "Uncommon",   # Long Sword
  "Epic",       # Crystal Sword
  "Legendary",  # Arthur Blade Of Secret
  "Legendary",  # Large Alien Of Utility
  "Legendary",  # Dust Of Electricity
  "Epic",       # Hector's Displacer Of Ending
  "Legendary",  # Elixir Of Eternal Flame
  "Legendary",  # Serpent Venom
  "Legendary",  # Tears Of The Moon
  "Legendary",  # Shadowmeld Draught
  "Legendary",   # Phoenix Embers
  "Common", "Common", "Common", "Common", "Common",
  "Uncommon", "Uncommon", "Uncommon", "Uncommon", "Uncommon",
  "Rare", "Rare", "Epic", "Epic"
]

item_name.each_with_index do |name, i|
  Item.find_or_create_by!(name: name) do |item|
    item.description = item_description[i]
    item.item_type   = item_type[i]
    item.price       = item_prices[i]
    item.img         = item_img[i]
    item.rarity      = item_rarity[i]
  end
end

# --- Create the user ---
user = User.create!(
  username: "GayLord",
  email: "anto.vinciguerra@hotmail.com",
  birthday: Date.new(1991, 9, 14),
  password: "password",
  password_confirmation: "password"
)



# # --- 500 random users ---
# 500.times do
#   u = User.create!(
#     email: Faker::Internet.unique.email,
#     password: "password",
#     username: Faker::Internet.username(specifier: 5..10),
#     birthday: Faker::Date.birthday(min_age: 18, max_age: 50)
#   )

#   # Character for each user
#   c = Character.create!(
#     user: u,
#     name: Faker::Fantasy::Tolkien.character,
#     class_name: ["Mage", "Warrior"].sample,
#     gender: ["Male", "Female", "Other"].sample,
#     xp: rand(0..1000),
#     coin: rand(0..5000),
#     apperance: "default",
#     level: rand(1..10)
#   )

#   # Journey for each user
#   Journey.create!(
#     user: u,
#     purpose: Faker::Lorem.sentence(word_count: 5),
#     daily_quests: Faker::Lorem.sentence(word_count: 10),
#     main_quest: Faker::Lorem.sentence(word_count: 7)
#   )

#   # Assign random items to character
#   Item.all.sample(rand(3..8)).each do |item|
#     InventoryItem.create!(
#       character: c,
#       item: item,
#       equipped: [true, false].sample
#     )
#   end
# end

# puts "Seeded 500 users with characters, journeys, and items, plus your personal account."