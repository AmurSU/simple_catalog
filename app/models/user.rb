class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :registerable,
  # :database_authenticatable, :validatable,
  # :lockable, :recoverable, :timeoutable and :omniauthable
  devise :ldap_authenticatable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :uid, :name
  # attr_accessible :title, :body

  before_save :get_ldap_name, :get_ldap_email
 
  def get_ldap_name
      Rails::logger.info("### Getting the user name from LDAP")
      tempname = Devise::LdapAdapter.get_ldap_param(self.uid,"displayName")
      self.name = tempname.force_encoding("UTF-8")
  end

  def get_ldap_email
      Rails::logger.info("### Getting the user email address from LDAP")
      tempmail = Devise::LdapAdapter.get_ldap_param(self.uid,"mail")
      self.email = tempmail.force_encoding("UTF-8")
  end

end
