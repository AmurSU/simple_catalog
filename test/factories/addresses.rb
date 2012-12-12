# encoding: utf-8
FactoryGirl.define do

  factory :address do
    sequence(:url) { |i| (i-1).zero? ? "http://www.example.com/" : "http://node#{i-1}.example.net/" }
    description "Address description"
    association :discipline

    factory :address_idn do
      sequence(:url) { |i| (i-1).zero? ? "http://www.пример.рф/" : "http://пример#{i-1}.рф/" }
    end

    factory :address_idn_with_path do
      sequence(:url) { |i| "#{((i-1).zero? ? "http://www.пример.рф/" : "http://пример#{i-1}.рф/")}примеры/Example 1.html" }
    end

    factory :address_in_zone do
      sequence(:url) { |i| (i-1).zero? ? "http://www.bash.org.ru/" : "http://site#{i-1}.org.ru/" }
    end

  end

end
