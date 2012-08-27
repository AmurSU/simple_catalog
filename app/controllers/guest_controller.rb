class GuestController < ApplicationController

  def domains
    @domains = Address.order("domain ASC")
    if params[:search]
      param = "%"+params[:search]+"%"
      @domains = @domains.where("domain ILIKE ? OR url ILIKE ?", param, param)
    end
    @domains = @domains.uniq.pluck("domain") unless params[:format] == 'squid'
    @domains.map! { |d| IDN::Idna.toASCII(d) } unless params[:format] == 'squid'
    respond_to do |format|
      format.html
      format.squid {
        @domains = @domains.group("domain").select("domain, string_agg(description, ', ') AS description")
        max_length = @domains.map{ |address| address.normalized_domain.length }.max
        @domains.map!{|d| "#{".#{d.normalized_domain}".ljust(max_length+1)} #{"# "+d.description if d.description}"}
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
      @disciplines = Discipline.all
      if params[:discipline_id]
        @addresses = Address.where(:discipline_id => params[:discipline_id])
      end
    else
      @disciplines = Discipline.includes(:addresses)
      options = {:only => :name, :include => {
                                      :addresses => {:only => [:url, :domain]}
                                 }
                }
    end
    respond_to do |format|
      format.html  
      format.json  { render :json => @disciplines.to_json(options) }
      format.xml   { render :xml  => @disciplines.to_xml(options) }
    end
  end

  def addresses
    @addresses = Address.where(:discipline_id => params[:discipline_id]).order("url ASC")
    respond_to do |format|
      format.json { render :json => @addresses.to_json(:only => [:id, :url, :domain], :methods => [:normalized_url, :normalized_domain]) }
    end
  end

end
