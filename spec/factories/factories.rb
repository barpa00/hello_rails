FactoryBot.define do
  factory :mission do
    title { "Mission Name" }
    content { "Description." }
    start_time { nil }
    end_time { nil }
    created_at { nil }
    updated_at { nil }
  end
end
