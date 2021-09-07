FactoryBot.define do
  factory :reply do
    reply             {'test'}
    association :user
    association :comment
  end
end
