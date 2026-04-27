# frozen_string_literal: true

module RefererRedirection
  extend ActiveSupport::Concern

  private

  def redirect_back_with_referer_params(fallback_location:)
    if params[:referer_url].present?
      redirect_to params[:referer_url]
    else
      redirect_back_or_to(fallback_location)
    end
  end
end
