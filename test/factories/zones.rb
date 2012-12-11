# encoding: utf-8
FactoryGirl.define do

  factory :zone do
    sequence(:suffix) { |i| (i-1).zero? ? ".org.ru" : "sub1.tld" }
    description "A domain zone with a registration not in top level domain"
  end

end
