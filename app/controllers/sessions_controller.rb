# frozen_string_literal: true

class SessionsController < ApplicationController
  layout "plain"

  skip_before_action :require_login

  def new
    redirect_to root_path if logged_in?
  end

  def create
    @session = Session.build_from_credential(session_params)
    raise BlackCandy::InvalidCredential unless @session.save

    login if !api_request? || params[:with_cookie]

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { render :show, status: :created }
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

  def login
    cookies.signed[:session_id] = { value: @session.id, expires: 1.year.from_now, httponly: true, secure: BlackCandy.config.force_ssl? }
  end
end
