#!/usr/bin/env bash
# exit on error
set -o errexit

# Устанавливаем зависимости
bundle install
yarn install

# Компилируем ассеты
bundle exec rails assets:precompile
bundle exec rails assets:clean

# Выполняем миграции
bundle exec rails db:migrate
