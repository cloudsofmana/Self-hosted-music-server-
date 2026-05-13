# Playlist songs

These endpoints manage the songs inside a regular playlist. The playback queue and the favorite playlist have their own endpoints — see [Current playlist](current_playlist.md) and [Favorite playlist](favorite_playlist.md).

Songs in the responses below use the same shape as in [Songs](songs.md).

## `GET /playlists/:playlist_id/songs`

Returns the songs in a playlist, in playlist order.

> If `:playlist_id` refers to the current playlist or favorite playlist, the request is redirected to the corresponding built-in endpoint.

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
    "is_favorited": false,
    "format": "mp3",
    "album_image_urls": { "small": "...", "medium": "...", "large": "..." }
  }
]
```

## `POST /playlists/:playlist_id/songs`

Appends a song to the end of a playlist.

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `song_id` | integer | Yes | The ID of the song to add |

__Request:__

```json
{
  "song_id": 3
}
```

__Response:__

Returns the added song (same shape as `GET /playlists/:playlist_id/songs`).

## `DELETE /playlists/:playlist_id/songs/:id`

Removes a single song from a playlist.

__Response:__

Returns the removed song (same shape as `GET /playlists/:playlist_id/songs`).

## `DELETE /playlists/:playlist_id/songs`

Removes every song from a playlist (the playlist itself is preserved).

__Response:__

Returns `204 No Content` on success.

## `PUT /playlists/:playlist_id/songs/:id/move`

Reorders a song so that it occupies the position currently held by `destination_song_id`. Existing songs shift to accommodate.

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
