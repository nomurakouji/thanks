FactoryBot.define do
  factory :user do
    association :department
    # department_id{1}
    # id {1}
    name{ 'ゲスト管理者'}
    email{'guestadmin@guestadmin.com'}
    image{Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/pexels-marta-branco-1173576.jpg'))}
    password{'password'}
    password_confirmation{'password'}
    admin {true}
  end
  factory :second_user, class: User do
    association :department, factory: :second_department
    # department_id{2}
    # id {2}
    name{ '北河玲子'}
    email{'kitakawa@reiko.com'}
    image{Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/pexels-pixabay-415829.jpg'))}
    password{'password'}
    password_confirmation{'password'}
    admin {false}
  end
  factory :third_user, class: User do
    association :department, factory: :department
    department_id{3}
    # id {3}
    name{ 'ゲストユーザー'}
    email{'guest@guest.com'}
    image{Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/pexels-porapak-apichodilok-348520.jpg'))}
    password{'password'}
    password_confirmation{'password'}
    admin {false}
  end
end