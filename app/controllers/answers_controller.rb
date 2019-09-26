class AnswersController < ApplicationController
    def new
      @lesson = Lesson.find(params[:lesson_id])
        
        if @lesson.first_word.nil?
            @lesson.update(result: @lesson.lesson_results)
            @lesson.create_activity(user: current_user)
            redirect_to lesson_url(@lesson.id)
        else
            @answer=@lesson.answers.new
        end
    end
  
    def create
      lesson = Lesson.find(params[:lesson_id])
      @answer = lesson.answers.build(answer_params)
        if @answer.save
          redirect_to new_lesson_answer_url(lesson)
        else
          'new'
        end
    end
  
    private
  
    def answer_params
      params.require(:answer).permit(:word_id, :choice_id, :lesson_id)
    end
  end
