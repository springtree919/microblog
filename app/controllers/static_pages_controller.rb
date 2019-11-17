class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: [:home]

  def home
    @micropost = current_user.microposts.build 
    @feed_items = current_user.feed.paginate(page: params[:page])
  end

  def about
  end

  def contact
  end
end
