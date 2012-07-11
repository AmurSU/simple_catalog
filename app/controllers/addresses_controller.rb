class AddressesController < ApplicationController
  before_filter :authenticate_user!, :except => :domains
  active_scaffold :address do |conf|
    conf.columns = [:url, :description, :discipline]
    conf.list.columns = [:url, :description, :discipline, :domain]
    conf.columns[:discipline].clear_link
    conf.columns[:discipline].form_ui = :select
    conf.action_links.add :domains, :type => :collection, :inline => false, :page => true,
                                    :label => I18n.t("addresses.domains")
  end

  def domains
    @addresses = Address.group("domain").order("domain ASC")
                      .select("domain, string_agg(description, ', ') AS description")
    if params[:discipline_id]
      @discipline = Discipline.find(params[:discipline_id])
      @addresses = @addresses.where(:discipline_id => @discipline.id)
    end
    respond_to do |format|
      format.html
      format.squid { render :text => @addresses.map{|d| ".#{d.domain}\t##{d.description}"}.join("\n") }
      format.text  { render :text => @addresses.map{|d| d.domain }.join("\n") }
      format.json  { render :json => @addresses.to_json(:only => [:domain, :description]) }
      format.xml   { render :xml  => @addresses.to_xml( :only => [:domain, :description]) }
    end
  end

  def rebuild
    ActiveRecord::Base.transaction do
      Address.find_each do |address|
        address.domain = address.get_domain
        address.save
      end
    end
    redirect_to addresses_path
  end

end 
