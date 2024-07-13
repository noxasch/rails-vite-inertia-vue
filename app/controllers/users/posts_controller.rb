class Users::PostsController < Users::BaseController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    render inertia: 'posts/index', props: { posts: posts }
  end

  def show
    render inertia: 'posts/show', props: { post: post }
  end

  def new
    render inertia: 'posts/create', props: { post: post }
  end

  def edit
    render inertia: 'posts/create', props: { post: post }
  end

  def create
    if post.save
      redirect_to users_posts_path(post.id)
    end

    render inertia: 'posts/create', props: { errors: post.errors }
  end

  def destroy
    render inertia: 'posts/index'
  end

  private

  def post
    if action_name == 'new'
      @post = Post.new
    # elsif action_name == 'create'
    #   @post = current_user.posts.new(**create_params[:post])
    # else
    #   @post = current_user.posts.find(params[:id])
    else
      @post = Post.find(params[:id])
      authorize!(:read, @post)
    end
  end

  def posts
    @posts ||= Post.accessible_by(current_ability)
  end

  def create_params
    params.permit(post: %i[title body public])
  end
end
