# Search

Search across albums, artists, playlists, and songs by name. The summary endpoint returns a small slice of each category in a single response; per-category endpoints return paginated results for one category at a time.

The shape of items in each category matches the corresponding resource section: see [Albums](albums.md), [Artists](artists.md), [Playlists](playlists.md), and [Songs](songs.md).

## `GET /search`

Returns up to 10 matches in each category. **Not paginated** — when a category has more than 10 total matches, a `Link` header points to the per-category endpoint where the full paginated results can be fetched.

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `query` | string | Yes | The search term |

__Response:__

```json
{
  "albums":    [ { "id": 1, "name": "Love Songs", "year": 2024, "...": "..." } ],
  "artists":   [ { "id": 1, "name": "Lover", "is_various": false, "...": "..." } ],
  "playlists": [ { "id": 1, "name": "Love mix", "user_id": 1, "is_favorite": false } ],
  "songs":     [ { "id": 1, "name": "All You Need Is Love", "...": "..." } ]
}
```

When more results are available, the response includes a `Link` header with one or more of the following relations:

```
Link: <https://blackcandy.example.com/search/albums?query=love>; rel="search-albums",
      <https://blackcandy.example.com/search/songs?query=love>; rel="search-songs"
```

| Link relation | Endpoint |
|---------------|----------|
| `search-albums` | `GET /search/albums` |
| `search-artists` | `GET /search/artists` |
| `search-playlists` | `GET /search/playlists` |
| `search-songs` | `GET /search/songs` |

## `GET /search/albums`

Returns a list of albums matching `query`.

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `query` | string | Yes | The search term |

__Response:__

An array of album objects (same shape as `GET /albums`).

## `GET /search/artists`

Returns a list of artists matching `query`.

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `query` | string | Yes | The search term |

__Response:__

An array of artist objects (same shape as `GET /artists`).

## `GET /search/playlists`

Returns a list of playlists matching `query`.

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `query` | string | Yes | The search term |

__Response:__

An array of playlist objects (same shape as `GET /playlists`).

## `GET /search/songs`

Returns a list of songs matching `query`.

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `query` | string | Yes | The search term |

__Response:__

An array of song objects (same shape as `GET /songs`).
