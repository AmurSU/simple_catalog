class Zone < ActiveRecord::Base
  attr_accessible :description, :suffix

  validates :suffix, :presence => true, :uniqueness => true

  before_save do |zone|
    zone.suffix = Unicode::downcase(zone.suffix)
    zone.suffix = "."+zone.suffix unless zone.suffix.start_with? "."
  end

end
