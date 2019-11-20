class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: [:home]

  def home
    @micropost = current_user.microposts.build 
    if params[:q]
        relation = Micropost.joins(:user)
        @feed_items = relation.merge(User.search_by_keyword(params[:q]))
                        .or(relation.search_by_keyword(params[:q]))
                        .paginate(page: params[:page])
        if @feed_items.count == 0
          flash.now[:danger] = "一致する投稿はありませんでした"
        end
         
    else
        @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def about
  end

  def contact
  end
end
