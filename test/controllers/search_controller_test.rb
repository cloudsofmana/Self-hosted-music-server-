# frozen_string_literal: true

require "test_helper"

class SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    login
    get search_url(query: "test")

    assert_response :success
  end

  test "should get index via api" do
    get search_url(query: "1"), as: :json, headers: api_token_header(users(:visitor1))

    assert_response :success

    response = @response.parsed_body
    assert response["albums"].is_a?(Array)
    assert response["artists"].is_a?(Array)
    assert response["playlists"].is_a?(Array)
    assert response["songs"].is_a?(Array)

    assert_includes response["albums"].map { |a| a["name"] }, albums(:album1).name
    assert_includes response["artists"].map { |a| a["name"] }, artists(:artist1).name
    assert_includes response["playlists"].map { |p| p["name"] }, playlists(:playlist1).name
    assert_includes response["songs"].map { |s| s["name"] }, songs(:mp3_sample).name
  end

  test "should not set link header when no category has more results via api" do
    get search_url(query: "1"), as: :json, headers: api_token_header(users(:visitor1))

    assert_response :success
    assert_nil @response.headers["Link"]
  end

  test "should set scoped link header only for categories with more results via api" do
    11.times { |i| Album.create!(name: "more_album_#{i}", artist: artists(:artist1)) }
    11.times { |i| Playlist.create!(name: "more_playlist_#{i}", user: users(:admin)) }

    get search_url(query: "more_"), as: :json, headers: api_token_header(users(:visitor1))

    assert_response :success

    links = parse_link_header(@response.headers["Link"])
    assert_equal search_albums_url(query: "more_"), links["search-albums"]
    assert_equal search_playlists_url(query: "more_"), links["search-playlists"]
    assert_nil links["search-artists"]
    assert_nil links["search-songs"]
  end

  test "should set link header for all categories when each has more results via api" do
    11.times { |i| Album.create!(name: "extra_album_#{i}", artist: artists(:artist1)) }
    11.times { |i| Artist.create!(name: "extra_artist_#{i}") }
    11.times { |i| Playlist.create!(name: "extra_playlist_#{i}", user: users(:admin)) }
    11.times do |i|
      Song.create!(
        name: "extra_song_#{i}",
        file_path: "extra_song_#{i}.mp3",
        file_path_hash: "extra_song_#{i}_path_hash",
        md5_hash: "extra_song_#{i}_md5_hash",
        artist: artists(:artist1),
        album: albums(:album1)
      )
    end

    get search_url(query: "extra_"), as: :json, headers: api_token_header(users(:visitor1))

    assert_response :success

    links = parse_link_header(@response.headers["Link"])
    assert_equal search_albums_url(query: "extra_"), links["search-albums"]
    assert_equal search_artists_url(query: "extra_"), links["search-artists"]
    assert_equal search_playlists_url(query: "extra_"), links["search-playlists"]
    assert_equal search_songs_url(query: "extra_"), links["search-songs"]
  end
end
