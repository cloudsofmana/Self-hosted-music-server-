module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :find_current_session
    before_action :require_login

    helper_method :logged_in?
  end

  private

  def logged_in?
    Current.session.present?
  end

  def find_current_session
    Current.session = find_current_session_by_cookie || find_current_session_by_token
  end

  def require_login
    raise BlackCandy::Unauthorized unless logged_in?
  end

  def find_current_session_by_cookie
    Session.find_by(id: cookies.signed[:session_id])
  end

  def find_current_session_by_token
    authenticate_with_http_token do |token, _|
      Session.find_signed(token)
    end
  end
end
