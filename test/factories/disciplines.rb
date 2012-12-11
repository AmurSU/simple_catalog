# encoding: utf-8
FactoryGirl.define do

  factory :discipline do
    sequence(:name) { |i| "Discipline #{i}" }
    association :sector
  end

end
