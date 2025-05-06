class InsurersController < ApplicationController
  def index
    render json: Insurer.all
  end

  def show
    insurer = Insurer.find_by(id: params[:id])

    if insurer
      render json: insurer
    else
      render json: { error: 'Insurer not found' }, status: :not_found
    end
  end
end
