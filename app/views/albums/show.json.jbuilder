json.partial! "albums/album", album: @album
json.songs @songs, partial: "songs/song", as: :song
