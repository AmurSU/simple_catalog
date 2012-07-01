class DisciplinesController < ApplicationController
  before_filter :authenticate_user!
  active_scaffold :discipline do |conf|
    conf.update.columns.exclude :addresses
    conf.create.columns.exclude :addresses
    conf.nested.add_link :addresses
    conf.columns[:sector].form_ui = :select
  end
end 
