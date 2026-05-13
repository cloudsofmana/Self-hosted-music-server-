# Users

Users represent people who can sign in to a Black Candy instance. Most user-management endpoints require admin privileges; ordinary users may only update or delete themselves (and even those operations are blocked when the server is running in demo mode).

## `GET /users`

Returns every user **except the currently authenticated one**. Admins only. **Not paginated** — every user is returned in a single response.

__Response:__

```json
[
  {
    "id": 2,
    "email": "alice@example.com",
    "is_admin": false
  },
  {
    "id": 3,
    "email": "bob@example.com",
    "is_admin": false
  }
]
```

## `POST /users`

Creates a new user. Admins only.

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `user[email]` | string | Yes | The new user's email address |
| `user[password]` | string | Yes | The new user's password |
| `user[password_confirmation]` | string | No | Must match `password` if provided |

__Request:__

```json
{
  "user": {
    "email": "newuser@example.com",
    "password": "foobar"
  }
}
```

__Response:__

```
HTTP/1.1 201 Created
```

```json
{
  "id": 4,
  "email": "newuser@example.com",
  "is_admin": false
}
```

## `PATCH /users/:id`

Updates a user. The current user may update themselves; admins may update any user.

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `user[email]` | string | No | New email address |
| `user[password]` | string | No | New password |
| `user[password_confirmation]` | string | No | Must match `password` if provided |

__Request:__

```json
{
  "user": {
    "email": "alice+new@example.com"
  }
}
```

__Response:__

```json
{
  "id": 2,
  "email": "alice+new@example.com",
  "is_admin": false
}
```

## `DELETE /users/:id`

Deletes a user. Admins only. A user cannot delete themselves.

__Response:__

Returns `204 No Content` on success.
