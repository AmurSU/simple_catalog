class UsersController < ApplicationController
  before_filter :authenticate_user!
  active_scaffold :user do |conf|
    conf.columns = [:uid]
    conf.list.columns = [:name, :uid, :email, :current_sign_in_at, :current_sign_in_ip, :created_at]
  end
end 
