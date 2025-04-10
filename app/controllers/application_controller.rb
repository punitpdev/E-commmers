class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_user_role

  def check_user_role
    return unless current_user
    return if params[:controller].include?('devise')

    if current_user&.role == 'admin' && !params[:controller].include?('admin')
      redirect_to admin_products_path
    end
    if current_user&.role == 'user' && params[:controller].include?('admin')
      redirect_to root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :role])
  end
end
