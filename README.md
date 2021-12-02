# README

### Currency exchange server

To install:

```
bundle install
rake db:create
rake db:migrate
```

To run:

```
rails s -p 3001
```

To test:

```
rake db:migrate RAILS_ENV=test
rspec
```