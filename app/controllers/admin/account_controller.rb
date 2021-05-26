module Admin
  class AccountController < AdminController
    before_action :set_user, only: %i[ show ]

    include FriendshipHelper

    def show
      p friends_with?(@user.id)
    end

    private
      def set_user
        @user = User.friendly.find(params[:id])
      end
  end
end