# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  def callback
    auth_hash = request.env['omniauth.auth']
    return redirect_to(root_path, alert: t('auth.failure')) if auth_hash.nil?

    email = auth_hash[:info][:email].downcase
    user = User.find_or_initialize_by(email: email)

    if user.new_record?
      user.name = auth_hash[:info][:name]
    end

    if user.save
      sign_in(user)
      redirect_to root_path, notice: t('auth.success')
    else
      redirect_to root_path, alert: t('auth.failure')
    end
  end

  def destroy
    sign_out
    redirect_to root_path, notice: t('auth.logout')
  end
end
