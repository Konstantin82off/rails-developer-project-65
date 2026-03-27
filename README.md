# Доска объявлений

### Hexlet tests and linter status:
[![Actions Status](https://github.com/Konstantin82off/rails-developer-project-65/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/Konstantin82off/rails-developer-project-65/actions)

[![CI](https://github.com/Konstantin82off/rails-developer-project-65/actions/workflows/ci.yml/badge.svg)](https://github.com/Konstantin82off/rails-developer-project-65/actions/workflows/ci.yml)

Проект "Доска объявлений" - аналог Avito, созданный в рамках обучения на Хекслете. 
Сервис позволяет пользователям размещать объявления, просматривать существующие и управлять ими.

## Демо

Приложение доступно по адресу: [https://rails-developer-project-65-kwud.onrender.com](https://rails-developer-project-65-kwud.onrender.com)

## Технологии

- **Ruby** 4.0.2
- **Ruby on Rails** 8.0
- **Bootstrap** 5 (с темой пагинации bootstrap4 для совместимости)
- **esbuild** для сборки JavaScript
- **PostgreSQL** (в продакшене)
- **Rollbar** для отслеживания ошибок
- **GitHub Actions** для CI/CD

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
rails db:seed

# Скопировать переменные окружения
cp .env.example .env
# Затем отредактируйте .env, добавив свои GITHUB_CLIENT_ID и GITHUB_CLIENT_SECRET
```

После запуска приложение будет доступно по адресу: [http://localhost:3000](http://localhost:3000/)

## **Настройка GitHub OAuth**

Для работы аутентификации через GitHub необходимо:

1. Зарегистрировать новое OAuth приложение на [GitHub](https://github.com/settings/developers)
2. Указать Homepage URL: http://localhost:3000 (для разработки) или URL вашего приложения (для продакшена)
3. Указать Authorization callback URL: http://localhost:3000/auth/github/callback
4. Скопировать Client ID и Client Secret в файл .env

## **Деплой**

Проект подготовлен для деплоя на Render. Необходимые переменные окружения:

- RAILS_MASTER_KEY - мастер-ключ Rails (из config/master.key)
- ROLLBAR_ACCESS_TOKEN - токен для Rollbar
- GITHUB_CLIENT_ID - Client ID от OAuth приложения
- GITHUB_CLIENT_SECRET - Client Secret от OAuth приложения
- DATABASE_URL - автоматически добавляется Render

## **Особенности реализации**

- Адаптивный интерфейс на Bootstrap 5
- Отслеживание ошибок через Rollbar
- Автоматические проверки кода через GitHub Actions
- Аутентификация через GitHub с помощью OmniAuth
- Makefile для автоматизации настройки проекта
- Полная локализация на русский язык (i18n)
- Поиск и фильтрация объявлений (ransack)
- Пагинация (kaminari с темой bootstrap4)
- Конечный автомат для управления статусами объявлений (AASM)

## **Автор**

**Константин**

- GitHub: [@Konstantin82off](https://github.com/Konstantin82off)
- Email: [k.udodov@internet.ru](mailto:k.udodov@internet.ru)