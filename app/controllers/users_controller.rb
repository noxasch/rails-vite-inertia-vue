class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[new create]
  
  def show
    render inertia: 'users/show'
  end

  def new
    render inertia: 'users/sign_up', 
      props: { 
        user: user.as_json
      }
  end

  def create
    user.save

    if user.persisted?
      redirect_to controller: 'users/sessions', action: 'new', status: 302
    else
      flash[:message] = 'Sign up error!'
      flash[:type] = :error

      render inertia: 'users/sign_up', props: { 
        user: user.as_json
      }, status: :unprocessable_entity
    end
  end

  private

  def user
    return @user if @user

    @user = if action_name == 'new'
      User.new_with_session({}, session)
    else
      User.new(sign_up_params[:user])
    end
  end

  def sign_up_params
    params.permit(user: [:email, :password, :password_confirmation])
  end
end
