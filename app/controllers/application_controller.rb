class ApplicationController < ActionController::Base
  inertia_share flash: -> { flash.to_hash }
  inertia_share do
    {
      public_url: {
        sign_up_path: signup_users_path, #user_registration_path,
        sign_in_path: new_user_session_path,
        users_path: user_session_path,
        sign_out_path: destroy_user_session_path
      }
    }
  end
  inertia_share do
    if user_signed_in?
      {
        auth: { 
          user: current_user.as_json(only: %i[email])
        }
      }
    else
      {}
    end
  end

  def authenticate_user!
    if user_signed_in?
      super
    else
      render inertia: '401', status: :unauthorized
    end
  end
end
