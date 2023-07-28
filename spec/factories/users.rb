FactoryBot.define do
  factory :user do
    email { "user@example.com" }
    password { "password" }
    password_confirmation { "password" }
    name { "testname" }
    lastname { "testlastname" }

    confirmed_at { Time.current }
  end
end
