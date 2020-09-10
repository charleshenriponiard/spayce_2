web: bundle exec rails s
assets: bin/webpack-dev-server
heroku-staging: heroku logs --tail -r heroku-staging
heroku-production: heroku logs --tail -r heroku
sidekiq: sidekiq
worker: bundle exec sidekiq -e production -C config/sidekiq.yml
