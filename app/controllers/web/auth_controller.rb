# frozen_string_literal: true

module Web
  class AuthController < Web::ApplicationController
    def callback
      user_info = request.env['omniauth.auth']

      auth_info = user_info[:info]
      user = User.find_or_initialize_by(email: auth_info[:email].downcase)
      user.name = auth_info[:name]

      sign_in user if user.save
      redirect_to root_path, notice: t('.success')
    end

    def logout
      sign_out

      redirect_to root_path, notice: t('.success')
    end
  end
end
