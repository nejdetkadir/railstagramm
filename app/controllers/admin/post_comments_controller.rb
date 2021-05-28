module Admin
  class PostCommentsController < AdminController
    before_action :set_comment, only: %i[ destroy ]
    before_action :set_post, only: %i[ create destroy ]

    include ApplicationHelper

    def create
      @comment = PostComment.new(comment_params)
      @comment.user = current_user
      @comment.post = @post
  
      if @comment.save
        flash[:notice] = "Your comment was successfully shared."
      else
        flash[:alert] = @post.errors.full_messages.first
      end

      redirect_to admin_post_path(@post)
    end

    def destroy
      if check_me(@comment.user) or check_me(@post.user)
        @comment.destroy
        
        if check_me(@comment.user)
          flash[:notice] = "Your comment was successfully deleted."
        else
          flash[:notice] = "Comment was successfully deleted."
        end
      else
        flash[:alert] = "Something went wrong."
      end

      redirect_to admin_post_path(@post)
    end

    private
      def set_comment
        @comment = PostComment.find(params[:id])
      end

      def set_post
        @post = Post.find(params[:post_id])
      end
      
      def comment_params
        params.require(:post_comment).permit(:body)
      end
  end
end