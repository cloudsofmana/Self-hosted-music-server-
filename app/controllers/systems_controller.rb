# frozen_string_literal: true

class SystemsController < ApplicationController
  skip_before_action :find_current_session
  skip_before_action :require_login

  rate_limit to: 10, within: 3.seconds

  def show
  end
end
