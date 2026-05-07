# frozen_string_literal: true

class CurrentPlaylist::SongsController < Playlists::SongsController
  layout "playlist"

  skip_before_action :redirect_to_built_in_playlist

  def index
    @songs = @playlist.songs_with_favorite
    @should_play = params[:should_play] == "true"
    @should_play_song_id = params[:song_id].to_i if @should_play
  end

  def create
    @song = Song.find(params[:song_id])

    if params[:location] == "last"
      @playlist.songs.push(@song)
    else
      @current_song_position = @playlist.playlists_songs.find_by(song_id: params[:current_song_id])&.position.to_i
      @playlist.playlists_songs.create(song_id: @song.id, position: @current_song_position + 1)
    end

    if @playlist.songs.count == 1
      respond_to do |format|
        format.json
        format.html { redirect_to action: "index", should_play: params[:should_play] }
      end
    else
      respond_to do |format|
        format.json
        format.turbo_stream
      end
    end
  rescue ActiveRecord::RecordNotUnique
    raise BlackCandy::DuplicatePlaylistSong
  end

  private

  def find_playlist
    @playlist = Current.user.current_playlist
  end
end
