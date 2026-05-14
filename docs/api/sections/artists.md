# Artists

An artist groups albums (and the songs on those albums). The `is_various` field is `true` for the special "Various Artists" artist used for compilation albums.

## `GET /artists`

Returns a list of artists.

__Query parameters:__

| Parameter | Description |
|-----------|-------------|
| `sort` | Sort field: `name`, `created_at` |
| `sort_direction` | `asc` (default) or `desc` |

__Response:__

```json
[
  {
    "id": 1,
    "name": "Sample Artist",
    "is_various": false,
    "image_urls": {
      "small": "https://blackcandy.example.com/rails/active_storage/.../small.jpg",
      "medium": "https://blackcandy.example.com/rails/active_storage/.../medium.jpg",
      "large": "https://blackcandy.example.com/rails/active_storage/.../large.jpg"
    }
  }
]
```

## `GET /artists/:id`

Returns a single artist with its albums embedded under `albums` (each album uses the same shape as in [Albums](albums.md)).

__Response:__

```json
{
  "id": 1,
  "name": "Sample Artist",
  "is_various": false,
  "image_urls": { "small": "...", "medium": "...", "large": "..." },
  "albums": [
    {
      "id": 1,
      "name": "Sample Album",
      "year": 2024,
      "genre": "Rock",
      "artist_id": 1,
      "artist_name": "Sample Artist",
      "image_urls": { "small": "...", "medium": "...", "large": "..." }
    }
  ]
}
```

## `PATCH /artists/:id`

Updates an artist's cover image. Admins only. Because this endpoint accepts a file upload, send the request as `multipart/form-data` rather than JSON.

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `artist[cover_image]` | file | Yes | A JPEG or PNG image file |

__Response:__

Returns the updated artist in the same shape as `GET /artists/:id`.
