class ZonesController < ApplicationController
  before_filter :authenticate_user!
  active_scaffold :zone do |conf|
    conf.columns = [:suffix, :description]
  end
end 
