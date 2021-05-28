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
        if !@like.save
          flash[:alert] = @like.errors.full_messages.first
        end
      end

      redirect_to admin_post_path(@post)
    end

    def destroy
      if check_me(@like.user)
        @like.destroy
      else
        flash[:alert] = "Something went wrong."
      end

      redirect_to admin_post_path(@post)
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