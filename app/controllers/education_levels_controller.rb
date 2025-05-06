class EducationLevelsController < ApplicationController
  def index
    render json: EducationLevel.all
  end

  def show
    level = EducationLevel::LEVELS[params[:id].to_i]

    if level
      render json: { id: params[:id].to_i, description: level[:description] }
    else
      render json: { error: 'Education level not found' }, status: :not_found
    end
  end
end
