# PassionCoded | API

This API responds with/to JSON requests and incorporates JSON Web Tokens ([JWT description](https://jwt.io/)) for authentication.

## User

__Register new user__

`POST` to `/reg_user`

```json
{
  "user": {
    "email": "new_user@example.com",
  	 "password": "password123",
  	 "password_confirmation": "password123"
  }
}
```

Success returns a JWT token to be used in future requests as well as the user info (`profile` will be false and `passions` will be an empty array for a newly created user):

```json
{
 "auth_token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJleHAiOjE0Njg2MzcyMjJ9.7IOheOSZmG-S-_Hzl4EvMXxum-RoPv2ht8YqFiP_UTg",
  "user": {
    "id": 1,
    "email": "new_user@example.com",
    "profile": false,
    "passions": []
  }
}
```

__User Login__

`POST` to `/auth_user`

```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

(*You may also send the login information as form data instead of JSON, if desired*)

Success returns JWT token to be used in future reqeusts as well as the user info:

```json
{
  "auth_token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJleHAiOjE0Njg2MzcyMjJ9.7IOheOSZmG-S-_Hzl4EvMXxum-RoPv2ht8YqFiP_UTg",
  "user": {
    "id": 1,
    "email": "new_user@example.com",
    "profile": {
      "first_name": "New",
      "last_name": "User",
      "profession": "Developer",
      "tech_of_choice": "JavaScript",
      "years_experience": "1",
      "willing_to_manage": true
    },
    "passions": [
      {
        "id": 1,
        "name": "Education",
      },
      {
        "id": 2,
        "name": "Environment"
      }
    ]
  }
}
```

## Profile

__Create new user profile__

`POST` to `/users/:user_id/profile`

__The `current_user.id` must match `:user_id` or it will return `Not Authorized`__

Set the JWT token in the request `Header`:
 
```
"Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0Njg2MzQ1ODJ9.nlAM2ohSvddnWiuEy6ec9iLZ33TNa_4coWIr_K1ulvw"
```

```json
{
  "profile": {
    "first_name": "New",
    "last_name": "User",
    "profession": "Developer",
    "tech_of_choice": "JavaScript",
    "years_experience": 2,
    "willing_to_manage": true
  }
}
```

Success returns user info (`passions` will be empty array if this is a newly created profile):

```json
{
  "user": {
    "id": 1,
    "email": "new_user@example.com",
    "profile": {
      "first_name": "New",
      "last_name": "User",
      "profession": "Developer",
      "tech_of_choice": "JavaScript",
      "years_experience": "2",
      "willing_to_manage": true
    },
    "passions": []
  }
}
```

## Passion (not implemented yet)

__Create new user passion__

`POST` to `/users/:user_id/passions`

Set the JWT token in the request `Header`: 

```
"Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0Njg2MzQ1ODJ9.nlAM2ohSvddnWiuEy6ec9iLZ33TNa_4coWIr_K1ulvw"
```

**`POST` *must* be an array of `passion` objects**

```json
[
  {
    "passion": {
      "name": "Education"
    }
  },
  {
    "passion": {
      "name": "Environment"
    }
  }
]
```

Success returns the user info:

```json
{
  "user": {
    "id": 1,
    "email": "new_user@example.com",
    "profile": {
      "first_name": "New",
      "last_name": "User",
      "profession": "Developer",
      "tech_of_choice": "JavaScript",
      "years_experience": "1",
      "willing_to_manage": true
    },
    "passions": [
      {
        "id": 1,
        "name": "Education",
      },
      {
        "id": 2,
        "name": "Environment"
      }
    ]
  }
}
```
