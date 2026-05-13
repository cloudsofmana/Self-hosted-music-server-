# System

Returns information about the running Black Candy server. This endpoint does not require authentication and is rate-limited to 10 requests every 3 seconds per IP address.

## `GET /system`

__Response:__

```json
{
  "version": {
    "major": 3,
    "minor": 4,
    "patch": 0,
    "pre": null
  },
  "min_app_version": {
    "major": 1,
    "minor": 0,
    "patch": 0
  }
}
```

| Field | Description |
|-------|-------------|
| `version` | The semantic version of the server. The `pre` field is `null` for a final release or holds a pre-release identifier (e.g. `"beta.1"`). |
| `min_app_version` | The minimum companion-app version this server supports. Native clients should refuse to connect to a server whose `min_app_version` is greater than the client's own version. |
