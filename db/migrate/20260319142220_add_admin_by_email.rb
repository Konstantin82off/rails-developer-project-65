class AddAdminByEmail < ActiveRecord::Migration[7.2]
  def up
    user = User.find_by(email: 'k.udodov@internet.ru')
    user&.update(admin: true)
  end

  def down
    user = User.find_by(email: 'k.udodov@internet.ru')
    user&.update(admin: false)
  end
end
