# encoding: utf-8
FactoryGirl.define do

  factory :user do
    sequence(:email) { |i| "user#{i}@amursu.ru" }
    password "users_should_use_secure_passwords"
  end

end
