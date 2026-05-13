# frozen_string_literal: true

class Search::ArtistsController < ApplicationController
  def index
    @pagy, @artists = pagy(Artist.search(params[:query]).with_attached_cover_image)
  end
end
