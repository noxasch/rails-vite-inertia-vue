class PagesController < ApplicationController
  def home
    render inertia: 'home'
  end
end
