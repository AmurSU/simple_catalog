class Address < ActiveRecord::Base
  attr_accessible :url

  before_save do |address|
    address.domain = URI.parse(address.url).host if address.url_changed?
  end

  validates_each :url do |record, attr, value|
    record.errors.add(attr, 'must be valid URI') if URI.parse(value).host.nil?
  end
  validates :url, :presence => true, :uniqueness => true

end
