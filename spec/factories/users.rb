FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "user#{n}@mail.com"
    end
    password { 'password' }
  end
end
