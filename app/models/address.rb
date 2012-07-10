class Address < ActiveRecord::Base
  include Addressable

  belongs_to :discipline

  attr_accessible :url, :description

  before_save do |address|
    if address.url_changed?
      host = URI.parse(address.url).normalize.host
      parts = IDN::Idna.toUnicode(host).split('.')
      address.domain = "#{parts[-2]}.#{parts[-1]}"
    end
  end

  validates_each :url do |record, attr, value|
    begin
      host = URI.parse(value).normalize.host
      record.errors.add(attr, 'must contain a host part!') if host.nil?
      record.errors.add(attr, 'hostname should include TLD!') unless host.include? '.' or host[-1] == '.'
    rescue URI::InvalidURIError
      record.errors.add(attr, 'must be valid URI')
    end
  end

  validates :url, :presence => true, :uniqueness => { :scope => :discipline_id }
  validates :description, :presence => true

  def to_label
    domain
  end

  def normalized_url
    @normalized_url ||= URI.parse(url).normalize.to_s
  end

  def normalized_domain
    @normalized_domain ||= IDN::Idna.toASCII(domain)
  end

  # If no protocol specified, add one
  def url=(value)
    begin
      value = "http://"+value if not value.strip.empty? and URI.parse(value).normalize.host.nil?
      self[:url] = value
    rescue URI::InvalidURIError
      self[:url] = value
    end
  end

end
