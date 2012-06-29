class ApplicationController < ActionController::Base
  protect_from_forgery

  ActiveScaffold.set_defaults do |config|
    config.ignore_columns.add [:created_at, :updated_at, :lock_version]
    config.actions.exclude :show
  end

private

  def after_sign_in_path_for(resource_or_scope)
    addresses_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

end
