class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken
  # allow_browser
  # before_action :decode_jwt_and_store_in_cookies

  before_action :authenticate_user!

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern
  #
  # skip_before_action :authenticate_user!, only: [ :signup, :login ]

  private


  def authenticate_user!
    token = request.headers["Authorization"]&.split(" ")&.last
    return render_unauthorized unless token

    decoded_token = JwtService.decode(token)
    return render_unauthorized unless decoded_token

    @current_user = User.find_by(id: decoded_token[:user_id])
    render_unauthorized unless @current_user
  end

  def render_unauthorized
    render json: { errors: [ "You need to sign in or sign up before continuing." ] }, status: :unauthorized
  end
end
