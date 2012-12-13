# encoding: utf-8
require "spec_helper"

describe Zone do

  it "is invalid without suffix" do
    zone = build(:zone, suffix: nil)
    zone.should_not be_valid
  end

  it "suffix is unique" do
    zone_1 = create(:zone)
    zone_2 = build(:zone, suffix: zone_1.suffix)
    zone_2.should_not be_valid
  end

  it "stores downcased suffix" do
    zone = create(:zone, suffix: ".ORG.RU")
    zone.suffix.should == ".org.ru"
    zone = create(:zone, suffix: ".ОРГ.РФ")
    zone.suffix.should == ".орг.рф"
  end

  it "prepend a dot to suffix if needed" do
    zone = create(:zone, suffix: "com.ua")
    zone.suffix.should == ".com.ua"
    zone = create(:zone, suffix: ".gov.ru")
    zone.suffix.should == ".gov.ru"
  end

end
