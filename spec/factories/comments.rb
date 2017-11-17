FactoryBot.define do
  factory :comment do
    body { FFaker::HipsterIpsum.phrase }

    trait :with_image do
      image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'images', 'sample.jpg')) }
    end

    association :task
  end
end
