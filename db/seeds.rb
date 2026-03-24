# frozen_string_literal: true

# Создаем администратора
User.find_or_create_by!(email: 'admin@example.com') do |user|
  user.name = 'Admin'
  user.admin = true
end

# Создаем обычных пользователей
users = []
5.times do |i|
  users << User.find_or_create_by!(email: "user#{i + 1}@example.com") do |user|
    user.name = "User #{i + 1}"
    user.admin = false
  end
end

# Создаем категории
categories = %w[Недвижимость Автомобили Работа Услуги Электроника].map do |name|
  Category.find_or_create_by!(name: name)
end

# Создаем 100 объявлений
100.times do |i|
  bulletin = Bulletin.new(
    title: "Объявление ##{i + 1}",
    description: "Описание объявления ##{i + 1}.",
    user: users.sample,
    category: categories.sample
  )

  bulletin.save(validate: false)

  case i % 5
  when 0
    bulletin.draft!
  when 1
    bulletin.under_moderation!
  when 2
    bulletin.published!
  when 3
    bulletin.rejected!
  when 4
    bulletin.archived!
  end
end

puts "Создано:"
puts "  - Пользователей: #{User.count}"
puts "  - Администраторов: #{User.where(admin: true).count}"
puts "  - Категорий: #{Category.count}"
puts "  - Объявлений: #{Bulletin.count}"
puts "  - Статусы объявлений:"
Bulletin.group(:state).count.each do |state, count|
  puts "    - #{state}: #{count}"
end
