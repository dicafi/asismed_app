class MaritalStatusesController < ApplicationController
  def index
    render json: MaritalStatus.all
  end

  def show
    status = MaritalStatus::STATUSES[params[:id].to_i]

    if status
      render json: { id: params[:id].to_i, description: status[:description] }
    else
      render json: { error: 'Marital status not found' }, status: :not_found
    end
  end
end
