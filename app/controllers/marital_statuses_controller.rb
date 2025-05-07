class MaritalStatusesController < ApplicationController
  def index
    render json: MaritalStatus.all
  end

  def show
    marital_status = MaritalStatus.find_by(id: params[:id].to_i)

    if marital_status
      render json: marital_status
    else
      render json: { error: 'Estado civil no encontrado' }, status: :not_found
    end
  end
end
