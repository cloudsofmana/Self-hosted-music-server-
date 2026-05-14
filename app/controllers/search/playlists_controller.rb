# frozen_string_literal: true

class Search::PlaylistsController < ApplicationController
  def index
    @pagy, @playlists = pagy(Playlist.search(params[:query]))
  end
end
