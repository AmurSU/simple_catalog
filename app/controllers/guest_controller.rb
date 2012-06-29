class GuestController < ApplicationController

  def domains
    @domains = Address.order("domain ASC")
    @domains = @domains.where("domain ILIKE ?", "%"+params[:search]+"%") if params[:search]
    @domains = @domains.uniq.pluck("domain")
    respond_to do |format|
      format.html
      format.squid { render :text => @domains.map{|d| ".#{d}"}.join("\n") }
      format.text  { render :text => @domains.join("\n") }
      format.json  { render :json => @domains }
      format.xml   { render :xml  => @domains }
    end
  end

end
