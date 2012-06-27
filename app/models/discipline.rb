class Discipline < ActiveRecord::Base
  has_many :addresses

  attr_accessible :name

  validates :name, :presence => true, :uniqueness => true

  default_scope order("name ASC")

end
