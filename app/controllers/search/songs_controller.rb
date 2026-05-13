# frozen_string_literal: true

class Search::SongsController < ApplicationController
  def index
    @pagy, @songs = pagy(Song.search(params[:query]).includes(:artist, :album))
  end
end
