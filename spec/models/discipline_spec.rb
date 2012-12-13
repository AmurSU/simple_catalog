# encoding: utf-8
require "spec_helper"

describe Discipline do

  it "is invalid without name" do
    discipline = build(:discipline, name: nil)
    discipline.should_not be_valid
  end

  it "name is unique" do
    discipline_1 = create(:discipline)
    discipline_2 = build(:discipline, name: discipline_1.name)
    discipline_2.should_not be_valid
  end

end
