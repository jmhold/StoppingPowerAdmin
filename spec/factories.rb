FactoryGirl.define do
  factory :user do
    email "test@test.com"
    password "password"
    admin false
  end
  
  factory :study do
    name "Study A"
  end
  
  factory :image do
  end
  
  factory :study_image do
    study
    image
  end
  
  factory :pair do |pair|
    study
    page_number 1
    study_image1 { create(:study_image, study: study) }
    study_image2 { create(:study_image, study: study) }
  end
end