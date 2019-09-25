module Admin
    class WordsController < ApplicationController
        before_action :admin_check
        
        def new
            @category=Category.find(params[:category_id])
            @word = @category.words.build
            3.times {@word.choices.build}
        end

        def index
            @category=Category.find(params[:category_id])
            @words=@category.words.paginate(page: params[:page], per_page: 10)
        end

        def create
            @category=Category.find(params[:category_id])
            @word = @category.words.build(word_params)
        
            if @word.save
            # redirect_to root_url         
            flash[:success]="Succesfully registered!"
            redirect_to admin_category_words_path
            else
            render "new"
            end
        end

        def edit
            @category=Category.find(params[:category_id])
            @word=Word.find(params[:id])
            
        end

        def update
            @category=Category.find(params[:category_id])
            @word=Word.find(params[:id])
            if @word.update_attributes(word_params)
                flash[:succcess]="Successfully Edited"
                redirect_to admin_category_words_path
            else
                render "edit"
            end
        end

        def destroy
            @category=Category.find(params[:category_id])
            @word=Word.find(params[:id])
            @word.destroy
        
            flash[:success]="Successfully deleted"
            redirect_to admin_category_words_path
        end

        private
        def admin_check
            unless current_user.admin?
                flash[:danger]="User not authorized"
                redirect_to(root_url)
            end
        end

        def word_params
            params.require(:word).permit(
                :content, choices_attributes: [:id, :content, :word_id, :correct]
            )
        end
    end
end