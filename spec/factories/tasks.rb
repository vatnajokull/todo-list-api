FactoryBot.define do
  factory :task do
    name { FFaker::HipsterIpsum.sentence }
    done false

    association :project
  end

  trait :with_due_date do
    due_date  { DateTime.now.end_of_day }
  end

  trait :with_due_date_in_past do
    due_date  { Time.now - 2.days }
    to_create { |instance| instance.save(validate: false) }
  end
end
