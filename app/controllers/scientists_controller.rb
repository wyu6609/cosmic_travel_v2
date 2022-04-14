class ScientistsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid,
              with: :render_unprocessable_entity_response

  def index
    scientists = Scientist.all
    render json: scientists, status: :ok
  end

  def show
    selected_scientist = find_scientist
    render json: selected_scientist,
           serializer: ScientistPlanetsSerializer,
           status: :ok
  end

  def create
    new_scientist = Scientist.create!(scientist_params)
    render json: new_scientist, status: :created
  end

  def update
    selected_scientist = find_scientist
    selected_scientist.update!(scientist_params)
    render json: selected_scientist, status: :accepted
  end

  def destroy
    selected_scientist = find_scientist
    selected_scientist.destroy
    head :no_content
  end

  private

  def find_scientist
    Scientist.find(params[:id])
  end

  def scientist_params
    params.permit(:name, :field_of_study, :avatar)
  end
  def render_not_found_response
    render json: { error: 'Scientist not found' }, status: :not_found
  end

  def render_unprocessable_entity_response(exception)
    render json: {
             errors: exception.record.errors.full_messages,
           },
           status: :unprocessable_entity
  end
end
