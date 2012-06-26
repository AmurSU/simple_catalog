class AddressesController < ApplicationController
  active_scaffold :address do |conf|
    conf.columns = [:url]
    conf.list.columns = [:url, :domain]
  end
end 
