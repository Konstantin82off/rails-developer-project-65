# frozen_string_literal: true

module Web
  class AuthController < Web::ApplicationController
    # POST /auth/:provider
    def request
      redirect_to "/auth/#{params[:provider]}", allow_other_host: true
    end

    # GET /auth/:provider/callback
    def callback
      auth_hash = request.env['omniauth.auth']
      return redirect_to(root_path, alert: t('auth.failure')) if auth_hash.nil?

      user = find_or_create_user_from_auth(auth_hash)
      session[:user_id] = user.id

      redirect_to root_path, notice: t('auth.success')
    end

    def destroy
      session[:user_id] = nil
      redirect_to root_path, notice: t('auth.logout')
    end

    private

    def find_or_create_user_from_auth(auth_hash)
      email = auth_hash[:info][:email].downcase
      name = auth_hash[:info][:name]

      user = User.find_or_initialize_by(email: email)
      return user unless user.new_record?

      user.name = name
      user.save!
      user
    end
  end
end
