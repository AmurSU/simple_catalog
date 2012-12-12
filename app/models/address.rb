class Address < ActiveRecord::Base
  include Addressable

  belongs_to :discipline

  attr_accessible :url, :description

  # Extract site host from URL
  before_save do |address|
    if address.url_changed?
      address.domain
      address.normalized_url
      address.normalized_domain
    end
  end

  validates_each :url do |record, attr, value|
    begin
      host = URI.parse(value).normalize.host unless value.nil?
      record.errors.add(attr, :no_host) if host.nil?
      record.errors.add(attr, :no_tld) unless host.nil? or host.include? '.' or host[-1] == '.'
    rescue URI::InvalidURIError
      record.errors.add(attr, :invalid)
    end
  end

  validates :url, :presence => true, :uniqueness => { :scope => :discipline_id }
  validates :description, :presence => true

  def to_label
    domain
  end

  def url=(value)
    if value.blank?
      self[:url] = value
      return
    end
    begin
      # If no protocol specified, add one. And check, that url always decoded to Unicode (for searching)
      value = "http://"+value if not value.strip.empty? and URI.parse(value).normalize.host.nil?
      url = URI.parse(URI::unencode(value))
      url.host = IDN::Idna.toUnicode(url.host)
      self[:url] = url.to_s
    rescue URI::InvalidURIError
      self[:url] = value
    end
  end

  def domain
    if self[:domain].blank? or url_changed?
      host = IDN::Idna.toUnicode( URI.parse(url).normalize.host )
      suffix_len = Zone.where("? ILIKE '%'||suffix", host).order("length DESC").pluck("char_length(suffix) AS length").first.to_i
      unless suffix_len.zero?
        suffix = host[-suffix_len..-1]
        host = host[0...-suffix_len]
        self[:domain] = host.split('.').last.to_s + suffix
      else
        parts = host.split('.')
        self[:domain] = "#{parts[-2]}.#{parts[-1]}"
      end
    end
    self[:domain]
  end

  def normalized_url
    if self["normalized_url"].blank? or url_changed?
      self["normalized_url"] = URI.parse(url).normalize.to_s
    end
    self["normalized_url"]
  end

  def normalized_domain
    if self["normalized_domain"].blank? or url_changed?
      self["normalized_domain"] = IDN::Idna.toASCII(domain)
    end
    self["normalized_domain"]
  end

end
