# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  def callback
    user_info = request.env["omniauth.auth"]

    auth_info = user_info[:info]
    user = User.find_or_initialize_by(email: auth_info[:email].downcase)
    user.name = auth_info[:name]

    if user.save
      sign_in user
      redirect_to root_path, notice: t(".success")
    else
      redirect_to root_path, notice: t(".success")
    end
  end

  def logout
    sign_out

    redirect_to root_path, notice: t(".success")
  end
end
