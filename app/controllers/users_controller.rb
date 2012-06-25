class UsersController < ApplicationController
  before_filter :authenticate_user!
  active_scaffold :user do |conf|
    conf.columns = [:email, :current_sign_in_at, :current_sign_in_ip]
    conf.update.columns = [:email, :password, :password_confirmation]
    conf.create.columns = [:email, :password, :password_confirmation]
  end
end 
