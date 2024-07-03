class UsersController < ApplicationController
  def new
    render inertia: 'users/sign_up', 
      props: { 
        user: user.as_json, 
        sign_up_path: signup_users_path
      }
  end

  def create

  end

  private

  def user
    @user = if action_name == 'new'
      User.new_with_session({}, session)
    else
      User.new_with_session(sign_up_params, session)
    end
  end

  def sign_up_params
    params.permit(:email, :password, :password_confirmation)
  end
end
