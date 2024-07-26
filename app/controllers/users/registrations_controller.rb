module Users
  class Users::RegistrationsController < DeviseTokenAuth::RegistrationsController
    skip_before_action :authenticate_user!, only: [ :create ]

    respond_to :json

    def create
      user = User.new(sign_up_params)
      if user.save
        render json: { message: "Registration created" }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def sign_up_params
      params.permit(:name, :email, :password, :password_confirmation, :image)
    end

    def account_update_params
      params.permit(:name, :email, :password, :password_confirmation, :current_password, :image)
    end
  end
end
