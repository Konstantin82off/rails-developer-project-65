# frozen_string_literal: true

# Создаем администратора
User.find_or_create_by!(email: 'admin@example.com') do |user|
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

# Добавляем дополнительных пользователей
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

# Вспомогательная функция для создания тестового изображения
def attach_test_image(bulletin)
  tempfile = Tempfile.new(['image', '.jpg'])
  tempfile.binmode
  # Минимальный валидный JPEG (1x1 пиксель)
  tempfile.write("\xFF\xD8\xFF\xE0\x00\x10JFIF\x00\x01\x01\x00\x00\x01\x00\x01\x00\x00\xFF\xDB\x00C\x00\x08\x06\x06\x07\x06\x05\x08\x07\x07\x07\t\t\x08\n\x0C\x14\r\x0C\x0B\x0B\x0C\x19\x12\x13\x0F\x14\x1D\x1A\x1F\x1E\x1D\x1A\x1C\x1C $.' ,#\x1C\x1C(7)(014\x1F\x1C\x1C\x1C\x1C\x1C\x1C\x1C\x1C\x1C\x1C\x1C\x1C\x1C\x1C\x1C\x1C\x1C\x1C\x1C\x1C\xFF\xC0\x00\x11\x08\x00\x01\x00\x01\x03\x01\x22\x00\x02\x11\x01\x03\x11\x01\xFF\xC4\x00\x1F\x00\x00\x01\x05\x01\x01\x01\x01\x01\x01\x00\x00\x00\x00\x00\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0A\x0B\xFF\xC4\x00\xB5\x10\x00\x02\x01\x03\x03\x02\x04\x03\x05\x05\x04\x04\x00\x00\x01\x02\x03\x00\x04\x11\x05\x12\x21\x31\x41\x06\x13\x51\x61\x07\x22\x71\x14\x32\x81\x91\xA1\x08\x23\x42\xB1\xC1\x15\x52\xD1\xF0\x24\x33\x62\x72\x82\x09\x0A\x16\x17\x18\x19\x1A\x25\x26\x27\x28\x29\x2A\x34\x35\x36\x37\x38\x39\x3A\x43\x44\x45\x46\x47\x48\x49\x4A\x53\x54\x55\x56\x57\x58\x59\x5A\x63\x64\x65\x66\x67\x68\x69\x6A\x73\x74\x75\x76\x77\x78\x79\x7A\x83\x84\x85\x86\x87\x88\x89\x8A\x92\x93\x94\x95\x96\x97\x98\x99\x9A\xA2\xA3\xA4\xA5\xA6\xA7\xA8\xA9\xAA\xB2\xB3\xB4\xB5\xB6\xB7\xB8\xB9\xBA\xC2\xC3\xC4\xC5\xC6\xC7\xC8\xC9\xCA\xD2\xD3\xD4\xD5\xD6\xD7\xD8\xD9\xDA\xE1\xE2\xE3\xE4\xE5\xE6\xE7\xE8\xE9\xEA\xF1\xF2\xF3\xF4\xF5\xF6\xF7\xF8\xF9\xFA\xFF\xC4\x00\x1F\x01\x00\x03\x01\x01\x01\x01\x01\x01\x01\x01\x01\x00\x00\x00\x00\x00\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0A\x0B\xFF\xC4\x00\xB5\x11\x00\x02\x01\x02\x04\x04\x03\x04\x07\x05\x04\x04\x00\x01\x02\x77\x00\x01\x02\x03\x11\x04\x05\x21\x31\x06\x12\x41\x51\x07\x61\x71\x13\x22\x32\x81\x08\x14\x42\x91\xA1\xB1\xC1\x09\x23\x33\x52\xF0\x15\x62\x72\xD1\x0A\x16\x24\x34\xE1\x25\xF1\x17\x18\x19\x1A\x26\x27\x28\x29\x2A\x35\x36\x37\x38\x39\x3A\x43\x44\x45\x46\x47\x48\x49\x4A\x53\x54\x55\x56\x57\x58\x59\x5A\x63\x64\x65\x66\x67\x68\x69\x6A\x73\x74\x75\x76\x77\x78\x79\x7A\x82\x83\x84\x85\x86\x87\x88\x89\x8A\x92\x93\x94\x95\x96\x97\x98\x99\x9A\xA2\xA3\xA4\xA5\xA6\xA7\xA8\xA9\xAA\xB2\xB3\xB4\xB5\xB6\xB7\xB8\xB9\xBA\xC2\xC3\xC4\xC5\xC6\xC7\xC8\xC9\xCA\xD2\xD3\xD4\xD5\xD6\xD7\xD8\xD9\xDA\xE2\xE3\xE4\xE5\xE6\xE7\xE8\xE9\xEA\xF2\xF3\xF4\xF5\xF6\xF7\xF8\xF9\xFA\xFF\xDA\x00\x0C\x03\x01\x00\x02\x11\x03\x11\x00\x3F\x00\xF9\xFF\x00\xFF\xD9")
  tempfile.rewind

  bulletin.image.attach(
    io: tempfile,
    filename: 'test_image.jpg',
    content_type: 'image/jpeg'
  )
ensure
  tempfile.close
  tempfile.unlink
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
  bulletin = Bulletin.find_or_create_by!(title: data[:title]) do |b|
    b.description = data[:description]
    b.user = data[:user]
    b.category = data[:category]
    b.state = data[:state]
  end
  attach_test_image(bulletin) unless bulletin.image.attached?
end

# Создаем дополнительные опубликованные объявления (для пагинации)
if Bulletin.published.count < 10
  20.times do |i|
    bulletin = Bulletin.new(
      title: "Дополнительное объявление #{i + 1}",
      description: "Описание дополнительного объявления #{i + 1}. Здесь может быть длинный текст для проверки отображения.",
      user: users.sample,
      category: categories.sample,
      state: 'published'
    )
    bulletin.save(validate: false)
    attach_test_image(bulletin) if i % 3 != 0
  end
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

  attach_test_image(bulletin) if i % 5 != 0

  state = case i % 5
          when 0 then 'draft'
          when 1 then 'under_moderation'
          when 2 then 'published'
          when 3 then 'rejected'
          when 4 then 'archived'
          end
  bulletin.update(state: state)
end

# Добавляем дополнительные опубликованные объявления
10.times do |i|
  bulletin = Bulletin.new(
    title: "Актуальное объявление #{i + 1}",
    description: "Актуальное описание объявления #{i + 1}",
    user: users.first,
    category: categories.first,
    state: 'published'
  )
  bulletin.save(validate: false)
  attach_test_image(bulletin)
end

Rails.logger.debug 'Создано:'
Rails.logger.debug { "  - Пользователей: #{User.count}" }
Rails.logger.debug { "  - Администраторов: #{User.where(admin: true).count}" }
Rails.logger.debug { "  - Категорий: #{Category.count}" }
Rails.logger.debug { "  - Объявлений: #{Bulletin.count}" }
Rails.logger.debug '  - Статусы объявлений:'
Bulletin.group(:state).count.each do |state, count|
  Rails.logger.debug "    - #{state}: #{count}"
end
Rails.logger.debug { "  - Опубликованных объявлений: #{Bulletin.published.count}" }
Rails.logger.debug { "  - Объявления с изображениями: #{Bulletin.joins(:image_attachment).count}" }
