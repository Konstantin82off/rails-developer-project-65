setup:
	cp -n .env.example .env || true
	bundle install
	yarn install
	rails db:create db:migrate
