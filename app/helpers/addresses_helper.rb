module AddressesHelper

  def address_url_form_column(record, options)
    url_field :record, :url, options
  end

end
