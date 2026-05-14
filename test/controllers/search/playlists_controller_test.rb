# frozen_string_literal: true

require "test_helper"

class Search::PlaylistsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    login
    get search_playlists_url(query: "test")

    assert_response :success
  end

  test "should get index via api" do
    get search_playlists_url(query: "1"), as: :json, headers: api_token_header(users(:visitor1))

    assert_response :success
    assert_includes @response.parsed_body.map { |p| p["name"] }, playlists(:playlist1).name
  end

  test "should paginate index via api with limit param and link header" do
    Playlist.destroy_all
    5.times { |i| Playlist.create!(name: "pager_playlist_#{i}", user: users(:admin)) }

    get search_playlists_url(query: "pager_", limit: 2, page: 2), as: :json, headers: api_token_header(users(:visitor1))

    assert_response :success
    assert_equal 2, @response.parsed_body.size

    links = parse_link_header(@response.headers["link"])
    assert_equal search_playlists_url(query: "pager_", limit: 2, page: 1), links["first"]
    assert_equal search_playlists_url(query: "pager_", limit: 2, page: 1), links["prev"]
    assert_equal search_playlists_url(query: "pager_", limit: 2, page: 3), links["next"]
    assert_equal search_playlists_url(query: "pager_", limit: 2, page: 3), links["last"]
  end
end
