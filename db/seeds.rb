# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


1.times do |n| 
    name = Faker::Job.field
    Department.create!(name: name,
                      )
end


1.times do |n| 
    department_id = Department.last.id
    name = Faker::Name.name
    email = Faker::Internet.email
    password = "password"
    User.create!(department_id: department_id,
                 name: name,
                 email: email,
                 password: password,
                 )
  end