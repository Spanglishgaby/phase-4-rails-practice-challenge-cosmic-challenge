class ScientistsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :invalid_inputs
    #GET
    def index
        scientists= Scientist.all 
        render json: scientists
    end
    #GET /scientists/:id
    def show
        scientist=  find_scientist
        render json: scientist , serializer: ScientistShowSerializer , status: :ok
    end
    #POST /scientists
    def create
        scientist= Scientist.create!(scientist_params)
        render json: scientist, status: :created
    end

    #PATCH /scientists/:id
    def update 
        scientist= find_scientist
        scientist.update!(scientist_params)
        render json: scientist ,status: :accepted
    end

    #DELETE /scientists/:id
    def destroy
        scientist= find_scientist
        scientist.destroy
        head :no_content
    end


    private
    def find_scientist
        Scientist.find(params[:id])
    end

    def scientist_params
        params.permit(:id, :name, :field_of_study,:avatar)
    end
    def render_not_found_response
        render json: {error: "Scientist not found"}, status: :not_found
    end
    def invalid_inputs(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
