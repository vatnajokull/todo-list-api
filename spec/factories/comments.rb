FactoryBot.define do
  factory :comment do
    body { FFaker::HipsterIpsum.phrase }

    association :task
  end
end
