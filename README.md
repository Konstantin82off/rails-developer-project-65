# Доска объявлений

### Hexlet tests and linter status:
[![Actions Status](https://github.com/Konstantin82off/rails-developer-project-65/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/Konstantin82off/rails-developer-project-65/actions)

[![CI](https://github.com/Konstantin82off/rails-developer-project-65/actions/workflows/ci.yml/badge.svg)](https://github.com/Konstantin82off/rails-developer-project-65/actions/workflows/ci.yml)

Проект "Доска объявлений" - аналог Avito, созданный в рамках обучения на Хекслете. 
Сервис позволяет пользователям размещать объявления, просматривать существующие и управлять ими.

## Демо

*Ссылка на задеплоенное приложение появится после деплоя на Render*

## Технологии

- **Ruby** 3.2.2
- **Ruby on Rails** 7.2
- **Bootstrap** 5
- **esbuild** для сборки JavaScript
- **PostgreSQL** (в продакшене)
- **Rollbar** для отслеживания ошибок
- **GitHub Actions** для CI/CD

## Установка и запуск

```bash
# Клонировать репозиторий
git clone https://github.com/Konstantin82off/rails-developer-project-65.git
cd rails-developer-project-65

# Установить зависимости
bundle install
yarn install

# Создать и настроить базу данных
rails db:create
rails db:migrate

# Запустить сервер разработки
rails server
```

После запуска приложение будет доступно по адресу: http://localhost:3000

Деплой
Проект подготовлен для деплоя на Render. Необходимые переменные окружения:

RAILS_MASTER_KEY - мастер-ключ Rails (из config/master.key)

ROLLBAR_ACCESS_TOKEN - токен для Rollbar

DATABASE_URL - автоматически добавляется Render

Особенности реализации
Адаптивный интерфейс на Bootstrap

Отслеживание ошибок через Rollbar

Автоматические проверки кода через GitHub Actions

Подготовка к работе с пользователями и объявлениями

## Автор

**Константин**  
- GitHub: [@Konstantin82off](https://github.com/Konstantin82off)
- Email: [k.udodov@internet.ru](mailto:k.udodov@internet.ru)
