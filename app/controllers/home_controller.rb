class HomeController < ApplicationController
  def index
    @home = "home"
    @article = Article.order("created_at desc").first
    @posts = Post.includes(user: [avatar_attachment: :blob]).includes([:club]).order("created_at desc").page(params[:page]).per(50)
    @user = current_user
    @leaderboard_users = User.includes([:sash]).find Merit::Score.top_scored.map{ |s| s["user_id"] }
    @polls = Poll.active.order(:created_at).limit(3).all
  end
end
