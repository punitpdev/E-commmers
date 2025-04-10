# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

require "open-uri"

Product.destroy_all

puts "Creating dummy products with images..."

10.times do |i|
  product = Product.create!(
    name: "Product ##{i + 1}",
    description: "This is a description for Product ##{i + 1}. Great for demos.",
    price: rand(100.0..999.99).round(2),
    stock_quantity: rand(10..100)
  )

  # Using a placeholder image from a URL
  image_url = "https://picsum.photos/200/300"
  product.image.attach(
    io: URI.open(image_url),
    filename: "product_#{i + 1}.png",
    content_type: "image/png"
  )
end

puts "✅ Created #{Product.count} products with images."
