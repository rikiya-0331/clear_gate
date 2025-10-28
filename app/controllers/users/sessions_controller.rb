class Users::SessionsController < Devise::SessionsController
  # POST /resource/sign_in
  def create
    super do |resource|
      migrate_favorites_from_session(resource) if resource.persisted?
    end
  end
end
