class Category < ApplicationRecord
    validates :title,presence: true

    has_many :words, foreign_key: "category_id", dependent: :destroy

    has_many :lessons, dependent: :destroy
    has_many :users, through: :lessons
    has_many :answers, through: :lessons

    has_one :activity, as: :action, dependent: :destroy

    def get_lesson(current_user)
        lessons.find_by(user: current_user)
    end
end
