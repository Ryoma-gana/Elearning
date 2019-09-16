module Admin
    class UsersController < ApplicationController
        before_action :admin_check
    

        def index
            @users=User.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
        end

        def update
            user = User.find(params[:id])
            if user.admin?
                user.update(admin: false)
            else
                user.update(admin: true)
            end
            redirect_to admin_users_path
        end

        
        private
        def admin_check
            unless current_user.admin?
                flash[:info]="You are not admin!"
                redirect_to root_url
            end
        end
        
    end
end