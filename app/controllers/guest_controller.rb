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

  def catalog
    options = {}
    if params[:format].nil? or params[:format] == 'html'
      @sectors = Sector.all
      if params[:sector_id]
        @disciplines = Discipline.where(:sector_id => params[:sector_id])
        if params[:sector_id]
          @addresses = Address.where(:discipline_id => params[:discipline_id])
        end
      end
    else
      @sectors = Sector.includes(:disciplines => :addresses)
      options = {:only => :name, :include => {
                   :disciplines => {:only => :name, :include => {
                                      :addresses => {:only => [:url, :description, :domain]}
                                   }}
                }}
    end
    respond_to do |format|
      format.html  
      format.json  { render :json => @sectors.to_json(options) }
      format.xml   { render :xml  => @sectors.to_xml(options) }
    end
  end

end
