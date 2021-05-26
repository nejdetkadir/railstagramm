module Admin
  class PagesController < AdminController
    def feed
      @posts = Post.all.limit(15)
      @users = User.all.limit(5)
    end
  end
end