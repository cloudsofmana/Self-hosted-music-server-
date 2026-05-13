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
end
