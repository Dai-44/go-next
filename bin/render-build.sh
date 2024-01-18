#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate
bundle exec rake db:seed_fu FIXTURE_PATH=db/fixtures/01_feeling
bundle exec rake db:seed_fu FIXTURE_PATH=db/fixtures/02_google_places_api_type/part1
bundle exec rake db:seed_fu FIXTURE_PATH=db/fixtures/02_google_places_api_type/part2
bundle exec rake db:seed_fu FIXTURE_PATH=db/fixtures/02_google_places_api_type/part3
bundle exec rake db:seed_fu FIXTURE_PATH=db/fixtures/02_google_places_api_type/part4
bundle exec rake db:seed_fu FIXTURE_PATH=db/fixtures/02_google_places_api_type/part5
bundle exec rake db:seed_fu FIXTURE_PATH=db/fixtures/03_feeling_type_mapping
