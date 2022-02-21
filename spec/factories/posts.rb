FactoryBot.define do
    factory :post do
      association :user
      comment{'ありがとう'}
      receiver_id{2}
    end
end