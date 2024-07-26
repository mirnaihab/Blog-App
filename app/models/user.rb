class User < ApplicationRecord
  has_many :posts
            # Include default devise modules.
            devise :database_authenticatable, :registerable,
                    :recoverable, :rememberable, :trackable, :validatable,
                    :confirmable, :omniauthable
            include DeviseTokenAuth::Concerns::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :image, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }

  def generate_jwt
    payload = {
      user_id: id,
      exp: 24.hours.from_now.to_i,
      iat: Time.now.to_i
    }
    JWT.encode(payload, Rails.application.credentials.dig(:devise, :jwt_secret_key))
  end

  def decode_jwt(token)
    decoded_token = JWT.decode(token, Rails.application.credentials.dig(:devise, :jwt_secret_key), true, { algorithm: "HS256" })
    decoded_token.first
  rescue JWT::DecodeError
    nil
  end
  # def generate_jwt
  # JWT.encode({ id: id, exp: 60.days.from_now.to_i }, Rails.application.credentials.dig(:devise, :jwt_secret_key))
  # end
  # def generate_jwt
  #   payload = { user_id: id, exp: 24.hours.from_now.to_i }
  #   JWT.encode(payload, Rails.application.secrets.secret_key_base)
  # end
end
