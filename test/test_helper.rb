ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  include Devise::TestHelpers
  include FactoryGirl::Syntax::Methods

  def sign_in_user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in users(:pupkin)
  end

end
