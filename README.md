# Доска объявлений

### Hexlet tests and linter status:
[![Actions Status](https://github.com/Konstantin82off/rails-developer-project-65/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/Konstantin82off/rails-developer-project-65/actions)

[![CI](https://github.com/Konstantin82off/rails-developer-project-65/actions/workflows/ci.yml/badge.svg)](https://github.com/Konstantin82off/rails-developer-project-65/actions/workflows/ci.yml)

Проект "Доска объявлений" — аналог Avito, созданный в рамках обучения на Хекслете. 
Сервис позволяет пользователям размещать объявления, просматривать существующие и управлять ими.

## Демо

Приложение доступно по адресу: [https://rails-developer-project-65-kwud.onrender.com](https://rails-developer-project-65-kwud.onrender.com)

## Технологии

- **Ruby** 4.0.2
- **Ruby on Rails** 8.0
- **Bootstrap** 5
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
2. Для локальной разработки указать:
   - **Homepage URL**: http://localhost:3000
   - **Authorization callback URL**: http://localhost:3000/auth/github/callback
3. Для продакшена на Render указать:
   - **Homepage URL**: https://rails-developer-project-65-kwud.onrender.com
   - **Authorization callback URL**: https://rails-developer-project-65-kwud.onrender.com/auth/github/callback
4. Скопировать Client ID и Client Secret в переменные окружения

## **Деплой**

Проект подготовлен для деплоя на Render. Необходимые переменные окружения:

- RAILS_MASTER_KEY — мастер-ключ Rails (из config/master.key)
- ROLLBAR_ACCESS_TOKEN — токен для Rollbar
- GITHUB_CLIENT_ID — Client ID от OAuth приложения (для продакшена)
- GITHUB_CLIENT_SECRET — Client Secret от OAuth приложения (для продакшена)
- DATABASE_URL — автоматически добавляется Render при создании PostgreSQL базы данных

## **Особенности реализации**

- **Аутентификация через GitHub** с помощью OmniAuth
- **Полная локализация** на русский язык (i18n)
- **Управление состояниями объявлений** с помощью AASM (черновик, на модерации, опубликовано, отклонено, в архиве)
- **Поиск и фильтрация** объявлений с помощью ransack
- **Пагинация** с kaminari
- **Административная панель** с управлением категориями и объявлениями (публикация, отклонение, архивация)
- **Личный кабинет пользователя** с управлением своими объявлениями
- **Загрузка изображений** через Active Storage
- **Автоматические проверки кода** через GitHub Actions (RuboCop, Brakeman, тесты)
- **Отслеживание ошибок** через Rollbar
- **Адаптивный интерфейс** на Bootstrap 5

## **Автор**

**Константин**

- GitHub: [@Konstantin82off](https://github.com/Konstantin82off)
- Email: [k.udodov@internet.ru](mailto:k.udodov@internet.ru)
