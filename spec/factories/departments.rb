FactoryBot.define do
    factory :department do
      id {1}
      name{ '管理者' }
    end
    
    factory :second_department, class: Department do
      id {2}
      name{ '営業部' }
    end
end