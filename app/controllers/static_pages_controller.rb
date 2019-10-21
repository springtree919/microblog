class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: [:home]

  def home
  end

  def about
  end

  def contact
  end
end
