class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller? 

  # 無くても機能しているが、コントローラーで使う必要ができたら有効にする。
  # private

  # def sign_in_required
  #   redirect_to new_user_session_url unless user_signed_in?
  # end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys:[:email, :name])
    devise_parameter_sanitizer.permit(:sign_in,keys:[:email])
    devise_parameter_sanitizer.permit(:account_update,keys:[:name,:email])
  end

end
