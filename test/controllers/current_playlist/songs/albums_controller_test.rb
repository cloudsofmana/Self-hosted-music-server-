require "test_helper"

class CurrentPlaylist::Songs::AlbumControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:visitor1)
    @playlist = @user.current_playlist
  end

  test "should replace all songs with album songs" do
    login @user
    put current_playlist_album_url(albums(:album1), should_play: true)

    assert_redirected_to current_playlist_songs_url(should_play: true)
    assert_equal albums(:album1).song_ids, @playlist.song_ids
  end

  test "should return not found when album not found" do
    login @user
    put current_playlist_album_url(id: "invalid_id")

    assert_response :not_found
  end

  test "should add album to recently played" do
    login @user
    assert_difference -> { @user.reload.recently_played_albums.count } do
      put current_playlist_album_url(albums(:album1))
    end
  end

  test "should replace all songs with album songs via api" do
    put current_playlist_album_url(albums(:album1)), as: :json, headers: api_token_header(@user)
    response = @response.parsed_body

    assert_response :success
    assert_equal albums(:album1).song_ids, @playlist.song_ids
    assert_equal albums(:album1).song_ids, response.map { |song| song["id"] }
  end

  test "should return not found when album not found via api" do
    put current_playlist_album_url(id: "invalid_id"), as: :json, headers: api_token_header(@user)

    assert_response :not_found
  end

  test "should add album to recently played via api" do
    assert_difference -> { @user.reload.recently_played_albums.count } do
      put current_playlist_album_url(albums(:album1)), as: :json, headers: api_token_header(@user)
    end
  end
end
