This is an API for a Bownling game.

### DER

![IMAGE](https://i.imgur.com/DINlB6K.png)

### Endpoints

#### POST /admin (Create a new admin)

**Request**
```ruby
{
	"admin": {
		"name": "Breno Moura",
		"email": "basmoura@gmail.com",
		"password": "123456",
		"password_confirmation": "123456"
	}
}
```

**Response**
```ruby
{
  "id": 1,
  "name": "Breno Moura",
  "email": "basmoura@gmail.com",
  "password_digest": "$2a$12$A9J02Nwr26FQsbiaG0TjTuf.NH2sW55QIP9jOGwgQVJPJYfPc9oZi",
  "created_at": "2020-02-02T22:59:26.180Z",
  "updated_at": "2020-02-02T22:59:26.180Z"
}
```

#### POST /auth/login

**Request**
```
curl -u email:password http://localhost:3000/auth/login
```

**Response**
```ruby
{
  "token": "eyJhbGciOiJIUzI1NiJ9.eyJhZG1pbl9pZCI6MSwiZXhwIjoxNTgzMTkwODE2fQ.PwjarAYn231nmvkKITgYqndUyawXjkhNkX9riuMPuQ4",
  "exp": "03-04-2020 06:42",
  "name": "Breno Moura"
}
```

#### POST /bowling_houses (Create a new bowling house)
**Request**

> Headers: "Authorization: YourJwtToken"

```ruby
{
	"bowling_house": {
		"name": "YaH Inc."
	}
}
```

**Response**
```ruby
{
  "id": 4,
  "name": "YaH Inc.",
  "admin_id": 1,
  "created_at": "2020-02-03T13:06:37.331Z",
  "updated_at": "2020-02-03T13:06:37.331Z"
}
```

#### GET /bowling_houses
**Request**

> Headers: "Authorization: YourJwtToken"

**Response**
```ruby
[
  {
    "id": 1,
    "name": "Floyd Inc.",
    "admin_id": 1,
    "created_at": "2020-02-03T13:02:53.709Z",
    "updated_at": "2020-02-03T13:02:53.709Z"
  },
  {
    "id": 2,
    "name": "Pink Floy Inc.",
    "admin_id": 1,
    "created_at": "2020-02-03T13:04:30.564Z",
    "updated_at": "2020-02-03T13:04:30.564Z"
  },
  {
    "id": 3,
    "name": "Pink Floy Inc.",
    "admin_id": 1,
    "created_at": "2020-02-03T13:06:27.174Z",
    "updated_at": "2020-02-03T13:06:27.174Z"
  },
  {
    "id": 4,
    "name": "YaH Inc.",
    "admin_id": 1,
    "created_at": "2020-02-03T13:06:37.331Z",
    "updated_at": "2020-02-03T13:06:37.331Z"
  }
]
```

#### POST /bowling_houses/:bowling_house_id/lanes (create a new lane)
**Request**

> Headers: "Authorization: YourJwtToken"

```ruby
{
	"lane": {
		"status": "open"
	}
}
```

**Response**
```ruby
{
  "id": 2,
  "status": "open",
  "bowling_house_id": 1,
  "created_at": "2020-02-03T18:44:13.539Z",
  "updated_at": "2020-02-03T18:44:13.539Z"
}
```

#### PATCH /bowling_houses/:bowling_house_id/lanes/:lane_id
**Request**

> Headers: "Authorization: YourJwtToken"

```ruby
{
	"lane": {
		"status": "maintenance"
	}
}
```

**Response**
```ruby
{
  "bowling_house_id": 1,
  "id": 2,
  "status": "maintenance",
  "created_at": "2020-02-03T18:44:13.539Z",
  "updated_at": "2020-02-03T18:44:47.017Z"
}
```

#### POST /lanes/:lane_id/games (Create a new game)
**Request**

> Headers: "Authorization: YourJwtToken"

```ruby
{
	"game": {
		"start_at": "2020-02-03T18:44:13.539Z",
		"status": "live"
	}
}
```

**Response**
```ruby
{
  "id": 1,
  "start_at": "2020-02-03T18:44:13.539Z",
  "end_at": null,
  "status": "live",
  "lane_id": 2,
  "created_at": "2020-02-03T19:09:52.408Z",
  "updated_at": "2020-02-03T19:09:52.408Z"
}
```

#### PATCH /lanes/:lane_id/games/:game_id (Update a specific game)
**Request**

> Headers: "Authorization: YourJwtToken"

```ruby
{
	"game": {
		"start_at": "2020-02-03T18:44:13.539Z",
		"end_at": "2020-02-03T18:44:13.539Z",
		"status": "ended"
	}
}
```

**Response**
```ruby
{
  "lane_id": 2,
  "id": 1,
  "start_at": "2020-02-03T18:44:13.539Z",
  "end_at": "2020-02-03T18:44:13.539Z",
  "status": "ended",
  "created_at": "2020-02-03T19:09:52.408Z",
  "updated_at": "2020-02-03T19:14:56.650Z"
}
```

#### POST /users (Create a new user)
**Request**

> Headers: "Authorization: YourJwtToken"

```ruby
{
	"user": {
		"name": "David Gilmour",
		"nickname": "Eclispe"
	}
}
```

**Response**
```ruby
{
  "id": 1,
  "name": "David Gilmour",
  "nickname": "Eclispe",
  "created_at": "2020-02-03T19:37:29.696Z",
  "updated_at": "2020-02-03T19:37:29.696Z"
}
```
