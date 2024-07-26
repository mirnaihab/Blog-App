module AuthHelper
  def authenticated_header
    user = FactoryBot.create(:user) # or however you create your user
    token = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
    { 'Authorization': "Bearer #{token}" }
  end
end

RSpec.configure do |config|
  config.include AuthHelper, type: :request
end
