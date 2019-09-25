module CategoryHelper
    def lesson_words(category)
        lesson = category.lessons.find_by(user: current_user)
        category.words
    end
end