# Favorite playlist

The favorite playlist is a per-user built-in playlist. Adding a song to it is how a song becomes "favorited"; removing it un-favorites the song. There is exactly one favorite playlist per user, accessed without an ID.

When a song is in the favorite playlist, the `is_favorited` field on the song's JSON representation is `true`. Songs in responses use the same shape as in [Songs](songs.md).

## `GET /favorite_playlist/songs`

Returns the user's favorited songs.

__Response:__

```json
[
  {
    "id": 1,
    "name": "Sample Song",
    "duration": 215.4,
    "album_id": 1,
    "artist_id": 1,
    "url": "https://blackcandy.example.com/stream/new?song_id=1",
    "album_name": "Sample Album",
    "artist_name": "Sample Artist",
    "is_favorited": true,
    "format": "mp3",
    "album_image_urls": { "small": "...", "medium": "...", "large": "..." }
  }
]
```

## `POST /favorite_playlist/songs`

Favorites a song.

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `song_id` | integer | Yes | The ID of the song to favorite |

__Request:__

```json
{
  "song_id": 3
}
```

__Response:__

Returns the favorited song with `is_favorited: true`.

## `DELETE /favorite_playlist/songs/:id`

Un-favorites a song.

__Response:__

Returns the removed song with `is_favorited: false`.

## `DELETE /favorite_playlist/songs`

Un-favorites every song.

__Response:__

Returns `204 No Content` on success.

## `PUT /favorite_playlist/songs/:id/move`

Reorders a favorited song so it takes the position currently held by `destination_song_id`.

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `destination_song_id` | integer | Yes | The ID of the song whose position to take |

__Request:__

```json
{
  "destination_song_id": 2
}
```

__Response:__

Returns `204 No Content` on success.
