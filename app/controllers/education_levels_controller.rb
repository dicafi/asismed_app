class EducationLevelsController < ApplicationController
  def index
    render json: EducationLevel.all
  end

  def show
    educational_level = EducationLevel.find_by(id: params[:id].to_i)

    if educational_level
      render json: educational_level
    else
      render json: { error: 'Nivel educativo no encontrado' }, status: :not_found
    end
  end
end
