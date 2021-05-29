module Admin
  class PostLikesController < AdminController
    before_action :set_post, only: %i[ create destroy ]
    before_action :set_like, only: %i[ destroy ]

    include ApplicationHelper

    def create
      @like = PostLike.new
      @like.user = current_user
      @like.post = @post

      if !liked_post(@post)
        @like.save
      end

      render json: @like
    end

    def destroy
      if check_me(@like.user)
        @like.destroy
        render json: {status: true}
      else
        render json: {status: false}
      end
    end

    private
      def set_post
        @post = Post.find(params[:post_id])
      end

      def set_like
        @like = PostLike.find(params[:id])
      end
  end
end