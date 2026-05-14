module Pagination
  extend ActiveSupport::Concern

  included do
    after_action :add_pagination_headers
  end

  private

  def add_pagination_headers
    return unless @pagy && request.format.json?

    pagy_headers_merge(@pagy)
  end
end
