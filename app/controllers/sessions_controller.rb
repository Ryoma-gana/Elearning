class SessionsController < ApplicationController
    def new
    end

    def create
        @user=User.find_by(email: params[:session][:email])

        if @user && @user.authenticate(params[:session][:password])
            log_in(@user)    

            flash[:success]="Successfully logged in!"
            redirect_to root_url
        else
            flash[:danger]="Email or password incorrect"
            render "new"
        end
    end

    def destroy
        session.delete(:user_id)
        # flash[:info]="Successfully logged out"
        redirect_to root_url
      end
end
