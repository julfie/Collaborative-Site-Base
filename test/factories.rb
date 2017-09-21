FactoryGirl.define do
  factory :user do
    f_name "Stevie"
    l_name "Wonder"
    # picture nil
    email "wonder@wonder.com"
    username "swonder"
    phone "412-344-5212"
    password "Secret1!"
    password_confirmation "Secret1!"
    active true
  end

  factory :role do
    name "artist"
    description "Creator of the project"
    active true
  end
  
  factory :user_role do
    association :role
    association :user 
  end

  

end