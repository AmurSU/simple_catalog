class SectorsController < ApplicationController
  before_filter :authenticate_user!
  active_scaffold :sector do |conf|
    conf.columns = [:name, :disciplines]
    conf.update.columns.exclude :disciplines
    conf.create.columns.exclude :disciplines
    conf.nested.add_link :disciplines
  end
end 
