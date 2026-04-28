module ExceptionRescue
  extend ActiveSupport::Concern

  included do
    rescue_from BlackCandy::Forbidden do |error|
      respond_to do |format|
        format.json { render_json_error(error, :forbidden) }
        format.html { render template: "errors/forbidden", layout: "plain", status: :forbidden }
      end
    end

    rescue_from BlackCandy::InvalidCredential do |error|
      respond_to do |format|
        format.json { render_json_error(error, :unauthorized) }
        format.html { redirect_to new_session_path, alert: t("error.login") }
      end
    end

    rescue_from BlackCandy::DuplicatePlaylistSong do |error|
      respond_to do |format|
        format.json { render_json_error(error, :bad_request) }
        format.html { redirect_back_or_to root_path, alert: t("error.already_in_playlist") }
      end
    end

    rescue_from BlackCandy::Unauthorized do |error|
      respond_to do |format|
        format.json { render_json_error(error, :unauthorized) }
        format.html { redirect_to new_session_path }
      end
    end

    rescue_from ActiveRecord::RecordNotFound do |error|
      respond_to do |format|
        format.json { render_json_error(BlackCandy::CustomError.new("RecordNotFound", error.message), :not_found) }
        format.html { render template: "errors/not_found", layout: "plain", status: :not_found }
      end
    end
  end

  private

  def render_json_error(error, status)
    render json: { type: error.type, message: error.message }, status: status
  end
end
