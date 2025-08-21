# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
item_img = [
  "../app/assets/images/items/archer1.png",
  "../app/assets/images/items/archer2.png",
  "../app/assets/images/items/archer3.png",
  "../app/assets/images/items/bkn.png",
  "../app/assets/images/items/book.png",
  "../app/assets/images/items/bow1.png",
  "../app/assets/images/items/bow2.png",
  "../app/assets/images/items/bow3.png",
  "../app/assets/images/items/feather.png",
  "../app/assets/images/items/mage1.png",
  "../app/assets/images/items/mage2.png",
  "../app/assets/images/items/mage3.png",
  "../app/assets/images/items/potion.png",
  "../app/assets/images/items/ring1.png",
  "../app/assets/images/items/ring2.png",
  "../app/assets/images/items/staff1.png",
  "../app/assets/images/items/staff2.png",
  "../app/assets/images/items/staff3.png",
  "../app/assets/images/items/sword1.png",
  "../app/assets/images/items/sword2.png",
  "../app/assets/images/items/sword3.png",
  "../app/assets/images/items/warrior1.png",
  "../app/assets/images/items/warrior2.png",
  "../app/assets/images/items/warrior3.png"
]

item_name = [
  "Light Vest",
  "Leather Coat",
  "Heavy Vest",
  "Summer Equipment",
  "Book",
  "Training Bow",
  "Bow",
  "Enchanted Bow",
  "Magic Feather",
  "Arcane Scarf",
  "Mage Robe",
  "Mantle Of Knowledge",
  "Potion",
  "Power Ring",
  "Magic Ring",
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
  "Light Vest",
  "Leather Coat",
  "Heavy Vest",
  "Summer Equipment",
  "Book",
  "Training Bow",
  "Bow",
  "Enchanted Bow",
  "Magic Feather",
  "Arcane Scarf",
  "Mage Robe",
  "Mantle Of Knowledge",
  "Potion",
  "Power Ring",
  "Magic Ring",
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

item_type = [
  "Light Vest",
  "Leather Coat",
  "Heavy Vest",
  "Summer Equipment",
  "Book",
  "Training Bow",
  "Bow",
  "Enchanted Bow",
  "Magic Feather",
  "Arcane Scarf",
  "Mage Robe",
  "Mantle Of Knowledge",
  "Potion",
  "Power Ring",
  "Magic Ring",
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

length = item_img.length

length.times do |i|
  item = Item.new(
    name: item_name[i],
    description: item_description[i],
    item_type: item_type[i],
    price: 0,
    img: item_img[i]
  )
  item.save!
end

puts "#{length} items created"
