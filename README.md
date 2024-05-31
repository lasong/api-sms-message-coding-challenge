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

## Possible Issues
- Security issues:
  - Unauthorized use of the endpoint which can lead to data breaches, unauthorized data manipulation, and other malicious activities. This can be solved by implementing authorization techniques such as tokens (JWT) or API keys.
  - The message sent can have SQL injections and other common attacks. This can be solved by implementing sanitization of the message
- Introduction of new features or changes can cause the api to break, so it is always a good practice to implement API versioning to ensure backward compatibility
- As the number of requests grow, it can lead to performance issues in the database. This can be solved by database optimizations techniques like implementing proper indexing.
- Errors in the request can occur and it will be hard to track, so implementing logging and monitoring to track API requests and responses would be a solution.
- The app is open to abusive requests. A solution would be to implement rate limiting using tools like tools like [rack-attack](https://github.com/rack/rack-attack)
