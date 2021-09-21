class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

  private

  #method which all controllers need
  def current_room
    @room ||= Room.find(session[:current_room]) if session[:current_room]
  end
  
  #to make it available in the views
  helper_method :current_room
end
