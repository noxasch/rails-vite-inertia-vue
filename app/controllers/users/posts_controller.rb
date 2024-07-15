class Users::PostsController < Users::BaseController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    render inertia: 'posts/index', props: { posts: resources }
  end

  def show
    render inertia: 'posts/show', props: { post: resource }
  end

  def new
    render inertia: 'posts/create', props: { post: resource }
  end

  def edit
    render inertia: 'posts/create', props: { post: resource }
  end

  def update
    redirect_to users_posts_path(resource.id)
  end

  def create
    if resource.save
      return redirect_to users_posts_path(resource.id)
    end

    render inertia: 'posts/create', props: { errors: resource.errors }
  end

  def destroy
    render inertia: 'posts/index'
  end

  private

  def resource_class
    Post
  end

  def resource
    if ['new', 'create'].include?(action_name)
      @resource = resource_class.new(**(create_params[:post] || {}), user: current_user)
    # elsif action_name == 'create'
    #   @post = current_user.posts.new(**create_params[:post])
    # else
    #   @post = current_user.posts.find(params[:id])
    else
      @resource = resource_class.find(params[:id])
    end
  end

  def resources
    @resources ||= Post.accessible_by(current_ability)
  end

  def create_params
    params.permit(post: %i[title body public])
  end
end
