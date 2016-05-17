class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  # saves username
  # see STRONG validation in Device documentation
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:sign_up) << :money
    devise_parameter_sanitizer.for(:sign_up) << :auth_level
    devise_parameter_sanitizer.for(:sign_up) << :info
    devise_parameter_sanitizer.for(:account_update) << :username
    devise_parameter_sanitizer.for(:account_update) << :money
    devise_parameter_sanitizer.for(:account_update) << :auth_level
    devise_parameter_sanitizer.for(:account_update) << :gender
    devise_parameter_sanitizer.for(:account_update) << :age
    devise_parameter_sanitizer.for(:account_update) << :device
    devise_parameter_sanitizer.for(:account_update) << :OS
    devise_parameter_sanitizer.for(:account_update) << :time_spent
    devise_parameter_sanitizer.for(:account_update) << :spending
    devise_parameter_sanitizer.for(:account_update) << :motivation
    devise_parameter_sanitizer.for(:account_update) << :game_genre
    devise_parameter_sanitizer.for(:account_update) << :nation
    devise_parameter_sanitizer.for(:account_update) << :info
  end
end
