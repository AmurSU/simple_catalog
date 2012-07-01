class Sector < ActiveRecord::Base
  has_many :disciplines
  has_many :addresses, :through => :disciplines

  attr_accessible :name

  validates :name, :presence => true, :uniqueness => true

  default_scope order("name ASC")

end
