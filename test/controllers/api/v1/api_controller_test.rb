# frozen_string_literal: true

require "test_helper"

class Api::V1::ApiControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:visitor1)
  end

  test "should not authenticate when use session" do
    login(@user)
    put api_v1_current_playlist_album_url(albums(:album1)), as: :json

    assert_response :unauthorized
  end

  test "should authenticate when have api token" do
    put api_v1_current_playlist_album_url(albums(:album1)), as: :json, headers: api_token_header(@user)

    assert_response :success
  end

  test "should not authenticate when do not have api token" do
    put api_v1_current_playlist_album_url(albums(:album1)), as: :json

    assert_response :unauthorized
  end
end
