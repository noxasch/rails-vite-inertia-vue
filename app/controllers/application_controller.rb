class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied, with: :access_denied
  # rescue_from ActiveRecord::RecordNotFound

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
        },
        users_url: { 
          users_posts_path: users_posts_path
        }
      }
    else
      {}
    end
  end

  private

  def access_denied
    render inertia: 'error', props: {
         code: '403', title: 'Forbidden', message: 'You are not allowed to access this content!'
        }, status: :forbidden
  end

  def authenticate_user!
    if user_signed_in?
      super
    else
      render inertia: 'error', props: {
         code: '401', title: 'Unauthorized', message: 'You are unauthorized to access this page!'
        }, status: :unauthorized
    end
  end
end
