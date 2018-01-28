class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  # Devise 客製化屬性的使用說明：  https://github.com/plataformatec/devise#strong-parameters

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  private

    def authenticate_admin
      unless current_user.admin?  #在要model/user.rb裡面加入admin?的method current_user是devise提供的helper method  但是controller如何去model裡面找到這個method
        flash[:alert] = "Not allow"
        redirect_to root_path
      end
    end 
end
