FactoryGirl.define do
  factory :user do
    email "test@test.com"
    password "password"
    admin false
  end
  
  factory :study do
    name "Study A"
  end
end