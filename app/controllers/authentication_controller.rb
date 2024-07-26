class AuthenticationController < ApplicationController
  # skip_before_action :verify_authenticity_token, only: [ :authenticate ]
  # skip_before_filter :verify_authenticity_token
  # before_action :authenticate_user!
  # skip_before_action :verify_authenticity_token, only: "reply", raise: false
  skip_before_action :authenticate_user!, only: [ :authenticate ]

  def authenticate
    user = User.find_for_database_authentication(email: params[:email])
    Rails.logger.info "User found: #{user.inspect}"

    if user&.valid_password?(params[:password])
      token = user.generate_jwt
      Rails.logger.info "Generated token: #{token}"
      render json: { token: token }, status: :ok
    else
      Rails.logger.info "Invalid email or password"
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end
end
