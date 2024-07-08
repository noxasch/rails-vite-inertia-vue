require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }

  
  describe "GET /index", inertia: true do
    before do
      sign_in user
    end

    it 'renders home page' do
      get users_path
      expect_inertia.to render_component 'users/show'
    end
  end

  describe "GET /new", inertia: true do
    before do
      sign_in user
    end

    it 'renders sign up page' do
      get signup_users_path
      expect_inertia.to render_component 'users/sign_up'
    end
  end

  describe "POST /create", inertia: true do
    let(:params) do
      {
        user: {
          email: 'user@example.com',
          password: 'password',
          password_confirmation: 'password'
        }
      }
    end
    
    it 'renders sign up page' do
      post(signup_users_path, params:)
      expect(response).to have_http_status(302)
    end
  end
end
