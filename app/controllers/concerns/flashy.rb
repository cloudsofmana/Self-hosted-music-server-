module Flashy
  extend ActiveSupport::Concern

  included do
    helper_method :render_flash
  end

  private

  def flash_errors_message(object, now: false)
    errors_message = object.errors.full_messages.join(". ")

    if now
      flash.now[:alert] = errors_message
    else
      flash[:alert] = errors_message
    end
  end

  def render_flash(type: :notice, message: "")
    flash[type] = message unless message.blank?
    turbo_stream.update "turbo-flash", partial: "shared/flash"
  end
end
