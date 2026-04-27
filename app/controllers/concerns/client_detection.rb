module ClientDetection
  extend ActiveSupport::Concern

  included do
    helper_method :native_app?, :mobile?, :need_transcode?
  end

  private

  def need_transcode?(song)
    song_format = song.format

    unless native_app?
      return true if !browser.safari? && !song_format.in?(Stream::WEB_SUPPORTED_FORMATS)
      # Non-Safari browsers don't support ALAC format. So we need to transcode it.
      return true if !browser.safari? && song_format == "m4a" && song.lossless?
      return true if browser.safari? && !song_format.in?(Stream::SAFARI_SUPPORTED_FORMATS)
    end

    return true if ios_app? && !song_format.in?(Stream::IOS_SUPPORTED_FORMATS)
    return true if android_app? && !song_format.in?(Stream::ANDROID_SUPPORTED_FORMATS)

    Setting.allow_transcode_lossless? ? song.lossless? : false
  end

  def native_app?
    ios_app? || android_app?
  end

  def mobile?
    browser.device.mobile?
  end

  def ios_app?
    Current.user_agent.to_s.match?(/Black Candy iOS/)
  end

  def android_app?
    Current.user_agent.to_s.match?(/Black Candy Android/)
  end
end
