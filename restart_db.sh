#!/bin/bash

# rake db:drop
# rake db:rollback

# rake db:migrate
# rake db:seed
# rake db:setup

#Drop the DBs:
rake db:drop
#rake db:drop RAILS_ENV=production DISABLE_DATABASE_ENVIRONMENT_CHECK=1
#Create all DBs:
rake db:create
#Prepare your test DB:
rake db:test:prepare
#Migrate your DBs:
rake db:migrate
rake db:migrate RAILS_ENV=production
rake db:migrate RAILS_ENV=test
#Seed your DBs:
rake db:seed
rake db:seed RAILS_ENV=production

# To SEED your test DB: rails c -e test THEN Rails.application.load_seed