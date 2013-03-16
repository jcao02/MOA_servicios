class ApplicationController < ActionController::Base
  before_filter :authenticate_usuario!
  before_filter :set_locale
  protect_from_forgery

  def set_locale
    I18n.locale = params[:locale]
  end

  def default_url_options( options={} )
    { :locale => I18n.locale }
  end

end
