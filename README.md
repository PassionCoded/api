# PassionCoded | API Preliminary Specs

Thought I would start jotting down my brainstorms on how the API interface could possibly work. Obviously just my thoughts, up for any other suggestions!

This would be a JSON API that would serve a front end SPA (React or Angular).

It is possible to serve the front end app from Rails, however it takes some special configuration.  I think it would be better to have the front end seperate (maybe hosted on GitHub Pages or directly on AWS?) and have it connect to the API hosted on Heroku?

Also I was thinking we could use JWT (JSON Web Tokens) ([JWT description](https://jwt.io/)) for authenticating requests?  I just used it in another project and it's a slick, sessionless solution.

## User

__Register new user__

`POST` to `/users`

```json
{
  "user": {
  	"email": "new_user@example.com",
  	"password": "password123",
  	"password_confirmation": "password123"
  }
}
```

Success returns user instance and JWT token:

```json
{
 "auth_token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJleHAiOjE0Njg2MzcyMjJ9.7IOheOSZmG-S-_Hzl4EvMXxum-RoPv2ht8YqFiP_UTg",
  "user": {
	"id": 1,
	"email": "new_user@example.com"
  }
}
```

__Login__

`POST` to `/auth_user`

```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

Success returns user instance and JWT token:

```json
{
 "auth_token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJleHAiOjE0Njg2MzcyMjJ9.7IOheOSZmG-S-_Hzl4EvMXxum-RoPv2ht8YqFiP_UTg",
  "user": {
	"id": 1,
	"email": "user@example.com"
  }
}
```

## Profile

__Create new user profile__

`POST` to `/users/:user_id/profiles`

Set the JWT token in the request `Header`: 
```
"Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0Njg2MzQ1ODJ9.nlAM2ohSvddnWiuEy6ec9iLZ33TNa_4coWIr_K1ulvw"
```

```json
{
  "profile": {
    "first_name": "First",
    "last_name": "Last",
    "profession": "Web Developer",
    "tech_of_choice": "JavaScript",
    "years_experience": 2,
    "willing_to_manage": true
  }
}
```
Success returns profile and user:

```json
{
  "id": 1,
  "first_name": "First",
  "last_name": "Last",
  "profession": "Web Developer",
  "tech_of_choice": "JavaScript",
  "years_experience": 2,
  "willing_to_manage": true,
  "user": {
    "id": 1,
    "email": "user@example.com"
  }
}
```

__Retrieve a user profile__

`GET` to `/users/:user_id/profile`

Set the JWT token in the request `Header`: 
```
"Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0Njg2MzQ1ODJ9.nlAM2ohSvddnWiuEy6ec9iLZ33TNa_4coWIr_K1ulvw"
```

Success returns profile and user:

```json
{
  "id": 1,
  "first_name": "First",
  "last_name": "Last",
  "profession": "Web Developer", 
  "tech_of_choice": "JavaScript",
  "years_experience": 2,
  "willing_to_manage": true,
  "user": {
    "id": 1,
    "email": "user@example.com"
  }
}
```

## Passion

__Create new user passion__

`POST` to `/users/:user_id/passions`

Set the JWT token in the request `Header`: 
```
"Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0Njg2MzQ1ODJ9.nlAM2ohSvddnWiuEy6ec9iLZ33TNa_4coWIr_K1ulvw"
```

```json
{
  "passion": {
    "name": "Education"
  }
}
```
Success returns the passion and user:

```json
{
  "id": 1,
  "name": "Education",
  "user": {
    "id": 1,
    "email": "user@example.com"
  }
}
```

__Retrieve all user passions__

`GET` to `/users/:user_id/passions`

Set the JWT token in the request `Header`: 
```
"Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0Njg2MzQ1ODJ9.nlAM2ohSvddnWiuEy6ec9iLZ33TNa_4coWIr_K1ulvw"
```

Success returns an array of passions:

```json
[
  {
    "id": 1,
    "name": "Education",
    "user": {
      "id": 1,
      "email": "user@example.com"
    }
  },
  {
    "id": 2,
    "name": "Environment",
    "user": {
      "id": 1,
      "email": "user@example.com"
    }
  }
]  
```
