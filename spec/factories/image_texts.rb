FactoryBot.define do
  factory :image_text do
    sequence(:nickname) { |i| "nickname#{i}" }
    sequence(:hobby) { |i| "hobby#{i}" }
    sequence(:message) { |i| "message#{i}" }
    sequence(:image_url) { |i| "http://example.com/image#{i}"}
  end
end
