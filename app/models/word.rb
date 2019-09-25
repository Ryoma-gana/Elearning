class Word < ApplicationRecord
    validates :content, presence: true

    belongs_to :category
    has_many :choices, dependent: :destroy
    accepts_nested_attributes_for :choices, allow_destroy: true

    has_many :words, through: :answers

    validate :count_check

    def count_check
        correct_count = choices.select{ |choice| choice.correct? }.count
        unless correct_count == 1
            errors.add(:choices, "Select only one")
        end
    end

    def correct_choice
        choices.find_by(correct: true)
    end
end
