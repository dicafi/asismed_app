class EducationLevelsController < ApplicationController
  def index
    render json: EducationLevel.all
  end

  def show
    render json: {
      id: params[:id],
      description: EducationLevel::LEVELS[params[:id].to_i][:description]
    }
  end
end
