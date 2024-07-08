require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe "GET /index", inertia: true do
    it 'renders home page' do
      get '/'
      expect_inertia.to render_component 'home'
    end
  end
end
