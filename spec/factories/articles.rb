FactoryBot.define do
  factory :article do
    country             {'test'}
    city                {'test'}
    season              {'1111-11-11'}
    english_id          {'2'}
    safe_id             {'2'}
    nice_id             {'2'}
    content             {'aあ'}
    association :user

    after(:build) do |article|
      article.images.attach(io: File.open('public/images/furima-test-image.png'), filename: 'furima-test-image.png')
    end
  end
end