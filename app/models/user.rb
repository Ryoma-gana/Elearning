class User < ApplicationRecord
    validates :name,presence: true
    validates :email,presence: true
    has_secure_password
    # validates :password, length: {minimum: ６}, allow_nil: true

    #フォローしてる側
    has_many :active_relationships, class_name: "Relationship",
                                    foreign_key: "follower_id",
                                    dependent: :destroy
    has_many :following, through: :active_relationships, source: :followed

    #フォローされてる側
    has_many :passive_relationships, class_name: "Relationship",
                                     foreign_key: "followed_id",
                                     dependent: :destroy
    has_many :followers, through: :passive_relationships, source: :follower

    #Follows a user
    def follow(other_user)
        following << other_user      #他のユーザーを追加
    end

    #Unfollows a user
    def unfollow(other_user)
        following.delete(other_user)       #ユーザーを削除
    end

    #Returns true if the current user is following the other user
    def following?(other_user)
        following.include?(other_user)      #ユーザーがいるか確認
    end

    def feed
        following_ids = "SELECT followed_id FROM relationships 
                       WHERE follower_id = :user_id"
        # Micropost.where("user_id IN (#{following_ids}) 
        #                  OR user_id = :user_id", user_id: id)
    end
end