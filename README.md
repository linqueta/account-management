# [AccountManagement][repo_page]

## Table of Contents
- [Getting started](#getting-started)
  - [Installation](#installation)
    - [Install packages](#install-packages)
    - [Setup environments](#setup-environments)
    - [Setup the database](#setup-the-database)
  - [Running](#running)
    - [Getting a session](#getting-a-session)
    - [Checking your balance](#checking-your-balance)
    - [Taking a transfer](#taking-a-transfer)
  - [Testing](#testing)

## Getting started

### Installation

This project was built using:
- Ruby 2.7.0
- Ruby on Rails 6.0.2
- Postgresql
- Devise Jwt for Jwt sessions
- Rubocop as a lint
- Faker tests
- Json Matcher tests
- Factories
- Shoulda Matcher tests
- Serializers
- Service Objects
- Simple Cov to coverage

#### Install packages

```shell
bundle install
```

#### Setup environments

This project uses the gem `dotenv-rails` to import environments and you have to copy the file `.env.sample` to the root as the respective names, `.env.test` and `.env.development`.
In both, you have to configure the database connection keys and a key to devise works as well.

#### Setup the database

```shell
rails db:create db:migrate db:seed
```

### Running

In a terminal, type it to start the server:

```shell
rails s
```

#### Getting a session

```shell
curl -i \
--request POST 'localhost:3000/api/v1/login' \
--header 'Content-Type: application/json' \
--data-raw '{
        "user": {
                "email": "linqueta@gmail.com",
                "password": "123456"
        }
}'

HTTP/1.1 200 OK
X-Frame-Options: SAMEORIGIN
X-XSS-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Download-Options: noopen
X-Permitted-Cross-Domain-Policies: none
Referrer-Policy: strict-origin-when-cross-origin
Location: /
Content-Type: text/plain; charset=utf-8
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNTgyMjY3MzQxLCJleHAiOjE1ODIzNTM3NDEsImp0aSI6ImU5ZWYyMGQxLTk3NDctNDJiMi04NTJiLTQ5ZjAzN2E1M2RkYyJ9.aZwyFC1k3jeI97489Bb0Lj3NpRnHczcJKh6OV3s1Gh4
ETag: W/"36a9e7f1c95b82ffb99743e0c5c4ce95"
Cache-Control: max-age=0, private, must-revalidate
X-Request-Id: a461fe93-615f-419a-9b9c-d43768916802
X-Runtime: 0.116105
Transfer-Encoding: chunked
```

The important part here is the header `Authorization`.

#### Checking your balance

Open Rails console with:

```shell
rails c
```

and type:

```ruby
User.find_by(email: 'linqueta@gmail.com').account.id
# => 1
```

Catch this id and call the api with the `Authorization` header:

```shell
curl --request GET 'localhost:3000/api/v1/accounts/1' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNTgyMjY3MzQxLCJleHAiOjE1ODIzNTM3NDEsImp0aSI6ImU5ZWYyMGQxLTk3NDctNDJiMi04NTJiLTQ5ZjAzN2E1M2RkYyJ9.aZwyFC1k3jeI97489Bb0Lj3NpRnHczcJKh6OV3s1Gh4'

{"id":1,"balance":85.0}
```

#### Taking a transfer

Open Rails console with:

```shell
rails c
```

and type:

```ruby
{
  source_account_id: User.find_by(email: 'linqueta@gmail.com').account.id,
  destination_account_id: User.find_by(email: 'father@gmail.com').account.id,
  amount: 30.5
}
# => {:source_account_id=>1, :destination_account_id=>2, :amount=>30.5}
```

Override these values in the request below (Don't forget the `Authorization` header):

```shell
curl --request POST 'localhost:3000/api/v1/transfers' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNTgyMjY3MzQxLCJleHAiOjE1ODIzNTM3NDEsImp0aSI6ImU5ZWYyMGQxLTk3NDctNDJiMi04NTJiLTQ5ZjAzN2E1M2RkYyJ9.aZwyFC1k3jeI97489Bb0Lj3NpRnHczcJKh6OV3s1Gh4' \
--data-raw '{
	"transfer": {
		"source_account_id": 1,
		"destination_account_id": 2,
		"amount": 30.5
	}
}'
{"id":2,"source_account":{"id":1,"balance":54.5},"source_event":{"amount":"-30.5"},"destination_event":{"amount":"30.5"}}
```

### Testing

This project includes tests a lot, like:
- Validations tests
- Associations tests
- Models tests
- Services tests
- Serializers tests
- Requests tests

The result about it is 100% of coverage:

```shell
COVERAGE: 100.00% -- 94/94 lines in 13 files
```

And a nice test ratio:

```shell
RAILS_ENV=test rails stats

+----------------------+--------+--------+---------+---------+-----+-------+
| Name                 |  Lines |    LOC | Classes | Methods | M/C | LOC/M |
+----------------------+--------+--------+---------+---------+-----+-------+
| Controllers          |     64 |     47 |       5 |       4 |   0 |     9 |
| Jobs                 |      4 |      2 |       1 |       0 |   0 |     0 |
| Models               |    105 |     72 |       7 |       6 |   0 |    10 |
| Libraries            |      0 |      0 |       0 |       0 |   0 |     0 |
| Model specs          |    174 |    129 |       0 |       0 |   0 |     0 |
| Request specs        |    108 |     81 |       0 |       0 |   0 |     0 |
| Serializer specs     |     53 |     38 |       0 |       0 |   0 |     0 |
| Service specs        |     87 |     63 |       0 |       0 |   0 |     0 |
+----------------------+--------+--------+---------+---------+-----+-------+
| Total                |    595 |    432 |      13 |      10 |   0 |    41 |
+----------------------+--------+--------+---------+---------+-----+-------+
  Code LOC: 121     Test LOC: 311     Code to Test Ratio: 1:2.6
```

To run tests, just type it:

```shell
bundle exec rspec
```

---

To see more about me, access these links:

- [Blog][blog]
- [Github][github]
- [Rails::Healthcheck][rails-healthcheck]

[repo_page]: https://github.com/linqueta/account-management
[blog]: https://linqueta.com
[github]: https://linqueta.com
[rails-healthcheck]: https://github.com/linqueta/rails-healthcheck
