class Choice < ApplicationRecord
    validates :content, presence: true
    validates :correct, inclusion: {in: [true, false]}
    belongs_to :word
end
