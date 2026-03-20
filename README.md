# Доска объявлений

### Hexlet tests and linter status:
[![Actions Status](https://github.com/Konstantin82off/rails-developer-project-65/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/Konstantin82off/rails-developer-project-65/actions)

[![CI](https://github.com/Konstantin82off/rails-developer-project-65/actions/workflows/ci.yml/badge.svg)](https://github.com/Konstantin82off/rails-developer-project-65/actions/workflows/ci.yml)

Проект "Доска объявлений" - аналог Avito, созданный в рамках обучения на Хекслете. 
Сервис позволяет пользователям размещать объявления, просматривать существующие и управлять ими.

## Демо

Приложение доступно по адресу: [https://rails-developer-project-65.onrender.com](https://rails-developer-project-65.onrender.com)

## Технологии

- **Ruby** 3.2.2
- **Ruby on Rails** 7.2
- **Bootstrap** 5
- **esbuild** для сборки JavaScript
- **PostgreSQL** (в продакшене)
- **Rollbar** для отслеживания ошибок
- **GitHub Actions** для CI/CD
- **OmniAuth** аутентификация через GitHub
- **Pundit** авторизация и права доступа
- **AASM** конечные автоматы для управления состояниями
- **Ransack** поиск и фильтрация
- **Kaminari** пагинация

## Установка и запуск

### Быстрая настройка (рекомендуется)

```bash
# Клонировать репозиторий
git clone https://github.com/Konstantin82off/rails-developer-project-65.git
cd rails-developer-project-65

# Запустить автоматическую настройку проекта
make setup
```

### **Ручная настройка**

bash

```javascript
# Клонировать репозиторий
git clone https://github.com/Konstantin82off/rails-developer-project-65.git
cd rails-developer-project-65

# Установить зависимости
bundle install
yarn install

# Создать и настроить базу данных
rails db:create
rails db:migrate

# Скопировать переменные окружения
cp .env.example .env
# Затем отредактируйте .env, добавив свои GITHUB_CLIENT_ID и GITHUB_CLIENT_SECRET
```

После запуска приложение будет доступно по адресу: [http://localhost:3000](http://localhost:3000/)

## **Настройка GitHub OAuth**

Для работы аутентификации через GitHub необходимо:

1. Зарегистрировать новое OAuth приложение на [GitHub](https://github.com/settings/developers)
2. Указать Homepage URL: http://localhost:3000
3. Указать Authorization callback URL: http://localhost:3000/auth/github/callback
4. Скопировать Client ID и Client Secret в файл .env

## **Возможности приложения**

### **Управление объявлениями**

- Создание объявлений с заголовком, описанием, категорией и изображением
- Загрузка изображений (до 5 МБ)
- Валидация полей (максимум 50 символов для заголовка, 1000 для описания)

### **Статусы объявлений (конечный автомат)**

- **Черновик** — начальное состояние после создания
- **На модерации** — после отправки на проверку
- **Опубликовано** — после одобрения администратором
- **Отклонено** — если объявление не прошло модерацию
- **В архиве** — объявление можно отправить в архив в любой момент

### **Поиск и фильтрация**

- Поиск по названию и описанию на главной странице
- Фильтрация по категории и статусу
- Поиск по своим объявлениям в профиле пользователя
- Расширенный поиск в админ-панели (по пользователю, категории, статусу)

### **Пагинация**

- Главная страница — 12 объявлений
- Профиль пользователя — 10 объявлений
- Админ-панель — 20 объявлений

### **Админ-панель**

- Управление категориями (CRUD)
- Управление объявлениями (просмотр, редактирование, удаление)
- Управление пользователями (изменение прав администратора)
- Модерация объявлений (публикация, отклонение, отправка в архив)

### **Профиль пользователя**

- Просмотр своих объявлений
- Отправка объявлений на модерацию
- Отправка объявлений в архив
- Поиск и фильтрация по своим объявлениям

## **Деплой**

Проект подготовлен для деплоя на Render. Необходимые переменные окружения:

- RAILS_MASTER_KEY - мастер-ключ Rails (из config/master.key)
- ROLLBAR_ACCESS_TOKEN - токен для Rollbar
- GITHUB_CLIENT_ID - Client ID от OAuth приложения
- GITHUB_CLIENT_SECRET - Client Secret от OAuth приложения
- DATABASE_URL - автоматически добавляется Render

## **Особенности реализации**

- Адаптивный интерфейс на Bootstrap
- Отслеживание ошибок через Rollbar
- Автоматические проверки кода через GitHub Actions
- Аутентификация через GitHub с помощью OmniAuth
- Авторизация через Pundit (администраторы имеют расширенные права)
- Конечный автомат (AASM) для управления состояниями объявлений
- Поиск и фильтрация через Ransack
- Пагинация через Kaminari с Bootstrap 4 темой
- Makefile для автоматизации настройки проекта

## **Автор**

**Константин**

- GitHub: [@Konstantin82off](https://github.com/Konstantin82off)
- Email: [k.udodov@internet.ru](mailto:k.udodov@internet.ru)
