# Songs

A song represents a single audio file in the library. Each song belongs to an album and an artist.

The `url` field on a song points to a streaming endpoint. When the underlying file is in a format the browser cannot play directly (or is a lossless format with on-the-fly transcoding enabled), `url` points to the transcoded stream and `format` reports the transcoded format (typically `mp3`); otherwise both reflect the original file.

## `GET /songs`

Returns a list of songs.

__Query parameters:__

| Parameter | Description |
|-----------|-------------|
| `filter[album_year]` | Filter by album year |
| `filter[album_genre]` | Filter by album genre |
| `sort` | Sort field: `name`, `created_at`, `artist_name`, `album_name`, `album_year` |
| `sort_direction` | `asc` (default) or `desc` |

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
    "album_image_urls": {
      "small": "https://blackcandy.example.com/rails/active_storage/.../small.jpg",
      "medium": "https://blackcandy.example.com/rails/active_storage/.../medium.jpg",
      "large": "https://blackcandy.example.com/rails/active_storage/.../large.jpg"
    }
  }
]
```

## `GET /songs/:id`

Returns a single song.

__Response:__

Returns the same object as a single entry in the `GET /songs` collection.
