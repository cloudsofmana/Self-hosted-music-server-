# frozen_string_literal: true

require "test_helper"

module My
  class SessionsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:visitor1)
    end

    test "should destroy current session" do
      login @user

      delete my_session_url

      assert_empty cookies[:session_id]
      assert_empty @user.sessions.reload
      assert_redirected_to new_session_url
    end

    test "should destroy current session as api request" do
      delete my_session_url, as: :json, headers: api_token_header(@user)

      assert_response :no_content
      assert_nil cookies[:session_id]
      assert_empty @user.sessions.reload
    end
  end
end
