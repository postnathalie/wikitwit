class StaticPagesController < ApplicationController
  def home
  	if signed_in?
  		@survey = current_user.surveys.build
  		redirect_to user_path(current_user)
  	end
  end
end
