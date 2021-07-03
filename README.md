# Assignment 

## Techs
1. Ruby 2.7.1
2. Rails 6.1.4
3. mysql 5.7.32

## Install
1. clone repo
```
git clone git@github.com:trungle1612/good_night.git
```
2. `bundle install`
3. `rake db:create`
4. `rake db:migrate`

2. run test
```ruby
rspec
```

6. Start server
```
rails server
```

## DB schema
![DB](https://i.imgur.com/XihUKCz.png)

## Api Endpoints
### access_token
 - How to create a new access_token

```ruby
Doorkeeper::AccessToken.create(resource_owner_id: user_id)
```

### follwers
1. `POST /api/v1/followers`
 - Follow a user
 - headers
 ```
 { Authorization: Bearer 3V1q7TjTzioG98NWHDB5CvzXBEhcBhKxWnQhIS4yOWQ }
 ```
 - params

| name   | required | type   |example|
|--------|----------|--------|-------|
|user_id | true     |integer |1      |

 - response

 ```
 201
 ```

2. `GET /api/v1/followers`
 - headers
 ```
 { Authorization: Bearer 3V1q7TjTzioG98NWHDB5CvzXBEhcBhKxWnQhIS4yOWQ }
 ```
 - response

```json
[
    {
        "id": 2,
        "name": "Peter"
    },
    {
        "id": 3,
        "name": "Mike"
    }
]
 ```

3. `DELETE /api/v1/followers/:user_id`
 - Unfollow a user
 - headers
 ```
 { Authorization: Bearer 3V1q7TjTzioG98NWHDB5CvzXBEhcBhKxWnQhIS4yOWQ }
 ```
 - response

```json
204
```


### time_sleeps

1. `GET /api/v1/time_sleeps`
 - headers
 ```
 { Authorization: Bearer 3V1q7TjTzioG98NWHDB5CvzXBEhcBhKxWnQhIS4yOWQ }
 ```
 - params

| name       | required | type   |example|
|------------|----------|--------|-------|
|follower_id | false    |integer |1      |

** with `fowllower_id` return time_sleeps of friends, and without `follower_id` return time_sleeps of your self
- response

```json
[
    {
        "id": 6,
        "date": "2021-07-01",
        "start_time": "2021-07-02 01:00",
        "finish_time": "2021-07-02 07:10",
        "length_sleep": 6.17
    }
]
```

2. `POST /api/v1/time_sleeps`
 - headers
 ```
 { Authorization: Bearer 3V1q7TjTzioG98NWHDB5CvzXBEhcBhKxWnQhIS4yOWQ }
 ```
 - params

| name       | required | type    |example          |
|------------|----------|---------|-----------------|
|date        | true     |date     |2021-07-03       |
|start_time  | true     |datetime |2021-07-02 23:00 |
|finish_time | true     |datetime |2021-07-03 06:00 |

- response

```json
201
```
