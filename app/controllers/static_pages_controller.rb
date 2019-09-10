class StaticPagesController < ApplicationController
  def home

    if logged_in?
      render 'users/home_feed'
    end
  end

  def about
  end
end
