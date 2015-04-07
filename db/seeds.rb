(1..5_000).each do |i|
  Category.create(name: Faker::Internet.slug, description: Faker::Lorem.sentence)
end

category_size = Category.count

(1..5_000_000).each do |i|
  Contact.create(name: Faker::Name.name, phone: Faker::PhoneNumber.phone_number, fake: (i % 3 == 0), category_id: (1..category_size).to_a.sample, country: [ 'MY', 'PH', 'SG', 'TH', 'US', 'AU' ].sample)
end
