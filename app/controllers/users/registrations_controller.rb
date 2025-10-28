class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  # POST /resource
  def create
    super do |resource|
      migrate_favorites_from_session(resource) if resource.persisted?
    end
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name]) # :name を許可
  end
end
