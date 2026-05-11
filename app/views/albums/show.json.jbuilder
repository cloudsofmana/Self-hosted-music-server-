json.call(@album, :id, :name, :year, :genre, :artist_id)
json.artist_name @album.artist.name
json.songs @songs, partial: "songs/song", as: :song
