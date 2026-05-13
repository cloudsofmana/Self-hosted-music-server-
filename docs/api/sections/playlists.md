# Playlists

A playlist is an ordered list of songs owned by a user. Each user also has two built-in playlists — the **current playlist** (the playback queue) and the **favorite playlist** — which are managed through dedicated endpoints; see [Current playlist](current_playlist.md) and [Favorite playlist](favorite_playlist.md).

The endpoints in this section operate on regular user-created playlists. To work with the songs inside a playlist, see [Playlist songs](playlist_songs.md).

## `GET /playlists`

Returns the current user's playlists, including the favorite playlist (which is marked with `is_favorite: true`).

__Query parameters:__

| Parameter | Description |
|-----------|-------------|
| `sort` | Sort field: `name`, `created_at` |
| `sort_direction` | `asc` or `desc` (default `desc`) |

__Response:__

```json
[
  {
    "id": 1,
    "name": "My Playlist",
    "user_id": 1,
    "is_favorite": false
  },
  {
    "id": 2,
    "name": "Favorite",
    "user_id": 1,
    "is_favorite": true
  }
]
```

## `POST /playlists`

Creates a new playlist owned by the current user.

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `playlist[name]` | string | Yes | The playlist's name |

__Request:__

```json
{
  "playlist": {
    "name": "Road Trip"
  }
}
```

__Response:__

```
HTTP/1.1 201 Created
```

```json
{
  "id": 3,
  "name": "Road Trip",
  "user_id": 1,
  "is_favorite": false
}
```

## `PATCH /playlists/:id`

Renames a playlist. Only the owner may update it.

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `playlist[name]` | string | Yes | The new name |

__Request:__

```json
{
  "playlist": {
    "name": "Long Drive"
  }
}
```

__Response:__

```json
{
  "id": 3,
  "name": "Long Drive",
  "user_id": 1,
  "is_favorite": false
}
```

## `DELETE /playlists/:id`

Deletes a playlist and all its songs. Only the owner may delete it.

__Response:__

Returns `204 No Content` on success.
