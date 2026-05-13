# frozen_string_literal: true

require "test_helper"

class Search::SongsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    login
    get search_songs_url(query: "test")

    assert_response :success
  end

  test "should get index via api" do
    get search_songs_url(query: "mp3"), as: :json, headers: api_token_header(users(:visitor1))

    assert_response :success
    assert_includes @response.parsed_body.map { |s| s["name"] }, songs(:mp3_sample).name
  end

  test "should paginate index via api with limit param and link header" do
    Song.destroy_all
    5.times do |i|
      Song.create!(
        name: "pager_song_#{i}",
        file_path: "pager_song_#{i}.mp3",
        file_path_hash: "pager_song_#{i}_path_hash",
        md5_hash: "pager_song_#{i}_md5_hash",
        artist: artists(:artist1),
        album: albums(:album1)
      )
    end

    get search_songs_url(query: "pager_", limit: 2, page: 2), as: :json, headers: api_token_header(users(:visitor1))

    assert_response :success
    assert_equal 2, @response.parsed_body.size

    links = parse_link_header(@response.headers["link"])
    assert_equal search_songs_url(query: "pager_", limit: 2, page: 1), links["first"]
    assert_equal search_songs_url(query: "pager_", limit: 2, page: 1), links["prev"]
    assert_equal search_songs_url(query: "pager_", limit: 2, page: 3), links["next"]
    assert_equal search_songs_url(query: "pager_", limit: 2, page: 3), links["last"]
  end
end
