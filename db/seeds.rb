require 'faker'

InventoryItem.destroy_all
Item.destroy_all
Quest.destroy_all
Character.destroy_all
Journey.destroy_all
User.destroy_all

item_img = [
  "books/book.png", "accessories/feather_amulet.png", "accessories/potion.png",
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
  "accessories/dragonheart_elixir_potion.png", "staves/unearthed_chaos_staff.png", 
  "top/crystalline_armor_top.png", "head/golden_helmet_head.png", "head/crystalline_helmet_head.png",
  "head/winged_helmet_head.png", "head/obsidian_helmet_head.png", "top/winged_armor_top.png",
  "top/golden_armor_top.png", "bottom/golden_bottom.png"
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
  "Eclipse Draught", "Dragonheart Elixir", "Unearthed Chaos",
  "Crystalline Armor", "Golden Helmet", "Crystalline helmet",
  "Winged Helmet", "Obsidian Helmet", "Winged Armor",
  "Golden Armor", "Golden Leggings"
]

item_description = [
  "An old book containing valuable wisdom and spells.",
  "A feather with mystical properties, often used in spellcasting.",
  "A potion that heals minor wounds and restores vitality.",
  "A ring that enhances the wearer's strength and agility.",
  "A magical ring offering protection from dark forces.",
  "A basic wooden staff for training and channeling magic.",
  "A legendary staff blessed under the full moon, amplifying magical power.",
  "A staff with a sharp tip, suited for both magic and combat.",
  "A beginner's sword for training in close combat.",
  "A well-balanced long sword, ideal for knights and warriors.",
  "A legendary crystal sword that shimmers with magical energy.",
  "A legendary sword that reveals hidden truths, striking with precision and silent power.",
  "A legendary weapon of otherworldly origin, built for both offense and utility.",
  "A legendary staff crackling with electrical energy, channeling lightning with every strike.",
  "A legendary sword that severs fate itself with every strike, leaving nothing but finality in its wake.",
  "A legendary potion of eternal flame, granting unmatched fortitude to its user.",
  "A legendary venomous potion, enhancing agility and danger in battle.",
  "A legendary lunar potion, infused with the power of moonlight for mystical effects.",
  "A legendary shadowmeld draught, granting stealth and arcane power to its drinker.",
  "A legendary potion of phoenix embers, igniting courage and fiery strength.",
  "A common potion of minor healing, restoring a small amount of health.",
  "A common elixir of energy, refreshing the drinker with vitality.",
  "A common draught of clarity, sharpening focus and mind.",
  "A common tonic of vitality, replenishing stamina and strength.",
  "A common brew of swiftness, slightly increasing speed and agility.",
  "A potion that calms the mind and brings restful sleep under the moonlight.",
  "A warm, glowing potion that inspires courage and determination in the drinker.",
  "A chilling potion that enhances clarity and focus, infused with frostbloom essence.",
  "A sparkling potion of rejuvenation, drawing mystical energy from pure waters.",
  "A mystical potion that strengthens magical defenses and resilience, empowering the drinker against dark forces.",
  "An elixir that sharpens the mind and enhances awareness, connecting the drinker with celestial wisdom.",
  "A shadowy vial that glimmers faintly, granting clarity and resilience in darkness.",
  "A molten-red brew radiating heat, filling the drinker with strength and resolve.",
  "A swirling staff of untamed energy, crackling with chaotic power.",
  "The torso of the glorious Crystalline Armor Set",
  "A radiant golden helmet, offering unmatched protection and regal presence.",
  "A gleaming helmet of crystallized magic, granting both defense and arcane clarity.",
  "A majestic winged helmet, imbued with legendary power and soaring protection",
  "A dark, polished obsidian helmet that offers sturdy protection with a hint of mystique.",
  "A legendary chest armor with majestic wings, granting both protection and the aura of heroism",
  "A radiant golden armor, offering unmatched protection and regal presence.",
  "A radiant golden leggings, offering unmatched protection and regal presence."
]

item_type = [
  "Book", "Accessory", "Potion", "Accessory", "Accessory", 
  "Staff", "Staff", "Staff", "Sword", "Sword", 
  "Sword", "Sword", "Staff", "Staff", "Sword", 
  "Potion", "Potion", "Potion", "Potion", "Potion",
  "Potion", "Potion", "Potion", "Potion", "Potion",
  "Potion", "Potion", "Potion", "Potion", "Potion",
  "Potion", "Potion", "Potion", "Potion", "Staff",
  "Top", "Head", "Head", "Head", "Head", "Top", "Top",
  "Bottom"
]

item_prices = [
  18000, 12000, 5000, 14000, 20000, 6000, 25000, 15000, 4000, 10000,
  35000, 60000, 65000, 55000, 40000, 80000, 85000, 90000, 95000, 100000,
  3000, 3500, 3200, 3400, 3600, 4800, 5300, 5000, 5500, 12000,
  13000, 28000, 30000, 40000, 50000, 36000, 29000, 47000, 8000, 70000,
  46000, 39000
]

item_rarity = [
  "Rare", "Uncommon", "Common", "Uncommon", "Rare", "Common", "Rare", "Uncommon", "Common", "Uncommon",
  "Epic", "Legendary", "Legendary", "Legendary", "Epic", "Legendary", "Legendary", "Legendary", "Legendary", "Legendary",
  "Common", "Common", "Common", "Common", "Common", "Uncommon", "Uncommon", "Uncommon", "Uncommon", "Uncommon",
  "Rare", "Rare", "Epic", "Epic", "Epic", "Epic", "Epic", "Legendary", "Uncommon", "Legendary", "Epic", "Epic"
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

user = User.create!(
  username: "GayLord",
  email: "anto.vinciguerra@hotmail.com",
  birthday: Date.new(1991, 9, 14),
  password: "password",
  password_confirmation: "password"
)

journey = Journey.create!(
  user: user,
  purpose: "To create and stick to a daily routine, because I struggle to stay consistent.",
  daily_quests: "I want to learn ruby on rails!"
)

alastor = Character.create!(
  user: user,
  name: "Alastor",
  class_name: "Mage",
  gender: "Male",
  xp: 3000,
  coin: 600000,
  level: 3,
  slots: 10
)

Item.order("RANDOM()").limit(5).each do |item|
  InventoryItem.create!(
    character: alastor,
    item: item,
    equipped: false
  )
end
puts "Alastor created"

100.times do
  user = User.create!(
    username: Faker::Internet.unique.username,
    email: Faker::Internet.unique.email,
    birthday: Faker::Date.birthday(min_age: 18, max_age: 60),
    password: "password",
    password_confirmation: "password"
  )

  journey = Journey.create!(
    user: user,
    purpose: Faker::Lorem.sentence(word_count: 10),
    daily_quests: Faker::Lorem.sentence(word_count: 5)
  )

  character = Character.create!(
    user: user,
    name: Faker::Games::DnD.unique.name,
    class_name: ["Mage", "Warrior", "Rogue"].sample,
    gender: ["Male", "Female", "Other"].sample,
    xp: rand(0..5000),
    coin: rand(1000..500000),
    level: rand(1..10),
    slots: 10
  )

  Item.order("RANDOM()").limit(5).each do |item|
    InventoryItem.create!(
      character: character,
      item: item,
      equipped: true
    )
  end
end

puts "Users created"