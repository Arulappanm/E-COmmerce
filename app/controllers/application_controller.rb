class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?



  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :title, :email, :password, :password_confirmation, :role_id])
  end

end
