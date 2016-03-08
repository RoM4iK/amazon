class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :global_data
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def current_ability
    @current_ability ||= Ability.new(current_customer)
  end

  protected
  
  def global_data
    @categories = Category.all
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name]
  end
  
end
