json.partial! "artists/artist", artist: @artist
json.albums @albums, partial: "albums/album", as: :album
