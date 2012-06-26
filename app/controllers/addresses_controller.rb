class AddressesController < ApplicationController
  before_filter :authenticate_user!, :except => :domains
  active_scaffold :address do |conf|
    conf.columns = [:url, :description]
    conf.list.columns = [:url, :description, :domain]
    conf.action_links.add :domains, :type => :collection, :inline => false, :page => true,
                                    :label => I18n.t("addresses.domains")
  end

  def domains
    @addresses = Address.group("domain").order("domain ASC")
                      .select("domain, string_agg(description, ', ') AS description")
    respond_to do |format|
      format.html
      format.squid { render :text => @addresses.map{|d| ".#{d.domain}\t##{d.description}"}.join("\n") }
      format.text  { render :text => @addresses.map{|d| d.domain }.join("\n") }
      format.json  { render :json => @addresses.to_json(:only => [:domain, :description]) }
      format.xml   { render :xml  => @addresses.to_xml( :only => [:domain, :description]) }
    end
  end
end 
