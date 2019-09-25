module Admin
    class CategoriesController < ApplicationController
        before_action :admin_check
        # def index
        #     @category=Category.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
        # end

        def new 
            @category=Category.new
        end

        def create
            @category=Category.new(category_params)
        
            if @category.save
            # redirect_to root_url         
            flash[:success]="Succesfully registered!"
            redirect_to categories_path
            else
            render "new"
            end
        end

        def destroy
            category=Category.find(params[:id])
            category.destroy
        
            flash[:success]="Successfully deleted"
            redirect_to categories_path
        end


        private
        def admin_check
            unless current_user.admin?
                flash[:danger]="User not authorized"
                redirect_to(root_url)
            end
        end

        def category_params
            params.require(:category).permit(:title, :description)
        end

    end
end