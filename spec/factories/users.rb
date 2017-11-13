FactoryBot.define do
  factory :user do
    password { FFaker::Internet.password }
    password_confirmation { password }
    email { FFaker::Internet.email }
    uid { email }

    after(:create, &:confirm)
  end
end
