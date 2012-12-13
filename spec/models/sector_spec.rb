require "spec_helper"

describe Sector do

  it "is invalid without name" do
    sector = build(:sector, name: nil)
    sector.should_not be_valid
  end

  it "name is unique" do
    sector_1 = create(:sector)
    sector_2 = build(:sector, name: sector_1.name)
    sector_2.should_not be_valid
  end

end
