(1..10).each do |i|
  Contact.create(name: Faker::Name.name, phone: Faker::PhoneNumber.phone_number)
end

