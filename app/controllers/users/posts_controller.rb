class Users::PostsController < Users::BaseController
  def index
    render inertia: 'posts/index'
  end

  def show
    render inertia: 'posts/show'
  end

  def new
    render inertia: 'posts/form'
  end

  def edit
    render inertia: 'posts/form'
  end

  def create
    render inertia: 'posts/show'
  end

  def destroy
    render inertia: 'posts/index'
  end
end
