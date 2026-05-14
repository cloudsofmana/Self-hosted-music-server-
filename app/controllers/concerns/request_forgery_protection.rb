module RequestForgeryProtection
  extend ActiveSupport::Concern

  included do
    skip_before_action :verify_authenticity_token, if: :api_request?
  end
end
