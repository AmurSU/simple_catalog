class GuestController < ApplicationController

  def domains
    @domains = Address.order("domain ASC")
    @domains = @domains.where("domain ILIKE ?", "%"+params[:search]+"%") if params[:search]
    @domains = @domains.uniq.pluck("domain") unless params[:format] == 'squid'
    respond_to do |format|
      format.html
      format.squid {
        @domains = @domains.group("domain").select("domain, string_agg(description, ', ') AS description")
        max_length = @domains.inject(0){|max,elem| elem.domain.length > max ? elem.domain.length : max }
        @domains.map!{|d| "#{".#{d.domain}".ljust(max_length+1)} #{"# "+d.description if d.description}"}
        render :text => @domains.join("\n")
      }
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
                                      :addresses => {:only => [:url, :domain]}
                                   }}
                }}
    end
    respond_to do |format|
      format.html  
      format.json  { render :json => @sectors.to_json(options) }
      format.xml   { render :xml  => @sectors.to_xml(options) }
    end
  end

  def disciplines
    @disciplines = Discipline.where(:sector_id => params[:sector_id])
    respond_to do |format|
      format.json { render :json => @disciplines.to_json(:only => [:id, :name]) }
    end
  end

  def addresses
    @addresses = Address.where(:discipline_id => params[:discipline_id])
    respond_to do |format|
      format.json { render :json => @addresses.to_json(:only => [:id, :url, :domain]) }
    end
  end

end
