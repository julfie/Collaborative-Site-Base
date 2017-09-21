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

  factory :project do
    proj_description "A girl who pretends to be a boy because dragons and destiny"
    genre "fantasy"
    title "Eon"
    start_date 1.day.ago.to_date
    category "fiction"
    status "active"
    preview_level "published"
  end

  factory :project_role do
    project_id @Eon
    role_id @editor
    user_id @jim
    invite_num 1
  end

  factory :message do
    subject "Greetings"
    body "Hello, my name is Evan"
    read_status true
    send_date Date.today
    flagged false
  end
  

end