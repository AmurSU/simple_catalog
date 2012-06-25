module UsersHelper

  def user_email_form_column(record, options)
    email_field :record, :email, options
  end

  def user_password_form_column(record, options)
    password_field :record, :password, options
  end

  def user_password_confirmation_form_column(record, options)
    password_field :record, :password_confirmation, options
  end

end
