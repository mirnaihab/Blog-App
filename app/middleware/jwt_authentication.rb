# app/middleware/jwt_authentication.rb
class JwtAuthentication
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    if request.headers["Authorization"].present?
      token = request.headers["Authorization"].split(" ").last
      decoded_token = JWT.decode(token, Rails.application.credentials.devise[:jwt_secret_key], true, algorithm: "HS256")[0]
      env["warden"].authenticate!
    end
    @app.call(env)
  rescue JWT::DecodeError
    [ 401, { "Content-Type" => "application/json" }, [ { error: "Invalid token" }.to_json ] ]
  end
end
