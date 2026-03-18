# frozen_string_literal: true

class AuthController < ApplicationController
  def request
    # Этот метод просто инициирует OAuth редирект
    # OmniAuth обработает это автоматически
    redirect_to '/auth/github'
  end

  def callback
    auth_hash = request.env['omniauth.auth']
    email = auth_hash[:info][:email].downcase
    name = auth_hash[:info][:name]

    user = find_or_create_user(email, name)

    session[:user_id] = user.id
    redirect_to root_path, notice: t('.success')
  end

  private

  def find_or_create_user(email, name)
    user = User.find_or_initialize_by(email: email)

    if user.new_record?
      user.name = name
      user.save!
    end

    user
  end
end
