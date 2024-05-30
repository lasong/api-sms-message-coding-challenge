# README

## Prerequisites

- Ruby (v3.3.1)
- Postgresql

## Setup

Clone the repository and go to the `api-sms-message-coding-challenge` folder:

```
git clone git@github.com:lasong/api-sms-message-coding-challenge.git
cd api-sms-message-coding-challenge
```

Then install the gems by running

```
bundle install
```

## Running the application

Before you run the application for the first time, you must create the database and run migrations:

```
bundle exec rails db:create db:migrate
```

Start the app by running:

```
bundle exec rails s
```

Then send request by using a REST client app like Postman or by using curl.

Example with curl:

```
curl -X POST http://localhost:3000/api/messages/send_sms \
  -H "Content-Type: application/json" \
  -d '{"message": {"content": "This is a message to be sent by sms"}}'
```

## Running tests

If running for the first time, setup the test database:

```
bundle exec rails db:test:prepare
```

Then run the tests:

```
bundle exec rspec spec
```

### Linting

Run linting check by running

```
bundle exec rubocop
```
