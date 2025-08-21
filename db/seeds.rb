item_img = [
  "items/archer1.png",
  "items/archer2.png",
  "items/archer3.png",
  "items/bkn.png",
  "items/book.png",
  "items/bow1.png",
  "items/bow2.png",
  "items/bow3.png",
  "items/feather.png",
  "items/mage1.png",
  "items/mage2.png",
  "items/mage3.png",
  "items/potion.png",
  "items/ring1.png",
  "items/ring2.png",
  "items/staff1.png",
  "items/staff2.png",
  "items/staff3.png",
  "items/sword1.png",
  "items/sword2.png",
  "items/sword3.png",
  "items/warrior1.png",
  "items/warrior2.png",
  "items/warrior3.png"
]

item_name = [
  "Light Vest",
  "Leather Coat",
  "Heavy Vest",
  "Summer Equipment",
  "Book of Knowledge",
  "Training Bow",
  "Longbow",
  "Enchanted Bow",
  "Magic Feather",
  "Arcane Scarf",
  "Mage Robe",
  "Mantle of Knowledge",
  "Healing Potion",
  "Power Ring",
  "Ring of Protection",
  "Wooden Staff",
  "Moon Staff",
  "Pointy Staff",
  "Training Sword",
  "Long Sword",
  "Crystal Sword",
  "Bronze Armor",
  "Heavy Plate",
  "Runed Plate"
]

item_description = [
  "A light vest offering basic protection without hindering movement.",
  "Sturdy leather coat for adventurers seeking flexibility and defense.",
  "Heavy vest forged from tough materials for maximum protection.",
  "Light summer equipment, perfect for warm climates and mobility.",
  "An old book containing valuable wisdom and spells.",
  "A beginner's bow, ideal for honing archery skills.",
  "A finely crafted longbow with excellent range and accuracy.",
  "A bow imbued with enchantments to strike true against foes.",
  "A feather with mystical properties, often used in spellcasting.",
  "A scarf worn by mages, offering slight protection and arcane focus.",
  "A robe worn by novice mages, designed for comfort and spellcasting.",
  "A mantle containing ancient knowledge to aid magical studies.",
  "A potion that heals minor wounds and restores vitality.",
  "A ring that enhances the wearer's strength and agility.",
  "A magical ring offering protection from dark forces.",
  "A basic wooden staff for training and channeling magic.",
  "A staff blessed under the full moon, amplifying magical power.",
  "A staff with a sharp tip, suited for both magic and combat.",
  "A beginner's sword for training in close combat.",
  "A well-balanced long sword, ideal for knights and warriors.",
  "A crystal sword that shimmers with magical energy.",
  "Bronze armor offering decent protection without slowing you down.",
  "Heavy plate armor for warriors who face the toughest battles.",
  "A plate armor etched with runes, providing both defense and mystical resistance."
]

item_type = [
  "Light Armor",
  "Light Armor",
  "Heavy Armor",
  "Clothing",
  "Book",
  "Bow",
  "Bow",
  "Bow",
  "Accessory",
  "Clothing",
  "Clothing",
  "Clothing",
  "Potion",
  "Accessory",
  "Accessory",
  "Staff",
  "Staff",
  "Staff",
  "Sword",
  "Sword",
  "Sword",
  "Armor",
  "Armor",
  "Armor"
]

length = item_img.length

length.times do |i|
  Item.create!(
    name: item_name[i],
    description: item_description[i],
    item_type: item_type[i],
    price: rand(5000..50000),
    img: item_img[i]
  )
end

puts "#{length} items created"