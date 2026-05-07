require "test_helper"

class CurrentPlaylist::Songs::PlaylistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:admin)
    @current_playlist = @user.current_playlist
  end

  test "should replace all songs with playlist songs" do
    login @user
    playlist = @user.playlists.create(name: "test", song_ids: [ 1, 2, 3 ])

    put current_playlist_playlist_url(playlist, should_play: true)

    assert_redirected_to current_playlist_songs_url(should_play: true)
    assert_equal playlist.song_ids, @current_playlist.song_ids
  end

  test "should return not found when playlist not found" do
    login @user
    put current_playlist_playlist_url(id: "invalid_id")

    assert_response :not_found
  end

  test "should return not found when playlist is not owned by user" do
    login @user
    playlist = users(:visitor1).playlists.create(name: "test", song_ids: [ 1, 2, 3 ])

    put current_playlist_playlist_url(playlist)

    assert_response :not_found
    assert_empty @current_playlist.song_ids
  end

  test "should replace all songs with playlist songs via api" do
    playlist = @user.playlists.create(name: "test", song_ids: [ 1, 2, 3 ])

    put current_playlist_playlist_url(playlist), as: :json, headers: api_token_header(@user)
    response = @response.parsed_body

    assert_response :success
    assert_equal playlist.song_ids, @current_playlist.song_ids
    assert_equal playlist.song_ids, response.map { |song| song["id"] }
  end

  test "should return not found when playlist not found via api" do
    put current_playlist_playlist_url(id: "invalid_id"), as: :json, headers: api_token_header(@user)

    assert_response :not_found
  end

  test "should return not found when playlist is not owned by user via api" do
    playlist = users(:visitor1).playlists.create(name: "test", song_ids: [ 1, 2, 3 ])

    put current_playlist_playlist_url(playlist), as: :json, headers: api_token_header(@user)

    assert_response :not_found
    assert_empty @current_playlist.song_ids
  end
end
