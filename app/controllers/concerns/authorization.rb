module Authorization
  extend ActiveSupport::Concern

  included do
    helper_method :is_admin?
  end

  private

  def is_admin?
    Current.user&.is_admin
  end

  def require_admin
    raise BlackCandy::Forbidden if BlackCandy.config.demo_mode? || !is_admin?
  end
end
