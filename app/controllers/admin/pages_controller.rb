module Admin
  class PagesController < AdminController
    def feed
      @posts = Post.all
      @users = User.all
    end

    def profile
    end
  end
end