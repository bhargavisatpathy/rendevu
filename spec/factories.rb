FactoryGirl.define do

  factory :user do
    first_name "Siya"
    last_name "Purohit"
    email "siya@email.com"
    password "password"
    password_confirmation "password"
  end

  factory :friend do
    name "Luna"
    phone_number "1234567891"
  end
end
