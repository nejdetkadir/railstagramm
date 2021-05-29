module Admin
  class SavedPostsController < AdminController
    before_action :set_post, only: %i[ create destroy ]
    before_action :set_saved, only: %i[ destroy ]

    include ApplicationHelper

    def create
      @saved = SavedPost.new
      @saved.user = current_user
      @saved.post = @post

      if !saved_post(@post)
        @saved.save
      end

      render json: {id: @saved.id}
    end

    def destroy
      if check_me(@saved.user)
        @saved.destroy
        render json: {status: true}
      else
        render json: {status: false}
      end
    end

    private
      def set_post
        @post = Post.find(params[:post_id])
      end

      def set_saved
        @saved = SavedPost.find(params[:id])
      end
  end
end