module Admin
  class PagesController < AdminController
    def feed
      @posts = Post.all.limit(15)
      @users = User.all.limit(5)
    end

    def profile
    end
  end
end