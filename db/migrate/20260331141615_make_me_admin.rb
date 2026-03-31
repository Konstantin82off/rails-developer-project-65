# frozen_string_literal: true

class MakeMeAdmin < ActiveRecord::Migration[8.0]
  def up
    user = User.find_by(email: 'k.udodov@internet.ru')
    if user
      user.update!(admin: true)
      puts "User #{user.email} is now admin"
    else
      puts "User with email k.udodov@internet.ru not found"
    end
  end

  def down
    user = User.find_by(email: 'k.udodov@internet.ru')
    user&.update!(admin: false)
  end
end
