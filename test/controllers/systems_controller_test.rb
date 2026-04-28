# frozen_string_literal: true

require "test_helper"

class SystemsControllerTest < ActionDispatch::IntegrationTest
  test "should get system version via api" do
    get system_url, as: :json
    response = @response.parsed_body["version"]

    assert_response :success
    assert_equal BlackCandy::Version::MAJOR, response["major"]
    assert_equal BlackCandy::Version::MINOR, response["minor"]
    assert_equal BlackCandy::Version::PATCH, response["patch"]
  end

  test "should get minimum app version via api" do
    get system_url, as: :json
    response = @response.parsed_body["min_app_version"]

    assert_response :success
    assert_equal BlackCandy::MinAppVersion::MAJOR, response["major"]
    assert_equal BlackCandy::MinAppVersion::MINOR, response["minor"]
    assert_equal BlackCandy::MinAppVersion::PATCH, response["patch"]
  end
end
