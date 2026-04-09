# frozen_string_literal: true

# Подключаем хелпер для изображений
require_relative '../test/support/image_helper'

# Создаем администратора
User.find_or_create_by!(email: 'k.udodov@internet.ru') do |user|
  user.name = 'Admin'
  user.admin = true
end

# Создаем обычных пользователей
users = []
users << User.find_or_create_by!(email: 'john@example.com') do |user|
  user.name = 'John Doe'
  user.admin = false
end

users << User.find_or_create_by!(email: 'jane@example.com') do |user|
  user.name = 'Jane Smith'
  user.admin = false
end

3.times do |i|
  users << User.find_or_create_by!(email: "user#{i + 3}@example.com") do |user|
    user.name = "User #{i + 3}"
    user.admin = false
  end
end

# Создаем категории
categories_data = [
  { name: 'Автомобили' },
  { name: 'Электроника' },
  { name: 'Работа' },
  { name: 'Недвижимость' },
  { name: 'Услуги' },
  { name: 'Личные вещи' },
  { name: 'Транспорт' },
  { name: 'Хобби' },
  { name: 'Животные' },
  { name: 'Для дома' },
  { name: 'Бизнес' }
]

categories = categories_data.map do |data|
  Category.find_or_create_by!(name: data[:name])
end

# Создаем объявления из фикстур
bulletins_from_fixtures = [
  { title: 'Продам Toyota Camry', description: 'Отличный автомобиль, 2020 года, в хорошем состоянии', user: users.first, category: categories.find { |c| c.name == 'Автомобили' }, state: 'published' },
  { title: 'iPhone 14 Pro Max', description: 'Новый, в упаковке, гарантия', user: users.second, category: categories.find { |c| c.name == 'Электроника' }, state: 'published' },
  { title: 'Требуется Ruby разработчик', description: 'Удаленная работа, гибкий график', user: users.first, category: categories.find { |c| c.name == 'Работа' }, state: 'published' },
  { title: 'На модерации', description: 'Объявление на модерации', user: users.first, category: categories.find { |c| c.name == 'Автомобили' }, state: 'under_moderation' },
  { title: 'Черновик', description: 'Черновик объявления', user: users.second, category: categories.find { |c| c.name == 'Электроника' }, state: 'draft' },
  { title: 'Отклоненное объявление', description: 'Это объявление было отклонено', user: users.first, category: categories.find { |c| c.name == 'Работа' }, state: 'rejected' }
]

bulletins_from_fixtures.each do |data|
  bulletin = Bulletin.new(
    title: data[:title],
    description: data[:description],
    user: data[:user],
    category: data[:category],
    state: data[:state]
  )
  ImageHelper.attach_test_image(bulletin)
  bulletin.save!
end

# Создаем дополнительные объявления для пагинации (25 штук)
if Bulletin.count < 30
  25.times do |i|
    bulletin = Bulletin.new(
      title: "Тестовое объявление #{i + 1}",
      description: "Описание тестового объявления #{i + 1}. " + ('x' * 50),
      user: users.sample,
      category: categories.sample,
      state: 'published'
    )
    ImageHelper.attach_test_image(bulletin)
    bulletin.save!
  end
end

Rails.logger.info 'Создано:'
Rails.logger.info "  - Пользователей: #{User.count}"
Rails.logger.info "  - Администраторов: #{User.where(admin: true).count}"
Rails.logger.info "  - Категорий: #{Category.count}"
Rails.logger.info "  - Объявлений: #{Bulletin.count}"
Rails.logger.info '  - Статусы объявлений:'
Bulletin.group(:state).count.each do |state, count|
  Rails.logger.info "    - #{state}: #{count}"
end
Rails.logger.info "  - Опубликованных объявлений: #{Bulletin.published.count}"
Rails.logger.info "  - Объявления с изображениями: #{Bulletin.joins(:image_attachment).count}"
