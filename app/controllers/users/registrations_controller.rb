module Users
  class Users::RegistrationsController < DeviseTokenAuth::RegistrationsController
    # before_action :set_provider
    # before_action :set_provider, only: [ :create ]

    skip_before_action :authenticate_user!, only: [ :create ]

    respond_to :json

    # def set_provider
    #   self[:provider]="email" if self[:provider].blank?
    # end
    # def set_provider
    #   # Ensure the provider is set in the params before creating the user
    #   params[:provider]= "email"
    # end

    def create
      user = User.new(sign_up_params)
      user.provider = "email"
      if user.save
        render json: { message: "Registration created" }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def sign_up_params
      params.permit(:name, :email, :password, :password_confirmation, :image)
      # params.permit(:name, :email, :password, :password_confirmation, :image, :provider)
      # permitted_params = params.permit(:name, :email, :password, :password_confirmation, :image, :provider)
      # permitted_params[:provider] = "email" if permitted_params[:provider].blank?
      # permitted_params
    end

    def account_update_params
      params.permit(:name, :email, :password, :password_confirmation, :current_password, :image)
    end
  end
end
