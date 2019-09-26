class RelationshipsController < ApplicationController
    def create
        # user=User.find(params[:followed_id])
        user = User.find(params[:followed_id])
        current_user.follow(user)
        redirect_to user

        # activity
        relationship = current_user.active_relationships.find_by(followed_id: user.id)
        relationship.create_activity(user: current_user)
    end

    def destroy
        user=Relationship.find(params[:id]).followed
        current_user.unfollow(user)
        redirect_to user
    end
end
