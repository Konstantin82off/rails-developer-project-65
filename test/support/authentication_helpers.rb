# frozen_string_literal: true

module AuthenticationHelpers
  def sign_in(user, _options = {})
    setup_omniauth_mock(user)
    get '/auth/github/callback'
    follow_redirect!
  end

  def sign_out
    delete logout_path
  end

  def signed_in?
    session[:user_id].present? && current_user.present?
  end

  def current_user
    return @current_user if defined?(@current_user)

    @current_user = User.find_by(id: session[:user_id])
  end

  private

  def setup_omniauth_mock(user)
    auth_hash = {
      provider: 'github',
      uid: '12345',
      info: {
        email: user.email,
        name: user.name
      }
    }

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash::InfoHash.new(auth_hash)
  end
end
