class SurveysController < ApplicationController
	before_action :signed_in_user, only: [:edit, :update, :destroy, :new, :create]

	def index
		if signed_in?
			@surveys = current_user.surveys.all
		else
			@surveys = Survey.all
		end
	end

	def edit
		@survey = Survey.find(params[:id])
	end

	def show
		@survey = Survey.find(params[:id])
	end

	def new
		@survey = Survey.new
			3.times do
			question = @survey.questions.build
			4.times { question.answers.build }
		end
    end

	def create
		@survey = current_user.surveys.build(survey_params)
		if @survey.save
			redirect_to @survey
			flash[:success] = "Succesfully created survey."
		else
			render 'new'
		end
	end

	def update
		@survey = Survey.find(params[:id])
		if @survey.update_attributes(survey_params)
			redirect_to @survey
			flash[:success] = "Succesfully updated survey."
		else
			render 'edit'
		end
	end

	def destroy
		@survey = Survey.find(params[:id])
		@survey.destroy
		redirect_to surveys_url
		flash[:success] = "Succesfully destroyed survey."
	end

	private

    def survey_params
  	     params.require(:survey).permit(
  	     	:name, 
  	     	questions_attributes: [:id, :survey_id, :content, :_destroy, 
  	     	answers_attributes: [:id, :question_id, :content, :_destroy]])
    end

    def correct_user
      @survey = current_user.surveys.find_by(id: params[:id])
      redirect_to root_url if @survey.nil?
    end

end