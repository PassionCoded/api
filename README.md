# PassionCoded | API

[![Build Status](https://travis-ci.org/PassionCoded/api.svg?branch=master)](https://travis-ci.org/PassionCoded/api)

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
      "years_experience": 1,
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

Success returns the user info:

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
      "years_experience": 1,
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

###Delete User

`DELETE` to `/del_user`

Set the JWT token in the request `Header`:

```
"Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0Njg2MzQ1ODJ9.nlAM2ohSvddnWiuEy6ec9iLZ33TNa_4coWIr_K1ulvw"
```

***The user that resolves from the JWT is the user that will be deleted***

Success returns a `204 NO CONTENT` status

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
  "auth_token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJleHAiOjE0Njg2MzcyMjJ9.7IOheOSZmG-S-_Hzl4EvMXxum-RoPv2ht8YqFiP_UTg",
  "user": {
    "id": 1,
    "email": "new_user@example.com",
    "profile": {
      "first_name": "New",
      "last_name": "User",
      "profession": "Developer",
      "tech_of_choice": "JavaScript",
      "years_experience": 2,
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

###Create new user passion(s)

`POST` to `/passions`

Set the JWT token in the request `Header`: 

```
"Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0Njg2MzQ1ODJ9.nlAM2ohSvddnWiuEy6ec9iLZ33TNa_4coWIr_K1ulvw"
```

Format:

```json
{
  "passions": [
    { "name": "Education" },
    { "name": "Environment" },
    { "name": "Sports" },
    { "name": "Government" }
  ]
}
```

Success returns the user info:

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
      },
      {
        "id": 3,
        "name": "Sports"
      },
      {
        "id": 4,
        "name": "Government"
      }
    ]
  }
}
```

###Delete user passion

`DELETE` to `/passions/:id`

Replace `:id` with the id number of the passion to be deleted.

Set the JWT token in the request `Header`: 

```
"Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0Njg2MzQ1ODJ9.nlAM2ohSvddnWiuEy6ec9iLZ33TNa_4coWIr_K1ulvw"
```

Success returns the user info minus the deleted passion:

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

If the passion to delete is not found, the standard return payload will still come back unchanged, **no error will be thrown**.
