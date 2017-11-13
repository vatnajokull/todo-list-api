FactoryBot.define do
  factory :project do
    name { FFaker::HipsterIpsum.sentence }

    association :user
  end
end
