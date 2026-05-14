module My
  class SessionsController < ApplicationController
    def destroy
      Current.session.destroy!

      reset_session
      cookies.delete(:session_id)

      respond_to do |format|
        format.html { redirect_to new_session_path }
        format.json { head :no_content }
      end
    end
  end
end
