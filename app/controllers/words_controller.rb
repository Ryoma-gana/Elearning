class WordsController < ApplicationController
    def index
        @user = User.find(params[:user_id])
        @categories = current_user.categories

        @answers = @user.answers.page(params[:page]).order(created_at: :desc)
    end
end