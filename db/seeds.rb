# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Department.create!(:name => "管理者")
Department.create!(:name => "ゲストログイン")
Department.create!(:name => "社長室")
Department.create!(:name => "広報宣伝部")
Department.create!(:name => "営業部")

User.create!(department_id: Department.third.id,
            name: 'arisa',
            email: 'arisa@jarisa.com',
            password: 'password',
            image: open("./db/fixtures/pexels-los-muertos-crew-8446867.jpg")
            )

User.create!(department_id: Department.third.id,
            name: 'john',
            email: 'john@john.com',
            password: 'password',
            image: open("./db/fixtures/pexels-andrea-piacquadio-3760260.jpg")
            )

# User.create!(department_id: Department.third.id,
#             name: 'emily',
#             email: 'emily@emily.com',
#             password: 'password',
#             image:File.open('./app/assets/images/pexels-andrea-piacquadio-3763188.jpg')
#             )

# User.create!(department_id: Department.last.id,
#             name: 'rihana',
#             email: 'rihana@rihana.com',
#             password: 'password',
#             image:File.open('./app/assets/images/pexels-andrea-piacquadio-3764152.jpg')
#             )

# User.create!(department_id: Department.last.id,
#             name: '北河玲子',
#             email: 'kitakawa@reiko.com',
#             password: 'password',
#             image:File.open('./app/assets/images/pexels-pixabay-415829.jpg')
#             )

# User.create!(department_id: Department.last.id,
#             name: '坂本龍二',
#             email: 'sakamoto@ryuji.com',
#             password: 'password',
#             image:File.open('./app/assets/images/pexels-spencer-selover-428364.jpg')
#             )

