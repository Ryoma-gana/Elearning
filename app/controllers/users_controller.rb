class UsersController < ApplicationController
    before_action :require_login, except:[:new, :create]
    before_action :correct_user, only:[:edit, :update]
    
    def new
        @user=User.new
    end

    def create
        @user=User.new(user_params)
    
        if @user.save
          # redirect_to root_url         
          flash[:succcess]="Succesfully registered!"
          redirect_to request.referer
        else
          render "new"
        end
    end

    def show
        @user=User.find(params[:id])
        @activities = @user.activities.order(created_at: :desc)
    end

    def edit
        @user=User.find(params[:id])
    end

    def update
        @user=User.find(params[:id])

        if @user.update_attributes(user_params)
            flash[:success]="Successfully Updated!"
            redirect_to @user
        else
            flash[:danger]="False"
            render :edit
        end
    end

    def destroy
        user=User.find(params[:id])
        user.destroy
    
        flash[:success]="Successfully deleted"
        redirect_to user_url
    end

    def index
        @users=User.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    end

    def following
        @title="Following"
        @user=User.find(params[:id])
        @users=@user.following.paginate(page: params[:page], per_page: 10)
        render 'show_follow'
      end
    
      def followers
        @title="Followers"
        @user=User.find(params[:id])
        @users=@user.followers.paginate(page: params[:page], per_page: 10)
        render 'show_follow'
      end


    private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
    end

    def require_login
        unless logged_in?
            flash[:info]="Please log in."
            redirect_to login_url
        end
    end

    def correct_user
        @user=User.find(params[:id])

        unless @user==current_user
            flash[:danger]="User not authorized"
            redirect_to root_url
        end
    end
end
