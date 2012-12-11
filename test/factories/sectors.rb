# encoding: utf-8
FactoryGirl.define do

  factory :sector do
    sequence(:name) { |i| "Sector #{i}" }
  end

end
