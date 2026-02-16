puts "Cleaning old data..."

Review.destroy_all

puts "Creating Users..."
3.times do |i|
  User.create!(
    name: "User #{i + 1}",
    email: "user#{i + 1}@example.com",
    password: "password123"
  )
end

puts "Creating Products..."
5.times do |i|
  Product.create!(
    name: "Product #{i + 1}",
    price: rand(100..500)
  )
end

puts "Creating Reviews..."

users = User.all
products = Product.all

20.times do |i|
  Review.create!(
    user: users.sample,
    product: products.sample,
    rating: rand(1..5),
    title: "Sample Review #{i + 1}",
    reviewer_name: "QA Tester",
    comment: "This is a review number #{i + 1}",
    approved: [ true, false ].sample
  )
end

puts "Seed data created successfully!"
