class Address < ActiveRecord::Base
  attr_accessible :url

  before_save do |address|
    if address.url_changed?
      parts = URI.parse(address.url).host.split(".")
      address.domain = "#{parts[-2]}.#{parts[-1]}"
    end
  end

  validates_each :url do |record, attr, value|
    record.errors.add(attr, 'must be valid URI') if URI.parse(value).host.nil?
  end
  validates :url, :presence => true, :uniqueness => true
  validates :description, :presence => true

end
