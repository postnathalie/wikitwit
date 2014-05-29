FactoryGirl.define do
  factory :user do
    name     "Nathalie Post"
    email    "npost@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end