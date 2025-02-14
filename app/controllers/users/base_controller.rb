class Users::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_action!

  private

  def authorize_action!
    if ['index', 'new', 'create'].include?(action_name)
      authorize!(action_name.to_sym, resource_class)
    else
      authorize!(action_name.to_sym, resource)
    end
  end
end
