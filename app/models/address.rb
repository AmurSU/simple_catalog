class Address < ActiveRecord::Base
  include Addressable

  belongs_to :discipline

  attr_accessible :url, :description

  # Extract site host from URL
  before_save do |address|
    if address.url_changed?
      address.domain = get_domain
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

  def get_domain
    domain = ""
    host = IDN::Idna.toUnicode( URI.parse(url).normalize.host )
    suffix_len = Zone.where("? ILIKE '%'||suffix", host).order("length DESC").pluck("char_length(suffix) AS length").first.to_i
    unless suffix_len.zero?
      suffix = host[-suffix_len..-1]
      host = host[0...-suffix_len]
      domain = host.split('.').last.to_s + suffix
    else
      parts = host.split('.')
      domain = "#{parts[-2]}.#{parts[-1]}"
    end
    return domain
  end

end
