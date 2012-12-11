module AddressesHelper

  def address_url_form_column(record, options)
    url_field :record, :url, options
  end

  def address_url_column(record, column)
    raw link_to(record.url, record.normalized_url)
  end

  def address_domain_column(record, column)
    raw link_to(record.domain, "http://"+record.normalized_domain+"/")
  end

end
