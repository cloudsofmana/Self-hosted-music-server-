# Authentication

Most Black Candy API endpoints require an API token sent in the `Authorization` header. The only endpoints that do not require authentication are `POST /sessions` (used to obtain a token) and `GET /system`.

## `POST /sessions`

Authenticates a user. Returns an API token in the response body and also sets a `session_id` cookie on the response. Rate-limited to 10 requests every 3 minutes per IP address.

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `session[email]` | string | Yes | The user's email address |
| `session[password]` | string | Yes | The user's password |

__Request:__

```json
{
  "session": {
    "email": "user@example.com",
    "password": "your-password"
  }
}
```

__Response:__

```
HTTP/1.1 201 Created
Set-Cookie: session_id=...; HttpOnly
```

```json
{
  "user": {
    "id": 1,
    "email": "user@example.com",
    "is_admin": false,
    "api_token": "eyJfcmFpbHMi..."
  }
}
```

## Authenticating subsequent requests

Include the token in the `Authorization` header using the `Token` scheme:

```
Authorization: Token token="eyJfcmFpbHMi..."
```

## `DELETE /my/session`

Destroys the current session. The token and cookie become invalid for future requests.

__Response:__

Returns `204 No Content` on success.
