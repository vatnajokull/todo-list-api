FactoryBot.define do
  factory :task do
    name { FFaker::HipsterIpsum.sentence }
    done false

    association :project
  end
end
