# frozen_string_literal: true

require "test_helper"

class Search::AlbumsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    login
    get search_albums_url(query: "test")

    assert_response :success
  end

  test "should get index via api" do
    get search_albums_url(query: "1"), as: :json, headers: api_token_header(users(:visitor1))

    assert_response :success
    assert_includes @response.parsed_body.map { |a| a["name"] }, albums(:album1).name
  end
end
