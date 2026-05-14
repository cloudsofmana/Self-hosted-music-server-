json.albums    @albums,    partial: "albums/album",       as: :album
json.artists   @artists,   partial: "artists/artist",     as: :artist
json.playlists @playlists, partial: "playlists/playlist", as: :playlist
json.songs     @songs,     partial: "songs/song",         as: :song
