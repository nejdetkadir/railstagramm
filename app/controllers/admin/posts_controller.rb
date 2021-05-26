module Admin
  class PostsController < AdminController
    before_action :set_post, only: %i[ show edit update destroy ]

    def edit
    end

    def show
    end

    def create
      @post = Post.new(post_params)
      @post.user = current_user
  
      if @post.save
        flash[:notice] = "Your post shared was successfully."
        redirect_to admin_feed_path
      else
        flash[:alert] = @post.errors.full_messages.first
        redirect_to admin_feed_path
      end
    end

    private
      def set_post
        @post = Post.find(params[:id])
      end

      def post_params
        params.require(:post).permit(:image, :description)
      end
  end
end