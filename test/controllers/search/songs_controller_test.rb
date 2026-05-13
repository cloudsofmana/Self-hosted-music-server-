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
end
