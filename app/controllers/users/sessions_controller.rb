# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  inertia_share flash: -> { flash.to_hash }
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    yield resource if block_given?

    render inertia: 'users/sign_in'
  end

  # POST /resource/sign_in
  def create
    # super
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    # yield resource if block_given?

    redirect_to users_path
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
