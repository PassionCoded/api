# PassionCoded | API

This API responds with/to JSON requests and incorporates JSON Web Tokens ([JWT description](https://jwt.io/)) for authentication.

## User

###Register new user

`POST` to `/reg_user`

Format:

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

__Data Requirements:__

* `email`:  Must be a string with a correctly formatted email address
* `password`: Must be a string of at least 6 characters
* `password_confirmation`: Must match password

Any data that does not pass validation will return an object with an `errors` key that contains an array of errors:

```json
{
  "errors": [
    "Email is invalid"
  ]
}
```

###User Login

`POST` to `/auth_user`

Format:

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

__Failed Login__

Any data that does not pass validation will return an object with an `errors` key that contains an array of errors:

```json
{
  "errors": [
    "Invalid Username/Password"
  ]
}
```

###User Info

`GET` to `/user_info`

Set the JWT token in the request `Header`:

```
"Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0Njg2MzQ1ODJ9.nlAM2ohSvddnWiuEy6ec9iLZ33TNa_4coWIr_K1ulvw"
```

Success returns the user info (similar to the return when logging in, however there is no JWT):

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

## Profile

###Create new user profile

`POST` to `/profile`

Set the JWT token in the request `Header`:
 
```
"Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0Njg2MzQ1ODJ9.nlAM2ohSvddnWiuEy6ec9iLZ33TNa_4coWIr_K1ulvw"
```

Format:

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

__Data Requirements:__

* All fields must have data (no blanks)
* `first_name`, `last_name`, `profession` and `tech_of_choice` must be strings
* `years_experience` must be a positive integer
* `willing_to_manage` must be a boolean (true/false)

Any data that does not pass validation will return an object with an `errors` key that contains an array of errors:

```json
{
  "errors": [
    "One or more profile fields is missing or empty"
  ]
}
``` 

## Passions

###Create new user passion

`POST` to `/passions`

Set the JWT token in the request `Header`: 

```
"Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0Njg2MzQ1ODJ9.nlAM2ohSvddnWiuEy6ec9iLZ33TNa_4coWIr_K1ulvw"
```

Format:

**`POST` *must* be an array of objects with one key called `name` and a string for the value**

```json
[
  { "name": "Education" },
  { "name": "Environment" },
  { "name": "Sports" },
  { "name": "Government" }
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

__Data Requirements:__

* Data must be an array of objects containing a `name` key and a string value

Any data that does not pass validation will return an object with an `errors` key that contains an array of errors:

```json
{
  "errors": [
    "Passions data formatted incorrectly or is blank"
  ]
}
``` 