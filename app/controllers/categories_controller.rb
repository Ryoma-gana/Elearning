class CategoriesController < ApplicationController

    def index
        @categories=Category.order(created_at: :desc).paginate(page: params[:page], per_page: 6)
        @lesson=Lesson.new
        if @lesson.result?
            update:is_complete==true
        end
    end

    def new 
        @category=Category.new
    end

    def create
        @category=Category.new(category_params)
    
        if @category.save
        # redirect_to root_url         
        flash[:succcess]="Succesfully registered!"
        redirect_to new_admin_category_path
        else
        render "new"
        end
    end

    def destroy
        category=Category.find(params[:id])
        category.destroy
    
        flash[:success]="Successfully deleted"
        redirect_to category_url
    end

    private
    def category_params
        params.require(:category).permit(:title, :description)
    end

end