module Admin
  class AccountController < AdminController
    before_action :set_user, only: %i[ show send_request accept_request delete_request delete_following delete_pending_request]

    include FriendshipHelper

    def show
      @posts = @user.posts.order(created_at: :desc)
    end

    def change_password
    end

    def activities
      @activities = PublicActivity::Activity.where(owner_id: current_user.id).order(created_at: :desc).limit(4)
    end

    def send_request
      send_follow_request(@user.id)
      redirect_back fallback_location: @user
    end

    def accept_request
      accept_follow_request(@user.id)
      redirect_back fallback_location: @user
    end

    def delete_request
      delete_follow_request(@user.id)
      redirect_back fallback_location: @user
    end

    def delete_following
      remove_friend(@user.id)
      redirect_back fallback_location: @user
    end

    def delete_pending_request
      remove_pending_request(@user.id)
      redirect_back fallback_location: @user
    end

    private
      def set_user
        @user = User.friendly.find(params[:id])
      end
  end
end