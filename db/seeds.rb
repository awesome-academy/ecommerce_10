count=1
for i in 1..5
  user = User.create!(name: "phanthanhdong",
                      email: "phanthanhdong"+ i.to_s+"@gmail.com",
                      password: "phanthanhdong",
                      password_confirmation: "phanthanhdong")

  order = Order.create!(address_order: "640 trung nu vuong",
                        name_order: Faker::Name.name,
                        date_order: 22/11/2019,
                        phone_order: "0961141478",
                        total_amount: "500000",
                        user_id: user.id)

  category = Category.create!(name_category: "Category " + i.to_s,
                 description: Faker::Lorem.sentence)

  for j in 1..5
   product =  Product.create!(name: "Product " + j.to_s,
                              description: Faker::Lorem.sentence,
                              quantity: rand(10..15),
                              price: rand(500..5000000),
                              viewer: rand(5...15),
                              category_id: category.id)
   order_detail = OrderDetail.create!(product_id: product.id,
                                      quantity: rand(5...15),
                                      order_id: order.id)
   image = Image.create!(url_path: "product" + count.to_s + ".jpg",
                        product_id: product.id)
   count = count+1
  end
end
